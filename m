Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6R0c18p3zDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 10:32:15 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3I0SiWh008124
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 20:32:14 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29w0p6gyk1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 20:32:14 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 18:32:13 -0600
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: robh+dt@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, nfont@linux.vnet.ibm.com,
 mpe@ellerman.id.au, frowand.list@gmail.com, rostedt@goodmis.org,
 mingo@redhat.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
Date: Mon, 17 Apr 2017 20:32:05 -0400
Message-Id: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch introduces event tracepoints for tracking a device_nodes
reference cycle as well as reconfig notifications generated in response
to node/property manipulations.

With the recent upstreaming of the refcount API several device_node
underflows and leaks have come to my attention in the pseries (DLPAR) dynamic
logical partitioning code (ie. POWER speak for hotplugging virtual and physcial
resources at runtime such as cpus or IOAs). These tracepoints provide a
easy and quick mechanism for validating the reference counting of
device_nodes during their lifetime.

Further, when pseries lpars are migrated to a different machine we
perform a live update of our device tree to bring it into alignment with the
configuration of the new machine. The of_reconfig_notify trace point
provides a mechanism that can be turned for debuging the device tree
modifications with out having to build a custom kernel to get at the
DEBUG code introduced by commit 00aa3720.

The following trace events are provided: of_node_get, of_node_put,
of_node_release, and of_reconfig_notify. These trace points require a kernel
built with ftrace support to be enabled. In a typical environment where
debugfs is mounted at /sys/kernel/debug the entire set of tracepoints
can be set with the following:

  echo "of:*" > /sys/kernel/debug/tracing/set_event

or

  echo 1 > /sys/kernel/debug/tracing/of/enable

The following shows the trace point data from a DLPAR remove of a cpu
from a pseries lpar:

cat /sys/kernel/debug/tracing/trace | grep "POWER8@10"

cpuhp/23-147   [023] ....   128.324827:
	of_node_put: refcount=5, dn->full_name=/cpus/PowerPC,POWER8@10
cpuhp/23-147   [023] ....   128.324829:
	of_node_put: refcount=4, dn->full_name=/cpus/PowerPC,POWER8@10
cpuhp/23-147   [023] ....   128.324829:
	of_node_put: refcount=3, dn->full_name=/cpus/PowerPC,POWER8@10
cpuhp/23-147   [023] ....   128.324831:
	of_node_put: refcount=2, dn->full_name=/cpus/PowerPC,POWER8@10
   drmgr-7284  [009] ....   128.439000:
	of_node_put: refcount=1, dn->full_name=/cpus/PowerPC,POWER8@10
   drmgr-7284  [009] ....   128.439002:
	of_reconfig_notify: action=DETACH_NODE, dn->full_name=/cpus/PowerPC,POWER8@10,
			    prop->name=null, old_prop->name=null
   drmgr-7284  [009] ....   128.439015:
	of_node_put: refcount=0, dn->full_name=/cpus/PowerPC,POWER8@10
   drmgr-7284  [009] ....   128.439016:
	of_node_release: dn->full_name=/cpus/PowerPC,POWER8@10, dn->_flags=4

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 drivers/of/dynamic.c      | 30 ++++++---------
 include/trace/events/of.h | 93 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 18 deletions(-)
 create mode 100644 include/trace/events/of.h

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 888fdbc..85c0966 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -16,6 +16,9 @@
 
 #include "of_private.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/of.h>
+
 /**
  * of_node_get() - Increment refcount of a node
  * @node:	Node to inc refcount, NULL is supported to simplify writing of
@@ -25,8 +28,10 @@
  */
 struct device_node *of_node_get(struct device_node *node)
 {
-	if (node)
+	if (node) {
 		kobject_get(&node->kobj);
+		trace_of_node_get(refcount_read(&node->kobj.kref.refcount), node->full_name);
+	}
 	return node;
 }
 EXPORT_SYMBOL(of_node_get);
@@ -38,8 +43,10 @@ struct device_node *of_node_get(struct device_node *node)
  */
 void of_node_put(struct device_node *node)
 {
-	if (node)
+	if (node) {
+		trace_of_node_put(refcount_read(&node->kobj.kref.refcount) - 1, node->full_name);
 		kobject_put(&node->kobj);
+	}
 }
 EXPORT_SYMBOL(of_node_put);
 
