Return-Path: <turtle.in.the.kernel@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7dSg61jMzDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 09:27:15 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id t52so5329495qtb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 16:27:15 -0700 (PDT)
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
To: Michael Ellerman <mpe@ellerman.id.au>,
 Frank Rowand <frowand.list@gmail.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, robh+dt@kernel.org
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <58F6AA35.2040902@gmail.com> <87efwp6v4e.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, nfont@linux.vnet.ibm.com, rostedt@goodmis.org,
 mingo@redhat.com
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <1d51a229-612b-bf09-93d5-6e43b476e2cf@gmail.com>
Date: Wed, 19 Apr 2017 16:27:10 -0700
MIME-Version: 1.0
In-Reply-To: <87efwp6v4e.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/18/2017 06:31 PM, Michael Ellerman wrote:
> Frank Rowand <frowand.list@gmail.com> writes:
> 
>> On 04/17/17 17:32, Tyrel Datwyler wrote:
>>> This patch introduces event tracepoints for tracking a device_nodes
>>> reference cycle as well as reconfig notifications generated in response
>>> to node/property manipulations.
>>>
>>> With the recent upstreaming of the refcount API several device_node
>>> underflows and leaks have come to my attention in the pseries (DLPAR) dynamic
>>> logical partitioning code (ie. POWER speak for hotplugging virtual and physcial
>>> resources at runtime such as cpus or IOAs). These tracepoints provide a
>>> easy and quick mechanism for validating the reference counting of
>>> device_nodes during their lifetime.
>>>
>>> Further, when pseries lpars are migrated to a different machine we
>>> perform a live update of our device tree to bring it into alignment with the
>>> configuration of the new machine. The of_reconfig_notify trace point
>>> provides a mechanism that can be turned for debuging the device tree
>>> modifications with out having to build a custom kernel to get at the
>>> DEBUG code introduced by commit 00aa3720.
>>
>> I do not like changing individual (or small groups of) printk() style
>> debugging information to tracepoint style.
> 
> I'm not quite sure which printks() you're referring to.
> 
> The only printks that are removed in this series are under #ifdef DEBUG,
> and so are essentially not there unless you build a custom kernel.
> 
> They also only cover the reconfig case, which is actually less
> interesting than the much more common and bug-prone get/put logic.
> 
>> As far as I know, there is no easy way to combine trace data and printk()
>> style data to create a single chronology of events.  If some of the
>> information needed to debug an issue is trace data and some is printk()
>> style data then it becomes more difficult to understand the overall
>> situation.
> 
> If you enable CONFIG_PRINTK_TIME then you should be able to just sort
> the trace and the printk output by the timestamp. If you're really
> trying to correlate the two then you should probably just be using
> trace_printk().
> 
> But IMO this level of detail, tracing every get/put, does not belong in
> printk. Trace points are absolutely the right solution for this type of
> debugging.

Something else to keep in mind is that while pr_debugs could be used to
provide feedback on the reference counts and of_reconfig events they
don't in anyway tell us where they are happening in the kernel. The
trace infrastructure provides the ability to stack trace those events.
The following example provides me a lot more information about who is
doing what and where after I hot-add an ethernet adapter:

# echo stacktrace > /sys/kernel/debug/tracing/trace_options
# cat trace | grep -A6 "/pci@800000020000018"
...
           drmgr-7349  [006] d...  7138.821875: of_node_get: refcount=8,
dn->full_name=/pci@800000020000018
           drmgr-7349  [006] d...  7138.821876: <stack trace>
 => .msi_quota_for_device
 => .rtas_setup_msi_irqs
 => .arch_setup_msi_irqs
 => .__pci_enable_msix
 => .pci_enable_msix_range
--
           drmgr-7349  [006] d...  7138.821876: of_node_put: refcount=2,
dn->full_name=/pci@800000020000018/ethernet@0
           drmgr-7349  [006] d...  7138.821877: <stack trace>
 => .msi_quota_for_device
 => .rtas_setup_msi_irqs
 => .arch_setup_msi_irqs
 => .__pci_enable_msix
 => .pci_enable_msix_range
--
           drmgr-7349  [006] ....  7138.821878: of_node_put: refcount=7,
dn->full_name=/pci@800000020000018
           drmgr-7349  [006] ....  7138.821879: <stack trace>
 => .rtas_setup_msi_irqs
 => .arch_setup_msi_irqs
 => .__pci_enable_msix
 => .pci_enable_msix_range
 => .bnx2x_enable_msix
--

To get that same info as far as I know is to add a dump_stack() after
each pr_debug.

Further, filters can be set on the tracepoint event fields such that
trace data could be restricted to a particular device_node or refcount
threshold. For example:

# cd /sys/kernel/debug/tracing# cat events/of/of_node_get/format
# echo "dn_name == /pci@800000020000018" > events/of/filter

# cat trace
           drmgr-10542 [003] ....  9630.677001: of_node_put: refcount=5,
dn->full_name=/pci@800000020000018
           drmgr-10542 [003] d...  9631.677368: of_node_get: refcount=6,
dn->full_name=/pci@800000020000018
           drmgr-10542 [003] ....  9631.677389: of_node_put: refcount=5,
dn->full_name=/pci@800000020000018
           drmgr-10542 [003] ....  9631.677390: of_reconfig_notify:
action=DETACH_NODE, dn->full_name=/pci@800000020000018, prop->name=null,
old_prop->name=null
           drmgr-10542 [003] .n..  9632.025656: of_node_put: refcount=4,
dn->full_name=/pci@800000020000018
           drmgr-10542 [003] .n..  9632.025657: of_node_put: refcount=3,
dn->full_name=/pci@800000020000018

After setting the filter and doing a hot-remove of the pci device in
question the trace quickly tells me 3 references are being leaked. In
combination with the stacktrace option I can quickly correlate call
sites that take references without releasing them.

-Tyrel

> 
> cheers
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
