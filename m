Return-Path: <SRS0=gJAX=2I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CCDC2D0CD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 10:50:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2633321582
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 10:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="iP83JgyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2633321582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47dBcr6N4PzDqgl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 21:50:52 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47dBYs5bwbzDqdc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2019 21:48:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="iP83JgyK"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 47dBYs3MHWz9sS9; Wed, 18 Dec 2019 21:48:17 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 47dBYs16rnz9sRv;
 Wed, 18 Dec 2019 21:48:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1576666097;
 bh=ZxUGwSnd+Uj+76kk7JZsXqdVR/+/bA5WleNX8JnscbA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=iP83JgyK9jL61e13XD/6XYlUHfuwFrNukWKOXIq+ZwAHjjPFQkzcMLSqPnRJiDws0
 4vpDFnl7HSJ2ePsHWwDHD1KXe28EoTt0+A5aF0U3HdbkFloBxPiM4QfuW1q3Gf/+DJ
 FF7zkjyFhxiyhYRu10SJw7Fl557Dw3TM08e2Sx1amh6Fz7490Y7GA3UwFeCpxweTQB
 kndaCcYRWJcygo0EA6/Ec2tOeTtVVC5Xf+65Y9JCg2wUmA6u5ihgKjaMaG8uh893nG
 IlJxqlsQoqliY77UvSIX8NilmMmkM+AURj6WeMmd8dVyLoF85LEeUoqbedLV3jg24o
 86bAENWVjYOQw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>, linuxram@us.ibm.com
Subject: Re: [PATCH 1/2] powerpc/pseries/svm: Don't access some SPRs
In-Reply-To: <20191218043048.3400-1-sukadev@linux.ibm.com>
References: <20191218043048.3400-1-sukadev@linux.ibm.com>
Date: Wed, 18 Dec 2019 21:48:11 +1100
Message-ID: <875zidoqok.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@ozlabs.org, andmike@linux.ibm.com, kvm-ppc@vger.kernel.org,
 bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sukadev Bhattiprolu <sukadev@linux.ibm.com> writes:
> Ultravisor disables some CPU features like EBB and BHRB in the HFSCR
> for secure virtual machines (SVMs). If the SVMs attempt to access
> related registers, they will get a Program Interrupt.
>
> Use macros/wrappers to skip accessing EBB and BHRB registers in secure
> VMs.

I continue to dislike this approach.

The result is code that at a glance looks like it's doing one thing,
ie. reading or writing an SPR, but is in fact doing nothing.

It's confusing for readers.

It also slows down all these already slow register accesses further, by
inserting an mfmsr() in front of every single one.


> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index b3cbb1136bce..026eb20f6d13 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1379,6 +1379,41 @@ static inline void msr_check_and_clear(unsigned long bits)
>  		__msr_check_and_clear(bits);
>  }
>  
> +#ifdef CONFIG_PPC_SVM
> +/*
> + * Move from some "restricted" sprs.
> + * Secure VMs should not access some registers as the related features
> + * are disabled in the CPU. If an SVM is attempting read from the given
> + * SPR, return 0. Otherwise behave like a normal mfspr.
> + */
> +#define mfspr_r(rn)						\
> +({								\
> +	unsigned long rval = 0ULL;				\
> +								\
> +	if (!(mfmsr() & MSR_S))					\
> +		asm volatile("mfspr %0," __stringify(rn)	\
> +				: "=r" (rval));			\
> +	rval;							\
> +})
> +
> +/*
> + * Move to some "restricted" sprs.
> + * Secure VMs should not access some registers as the related features
> + * are disabled in the CPU. If an SVM is attempting write to the given
> + * SPR, ignore the write. Otherwise behave like a normal mtspr.
> + */
> +#define mtspr_r(rn, v)					\
> +({								\
> +	if (!(mfmsr() & MSR_S))					\
> +		asm volatile("mtspr " __stringify(rn) ",%0" :	\
> +				     : "r" ((unsigned long)(v)) \
> +				     : "memory");		\
> +})
> +#else
> +#define mfspr_r		mfspr
> +#define mtspr_r		mtspr
> +#endif
> +
>  #ifdef __powerpc64__
>  #if defined(CONFIG_PPC_CELL) || defined(CONFIG_PPC_FSL_BOOK3E)
>  #define mftb()		({unsigned long rval;				\
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 639ceae7da9d..9a691452ea3b 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1059,9 +1059,9 @@ static inline void save_sprs(struct thread_struct *t)
>  		t->dscr = mfspr(SPRN_DSCR);
>  
>  	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
> -		t->bescr = mfspr(SPRN_BESCR);
> -		t->ebbhr = mfspr(SPRN_EBBHR);
> -		t->ebbrr = mfspr(SPRN_EBBRR);
> +		t->bescr = mfspr_r(SPRN_BESCR);
> +		t->ebbhr = mfspr_r(SPRN_EBBHR);
> +		t->ebbrr = mfspr_r(SPRN_EBBRR);

eg. here.

This is the fast path of context switch.

That expands to:

	if (!(mfmsr() & MSR_S))
		asm volatile("mfspr %0, SPRN_BESCR" : "=r" (rval));
	if (!(mfmsr() & MSR_S))
		asm volatile("mfspr %0, SPRN_EBBHR" : "=r" (rval));
	if (!(mfmsr() & MSR_S))
		asm volatile("mfspr %0, SPRN_EBBRR" : "=r" (rval));


If the Ultravisor is going to disable EBB and BHRB then we need new
CPU_FTR bits for those, and the code that accesses those registers
needs to be put behind cpu_has_feature(EBB) etc.

cheers