@@ -92,24 +99,9 @@ int of_reconfig_notifier_unregister(struct notifier_block *nb)
 int of_reconfig_notify(unsigned long action, struct of_reconfig_data *p)
 {
 	int rc;
-#ifdef DEBUG
-	struct of_reconfig_data *pr = p;
 
-	switch (action) {
-	case OF_RECONFIG_ATTACH_NODE:
-	case OF_RECONFIG_DETACH_NODE:
-		pr_debug("notify %-15s %s\n", action_names[action],
-			pr->dn->full_name);
-		break;
-	case OF_RECONFIG_ADD_PROPERTY:
-	case OF_RECONFIG_REMOVE_PROPERTY:
-	case OF_RECONFIG_UPDATE_PROPERTY:
-		pr_debug("notify %-15s %s:%s\n", action_names[action],
-			pr->dn->full_name, pr->prop->name);
-		break;
+	trace_of_reconfig_notify(action, p);
 
-	}
-#endif
 	rc = blocking_notifier_call_chain(&of_reconfig_chain, action, p);
 	return notifier_to_errno(rc);
 }
@@ -326,6 +318,8 @@ void of_node_release(struct kobject *kobj)
 	struct device_node *node = kobj_to_device_node(kobj);
 	struct property *prop = node->properties;
 
+	trace_of_node_release(node);
+
 	/* We should never be releasing nodes that haven't been detached. */
 	if (!of_node_check_flag(node, OF_DETACHED)) {
 		pr_err("ERROR: Bad of_node_put() on %s\n", node->full_name);
diff --git a/include/trace/events/of.h b/include/trace/events/of.h
new file mode 100644
index 0000000..0d53271
--- /dev/null
+++ b/include/trace/events/of.h
@@ -0,0 +1,93 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM of
+
+#if !defined(_TRACE_OF_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_OF_H
+
+#include <linux/of.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(of_node_ref_template,
+
+	TP_PROTO(int refcount, const char* dn_name),
+
+	TP_ARGS(refcount, dn_name),
+
+	TP_STRUCT__entry(
+		__string(dn_name, dn_name)
+		__field(int, refcount)
+	),
+
+	TP_fast_assign(
+		__assign_str(dn_name, dn_name);
+		__entry->refcount = refcount;
+	),
+
+	TP_printk("refcount=%d, dn->full_name=%s",
+		  __entry->refcount, __get_str(dn_name))
+);
+
+DEFINE_EVENT(of_node_ref_template, of_node_get,
+	     TP_PROTO(int refcount, const char* dn_name),
+	     TP_ARGS(refcount, dn_name));
+
+DEFINE_EVENT(of_node_ref_template, of_node_put,
+	     TP_PROTO(int refcount, const char* dn_name),
+	     TP_ARGS(refcount, dn_name));
+
+TRACE_EVENT(of_node_release,
+
+	TP_PROTO(struct device_node *dn),
+
+	TP_ARGS(dn),
+
+	TP_STRUCT__entry(
+		__string(dn_name, dn->full_name)
+		__field(unsigned long, flags)
+	),
+
+	TP_fast_assign(
+		__assign_str(dn_name, dn->full_name);
+		__entry->flags = dn->_flags;
+	),
+
+	TP_printk("dn->full_name=%s, dn->_flags=%lu", 
+		  __get_str(dn_name), __entry->flags)
+);
+
+#define of_reconfig_action_names \
+	{OF_RECONFIG_ATTACH_NODE, "ATTACH_NODE"}, \
+	{OF_RECONFIG_DETACH_NODE, "DETACH_NODE"}, \
+	{OF_RECONFIG_ADD_PROPERTY, "ADD_PROPERTY"}, \
+	{OF_RECONFIG_REMOVE_PROPERTY, "REMOVE_PROPERTY"}, \
+	{OF_RECONFIG_UPDATE_PROPERTY, "UPDATE_PROPERTY"}
+
+TRACE_EVENT(of_reconfig_notify,
+
+	TP_PROTO(unsigned long action, struct of_reconfig_data *ord),
+
+	TP_ARGS(action, ord),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, action)
+		__string(dn_name, ord->dn->full_name)
+		__string(prop_name, ord->prop ? ord->prop->name : "null")
+		__string(oldprop_name, ord->old_prop ? ord->old_prop->name : "null")
+	),
+
+	TP_fast_assign(
+		__entry->action = action;
+		__assign_str(dn_name, ord->dn->full_name);
+		__assign_str(prop_name, ord->prop ? ord->prop->name : "null");
+		__assign_str(oldprop_name, ord->old_prop ? ord->old_prop->name : "null");
+	),
+
+	TP_printk("action=%s, dn->full_name=%s, prop->name=%s, old_prop->name=%s",
+		  __print_symbolic(__entry->action, of_reconfig_action_names),
+		  __get_str(dn_name), __get_str(prop_name), __get_str(oldprop_name))
+);
+
+#endif /*	_TRACE_OF_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
1.8.3.1
