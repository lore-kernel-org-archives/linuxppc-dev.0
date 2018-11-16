Return-Path: <SRS0=5aIK=N3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9344CC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 04:44:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C92902087A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 04:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C92902087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42x5HH1KTrzF3gH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 15:44:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=abdhalee@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42x5FG6PSNzF3bV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 15:42:42 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAG4ciHS112392
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 23:42:39 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nsprn0pcy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 23:42:39 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Fri, 16 Nov 2018 04:42:38 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 16 Nov 2018 04:42:36 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAG4gZ9V20054238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 16 Nov 2018 04:42:35 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15FE97805C;
 Fri, 16 Nov 2018 04:42:35 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55DE47805F;
 Fri, 16 Nov 2018 04:42:33 +0000 (GMT)
Received: from [9.79.179.43] (unknown [9.79.179.43])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 16 Nov 2018 04:42:32 +0000 (GMT)
Subject: Re: [PATCH] powerpc/64: Fix kernel stack 16-byte alignment
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 16 Nov 2018 10:12:31 +0530
In-Reply-To: <20181115023427.31033-1-npiggin@gmail.com>
References: <20181115023427.31033-1-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18111604-8235-0000-0000-00000E28AB86
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010058; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01118109; UDB=6.00579992; IPR=6.00898217; 
 MB=3.00024187; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-16 04:42:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111604-8236-0000-0000-0000435FCE51
