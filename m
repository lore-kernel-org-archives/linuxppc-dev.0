Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87AFC07E85
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 11:35:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4B32081B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 11:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4B32081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DdDJ3prBzDr5b
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 22:35:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dd2w17r5zDqjH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 22:27:36 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43Dd2r0QSyzB09bD;
 Tue, 11 Dec 2018 12:27:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id hEoo7A2jCkfO; Tue, 11 Dec 2018 12:27:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43Dd2q6zbPzB09bC;
 Tue, 11 Dec 2018 12:27:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id DFAB08B7EB;
 Tue, 11 Dec 2018 12:27:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Oo3agIdGGO5b; Tue, 11 Dec 2018 12:27:32 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 890358B7E7;
 Tue, 11 Dec 2018 12:27:32 +0100 (CET)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc: Fix bogus usage of MSR_RI on BookE and 40x
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <61ad3646674e6bf541a8f7fb420cdf556d0b2152.camel@kernel.crashing.org>
Message-ID: <a7e75b02-b1a1-1f14-20c8-f180dfe496ee@c-s.fr>
Date: Tue, 11 Dec 2018 12:27:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <61ad3646674e6bf541a8f7fb420cdf556d0b2152.camel@kernel.crashing.org>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 11/12/2018 à 02:57, Benjamin Herrenschmidt a écrit :
> BookE and 40x processors lack the MSR:RI bit. However, we have a
> few common code places that rely on it.
> 
> This fixes it by not defining MSR_RI on those processor types and
> using the appropriate ifdef's in those locations.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>   arch/powerpc/include/asm/reg.h       | 2 ++
>   arch/powerpc/include/asm/reg_booke.h | 4 ++--
>   arch/powerpc/kernel/process.c        | 2 +-
>   arch/powerpc/kernel/traps.c          | 8 ++++++--
>   arch/powerpc/lib/sstep.c             | 2 ++
>   5 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index de52c31..41d0b2e 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -110,7 +110,9 @@
>   #ifndef MSR_PMM
>   #define MSR_PMM		__MASK(MSR_PMM_LG)	/* Performance monitor */
>   #endif
> +#if !defined(CONFIG_BOOKE) && !defined(CONFIG_4xx)
>   #define MSR_RI		__MASK(MSR_RI_LG)	/* Recoverable Exception */
> +#endif
>   #define MSR_LE		__MASK(MSR_LE_LG)	/* Little Endian */
>   
>   #define MSR_TM		__MASK(MSR_TM_LG)	/* Transactional Mem Available */
> diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
> index eb2a33d..06967f1 100644
> --- a/arch/powerpc/include/asm/reg_booke.h
> +++ b/arch/powerpc/include/asm/reg_booke.h
> @@ -46,10 +46,10 @@
>   #define MSR_USER32	(MSR_ | MSR_PR | MSR_EE)
>   #define MSR_USER64	(MSR_USER32 | MSR_64BIT)
>   #elif defined (CONFIG_40x)
> -#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
> +#define MSR_KERNEL	(MSR_ME|MSR_IR|MSR_DR|MSR_CE)
>   #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
>   #else
> -#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE)
> +#define MSR_KERNEL	(MSR_ME|MSR_CE)
>   #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
>   #endif
>   
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 96f3473..77679a7 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1359,7 +1359,7 @@ static struct regbit msr_bits[] = {
>   	{MSR_IR,	"IR"},
>   	{MSR_DR,	"DR"},
>   	{MSR_PMM,	"PMM"},
> -#ifndef CONFIG_BOOKE
> +#if !defined(CONFIG_BOOKE) && !defined(CONFIG_40x)
>   	{MSR_RI,	"RI"},
>   	{MSR_LE,	"LE"},
>   #endif
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 9a86572..2d00696 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -429,10 +429,11 @@ void system_reset_exception(struct pt_regs *regs)
>   	if (get_paca()->in_nmi > 1)
>   		nmi_panic(regs, "Unrecoverable nested System Reset");
>   #endif
> +#ifdef MSR_RI
>   	/* Must die if the interrupt is not recoverable */
>   	if (!(regs->msr & MSR_RI))
>   		nmi_panic(regs, "Unrecoverable System Reset");
> -
> +#endif

Could we have a helper in .h file instead of #ifdefs ?

For instance something like

#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
static inline bool exception_is_recoverable(u32 msr)
{
	return msr & MSR_RI;
}
#else
static inline bool exception_is_recoverable(u32 msr)
{
	return true;
}
#endif

Or reuse the function unrecoverable_excp() defined in xmon.c ?

>   	if (!nested)
>   		nmi_exit();
>   
> @@ -478,7 +479,9 @@ static inline int check_io_access(struct pt_regs *regs)
>   			printk(KERN_DEBUG "%s bad port %lx at %p\n",
>   			       (*nip & 0x100)? "OUT to": "IN from",
>   			       regs->gpr[rb] - _IO_BASE, nip);
> +#ifdef MSR_RI
>   			regs->msr |= MSR_RI;
> +#endif

Same here, a helper, something like that, to also be used in 
arch/powerpc/sysdev/fsl_rio.c ?

#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
static inline void exception_set_recoverable(struct pt_regs *regs)
{
	regs->msr |= MSR_RI;
}
#else
static inline void exception_set_recoverable(struct pt_regs *regs)
{
}
#endif

>   			regs->nip = extable_fixup(entry);
>   			return 1;
>   		}
> @@ -763,10 +766,11 @@ void machine_check_exception(struct pt_regs *regs)
>   	if (check_io_access(regs))
>   		goto bail;
>   
> +#ifdef MSR_RI
>   	/* Must die if the interrupt is not recoverable */
>   	if (!(regs->msr & MSR_RI))
>   		nmi_panic(regs, "Unrecoverable Machine check");
> -
> +#endif

Same

>   	if (!nested)
>   		nmi_exit();
>   
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index d81568f..c03c453 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -3059,9 +3059,11 @@ int emulate_step(struct pt_regs *regs, unsigned int instr)
>   
>   	case MTMSR:
>   		val = regs->gpr[op.reg];
> +#ifdef MSR_RI
>   		if ((val & MSR_RI) == 0)

Could be something like the following instead of this #ifdef stuff ?

		if (!IS_ENABLED(CONFIG_4xx) && !IS_ENABLED(CONFIG_BOOKE) && 
exception_is_recoverable(val))


>   			/* can't step mtmsr[d] that would clear MSR_RI */
>   			return -1;
> +#endif
>   		/* here op.val is the mask of bits to change */
>   		regs->msr = (regs->msr & ~op.val) | (val & op.val);
>   		goto instr_done;
> 


Christophe
