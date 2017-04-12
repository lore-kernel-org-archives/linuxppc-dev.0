Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2nSY2gDRzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 12:10:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Sachin Sant <sachinp@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARN @lib/refcount.c:128 during hot unplug of I/O adapter.
In-Reply-To: <eadda997-6e55-5741-e306-0ac723e19393@gmail.com>
References: <E5B3D5CE-EB6A-4470-B7E9-4F6F7B029809@linux.vnet.ibm.com>
 <a7a782f2-3783-fd96-eda9-1c7634b2a2e5@linux.vnet.ibm.com>
 <8760ig983f.fsf@concordia.ellerman.id.au>
 <89aec36c-e352-e055-5e80-1235449762ce@linux.vnet.ibm.com>
 <871sszwc87.fsf@concordia.ellerman.id.au>
 <eadda997-6e55-5741-e306-0ac723e19393@gmail.com>
Date: Wed, 12 Apr 2017 12:10:20 +1000
Message-ID: <87efwyv0j7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tyrel Datwyler <turtle.in.the.kernel@gmail.com> writes:
> On 04/11/2017 02:00 AM, Michael Ellerman wrote:
>> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
>>> I started looking at it when Bharata submitted a patch trying to fix the
>>> issue for CPUs, but got side tracked by other things. I suspect that
>>> this underflow has actually been an issue for quite some time, and we
>>> are just now becoming aware of it thanks to the recount_t patchset being
>>> merged.
>> 
>> Yes I agree. Which means it might be broken in existing distros.
>
> Definitely. I did some profiling last night, and I understand the
> hotplug case. It turns out to be as I suggested in the original thread
> about CPUs. When the devicetree code was worked to move the tree out of
> proc and into sysfs the sysfs detach code added a of_node_put to remove
> the original of_init reference. pSeries Being the sole original
> *dynamic* device tree user we had always issued a of_node_put in our
> dlpar specific detach function to achieve that end. So, this should be a
> pretty straight forward trivial fix.

Excellent, thanks.

> However, for the case where devices are present at boot it appears we a
> leaking a lot of references resulting in the device nodes never actually
> being released/freed after a dlpar remove. In the CPU case after boot I
> count 8 more references taken than the hotplug case, and corresponding
> of_node_put's are not called at dlpar remove time either. That will take
> some time to track them down, review and clean up.

Yes that is a perennial problem unfortunately which we've never come up
with a good solution for.

The (old) patch below might help track some of them down. I remember
having a script to process the output of the trace and find mismatches,
but I can't find it right now - but I'm sure you can hack up something
:)

cheers


diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
index 32e36b16773f..ad32365082a0 100644
--- a/arch/powerpc/include/asm/trace.h
+++ b/arch/powerpc/include/asm/trace.h
@@ -168,6 +168,44 @@ TRACE_EVENT(hash_fault,
 		      __entry->addr, __entry->access, __entry->trap)
 );
 
+TRACE_EVENT(of_node_get,
+
+	TP_PROTO(struct device_node *dn, int val),
+
+	TP_ARGS(dn, val),
+
+	TP_STRUCT__entry(
+		__field(struct device_node *, dn)
+		__field(int, val)
+	),
+
+	TP_fast_assign(
+		__entry->dn = dn;
+		__entry->val = val;
+	),
+
+	TP_printk("get %d -> %d %s", __entry->val - 1, __entry->val, __entry->dn->full_name)
+);
+
+TRACE_EVENT(of_node_put,
+
+	TP_PROTO(struct device_node *dn, int val),
+
+	TP_ARGS(dn, val),
+
+	TP_STRUCT__entry(
+		__field(struct device_node *, dn)
+		__field(int, val)
+	),
+
+	TP_fast_assign(
+		__entry->dn = dn;
+		__entry->val = val;
+	),
+
+	TP_printk("put %d -> %d %s", __entry->val + 1, __entry->val, __entry->dn->full_name)
+);
+
 #endif /* _TRACE_POWERPC_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index c647bd1b6903..f5c3d761f3cd 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -14,6 +14,8 @@
 
 #include "of_private.h"
 
+#include <asm/trace.h>
+
 /**
  * of_node_get() - Increment refcount of a node
  * @node:	Node to inc refcount, NULL is supported to simplify writing of
@@ -23,8 +25,12 @@
  */
 struct device_node *of_node_get(struct device_node *node)
 {
-	if (node)
+	if (node) {
 		kobject_get(&node->kobj);
+
+		trace_of_node_get(node, atomic_read(&node->kobj.kref.refcount));
+	}
+
 	return node;
 }
 EXPORT_SYMBOL(of_node_get);
@@ -36,8 +42,10 @@ EXPORT_SYMBOL(of_node_get);
  */
 void of_node_put(struct device_node *node)
 {
-	if (node)
+	if (node) {
 		kobject_put(&node->kobj);
+		trace_of_node_put(node, atomic_read(&node->kobj.kref.refcount));
+	}
 }
 EXPORT_SYMBOL(of_node_put);
 