Message-Id: <1542343351.15177.9.camel@abdul>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-16_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811160039
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-11-15 at 12:34 +1000, Nicholas Piggin wrote:
> Commit 4c2de74cc869 ("powerpc/64: Interrupts save PPR on stack rather
> than thread_struct") changed sizeof(struct pt_regs) % 16 from 0 to 8,
> which causes the interrupt frame allocation on kernel entry to put the
> kernel stack out of alignment.
> 
> Add a pad field to fix alignment, and add a BUILD_BUG_ON to catch this
> in future.
> 
> Fixes: 4c2de74cc869 ("powerpc/64: Interrupts save PPR on stack rather
> than thread_struct")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/ptrace.h | 1 +
>  arch/powerpc/kernel/setup_64.c    | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index f73886a1a7f5..1513292bf046 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -54,6 +54,7 @@ struct pt_regs
> 
>  #ifdef CONFIG_PPC64
>  	unsigned long ppr;
> +	unsigned long pad;	/* Maintain 16 byte interrupt stack alignment */
>  #endif
>  };
>  #endif
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 2a51e4cc8246..236c1151a3a7 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -636,6 +636,8 @@ static void *__init alloc_stack(unsigned long limit, int cpu)
>  {
>  	unsigned long pa;
> 
> +	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
> +
>  	pa = memblock_alloc_base_nid(THREAD_SIZE, THREAD_SIZE, limit,
>  					early_cpu_to_node(cpu), MEMBLOCK_NONE);
>  	if (!pa) {

Tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>

This patch fixes hard lockup warnings at opal_interrupt on our P8 system
seen when bnx2x module load unload.

watchdog: CPU 80 self-detected hard LOCKUP @ opal_interrupt+0x34/0x90
watchdog: CPU 80 TB:2355493195232, last heartbeat TB:2350368214474 (10009ms ago)
Modules linked in: iptable_mangle ipt_MASQUERADE iptable_nat nf_nat_ipv4
nf_nat xt_conntrack nf_conntrack nf_defrag_ipv4 ipt_REJECT
nf_reject_ipv4 xt_tcpudp tun bridge stp llc iptable_filter dm_mirror
dm_region_hash dm_log dm_service_time vmx_crypto powernv_rng rng_core
dm_multipath kvm_hv kvm nfsd binfmt_misc ip_tables x_tables autofs4 xfs
lpfc bnx2x crc_t10dif crct10dif_generic nvme_fc mdio nvme libcrc32c
nvme_fabrics nvme_core crct10dif_common
CPU: 80 PID: 411 Comm: ksoftirqd/80 Not tainted 4.20.0-rc2-next-20181114-autotest-autotest #1
NIP:  c00000000009ffc4 LR: c000000000095d28 CTR: 0000000030032a00
REGS: c000003fff48fd78 TRAP: 0900   Not tainted  (4.20.0-rc2-next-20181114-autotest-autotest)
MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 48000022  XER: 00000000
CFAR: c000000000095d14 IRQMASK: 1
GPR00: 0000000030005128 c000003fff70bd70 c0000000010dcd00 0000000000000000
GPR04: 0000000048000022 c00000000009ffc4 9000000000009033 0000000000000090
GPR08: 0000000000000000 0000000000000000 c000000000095d3c 9000000000001003
GPR12: c000000000095d14 c000003fff7ff300 c000003c95080c80 0000000000010000
GPR16: 0000000000000000 000000000000003c c000003c95080800 c000003c95030e00
GPR20: 0000000000000001 0000000000000001 0000000000000002 0000000000000014
GPR24: c000003ca4981000 c000003fff70be84 0000000000000000 0000000000000000
GPR28: 0000000000000000 0000000000000014 c000003ca4981000 c000003ca4970200
NIP [c00000000009ffc4] opal_interrupt+0x34/0x90
LR [c000000000095d28] opal_return+0x14/0x48
Call Trace:
[c000003fff70bd70] [c00000000009ffc4] opal_interrupt+0x34/0x90 (unreliable)
[c000003fff70bda0] [c0000000001756d0] __handle_irq_event_percpu+0x90/0x2d0
[c000003fff70be60] [c000000000175948] handle_irq_event_percpu+0x38/0xb0
[c000003fff70bea0] [c000000000175a20] handle_irq_event+0x60/0xc0
[c000003fff70bed0] [c00000000017aedc] handle_fasteoi_irq+0xbc/0x1f0
[c000003fff70bf00] [c000000000173ec4] generic_handle_irq+0x44/0x70
[c000003fff70bf20] [c000000000019eac] __do_irq+0x8c/0x200
[c000003fff70bf90] [c00000000002c744] call_do_irq+0x14/0x24
[c000003ca96f7320] [c00000000001a0b4] do_IRQ+0x94/0x110
[c000003ca96f7370] [c000000000008d54] hardware_interrupt_common+0x154/0x160
--- interrupt: 501 at ip_route_input_rcu+0x510/0x950
    LR = ip_route_input_rcu+0x220/0x950
[c000003ca96f7768] [c00000000092a69c] ip_route_input_noref+0x2c/0x60
[c000003ca96f77b8] [c0000000009735b0] arp_process.constprop.14+0x3f0/0x8c0
[c000003ca96f78d8] [c0000000008c7508] __netif_receive_skb_one_core+0x68/0xa0
[c000003ca96f7918] [c0000000008d09bc] netif_receive_skb_internal+0x3c/0x130
[c000003ca96f7968] [c0000000008d153c] napi_gro_receive+0x11c/0x1c0
[c000003ca96f79a8] [c0000000007232bc] tg3_poll_work+0x60c/0x10a0
[c000003ca96f7ab8] [c000000000723da4] tg3_poll_msix+0x54/0x210
[c000003ca96f7b08] [c0000000008d1f0c] net_rx_action+0x35c/0x4c0
[c000003ca96f7c28] [c000000000a2d8ac] __do_softirq+0x16c/0x3e0
[c000003ca96f7d28] [c000000000102df4] run_ksoftirqd+0x54/0x80
[c000003ca96f7d48] [c00000000012d830] smpboot_thread_fn+0x2b0/0x2c0
[c000003ca96f7db8] [c000000000127d9c] kthread+0x15c/0x1a0
[c000003ca96f7e28] [c00000000000bdd0] ret_from_kernel_thread+0x5c/0x6c

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre



