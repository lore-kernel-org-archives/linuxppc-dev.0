Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWyCb0dWFzDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 21:11:07 +1100 (AEDT)
In-Reply-To: <20170221150047.7460-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Anju T <anju@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: powerpc: optprobes: fix TOC handling in optprobes trampoline
Message-Id: <3vWyCZ6pK5z9sN5@ozlabs.org>
Date: Mon, 27 Feb 2017 21:11:06 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-21 at 15:00:47 UTC, "Naveen N. Rao" wrote:
> Optprobes on powerpc is limited to kernel text area. We decided to also
> optimize kretprobe_trampoline since that is also in kernel text area.
> However,we failed to take into consideration the fact that the same
> trampoline is also used to catch function returns from kernel modules.
> As an example:
> 
>     $ sudo modprobe kobject-example
>     $ sudo bash -c "echo 'r foo_show+8' > /sys/kernel/debug/tracing/kprobe_events"
>     $ sudo bash -c "echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable"
>     $ sudo cat /sys/kernel/debug/kprobes/list
>     c000000000041350  k  kretprobe_trampoline+0x0    [OPTIMIZED]
>     d000000000e00200  r  foo_show+0x8  kobject_example
>     $ cat /sys/kernel/kobject_example/foo
>     Segmentation fault
> 
> With the below (trimmed) splat in dmesg:
> 
>     [70646.248029] Unable to handle kernel paging request for data at address 0xfec40000
>     [70646.248730] Faulting instruction address: 0xc000000000041540
>     [70646.249210] Oops: Kernel access of bad area, sig: 11 [#1]
>     [snip]
>     [70646.259635] NIP [c000000000041540] optimized_callback+0x70/0xe0
>     [70646.259962] LR [c000000000041e60] optinsn_slot+0xf8/0x10000
>     [70646.260268] Call Trace:
>     [70646.260583] [c0000000c7327850] [c000000000289af4] alloc_set_pte+0x1c4/0x860 (unreliable)
>     [70646.260910] [c0000000c7327890] [c000000000041e60] optinsn_slot+0xf8/0x10000
>     [70646.261223] --- interrupt: 700 at 0xc0000000c7327a80
> 		       LR = kretprobe_trampoline+0x0/0x10
>     [70646.261849] [c0000000c7327ba0] [c0000000003a30d4] sysfs_kf_seq_show+0x104/0x1d0
>     [70646.262135] [c0000000c7327bf0] [c0000000003a0bb4] kernfs_seq_show+0x44/0x60
>     [70646.264211] [c0000000c7327c10] [c000000000330578] seq_read+0xf8/0x560
>     [70646.265142] [c0000000c7327cb0] [c0000000003a1e64] kernfs_fop_read+0x194/0x260
>     [70646.266070] [c0000000c7327d00] [c0000000002f9954] __vfs_read+0x44/0x1a0
>     [70646.266977] [c0000000c7327d90] [c0000000002fb4cc] vfs_read+0xbc/0x1b0
>     [70646.267860] [c0000000c7327de0] [c0000000002fd138] SyS_read+0x68/0x110
>     [70646.268701] [c0000000c7327e30] [c00000000000b8e0] system_call+0x38/0xfc
>     [snip]
> 
> Fix this by loading up the kernel TOC before calling into the kernel.
> The original TOC gets restored as part of the usual pt_regs restore.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f558b37bf4c35a54e1949f6533f39c

cheers
