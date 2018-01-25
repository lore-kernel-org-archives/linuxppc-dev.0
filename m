Return-Path: <frowand.list@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zSJG23PMwzDqhZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jan 2018 10:31:37 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id 23so6962476pfp.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 15:31:37 -0800 (PST)
Subject: Re: [RFC PATCH v2 1/1] of: introduce event tracepoints for dynamic
 device_node lifecyle
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
 <20180121143117.19805-2-wsa+renesas@sang-engineering.com>
 <4cc627c4-1aaf-b8d5-5a26-eea7e596743f@gmail.com>
 <25f83d0d-bc67-f1b5-cadb-838987fd846d@linux.vnet.ibm.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <a9d00979-5c6c-b19c-5ca9-60b6283e6eec@gmail.com>
Date: Thu, 25 Jan 2018 15:31:33 -0800
MIME-Version: 1.0
In-Reply-To: <25f83d0d-bc67-f1b5-cadb-838987fd846d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/25/18 14:40, Tyrel Datwyler wrote:
> On 01/24/2018 10:48 PM, Frank Rowand wrote:
>> On 01/21/18 06:31, Wolfram Sang wrote:
>>> From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
>>>
>>> This patch introduces event tracepoints for tracking a device_nodes
>>> reference cycle as well as reconfig notifications generated in response
>>> to node/property manipulations.
>>>
>>> With the recent upstreaming of the refcount API several device_node
>>> underflows and leaks have come to my attention in the pseries (DLPAR)
>>> dynamic logical partitioning code (ie. POWER speak for hotplugging
>>> virtual and physcial resources at runtime such as cpus or IOAs). These
>>> tracepoints provide a easy and quick mechanism for validating the
>>> reference counting of device_nodes during their lifetime.
>>>
>>> Further, when pseries lpars are migrated to a different machine we
>>> perform a live update of our device tree to bring it into alignment with
>>> the configuration of the new machine. The of_reconfig_notify trace point
>>> provides a mechanism that can be turned for debuging the device tree
>>> modifications with out having to build a custom kernel to get at the
>>> DEBUG code introduced by commit 00aa37206e1a54 ("of/reconfig: Add debug
>>> output for OF_RECONFIG notifiers").
>>>
>>> The following trace events are provided: of_node_get, of_node_put,
>>> of_node_release, and of_reconfig_notify. These trace points require a
>>
>> Please add a note that the of_reconfig_notify trace event is not an
>> added bit of debug info, but is instead replacing information that
>> was previously available via pr_debug() when DEBUG was defined.
>>
>>
>>> kernel built with ftrace support to be enabled. In a typical environment
>>> where debugfs is mounted at /sys/kernel/debug the entire set of
>>> tracepoints can be set with the following:
>>>
>>>   echo "of:*" > /sys/kernel/debug/tracing/set_event
>>>
>>> or
>>>
>>>   echo 1 > /sys/kernel/debug/tracing/events/of/enable
>>>
>>> The following shows the trace point data from a DLPAR remove of a cpu
>>> from a pseries lpar:
>>>
>>> cat /sys/kernel/debug/tracing/trace | grep "POWER8@10"
>>>
>>> cpuhp/23-147   [023] ....   128.324827:
>>>         of_node_put: refcount=5, dn->full_name=/cpus/PowerPC,POWER8@10
>>> cpuhp/23-147   [023] ....   128.324829:
>>>         of_node_put: refcount=4, dn->full_name=/cpus/PowerPC,POWER8@10
>>> cpuhp/23-147   [023] ....   128.324829:
>>>         of_node_put: refcount=3, dn->full_name=/cpus/PowerPC,POWER8@10
>>> cpuhp/23-147   [023] ....   128.324831:
>>>         of_node_put: refcount=2, dn->full_name=/cpus/PowerPC,POWER8@10
>>>    drmgr-7284  [009] ....   128.439000:
>>>         of_node_put: refcount=1, dn->full_name=/cpus/PowerPC,POWER8@10
>>>    drmgr-7284  [009] ....   128.439002:
>>>         of_reconfig_notify: action=DETACH_NODE, dn->full_name=/cpus/PowerPC,POWER8@10,
>>>                             prop->name=null, old_prop->name=null
>>>    drmgr-7284  [009] ....   128.439015:
>>>         of_node_put: refcount=0, dn->full_name=/cpus/PowerPC,POWER8@10
>>>    drmgr-7284  [009] ....   128.439016:
>>>         of_node_release: dn->full_name=/cpus/PowerPC,POWER8@10, dn->_flags=4
>>>
>>> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
>>
>> The following belongs in a list of version 2 changes, below the "---" line:
>>
>>> [wsa: fixed commit abbrev and one of the sysfs paths in commit desc,
>>> removed trailing space and fixed pointer declaration in code]
>>
>>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>> ---
>>>  drivers/of/dynamic.c      | 32 ++++++----------
>>>  include/trace/events/of.h | 93 +++++++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 105 insertions(+), 20 deletions(-)
>>>  create mode 100644 include/trace/events/of.h
>>
>> mode looks incorrect.  Existing files in include/trace/events/ are -rw-rw----
>>
>>
>>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
>>> index ab988d88704da0..b0d6ab5a35b8c6 100644
>>> --- a/drivers/of/dynamic.c
>>> +++ b/drivers/of/dynamic.c
>>> @@ -21,6 +21,9 @@ static struct device_node *kobj_to_device_node(struct kobject *kobj)
>>>  	return container_of(kobj, struct device_node, kobj);
>>>  }
>>>  
>>> +#define CREATE_TRACE_POINTS
>>> +#include <trace/events/of.h>
>>> +
>>>  /**
>>>   * of_node_get() - Increment refcount of a node
>>>   * @node:	Node to inc refcount, NULL is supported to simplify writing of
>>> @@ -30,8 +33,10 @@ static struct device_node *kobj_to_device_node(struct kobject *kobj)
>>>   */
>>>  struct device_node *of_node_get(struct device_node *node)
>>>  {
>>> -	if (node)
>>> +	if (node) {
>>>  		kobject_get(&node->kobj);
>>> +		trace_of_node_get(refcount_read(&node->kobj.kref.refcount), node->full_name);
>>
>> See the comment from Ron that I mentioned in my previous email.
>>
>> Also, the path has been removed from node->full_name.  Does using it here
>> still give all of the information that is desired?  Same for all others uses
>> of full_name in this patch.
>>
>> The trace point should have a single argument, node.  Accessing the two
>> fields can be done in the tracepoint assignment.  Or is there some
>> reason that can't be done?  Same for the trace_of_node_put() tracepoint.
> 
> I originally was just passing the node, but added the refcount as an argument to deal with trace_of_node_put(). See my comment there for the reasoning.

In that case I would remove the "- 1" in of_node_put()
(which I'll talk about in general terms below -- and I
wrote the comment below before writing this paragraph)
or change the of_node_get and of_node_put trace events
to not depend upon the common of_node_ref_template.

Anyway, this is somewhat academic, since I noted in
another email in a different part of this thread that
there is a need to be able to debug of_node_get(),
of_node_put(), and of_node_release() earlier in the
boot than ftrace is available, so trace points are
not the answer in those functions.

>>
>>
>>> +	}
>>>  	return node;
>>>  }
>>>  EXPORT_SYMBOL(of_node_get);
>>> @@ -43,8 +48,10 @@ EXPORT_SYMBOL(of_node_get);
>>>   */
>>>  void of_node_put(struct device_node *node)
>>>  {
>>> -	if (node)
>>> +	if (node) {
>>> +		trace_of_node_put(refcount_read(&node->kobj.kref.refcount) - 1, node->full_name);
>>
>> If this is moved down one line to after kobject_put(), then no need
>> to subtract 1.
> 
> So, the problem here is that if this is the last put then the node structure will be destroyed by of_node_release before we trace the of_node_put and we get no useful tracing information about the device node. Further, you see an out of order trace with the of_node_release preceding the final of_node_put. So, I opted for the somewhat ugly implementation you see where we do the subtraction ahead of time to yield what the refcount is about to be, and pass both the refcount and the node.

Excellent point.  The tracepoint does need to be before the kobject_put().
I don't normally like in function comments, but this would be an
exception - there should be a comment noting that the node might
be freed by the kobject_put(), so trace first.

I could argue with myself as to whether the count value should be before
or after it is decremented.  I understand why both ways are valid.
I would get rid of the "- 1", even if traced before the kobject_put(),
but I won't insist on the change.


>>
>>
>>>  		kobject_put(&node->kobj);
>>> +	}
>>>  }
>>>  EXPORT_SYMBOL(of_node_put);
>>>  
>>> @@ -75,24 +82,7 @@ const char *action_names[] = {
>>>  int of_reconfig_notify(unsigned long action, struct of_reconfig_data *p)
>>>  {
>>>  	int rc;
>>> -#ifdef DEBUG
>>> -	struct of_reconfig_data *pr = p;
>>> -
>>> -	switch (action) {
>>> -	case OF_RECONFIG_ATTACH_NODE:
>>> -	case OF_RECONFIG_DETACH_NODE:
>>> -		pr_debug("notify %-15s %pOF\n", action_names[action],
>>> -			pr->dn);
>>> -		break;
>>> -	case OF_RECONFIG_ADD_PROPERTY:
>>> -	case OF_RECONFIG_REMOVE_PROPERTY:
>>> -	case OF_RECONFIG_UPDATE_PROPERTY:
>>> -		pr_debug("notify %-15s %pOF:%s\n", action_names[action],
>>> -			pr->dn, pr->prop->name);
>>> -		break;
>>> -
>>> -	}
>>> -#endif
>>> +	trace_of_reconfig_notify(action, p);
>>>  	rc = blocking_notifier_call_chain(&of_reconfig_chain, action, p);
>>>  	return notifier_to_errno(rc);
>>>  }
>>> @@ -320,6 +310,8 @@ void of_node_release(struct kobject *kobj)
>>>  {
>>>  	struct device_node *node = kobj_to_device_node(kobj);
>>>  
>>> +	trace_of_node_release(node);
>>> +
>>>  	/* We should never be releasing nodes that haven't been detached. */
>>>  	if (!of_node_check_flag(node, OF_DETACHED)) {
>>>  		pr_err("ERROR: Bad of_node_put() on %pOF\n", node);
>>> diff --git a/include/trace/events/of.h b/include/trace/events/of.h
>>> new file mode 100644
>>> index 00000000000000..e8b1302a6f0129
>>> --- /dev/null
>>> +++ b/include/trace/events/of.h
>>> @@ -0,0 +1,93 @@
>>> +#undef TRACE_SYSTEM
>>> +#define TRACE_SYSTEM of
>>> +
>>> +#if !defined(_TRACE_OF_H) || defined(TRACE_HEADER_MULTI_READ)
>>> +#define _TRACE_OF_H
>>> +
>>> +#include <linux/of.h>
>>> +#include <linux/tracepoint.h>
>>> +
>>> +DECLARE_EVENT_CLASS(of_node_ref_template,
>>> +
>>> +	TP_PROTO(int refcount, const char *dn_name),
>>> +
>>> +	TP_ARGS(refcount, dn_name),
>>> +
>>> +	TP_STRUCT__entry(
>>> +		__string(dn_name, dn_name)
>>> +		__field(int, refcount)
>>> +	),
>>> +
>>> +	TP_fast_assign(
>>> +		__assign_str(dn_name, dn_name);
>>> +		__entry->refcount = refcount;
>>> +	),
>>> +
>>> +	TP_printk("refcount=%d, dn->full_name=%s",
>>
>> For version 1 of the patch, the example trace output was reformatted
>> by hand because the lines were so long.  it seems that it is easy to
>> create long lines and trace output, so extra effort on keeping the
>> lines shorter is well spent.
> 
> It was mostly due to my desire to keep commit logs under 80 columns wide. :)
My issue has nothing to do with the commit log.  The commit log simply helped
point a finger at the issue.

My issue has to do with the length of the line in the trace data.  Longer
lines and extraneous text in the data make data analysis messier.  Both
for humans looking at the data and for tools parsing the data.


>>
>> A little verbose.  I would prefer to get rid of "refcount=", ",",
>> and "dn->full_name=" entirely
>>
>>
>>> +		  __entry->refcount, __get_str(dn_name))
>>> +);
>>> +
>>> +DEFINE_EVENT(of_node_ref_template, of_node_get,
>>> +	     TP_PROTO(int refcount, const char *dn_name),
>>> +	     TP_ARGS(refcount, dn_name));
>>> +
>>> +DEFINE_EVENT(of_node_ref_template, of_node_put,
>>> +	     TP_PROTO(int refcount, const char *dn_name),
>>> +	     TP_ARGS(refcount, dn_name));
>>> +
>>> +TRACE_EVENT(of_node_release,
>>> +
>>> +	TP_PROTO(struct device_node *dn),
>>> +
>>> +	TP_ARGS(dn),
>>> +
>>> +	TP_STRUCT__entry(
>>> +		__string(dn_name, dn->full_name)
>>> +		__field(unsigned long, flags)
>>
>> Does not follow the alignment conventions for files in this directory.
>>
>> Steve: have you dropped the conventions or are they still relevant?
>>
>>
>>> +	),
>>> +
>>> +	TP_fast_assign(
>>> +		__assign_str(dn_name, dn->full_name);
>>> +		__entry->flags = dn->_flags;
>>> +	),
>>> +
>>> +	TP_printk("dn->full_name=%s, dn->_flags=%lu",
>>> +		  __get_str(dn_name), __entry->flags)
>>
>> That the first field is the node name should be obvious to the
>> person reading the trace, so ditch "dn->full_name=".  One
>> could argue that _flags is not so obvious, but if someone
>> is looking at why of_node_release() is being called, they
>> will either care about flag, in which case it will be obvious
>> that the flag value is being printed, or they won't care
>> about the flag value and will be ignoring it anyway.  So
>> I would ditch "dn->-flags=" also> 
>>
>>> +);
>>> +
>>> +#define of_reconfig_action_names \
>>> +	{OF_RECONFIG_ATTACH_NODE, "ATTACH_NODE"}, \
>>> +	{OF_RECONFIG_DETACH_NODE, "DETACH_NODE"}, \
>>> +	{OF_RECONFIG_ADD_PROPERTY, "ADD_PROPERTY"}, \
>>> +	{OF_RECONFIG_REMOVE_PROPERTY, "REMOVE_PROPERTY"}, \
>>> +	{OF_RECONFIG_UPDATE_PROPERTY, "UPDATE_PROPERTY"}
>>> +
>>> +TRACE_EVENT(of_reconfig_notify,
>>> +
>>> +	TP_PROTO(unsigned long action, struct of_reconfig_data *ord),
>>> +
>>> +	TP_ARGS(action, ord),
>>> +
>>> +	TP_STRUCT__entry(
>>> +		__field(unsigned long, action)
>>> +		__string(dn_name, ord->dn->full_name)
>>> +		__string(prop_name, ord->prop ? ord->prop->name : "null")
>>> +		__string(oldprop_name, ord->old_prop ? ord->old_prop->name : "null")
>>
>> Does not follow the alignment conventions for files in this directory.
>>
>>
>>> +	),
>>> +
>>> +	TP_fast_assign(
>>> +		__entry->action = action;
>>> +		__assign_str(dn_name, ord->dn->full_name);
>>> +		__assign_str(prop_name, ord->prop ? ord->prop->name : "null");
>>> +		__assign_str(oldprop_name, ord->old_prop ? ord->old_prop->name : "null");
>>> +	),
>>> +
>>> +	TP_printk("action=%s, dn->full_name=%s, prop->name=%s, old_prop->name=%s",
>>
>> Isn't old_prop->name the same as prop->name, if old_prop exists?  If so, drop
>> it.
>>
>> This is more verbose than the pr_debug() that is being replaced.  Please make
>> it more compact.
>>
>>
>>> +		  __print_symbolic(__entry->action, of_reconfig_action_names),
>>> +		  __get_str(dn_name), __get_str(prop_name), __get_str(oldprop_name))
>>> +);
>>> +
>>> +#endif /*	_TRACE_OF_H */
>>> +
>>> +/* This part must be outside protection */
>>> +#include <trace/define_trace.h>
>>>
>>
> 
> 
