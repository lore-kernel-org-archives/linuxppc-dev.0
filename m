Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01262C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 06:53:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 468C4213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 06:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468C4213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447qK254VvzDqTh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 17:53:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sathnaga@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447qGp0mcZzDq8F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 17:51:22 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1Q6hajn017574
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 01:51:19 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qvy5auquf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 01:51:19 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sathnaga@linux.vnet.ibm.com>;
 Tue, 26 Feb 2019 06:51:17 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 26 Feb 2019 06:51:15 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1Q6pE5C31195238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Feb 2019 06:51:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2917A4054;
 Tue, 26 Feb 2019 06:51:13 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25C46A405B;
 Tue, 26 Feb 2019 06:51:13 +0000 (GMT)
Received: from sathnaga86.in.ibm.com (unknown [9.193.110.210])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue, 26 Feb 2019 06:51:12 +0000 (GMT)
Date: Tue, 26 Feb 2019 12:21:10 +0530
From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 0/4] Fixes for 3 separate NMI reentrancy bugs
References: <20190226060901.18715-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226060901.18715-1-npiggin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19022606-0012-0000-0000-000002FA3749
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022606-0013-0000-0000-00002131D9F3
Message-Id: <20190226065110.GA13164@sathnaga86.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-26_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902260051
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Reply-To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 26, 2019 at 04:08:57PM +1000, Nicholas Piggin wrote:
> This series fixes several similar but unrelated bugs with NMIs
> clobbering live registers without noticing it, because MSR[RI] is set.
> Pretty rare bugs, but serious silent corruption consequences.
> 
> For the most part these can be observed and tested quite easily
> with the mambo simulator, except that it does not seem to follow
> the architecture wrt leaving MSR[RI] unchanged for HV interrupts.
> Mambo clears MSR[RI], so you have to account for that manually.
> 
> Since v1:
> - Fixed several build bugs.
> 
> Since v2:
> - Improved changelog and comments.
> - Fixed the NIA test for virt mode interrupts.

Hit with below crash on Power8 box, patch built with linuxppc merge branch with `ppc64le_defconfig`

UnknownStateTransition: Something happened system state="8" and we transitioned to UNKNOWN state.  Review the following for more details
Message="OpTestSystem in run_IPLing and Exception="Kernel OOPS (machine in state '5'): Oops: Kernel access of bad area, sig: 11 [#1]
[    0.000000] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA PowerNV
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc7-gf46b87021 #1
[    0.000000] NIP:  c000000000c1306c LR: c000000000c12f64 CTR: c00000000033d860
[    0.000000] REGS: c0000000014878b0 TRAP: 0380   Not tainted  (5.0.0-rc7-gf46b87021)
[    0.000000] MSR:  9000000000001033 <SF,HV,ME,IR,DR,RI,LE>  CR: 28002224  XER: 00000000
[    0.000000] CFAR: c000000000c12f7c IRQMASK: 1 
[    0.000000] GPR00: c000000000c12f64 c000000001487b40 c000000001488400 f000000000000000 
[    0.000000] GPR04: c000000001487b18 c000000001487b20 0000000000000000 c000000001388400 
[    0.000000] GPR08: f000000000000000 f000000000000008 0000000000000000 0000000800000000 
[    0.000000] GPR12: c0000000015e1ed0 c000000001670000 0000000000000000 0000000000000000 
[    0.000000] GPR16: 0000000000000000 0000000000000000 c0000000015e0d40 0000000000000001 
[    0.000000] GPR20: ffffffffffffffff ffffffffffffffff 0000000008000000 c000000001413b90 
[    0.000000] GPR24: c000000001413b98 007ffff000000000 0000000000080000 0000000000000000 
[    0.000000] GPR28: 0000000000000000 0000000000000000 007ffff000001000 0000000000000000 
[    0.000000] NIP [c000000000c1306c] memmap_init_zone+0x258/0x308
[    0.000000] LR [c000000000c12f64] memmap_init_zone+0x150/0x308
[    0.000000] Call Trace:
[    0.000000] [c000000001487b40] [c000000000c12f64] memmap_init_zone+0x150/0x308 (unreliable)
[    0.000000] [c000000001487be0] [c000000000f87acc] free_area_init_node+0x480/0x518
[    0.000000] [c000000001487cf0] [c000000000f88630] free_area_init_nodes+0x838/0x940
[    0.000000] [c000000001487e10] [c000000000f6340c] paging_init+0x8c/0xa8
[    0.000000] [c000000001487e80] [c000000000f5bc00] setup_arch+0x3b4/0x3f0
[    0.000000] [c000000001487ef0] [c000000000f53b68] start_kernel+0x94/0x630
[    0.000000] [c000000001487f90] [c00000000000b37c] start_here_common+0x1c/0x520
[    0.000000] Instruction dump:
[    0.000000] 71290002 41820014 ebea0008 7cc6fa14 78df8402 48000070 3d22000c 7bea3664 
[    0.000000] 39299d20 e9090000 7c685214 39230008 <fa290010> fa290018 fa290020 fa290030 
[    0.000000] random: get_random_bytes called from print_oops_end_marker+0x40/0x80 with crng_init=0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] 
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] Rebooting in 10 seconds" caused the system to go to UNKNOWN_BAD and the system will be stopping."

Regards,
-Satheesh.
> 
> Nicholas Piggin (4):
>   powerpc/64s: Fix HV NMI vs HV interrupt recoverability test
>   powerpc/64s: system reset interrupt preserve HSRRs
>   powerpc/64s: Prepare to handle data interrupts vs d-side MCE
>     reentrancy
>   powerpc/64s: Fix data interrupts vs d-side MCE reentrancy
> 
>  arch/powerpc/include/asm/asm-prototypes.h |  8 ++
>  arch/powerpc/include/asm/nmi.h            |  2 +
>  arch/powerpc/kernel/exceptions-64s.S      | 92 +++++++++++++++++++----
>  arch/powerpc/kernel/mce.c                 |  3 +
>  arch/powerpc/kernel/traps.c               | 91 +++++++++++++++++++++-
>  5 files changed, 179 insertions(+), 17 deletions(-)
> 
> -- 
> 2.18.0
> 

