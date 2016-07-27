Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzsSv6pPrzDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 20:59:43 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6RAs7Y7143831
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 06:59:41 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24dvp8dngg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 06:59:40 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Wed, 27 Jul 2016 04:59:40 -0600
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Subject: [PowerPC] Kernel OOPS while compiling LTP test suite on linus mainline
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au, ego@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com
Date: Wed, 27 Jul 2016 16:29:33 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------1EE9E6E3A12A9F5B373B18EB"
Message-Id: <7b06e366-c90e-7d56-acf2-8f6f1a98ffd0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------1EE9E6E3A12A9F5B373B18EB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Kernel OOPS messages were seen while compiling linux test project (LTP) source on4.7.0-rc5 mainline.


kernel config : pseries_le_defconfig
machine Type  : PowerVM LPAR
trace messages:
*15:34:57* [  862.548866] Unable to handle kernel paging request for data at address 0x00000000
*15:34:57* [  862.548904] Faulting instruction address: 0xc000000000260900
*15:34:57* [  862.548911] Oops: Kernel access of bad area, sig: 11 [#1]
*15:34:57* [  862.548917] SMP NR_CPUS=2048 NUMA pSeries
*15:34:57* [  862.548924] Modules linked in: rtc_generic(E) pseries_rng(E) autofs4(E)
*15:34:57* [  862.548938] CPU: 0 PID: 129 Comm: kswapd2 Tainted: G            E   4.7.0-rc5-autotest #1
*15:34:57* [  862.548946] task: c0000007766a2600 ti: c000000776764000 task.ti: c000000776764000
*15:34:57* [  862.548953] NIP: c000000000260900 LR: c00000000026452c CTR: 0000000000000000
*15:34:57* [  862.548961] REGS: c000000776767830 TRAP: 0300   Tainted: G            E    (4.7.0-rc5-autotest)
*15:34:57* [  862.548968] MSR: 800000010280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 24000222  XER: 20000001
*15:34:57* [  862.548996] CFAR: c000000000008468 DAR: 0000000000000000 DSISR: 40000000 SOFTE: 0
*15:34:57* GPR00: c00000000026452c c000000776767ab0 c0000000013ac100 c00000077ff54200
*15:34:57* GPR04: 0000000000000000 c000000776767ba0 0000000000000001 c00000000151c100
*15:34:57* GPR08: 0000000000000000 00000000000b4057 0000000080000000 c00000071664b7a0
*15:34:57* GPR12: 0000000000000000 c00000000e800000 0000000000000001 f0000000015dc000
*15:34:57* GPR16: c00000077ff54700 0000000000000000 0000000000000000 c00000077ff54700
*15:34:57* GPR20: 0000000000000001 0000000000000100 0000000000000200 c00000077ff54200
*15:34:57* GPR24: c000000776767ba0 0000000000000020 0000000000000000 0000000000000001
*15:34:57* GPR28: 0000000000000010 0000000000000000 c000000776767ba0 f0000000015dc020
*15:34:57* [  862.549094] NIP [c000000000260900] move_active_pages_to_lru.isra.16+0xa0/0x380
*15:34:57* [  862.549102] LR [c00000000026452c] shrink_active_list+0x2fc/0x510
*15:34:57* [  862.549108] Call Trace:
*15:34:57* [  862.549112] [c000000776767ab0] [f0000000015dc000] 0xf0000000015dc000 (unreliable)
*15:34:57* [  862.549122] [c000000776767b60] [c00000000026452c] shrink_active_list+0x2fc/0x510
*15:34:57* [  862.549131] [c000000776767c50] [c0000000002665d4] kswapd+0x434/0xa70
*15:34:57* [  862.549139] [c000000776767d80] [c0000000000f1b50] kthread+0x110/0x130
*15:34:57* [  862.549148] [c000000776767e30] [c0000000000095f0] ret_from_kernel_thread+0x5c/0x6c
*15:34:57* [  862.549155] Instruction dump:
*15:34:57* [  862.549161] 60000000 3b200020 3a800001 7b7c26e4 3aa00100 3ac00200 3a400000 3a770500
*15:34:57* [  862.549174] 3a200000 60000000 60000000 60420000 <e93d0000> 7fbd4840 419e01b8 ebfd0008
*15:34:57* [  862.549193] ---[ end trace fcc50906d9164c56 ]---
*15:34:57* [  862.550562]
*15:35:18* [  883.551577] INFO: rcu_sched self-detected stall on CPU
*15:35:18* [  883.551578] INFO: rcu_sched self-detected stall on CPU
*15:35:18* [  883.551588] 	2-...: (5249 ticks this GP) idle=cc5/140000000000001/0 softirq=50260/50260 fqs=5249
*15:35:18* [  883.551591] 	 (t=5250 jiffies g=48365 c=48364 q=182)


Regard's
Abdul

--------------1EE9E6E3A12A9F5B373B18EB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p>
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
    </p>
    <pre style="box-sizing: border-box; white-space: pre-wrap; word-wrap: break-word; margin: 0px; color: rgb(51, 51, 51); font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18.2px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px;">Hi, 

Kernel OOPS messages were seen while compiling linux test project (LTP) source on <meta http-equiv="content-type" content="text/html; charset=utf-8">4.7.0-rc5 mainline.<pre style="box-sizing: border-box; white-space: pre-wrap; word-wrap: break-word; margin: 0px; color: rgb(51, 51, 51); font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18.2px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px;"></pre>
kernel config : pseries_le_defconfig
machine Type  : PowerVM LPAR
trace messages:
<meta http-equiv="content-type" content="text/html; charset=utf-8"><span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.548866] Unable to handle kernel paging request for data at address 0x00000000
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.548904] Faulting instruction address: 0xc000000000260900
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.548911] Oops: Kernel access of bad area, sig: 11 [#1]
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.548917] SMP NR_CPUS=2048 NUMA pSeries
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.548924] Modules linked in: rtc_generic(E) pseries_rng(E) autofs4(E)
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.548938] CPU: 0 PID: 129 Comm: kswapd2 Tainted: G            E   4.7.0-rc5-autotest #1
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.548946] task: c0000007766a2600 ti: c000000776764000 task.ti: c000000776764000
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.548953] NIP: c000000000260900 LR: c00000000026452c CTR: 0000000000000000
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.548961] REGS: c000000776767830 TRAP: 0300   Tainted: G            E    (4.7.0-rc5-autotest)
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.548968] MSR: 800000010280b033 &lt;SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]&gt;  CR: 24000222  XER: 20000001
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.548996] CFAR: c000000000008468 DAR: 0000000000000000 DSISR: 40000000 SOFTE: 0 
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>GPR00: c00000000026452c c000000776767ab0 c0000000013ac100 c00000077ff54200 
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>GPR04: 0000000000000000 c000000776767ba0 0000000000000001 c00000000151c100 
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>GPR08: 0000000000000000 00000000000b4057 0000000080000000 c00000071664b7a0 
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>GPR12: 0000000000000000 c00000000e800000 0000000000000001 f0000000015dc000 
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>GPR16: c00000077ff54700 0000000000000000 0000000000000000 c00000077ff54700 
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>GPR20: 0000000000000001 0000000000000100 0000000000000200 c00000077ff54200 
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>GPR24: c000000776767ba0 0000000000000020 0000000000000000 0000000000000001 
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>GPR28: 0000000000000010 0000000000000000 c000000776767ba0 f0000000015dc020 
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.549094] NIP [c000000000260900] move_active_pages_to_lru.isra.16+0xa0/0x380
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.549102] LR [c00000000026452c] shrink_active_list+0x2fc/0x510
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.549108] Call Trace:
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.549112] [c000000776767ab0] [f0000000015dc000] 0xf0000000015dc000 (unreliable)
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.549122] [c000000776767b60] [c00000000026452c] shrink_active_list+0x2fc/0x510
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.549131] [c000000776767c50] [c0000000002665d4] kswapd+0x434/0xa70
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.549139] [c000000776767d80] [c0000000000f1b50] kthread+0x110/0x130
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.549148] [c000000776767e30] [c0000000000095f0] ret_from_kernel_thread+0x5c/0x6c
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.549155] Instruction dump:
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.549161] 60000000 3b200020 3a800001 7b7c26e4 3aa00100 3ac00200 3a400000 3a770500 
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.549174] 3a200000 60000000 60000000 60420000 &lt;e93d0000&gt; 7fbd4840 419e01b8 ebfd0008 
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.549193] ---[ end trace fcc50906d9164c56 ]---
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:34:57</b> </span>[  862.550562] 
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:35:18</b> </span>[  883.551577] INFO: rcu_sched self-detected stall on CPU
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:35:18</b> </span>[  883.551578] INFO: rcu_sched self-detected stall on CPU
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:35:18</b> </span>[  883.551588] 	2-...: (5249 ticks this GP) idle=cc5/140000000000001/0 softirq=50260/50260 fqs=5249 
<span class="timestamp" style="box-sizing: border-box;"><b style="box-sizing: border-box;">15:35:18</b> </span>[  883.551591] 	 (t=5250 jiffies g=48365 c=48364 q=182)<pre style="box-sizing: border-box; white-space: pre-wrap; word-wrap: break-word; margin: 0px; color: rgb(51, 51, 51); font-size: 13px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 18.2px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px;"></pre>
Regard's
Abdul
</pre></body></html>
--------------1EE9E6E3A12A9F5B373B18EB--
