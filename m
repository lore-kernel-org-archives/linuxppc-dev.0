Return-Path: <frowand.list@gmail.com>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com
 [IPv6:2607:f8b0:4001:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7mTv0DcbzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 14:43:47 +1000 (AEST)
Received: by mail-io0-x244.google.com with SMTP id k87so11756534ioi.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 21:43:46 -0700 (PDT)
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
To: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, robh+dt@kernel.org
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <58F6AA35.2040902@gmail.com> <87efwp6v4e.fsf@concordia.ellerman.id.au>
 <1d51a229-612b-bf09-93d5-6e43b476e2cf@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, nfont@linux.vnet.ibm.com, rostedt@goodmis.org,
 mingo@redhat.com
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <58F83C66.7030806@gmail.com>
Date: Wed, 19 Apr 2017 21:43:18 -0700
MIME-Version: 1.0
In-Reply-To: <1d51a229-612b-bf09-93d5-6e43b476e2cf@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/19/17 16:27, Tyrel Datwyler wrote:
> On 04/18/2017 06:31 PM, Michael Ellerman wrote:
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
>>
>> They also only cover the reconfig case, which is actually less
>> interesting than the much more common and bug-prone get/put logic.
>>
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
>>
>> But IMO this level of detail, tracing every get/put, does not belong in
>> printk. Trace points are absolutely the right solution for this type of
>> debugging.
> 
> Something else to keep in mind is that while pr_debugs could be used to
> provide feedback on the reference counts and of_reconfig events they
> don't in anyway tell us where they are happening in the kernel. The

Yes, that is critical information.  When there are refcount issues, the
root cause is at varying levels back in the call stack.


> trace infrastructure provides the ability to stack trace those events.
> The following example provides me a lot more information about who is
> doing what and where after I hot-add an ethernet adapter:
> 
> # echo stacktrace > /sys/kernel/debug/tracing/trace_options
> # cat trace | grep -A6 "/pci@800000020000018"
> ...
>            drmgr-7349  [006] d...  7138.821875: of_node_get: refcount=8,
> dn->full_name=/pci@800000020000018
>            drmgr-7349  [006] d...  7138.821876: <stack trace>
>  => .msi_quota_for_device
>  => .rtas_setup_msi_irqs
>  => .arch_setup_msi_irqs
>  => .__pci_enable_msix
>  => .pci_enable_msix_range

Nice!  It is great to have function names in the call stack.


> --
>            drmgr-7349  [006] d...  7138.821876: of_node_put: refcount=2,
> dn->full_name=/pci@800000020000018/ethernet@0
>            drmgr-7349  [006] d...  7138.821877: <stack trace>
>  => .msi_quota_for_device
>  => .rtas_setup_msi_irqs
>  => .arch_setup_msi_irqs
>  => .__pci_enable_msix
>  => .pci_enable_msix_range
> --
>            drmgr-7349  [006] ....  7138.821878: of_node_put: refcount=7,
> dn->full_name=/pci@800000020000018
>            drmgr-7349  [006] ....  7138.821879: <stack trace>
>  => .rtas_setup_msi_irqs
>  => .arch_setup_msi_irqs
>  => .__pci_enable_msix
>  => .pci_enable_msix_range
>  => .bnx2x_enable_msix
> --
> 
> To get that same info as far as I know is to add a dump_stack() after
> each pr_debug.

Here is a patch that I have used.  It is not as user friendly in terms
of human readable stack traces (though a very small user space program
should be able to fix that).  The patch is cut and pasted into this
email, so probably white space damaged.

Instead of dumping the stack, each line in the "report" contains
the top six addresses in the call stack.  If interesting, they
can be post-processed (as I will show in some examples below).

---
 drivers/of/dynamic.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

Index: b/drivers/of/dynamic.c
===================================================================
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/proc_fs.h>
+#include <linux/ftrace.h>
 
 #include "of_private.h"
 
@@ -27,6 +28,20 @@ struct device_node *of_node_get(struct d
 {
 	if (node)
 		kobject_get(&node->kobj);
+
+	if (node) {
+		int k;
+		int refcount = refcount_read(&node->kobj.kref.refcount);
+		pr_err("XXX get 0x%p %3d [0x%08lx 0x%08lx 0x%08lx 0x%08lx 0x%08lx 0x%08lx] ",
+			node, refcount,
+			CALLER_ADDR5, CALLER_ADDR4, CALLER_ADDR3,
+			CALLER_ADDR2, CALLER_ADDR1, CALLER_ADDR0);
+		// refcount = (refcount > 20) ? 20 : refcount; /* clamp max */
+		for (k = 0; k < refcount; k++)
+			pr_cont("+");
+		pr_cont(" %s\n", of_node_full_name(node));
+	}
+
 	return node;
 }
 EXPORT_SYMBOL(of_node_get);
@@ -38,8 +53,22 @@ EXPORT_SYMBOL(of_node_get);
  */
 void of_node_put(struct device_node *node)
 {
+	if (node) {
+		int k;
+		int refcount = refcount_read(&node->kobj.kref.refcount);
+		pr_err("XXX put 0x%p %3d [0x%08lx 0x%08lx 0x%08lx 0x%08lx 0x%08lx 0x%08lx] ",
+			node, refcount,
+			CALLER_ADDR5, CALLER_ADDR4, CALLER_ADDR3,
+			CALLER_ADDR2, CALLER_ADDR1, CALLER_ADDR0);
+		// refcount = (refcount > 20) ? 20 : refcount; /* clamp max */
+		for (k = 0; k < refcount; k++)
+			pr_cont("-");
+		pr_cont(" %s\n", of_node_full_name(node));
+	}
+
 	if (node)
 		kobject_put(&node->kobj);
+
 }
 EXPORT_SYMBOL(of_node_put);


I have used this mostly in the context of boot time, so there is a lot
of output.  My notes on configuration needed for my ARM boards are:

   FIXME: Currently using pr_err() so I don't need to set loglevel on boot.

          So obviously not a user friendly tool!!!
          The process is:
             - apply patch
             - configure, build, boot kernel
             - analyze data
             - remove patch

   LOG_BUF_SHIFT (was 17)
   General Setup ->
      [select 21] Kernel log buffer size (16 => 64KB, 17 => 128KB)


   Device Drivers ->
      Device Tree and Open Firmware support ->
        Device Tree overlays


Want CONFIG_FRAME_POINTER so that CALLER_ADDR* will work.
To be able to enable CONFIG_FRAME_POINTER, need to disable CONFIG_ARM_UNWIND.

   Kernel hacking ->
      [unselect] Enable stack unwinding support (EXPERIMENTAL)
      CONFIG_FRAME_POINTER will then be selected automatically


The output looks like:

[    0.231430] OF: XXX get 0xeefeb5dc   2 [0xc0814c58 0xc08148b0 0xc080e970 0xc080e894 0xc080e678 0xc080de7c] ++ /smp2p-adsp/slave-kernel
[    0.231457] OF: XXX get 0xeefeb5dc   3 [0xc08103c4 0xc0810024 0xc080fd94 0xc0814c58 0xc08149a8 0xc0814188] +++ /smp2p-adsp/slave-kernel
[    0.231495] OF: XXX get 0xeefeb5dc   4 [0xc08103c4 0xc0810024 0xc080fd94 0xc0814c58 0xc08149a8 0xc0814258] ++++ /smp2p-adsp/slave-kernel
[    0.231537] OF: XXX get 0xeefeb244   4 [0xc0810024 0xc080fd94 0xc0814c58 0xc08149a8 0xc0814278 0xc080ccc8] ++++ /smp2p-adsp
[    0.231568] OF: XXX put 0xeefeb5dc   4 [0xc08103c4 0xc0810024 0xc080fd94 0xc0814c58 0xc08149a8 0xc0814284] ---- /smp2p-adsp/slave-kernel
[    0.231610] OF: XXX get 0xeefe759c  23 [0xc0810024 0xc080fd94 0xc0814c58 0xc08149a8 0xc0814278 0xc080ccc8] +++++++++++++++++++++++ /
[    0.231702] OF: XXX put 0xeefeb244   4 [0xc08103c4 0xc0810024 0xc080fd94 0xc0814c58 0xc08149a8 0xc0814284] ---- /smp2p-adsp
[    0.231744] OF: XXX put 0xeefe759c  23 [0xc08103c4 0xc0810024 0xc080fd94 0xc0814c58 0xc08149a8 0xc0814284] ----------------------- /
[    0.231881] OF: XXX get 0xeefecb2c  22 [0xc0814c58 0xc08148b0 0xc080e970 0xc080e86c 0xc080e678 0xc080de7c] ++++++++++++++++++++++ /soc/interrupt-controller@f9000000
[    0.231972] OF: XXX put 0xeefecb2c  22 [0xc080fd94 0xc0814c58 0xc08148b0 0xc080e970 0xc080e894 0xc080e61c] ---------------------- /soc/interrupt-controller@f9000000
[    0.232101] OF: XXX get 0xeefeb5dc   4 [0xc0814c58 0xc08148b0 0xc080e970 0xc080e894 0xc080e678 0xc080de7c] ++++ /smp2p-adsp/slave-kernel
[    0.232134] OF: XXX put 0xeefeb5dc   4 [0xc080fd94 0xc0814c58 0xc08148b0 0xc080e970 0xc080e894 0xc080e61c] ---- /smp2p-adsp/slave-kernel
[    0.232178] OF: XXX get 0xeefeb5dc   4 [0xc0814c58 0xc08148b0 0xc080e970 0xc080e894 0xc080e678 0xc080de7c] ++++ /smp2p-adsp/slave-kernel
[    0.232211] OF: XXX get 0xeefeb5dc   5 [0xc08103c4 0xc0810024 0xc080fd94 0xc0814c58 0xc08149a8 0xc0814188] +++++ /smp2p-adsp/slave-kernel
[    0.232257] OF: XXX get 0xeefeb5dc   6 [0xc08103c4 0xc0810024 0xc080fd94 0xc0814c58 0xc08149a8 0xc0814258] ++++++ /smp2p-adsp/slave-kernel
[    0.232308] OF: XXX get 0xeefeb244   4 [0xc0810024 0xc080fd94 0xc0814c58 0xc08149a8 0xc0814278 0xc080ccc8] ++++ /smp2p-adsp
[    0.232339] OF: XXX put 0xeefeb5dc   6 [0xc08103c4 0xc0810024 0xc080fd94 0xc0814c58 0xc08149a8 0xc0814284] ------ /smp2p-adsp/slave-kernel
[    0.232390] OF: XXX get 0xeefe759c  23 [0xc0810024 0xc080fd94 0xc0814c58 0xc08149a8 0xc0814278 0xc080ccc8] +++++++++++++++++++++++ /
[    0.232482] OF: XXX put 0xeefeb244   4 [0xc08103c4 0xc0810024 0xc080fd94 0xc0814c58 0xc08149a8 0xc0814284] ---- /smp2p-adsp



But I normally strip off the timestamp, and grep for the "OF: XXX ",
which gets me only the get and put info.  It is also easy to grep
for a single node of interest.

The data fields are:
  get or put
  the struct device_node address
  refcount
  a 6 caller deep call stack
  for get, one '+' per refcount or for put, one '-' per refcount
  the full node name

The refcount for get is the post get value, for put is the pre put value,
so they are easy to match up for human scanning. The length of the "++++"
and "----" patterns on the end are also intended for easy human scanning.

Here are two actual refcount issues for the root node on my 4.11-rc1:

OF: XXX get 0xeefe759c   2 [0xc08138bc 0xc08137fc 0xc08136e4 0xc08136b4 0xc0813070 0xc080ccc8] ++ /
OF: XXX put 0xeefe759c   2 [0xc031aa28 0xc08138bc 0xc08137fc 0xc08136e4 0xc08136b4 0xc0813014] -- /
OF: XXX get 0xeefe759c   2 [0xc08138bc 0xc08137fc 0xc08136e4 0xc08136b4 0xc0813070 0xc080ccc8] ++ /
OF: XXX put 0xeefe759c   2 [0xc031aa40 0xc08138bc 0xc08137fc 0xc08136e4 0xc08136b4 0xc0813014] -- /
OF: XXX get 0xeefe759c  22 [0xc0308518 0xc09330e0 0xc0d00e3c 0xc03017d0 0xc0d3a1fc 0xc080d948] ++++++++++++++++++++++ /
OF: XXX put 0xeefe759c  22 [0xc0308518 0xc09330e0 0xc0d00e3c 0xc03017d0 0xc0d3a1fc 0xc080d8c8] ---------------------- /
OF: XXX get 0xeefe759c  22 [0xc0d00e3c 0xc03017d0 0xc0d3a234 0xc0810684 0xc081061c 0xc080d928] ++++++++++++++++++++++ /
OF: XXX get 0xeefe759c  23 [0xc08103c4 0xc0810024 0xc080fd84 0xc08137b4 0xc0812c88 0xc080ccc8] +++++++++++++++++++++++ /
OF: XXX put 0xeefe759c  23 [0xc08105d8 0xc08103c4 0xc0810024 0xc080fd84 0xc08137b4 0xc0812cb4] ----------------------- /

The call stack could easily be post-processed, for example using addr2line.
Here is the call stack for when the refcount incremented to 23 from 22 (or
more accurately, to 22 from 21):

0xc0d00e3c Line 857 of "init/main.c"
0xc03017d0 Line 792 of "init/main.c"
0xc0d3a234 Line 528 of "drivers/of/platform.c"
0xc0810684 Line 503 of "drivers/of/platform.c"
0xc081061c Line 267 of "include/linux/of.h"
0xc080d928 Line 815 of "drivers/of/base.c"

Which ends up being this code:

   of_platform_default_populate_init()
      of_platform_default_populate()
         of_platform_populate()
            [[ of_find_node_by_path("/") ]]
               [[ of_find_node_opts_by_path(path, NULL) ]]
                  of_node_get(of_root)

Note that some functions can be left out of the ARM call stack, with
a return going back more than one level.  The functions in the call
list above that are enclosed in '[[' and ']]' were found by source
inspection in those cases.

It looks like a put is missing, but about 250 get/put pairs later,
of_platform_populate() does the required put on node "/".

Then quite a bit later, after lots of balanced gets and puts, there is an
initcall that does a get on the root without a corresponding put.


The jump from refcount 2 to refcount 22 is an interesting case, insofar as it
is not the result of of_node_get().  It is instead inside a series of calls to
kobject_add():

   kernel_init()
      kernel_init_freeable()
        do_basic_setup()
            driver_init()
               of_core_init()
                  for_each_of_allnodes(np)
                     __of_attach_node_sysfs(np)
                        kobject_add()


Filtering and reformatting is "easily done" with grep and other
normal unix tools.

For example, a simple stream of command line tools can show a
streamlined report of the refcounts of a single node (in this
case the root node), which can easily be scanned for interesting
events:

[    0.199569]    2  ++ /
[    0.199629]    2  -- /
[    0.199826]    2  ++ /
[    0.199886]    2  -- /
[    0.212549]   22  ++++++++++++++++++++++ /
[    0.212855]   22  ---------------------- /
[    0.213087]   22  ++++++++++++++++++++++ /
[    0.213700]   23  +++++++++++++++++++++++ /
[    0.213797]   23  ----------------------- /
[    0.213973]   23  +++++++++++++++++++++++ /

... hundreds of boring put/get pairs

[    0.458737]   23  ----------------------- /
[    0.458909]   23  +++++++++++++++++++++++ /
[    0.459035]   23  ----------------------- /
[    0.459305]   22  ---------------------- /
[    0.470255]   22  ++++++++++++++++++++++ /

... hundreds of boring put/get pairs

[   93.110548]   22  ++++++++++++++++++++++ /
[   93.140046]   22  ---------------------- /
[   93.264639]   22  ++++++++++++++++++++++ /
[   93.389530]   23  +++++++++++++++++++++++ /
[   93.414269]   23  ----------------------- /


You might have noticed that the call trace is not interesting for
most of the gets and puts.  There are over 350 get/put pairs for
the root node in the boot that I collected the above examples on,
but only a few instances where the trace matters.  Thus leaving
the call stack in a compact format until needed is a feature.

I will be the first to admit that the tool is not polished and not
easy to use, though it is easily extended with post-processing.

I wrote the patch as a proof of concept a while ago and have not
fleshed it out.  In fact, calling it a "tool" is overstating what
it is.


> Further, filters can be set on the tracepoint event fields such that
> trace data could be restricted to a particular device_node or refcount
> threshold. For example:
> 
> # cd /sys/kernel/debug/tracing# cat events/of/of_node_get/format
> # echo "dn_name == /pci@800000020000018" > events/of/filter
> 
> # cat trace
>            drmgr-10542 [003] ....  9630.677001: of_node_put: refcount=5,
> dn->full_name=/pci@800000020000018
>            drmgr-10542 [003] d...  9631.677368: of_node_get: refcount=6,
> dn->full_name=/pci@800000020000018
>            drmgr-10542 [003] ....  9631.677389: of_node_put: refcount=5,
> dn->full_name=/pci@800000020000018
>            drmgr-10542 [003] ....  9631.677390: of_reconfig_notify:
> action=DETACH_NODE, dn->full_name=/pci@800000020000018, prop->name=null,
> old_prop->name=null
>            drmgr-10542 [003] .n..  9632.025656: of_node_put: refcount=4,
> dn->full_name=/pci@800000020000018
>            drmgr-10542 [003] .n..  9632.025657: of_node_put: refcount=3,
> dn->full_name=/pci@800000020000018
> 
> After setting the filter and doing a hot-remove of the pci device in
> question the trace quickly tells me 3 references are being leaked. In
> combination with the stacktrace option I can quickly correlate call
> sites that take references without releasing them.

Thanks for sharing that.  It is nice seeing your results.


> -Tyrel
> 
>>
>> cheers
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 
