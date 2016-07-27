Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rztjd2py0zDqPG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 21:55:49 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id cf3so1663494pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 04:55:49 -0700 (PDT)
Date: Wed, 27 Jul 2016 21:55:42 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PowerPC] Kernel OOPS while compiling LTP test suite on linus
 mainline
Message-ID: <20160727115542.GB3720@350D>
Reply-To: bsingharora@gmail.com
References: <2a9abff6-7820-a95b-0de3-8e6723707cb6@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2a9abff6-7820-a95b-0de3-8e6723707cb6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 27, 2016 at 04:45:35PM +0530, Abdul Haleem wrote:
> Hi,
> 
> Kernel OOPS messages were seen while compiling linux test project (LTP) source on 4.7.0-rc5 mainline.
> 
> Kernel config : pseries_le_defconfig
> Machine Type  : PowerVM LPAR
> Machine hardware : LPAR uses 16 vCPUs, and 29G memory
> 
> trace messages:
> *15:34:57* [  862.548866] Unable to handle kernel paging request for data at address 0x00000000
> *15:34:57* [  862.548904] Faulting instruction address: 0xc000000000260900
> *15:34:57* [  862.548911] Oops: Kernel access of bad area, sig: 11 [#1]
> *15:34:57* [  862.548917] SMP NR_CPUS=2048 NUMA pSeries
> *15:34:57* [  862.548924] Modules linked in: rtc_generic(E) pseries_rng(E) autofs4(E)
> *15:34:57* [  862.548938] CPU: 0 PID: 129 Comm: kswapd2 Tainted: G            E   4.7.0-rc5-autotest #1
> *15:34:57* [  862.548946] task: c0000007766a2600 ti: c000000776764000 task.ti: c000000776764000
> *15:34:57* [  862.548953] NIP: c000000000260900 LR: c00000000026452c CTR: 0000000000000000
> *15:34:57* [  862.548961] REGS: c000000776767830 TRAP: 0300   Tainted: G            E    (4.7.0-rc5-autotest)
> *15:34:57* [  862.548968] MSR: 800000010280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 24000222  XER: 20000001
> *15:34:57* [  862.548996] CFAR: c000000000008468 DAR: 0000000000000000 DSISR: 40000000 SOFTE: 0
> *15:34:57* GPR00: c00000000026452c c000000776767ab0 c0000000013ac100 c00000077ff54200
> *15:34:57* GPR04: 0000000000000000 c000000776767ba0 0000000000000001 c00000000151c100
> *15:34:57* GPR08: 0000000000000000 00000000000b4057 0000000080000000 c00000071664b7a0
> *15:34:57* GPR12: 0000000000000000 c00000000e800000 0000000000000001 f0000000015dc000
> *15:34:57* GPR16: c00000077ff54700 0000000000000000 0000000000000000 c00000077ff54700
> *15:34:57* GPR20: 0000000000000001 0000000000000100 0000000000000200 c00000077ff54200
> *15:34:57* GPR24: c000000776767ba0 0000000000000020 0000000000000000 0000000000000001
> *15:34:57* GPR28: 0000000000000010 0000000000000000 c000000776767ba0 f0000000015dc020
> *15:34:57* [  862.549094] NIP [c000000000260900] move_active_pages_to_lru.isra.16+0xa0/0x380
> *15:34:57* [  862.549102] LR [c00000000026452c] shrink_active_list+0x2fc/0x510
> *15:34:57* [  862.549108] Call Trace:
> *15:34:57* [  862.549112] [c000000776767ab0] [f0000000015dc000] 0xf0000000015dc000 (unreliable)
> *15:34:57* [  862.549122] [c000000776767b60] [c00000000026452c] shrink_active_list+0x2fc/0x510
> *15:34:57* [  862.549131] [c000000776767c50] [c0000000002665d4] kswapd+0x434/0xa70
> *15:34:57* [  862.549139] [c000000776767d80] [c0000000000f1b50] kthread+0x110/0x130
> *15:34:57* [  862.549148] [c000000776767e30] [c0000000000095f0] ret_from_kernel_thread+0x5c/0x6c
> *15:34:57* [  862.549155] Instruction dump:
> *15:34:57* [  862.549161] 60000000 3b200020 3a800001 7b7c26e4 3aa00100 3ac00200 3a400000 3a770500
> *15:34:57* [  862.549174] 3a200000 60000000 60000000 60420000 <e93d0000> 7fbd4840 419e01b8 ebfd0008
> *15:34:57* [  862.549193] ---[ end trace fcc50906d9164c56 ]---
> *15:34:57* [  862.550562]
> *15:35:18* [  883.551577] INFO: rcu_sched self-detected stall on CPU
> *15:35:18* [  883.551578] INFO: rcu_sched self-detected stall on CPU
> *15:35:18* [  883.551588] 	2-...: (5249 ticks this GP) idle=cc5/140000000000001/0 softirq=50260/50260 fqs=5249
> *15:35:18* [  883.551591] 	 (t=5250 jiffies g=48365 c=48364 q=182)
>

Is the problem repeatable? Comm says kswapd2, could you post the
topology?
 
> Regard's
> Abdul
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
