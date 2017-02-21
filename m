Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSNx14T3rzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 02:01:09 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1LExXQ9060893
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 10:01:07 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28rq819tuh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 10:01:06 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 20:31:03 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 2657B394004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 20:31:01 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1LF11CH39125060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 20:31:01 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1LF0wvw021535
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 20:31:00 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anju T <anju@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: optprobes: fix TOC handling in optprobes trampoline
Date: Tue, 21 Feb 2017 20:30:47 +0530
Message-Id: <20170221150047.7460-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Optprobes on powerpc is limited to kernel text area. We decided to also
optimize kretprobe_trampoline since that is also in kernel text area.
However,we failed to take into consideration the fact that the same
trampoline is also used to catch function returns from kernel modules.
As an example:

    $ sudo modprobe kobject-example
    $ sudo bash -c "echo 'r foo_show+8' > /sys/kernel/debug/tracing/kprobe_events"
    $ sudo bash -c "echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable"
    $ sudo cat /sys/kernel/debug/kprobes/list
    c000000000041350  k  kretprobe_trampoline+0x0    [OPTIMIZED]
    d000000000e00200  r  foo_show+0x8  kobject_example
    $ cat /sys/kernel/kobject_example/foo
    Segmentation fault

With the below (trimmed) splat in dmesg:

    [70646.248029] Unable to handle kernel paging request for data at address 0xfec40000
    [70646.248730] Faulting instruction address: 0xc000000000041540
    [70646.249210] Oops: Kernel access of bad area, sig: 11 [#1]
    [snip]
    [70646.259635] NIP [c000000000041540] optimized_callback+0x70/0xe0
    [70646.259962] LR [c000000000041e60] optinsn_slot+0xf8/0x10000
    [70646.260268] Call Trace:
    [70646.260583] [c0000000c7327850] [c000000000289af4] alloc_set_pte+0x1c4/0x860 (unreliable)
    [70646.260910] [c0000000c7327890] [c000000000041e60] optinsn_slot+0xf8/0x10000
    [70646.261223] --- interrupt: 700 at 0xc0000000c7327a80
		       LR = kretprobe_trampoline+0x0/0x10
    [70646.261849] [c0000000c7327ba0] [c0000000003a30d4] sysfs_kf_seq_show+0x104/0x1d0
    [70646.262135] [c0000000c7327bf0] [c0000000003a0bb4] kernfs_seq_show+0x44/0x60
    [70646.264211] [c0000000c7327c10] [c000000000330578] seq_read+0xf8/0x560
    [70646.265142] [c0000000c7327cb0] [c0000000003a1e64] kernfs_fop_read+0x194/0x260
    [70646.266070] [c0000000c7327d00] [c0000000002f9954] __vfs_read+0x44/0x1a0
    [70646.266977] [c0000000c7327d90] [c0000000002fb4cc] vfs_read+0xbc/0x1b0
    [70646.267860] [c0000000c7327de0] [c0000000002fd138] SyS_read+0x68/0x110
    [70646.268701] [c0000000c7327e30] [c00000000000b8e0] system_call+0x38/0xfc
    [snip]

Fix this by loading up the kernel TOC before calling into the kernel.
The original TOC gets restored as part of the usual pt_regs restore.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/optprobes_head.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/optprobes_head.S b/arch/powerpc/kernel/optprobes_head.S
index 53e429b5a29d..bf28188f308c 100644
--- a/arch/powerpc/kernel/optprobes_head.S
+++ b/arch/powerpc/kernel/optprobes_head.S
@@ -65,6 +65,13 @@ optprobe_template_entry:
 	mfdsisr	r5
 	std	r5,_DSISR(r1)
 
+	/*
+	 * We may get here from a module, so load the kernel TOC in r2.
+	 * The original TOC gets restored when pt_regs is restored
+	 *  further below.
+	 */
+	ld	r2,PACATOC(r13)
+
 	.global optprobe_template_op_address
 optprobe_template_op_address:
 	/*
-- 
2.11.0
