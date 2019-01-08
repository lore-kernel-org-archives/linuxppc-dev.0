Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2268AC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 14:36:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9656920850
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 14:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9656920850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Yvvv26rQzDqYB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 01:36:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Yvsr4BJkzDqX0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 01:34:40 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x08EUD7s096397
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Jan 2019 09:34:38 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pvtqu28fm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2019 09:34:38 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Tue, 8 Jan 2019 14:34:35 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 8 Jan 2019 14:34:32 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x08EYVFx59768884
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Jan 2019 14:34:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63E2B4C050;
 Tue,  8 Jan 2019 14:34:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C43764C040;
 Tue,  8 Jan 2019 14:34:30 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.241])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Tue,  8 Jan 2019 14:34:30 +0000 (GMT)
Date: Tue, 8 Jan 2019 16:34:29 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v12 01/10] powerpc/irq: use memblock functions returning
 virtual address
References: <cover.1546954233.git.christophe.leroy@c-s.fr>
 <ec01a9be000c2305eec61bb1e2c44df2f917c1a6.1546954236.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec01a9be000c2305eec61bb1e2c44df2f917c1a6.1546954236.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19010814-0028-0000-0000-00000335FC81
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010814-0029-0000-0000-000023F30A09
Message-Id: <20190108143428.GB14063@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-08_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901080120
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
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Tue, Jan 08, 2019 at 01:43:09PM +0000, Christophe Leroy wrote:
> Since only the virtual address of allocated blocks is used,
> lets use functions returning directly virtual address.
> 
> Those functions have the advantage of also zeroing the block.
> 
> Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  @Mike: Part of this is taken from your serie.

It seems you've found some places I've missed :)
Note that my series was merged to mmotm, so you may get a conflict with it.

>  I was not sure how to include you in the commit log, I used
>  Suggested-by: but could use any other property, so if you prefer
>  something different just tell me. Also, if you could review this patch,
>  it would be nice.

Suggested-by sounds reasonable.
 
>  arch/powerpc/kernel/irq.c      |  5 -----
>  arch/powerpc/kernel/setup_32.c | 15 +++++----------
>  arch/powerpc/kernel/setup_64.c | 16 ++--------------
>  3 files changed, 7 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 916ddc4aac44..4a44bc395fbc 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -725,18 +725,15 @@ void exc_lvl_ctx_init(void)
>  #endif
>  #endif
>  
> -		memset((void *)critirq_ctx[cpu_nr], 0, THREAD_SIZE);
>  		tp = critirq_ctx[cpu_nr];
>  		tp->cpu = cpu_nr;
>  		tp->preempt_count = 0;
>  
>  #ifdef CONFIG_BOOKE
> -		memset((void *)dbgirq_ctx[cpu_nr], 0, THREAD_SIZE);
>  		tp = dbgirq_ctx[cpu_nr];
>  		tp->cpu = cpu_nr;
>  		tp->preempt_count = 0;
>  
> -		memset((void *)mcheckirq_ctx[cpu_nr], 0, THREAD_SIZE);
>  		tp = mcheckirq_ctx[cpu_nr];
>  		tp->cpu = cpu_nr;
>  		tp->preempt_count = HARDIRQ_OFFSET;
> @@ -754,12 +751,10 @@ void irq_ctx_init(void)
>  	int i;
>  
>  	for_each_possible_cpu(i) {
> -		memset((void *)softirq_ctx[i], 0, THREAD_SIZE);
>  		tp = softirq_ctx[i];
>  		tp->cpu = i;
>  		klp_init_thread_info(tp);
>  
> -		memset((void *)hardirq_ctx[i], 0, THREAD_SIZE);
>  		tp = hardirq_ctx[i];
>  		tp->cpu = i;
>  		klp_init_thread_info(tp);
> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index 947f904688b0..bfe1b46a26dc 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -203,10 +203,8 @@ void __init irqstack_early_init(void)
>  	/* interrupt stacks must be in lowmem, we get that for free on ppc32
>  	 * as the memblock is limited to lowmem by default */
>  	for_each_possible_cpu(i) {
> -		softirq_ctx[i] = (struct thread_info *)
> -			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
> -		hardirq_ctx[i] = (struct thread_info *)
> -			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
> +		softirq_ctx[i] = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
> +		hardirq_ctx[i] = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
>  	}
>  }
>  
> @@ -224,13 +222,10 @@ void __init exc_lvl_early_init(void)
>  		hw_cpu = 0;
>  #endif
>  
> -		critirq_ctx[hw_cpu] = (struct thread_info *)
> -			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
> +		critirq_ctx[hw_cpu] = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
>  #ifdef CONFIG_BOOKE
> -		dbgirq_ctx[hw_cpu] = (struct thread_info *)
> -			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
> -		mcheckirq_ctx[hw_cpu] = (struct thread_info *)
> -			__va(memblock_phys_alloc(THREAD_SIZE, THREAD_SIZE));
> +		dbgirq_ctx[hw_cpu] = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
> +		mcheckirq_ctx[hw_cpu] = memblock_alloc(THREAD_SIZE, THREAD_SIZE);
>  #endif
>  	}
>  }
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 236c1151a3a7..943503f1e2c0 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -634,19 +634,10 @@ __init u64 ppc64_bolted_size(void)
>  
>  static void *__init alloc_stack(unsigned long limit, int cpu)
>  {
> -	unsigned long pa;
> -
>  	BUILD_BUG_ON(STACK_INT_FRAME_SIZE % 16);
>  
> -	pa = memblock_alloc_base_nid(THREAD_SIZE, THREAD_SIZE, limit,
> -					early_cpu_to_node(cpu), MEMBLOCK_NONE);
> -	if (!pa) {
> -		pa = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
> -		if (!pa)
> -			panic("cannot allocate stacks");
> -	}
> -
> -	return __va(pa);
> +	return memblock_alloc_try_nid(THREAD_SIZE, THREAD_SIZE, MEMBLOCK_LOW_LIMIT,
> +				      limit, early_cpu_to_node(cpu));

I'd prefer if you would keep the return value check and panic() here, as
I'm working on removing the panic() from memblock_alloc*().

Other than that, everything seems right, at least from the memblock
perspective. So, with panic retained feel free to add

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

>  }
>  
>  void __init irqstack_early_init(void)
> @@ -739,20 +730,17 @@ void __init emergency_stack_init(void)
>  		struct thread_info *ti;
>  
>  		ti = alloc_stack(limit, i);
> -		memset(ti, 0, THREAD_SIZE);
>  		emerg_stack_init_thread_info(ti, i);
>  		paca_ptrs[i]->emergency_sp = (void *)ti + THREAD_SIZE;
>  
>  #ifdef CONFIG_PPC_BOOK3S_64
>  		/* emergency stack for NMI exception handling. */
>  		ti = alloc_stack(limit, i);
> -		memset(ti, 0, THREAD_SIZE);
>  		emerg_stack_init_thread_info(ti, i);
>  		paca_ptrs[i]->nmi_emergency_sp = (void *)ti + THREAD_SIZE;
>  
>  		/* emergency stack for machine check exception handling. */
>  		ti = alloc_stack(limit, i);
> -		memset(ti, 0, THREAD_SIZE);
>  		emerg_stack_init_thread_info(ti, i);
>  		paca_ptrs[i]->mc_emergency_sp = (void *)ti + THREAD_SIZE;
>  #endif
> -- 
> 2.13.3
> 

-- 
Sincerely yours,
Mike.

