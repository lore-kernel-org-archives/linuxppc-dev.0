Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353EEC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 09:07:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576E22147C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 09:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="VYwPvz2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576E22147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44K5bG4xZczDqM4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 20:07:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="VYwPvz2X"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44K5Yb2xf3zDqGP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 20:06:27 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44K5YV1MCZz9tyv3;
 Wed, 13 Mar 2019 10:06:22 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=VYwPvz2X; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id b_ev4INDNGpo; Wed, 13 Mar 2019 10:06:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44K5YV04knz9tyv2;
 Wed, 13 Mar 2019 10:06:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1552467982; bh=IoijEz6VoS+nWaaMU7l1D1g3qs+lq9pKu9xC1BONTnI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=VYwPvz2XwhnNCS3aPMJ0N6RFw1Da5OQ3sOREb3csmha2HFej7bNieEFkQS49zdeaR
 Bgyo+AwRe/DzAM5ZTiSkpbwXo0qSyOIUeNWR4PBJw6/sQ4jcQPUCN8DFYed5S47zMA
 AAE8b4vZUFrN+jF4CcsifEhTodFOyBboVvpCxJhY=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EA9348B8F9;
 Wed, 13 Mar 2019 10:06:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id PUXw9sD4EhAz; Wed, 13 Mar 2019 10:06:22 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8C1128B8EE;
 Wed, 13 Mar 2019 10:06:21 +0100 (CET)
Subject: Re: [PATCH 1/1] arch/powerpc: Rework local_paca to avoid LTO warnings
To: Alastair D'Silva <alastair@au1.ibm.com>
References: <20190313034208.13134-1-alastair@au1.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <bd858b12-7fab-057d-0065-2ccb98cbf648@c-s.fr>
Date: Wed, 13 Mar 2019 10:06:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190313034208.13134-1-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: Michal Hocko <mhocko@suse.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Alastair D'Silva <alastair@d-silva.org>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

Le 13/03/2019 à 04:42, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> When building an LTO kernel, the existing code generates warnings:
>      ./arch/powerpc/include/asm/paca.h:37:30: warning: register of
>          ‘local_paca’ used for multiple global register variables
>       register struct paca_struct *local_paca asm("r13");
>                                ^
>      ./arch/powerpc/include/asm/paca.h:37:30: note: conflicts with
>          ‘local_paca’

How do you build a LTO kernel ?

> 
> This patch reworks local_paca into an inline getter & setter function,
> which addresses the warning.

This patch adds sparse warnings, see 
https://patchwork.ozlabs.org/patch/1055875/

> 
> Generated ASM from this patch is broadly similar (addresses have
> changed and the compiler uses different GPRs in some places).

Your text might be confusion. When I read it the first time I thought 
you were saying that the compiler was now using another GPR than r13.

> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

I guess the same has to be done for current, see 
arch/powerpc/include/asm/current.h :

/*
  * We keep `current' in r2 for speed.
  */
register struct task_struct *current asm ("r2");

> ---
>   arch/powerpc/include/asm/paca.h | 44 +++++++++++++++++++++++----------
>   arch/powerpc/kernel/paca.c      |  2 +-
>   2 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index e843bc5d1a0f..9c9e2dea0f9b 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -34,19 +34,6 @@
>   #include <asm/cpuidle.h>
>   #include <asm/atomic.h>
>   
> -register struct paca_struct *local_paca asm("r13");
> -
> -#if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
> -extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
> -/*
> - * Add standard checks that preemption cannot occur when using get_paca():
> - * otherwise the paca_struct it points to may be the wrong one just after.
> - */
> -#define get_paca()	((void) debug_smp_processor_id(), local_paca)
> -#else
> -#define get_paca()	local_paca
> -#endif
> -
>   #ifdef CONFIG_PPC_PSERIES
>   #define get_lppaca()	(get_paca()->lppaca_ptr)
>   #endif
> @@ -266,6 +253,37 @@ struct paca_struct {
>   #endif
>   } ____cacheline_aligned;
>   
> +#if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
> +extern unsigned int debug_smp_processor_id(void); /* from linux/smp.h */
> +#endif

Why moving this down, why not leaving at the same place as before ?

If you really need to move it, you should remove the 'extern' at the 
same time to make checkpatch happy.

> +
> +static inline struct paca_struct *get_paca_no_preempt_check(void)
> +{
> +	register struct paca_struct *paca asm("r13");

Should be a blank line there.

> +	return paca;
> +}
> +
> +static inline struct paca_struct *get_paca(void)
> +{
> +#if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
> +	/*
> +	 * Add standard checks that preemption cannot occur when using get_paca():
> +	 * otherwise the paca_struct it points to may be the wrong one just after.
> +	 */
> +	debug_smp_processor_id();
> +#endif
> +	return get_paca_no_preempt_check();
> +}
> +
> +#define local_paca	get_paca_no_preempt_check()
> +
> +static inline void set_paca(struct paca_struct *new)
> +{
> +	register struct paca_struct *paca asm("r13");

Blank line should be added here.

> +	paca = new;
> +}
> +
> +
>   extern void copy_mm_to_paca(struct mm_struct *mm);
>   extern struct paca_struct **paca_ptrs;
>   extern void initialise_paca(struct paca_struct *new_paca, int cpu);
> diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> index 913bfca09c4f..ae5c243f9d5a 100644
> --- a/arch/powerpc/kernel/paca.c
> +++ b/arch/powerpc/kernel/paca.c
> @@ -172,7 +172,7 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
>   void setup_paca(struct paca_struct *new_paca)
>   {
>   	/* Setup r13 */
> -	local_paca = new_paca;
> +	set_paca(new_paca);
>   
>   #ifdef CONFIG_PPC_BOOK3E
>   	/* On Book3E, initialize the TLB miss exception frames */
> 

Christophe
