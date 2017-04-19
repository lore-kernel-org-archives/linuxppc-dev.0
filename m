Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7VyJ25F2zDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 04:33:59 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JITgdT057700
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 14:33:57 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29x753b72w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 14:33:57 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 19 Apr 2017 12:33:56 -0600
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
To: Frank Rowand <frowand.list@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, robh+dt@kernel.org
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <58F6AA35.2040902@gmail.com> <87efwp6v4e.fsf@concordia.ellerman.id.au>
 <58F6CBF9.7060000@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, mingo@redhat.com, nfont@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Wed, 19 Apr 2017 11:33:47 -0700
MIME-Version: 1.0
In-Reply-To: <58F6CBF9.7060000@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <d291d007-d7c2-4642-ef04-b926c56b9003@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/18/2017 07:31 PM, Frank Rowand wrote:
> On 04/18/17 18:31, Michael Ellerman wrote:
>> Frank Rowand <frowand.list@gmail.com> writes:
>>
>>> On 04/17/17 17:32, Tyrel Datwyler wrote:
>>>> This patch introduces event tracepoints for tracking a device_nodes
>>>> reference cycle as well as reconfig notifications generated in response
>>>> to node/property manipulations.
>>>>
>>>> With the recent upstreaming of the refcount API several device_node
>>>> underflows and leaks have come to my attention in the pseries (DLPAR) dynamic
>>>> logical partitioning code (ie. POWER speak for hotplugging virtual and physcial
>>>> resources at runtime such as cpus or IOAs). These tracepoints provide a
>>>> easy and quick mechanism for validating the reference counting of
>>>> device_nodes during their lifetime.
>>>>
>>>> Further, when pseries lpars are migrated to a different machine we
>>>> perform a live update of our device tree to bring it into alignment with the
>>>> configuration of the new machine. The of_reconfig_notify trace point
>>>> provides a mechanism that can be turned for debuging the device tree
>>>> modifications with out having to build a custom kernel to get at the
>>>> DEBUG code introduced by commit 00aa3720.
>>>
>>> I do not like changing individual (or small groups of) printk() style
>>> debugging information to tracepoint style.
>>
>> I'm not quite sure which printks() you're referring to.
>>
>> The only printks that are removed in this series are under #ifdef DEBUG,
>> and so are essentially not there unless you build a custom kernel.
> 
> Yes, I am talking about pr_debug(), pr_info(), pr_err(), etc.
> 
> 
>>
>> They also only cover the reconfig case, which is actually less
>> interesting than the much more common and bug-prone get/put logic.
> 
> When I was looking at the get/put issue I used pr_debug().
> 
> 
>>> As far as I know, there is no easy way to combine trace data and printk()
>>> style data to create a single chronology of events.  If some of the
>>> information needed to debug an issue is trace data and some is printk()
>>> style data then it becomes more difficult to understand the overall
>>> situation.
>>
>> If you enable CONFIG_PRINTK_TIME then you should be able to just sort
>> the trace and the printk output by the timestamp. If you're really
>> trying to correlate the two then you should probably just be using
>> trace_printk().
> 
> Except the existing debug code that uses pr_debug() does not use
> trace_printk().
> 
> And "just sort" does not apply to multi-line output like:
> 
> cpuhp/23-147   [023] ....   128.324827:
> 	of_node_put: refcount=5, dn->full_name=/cpus/PowerPC,POWER8@10
> cpuhp/23-147   [023] ....   128.324829:
> 	of_node_put: refcount=4, dn->full_name=/cpus/PowerPC,POWER8@10
> cpuhp/23-147   [023] ....   128.324829:
> 	of_node_put: refcount=3, dn->full_name=/cpus/PowerPC,POWER8@10
> cpuhp/23-147   [023] ....   128.324831:
> 	of_node_put: refcount=2, dn->full_name=/cpus/PowerPC,POWER8@10
>    drmgr-7284  [009] ....   128.439000:
> 	of_node_put: refcount=1, dn->full_name=/cpus/PowerPC,POWER8@10
>    drmgr-7284  [009] ....   128.439002:
> 	of_reconfig_notify: action=DETACH_NODE, dn->full_name=/cpus/PowerPC,POWER8@10,
> 			    prop->name=null, old_prop->name=null
>    drmgr-7284  [009] ....   128.439015:
> 	of_node_put: refcount=0, dn->full_name=/cpus/PowerPC,POWER8@10
>    drmgr-7284  [009] ....   128.439016:
> 	of_node_release: dn->full_name=/cpus/PowerPC,POWER8@10, dn->_flags=4
> 
> I was kinda hoping that maybe someone had already created a tool to deal
> with this issue.  But not too optimistic.

This output was actually broken into multiple lines for the commit
message. Each trace point is actually a single line in the trace buffer.
This output was pulled from the trace buffer with the following:

cat /sys/kernel/debug/trace/tracing | grep "POWER8@10"

-Tyrel

> 
> 
>> But IMO this level of detail, tracing every get/put, does not belong in
>> printk. Trace points are absolutely the right solution for this type of
>> debugging.
>>
>> cheers
>> .
>>
> 
