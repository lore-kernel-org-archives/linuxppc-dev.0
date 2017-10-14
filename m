Return-Path: <chandan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yDnHM0WftzDrF3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 01:37:33 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9EEXaFF034721
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 10:37:29 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dkefebj08-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 10:37:29 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <chandan@linux.vnet.ibm.com>;
 Sat, 14 Oct 2017 15:37:27 +0100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9EEbNj815466594
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Oct 2017 14:37:24 GMT
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9EEbGKS031001
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 01:37:16 +1100
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next <linux-next@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: BUG_ON() in irq_work_run_list
Date: Sat, 14 Oct 2017 20:08:16 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1623847.FRxUFVXF3V@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Executing fstests' generic/036 test in a loop on next-20171013 kernel causes
BUG_ON()'s condition to evaluate to true,

run fstests generic/036 at 2017-10-14 09:23:29
------------[ cut here ]------------
kernel BUG at /root/repos/linux/kernel/irq_work.c:138!
Oops: Exception in kernel mode, sig: 5 [#1]
BE SMP NR_CPUS=2048 DEBUG_PAGEALLOC NUMA pSeries
Modules linked in:
CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W        4.14.0-rc4-next-20171013 #7
task: c00000063862c780 task.stack: c0000006387e4000
NIP:  c0000000002476ac LR: c0000000002477c8 CTR: 0000000000000000
REGS: c00000063ffd3810 TRAP: 0700   Tainted: G        W         (4.14.0-rc4-next-20171013)
MSR:  8000000000029032 <SF,EE,ME,IR,DR,RI>  CR: 24002442  XER: 20000000
CFAR: c0000000002477c4 SOFTE: 1
GPR00: c0000000001b70c4 c00000063ffd3a90 c00000000143bb00 c00000063fee1a60
GPR04: 000000000000002b c000000635ad1b0c c00000063383c9e8 0000000000000000
GPR08: 000000063ecd0000 0000000000000001 0000000000000001 0000000000000000
GPR12: 0000000028002482 c00000000fd41080 c0000006387e7f90 0000000000000200
GPR16: f000000000b048c0 0000000000000000 c0000000013a0920 c0000000013a0920
GPR20: 0000000000000003 0000000000000000 0000000000000001 0000000000000002
GPR24: 0000000000000010 c00000063e22c498 c00000063ffd3df0 0000000000000000
GPR28: 000000063ecd0000 0000000000000000 0000000000000000 c000000001211a60
NIP [c0000000002476ac] .irq_work_run_list+0xc/0x100
LR [c0000000002477c8] .irq_work_run+0x28/0x50
Call Trace:
[c00000063ffd3a90] [c000000000787638] .__blk_mq_complete_request_remote+0x38/0x50 (unreliable)
[c00000063ffd3b10] [c0000000001b70c4] .flush_smp_call_function_queue+0xd4/0x1e0
[c00000063ffd3ba0] [c000000000044a4c] .smp_ipi_demux_relaxed+0x9c/0x110
[c00000063ffd3c30] [c00000000008dbdc] .icp_hv_ipi_action+0x5c/0xb0
[c00000063ffd3cb0] [c000000000174384] .__handle_irq_event_percpu+0x94/0x2d0
[c00000063ffd3d80] [c0000000001745f4] .handle_irq_event_percpu+0x34/0x90
[c00000063ffd3e10] [c00000000017ae20] .handle_percpu_irq+0x80/0xd0
[c00000063ffd3e90] [c000000000172ad0] .generic_handle_irq+0x50/0x80
[c00000063ffd3f10] [c000000000016cd0] .__do_irq+0x90/0x210
[c00000063ffd3f90] [c00000000002a900] .call_do_irq+0x14/0x24
[c0000006387e77a0] [c000000000016ee0] .do_IRQ+0x90/0x140
[c0000006387e7840] [c000000000008c20] hardware_interrupt_common+0x150/0x160
--- interrupt: 501 at .plpar_hcall_norets+0x14/0x20
    LR = .check_and_cede_processor+0x2c/0x40
[c0000006387e7b30] [c000000000b3f028] .check_and_cede_processor+0x18/0x40 (unreliable)
[c0000006387e7ba0] [c000000000b3f3c8] .shared_cede_loop+0x48/0x140
[c0000006387e7c20] [c000000000b3c644] .cpuidle_enter_state+0xa4/0x410
[c0000006387e7cd0] [c000000000159158] .call_cpuidle+0x68/0xd0
[c0000006387e7d60] [c000000000159640] .do_idle+0x2b0/0x310
[c0000006387e7e20] [c0000000001598b0] .cpu_startup_entry+0x30/0x40
[c0000006387e7ea0] [c000000000045e38] .start_secondary+0x4e8/0x530
[c0000006387e7f90] [c00000000000b06c] start_secondary_prolog+0x10/0x14
Instruction dump:
38600001 4e800020 60000000 60000000 60000000 38600000 4e800020 60000000
60000000 894d027a 312affff 7d295110 <0b090000> e9230000 2fa90000 4d9e0020
---[ end trace 921006f210ad28ba ]---

The corresponding code is,

static void irq_work_run_list(struct llist_head *list)
{
        unsigned long flags;
        struct irq_work *work;
        struct llist_node *llnode;

        BUG_ON(!irqs_disabled());


-- 
chandan
