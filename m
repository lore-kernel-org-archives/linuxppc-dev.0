Return-Path: <SRS0=+pA4=RK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9740DC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 19:09:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B27620675
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 19:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmLqJH7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B27620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FgDZ3BftzDqHF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 06:09:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="HmLqJH7E"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FgBM4JVhzDqDP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2019 06:07:55 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id k11so11018932pgb.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Mar 2019 11:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tJo3uciM39NhXlTu5MfFJc8kc/AFbixp4LrAaMojqpk=;
 b=HmLqJH7ExI/1GMiYWLC9yiCqlFRKvfGJ6wascFNL0v+hL6q8WBPzr/TmsjrDc5PcHf
 etq3QYyaq1CKhFwdiKQzeZBt+G/iKMiy5tNEQJLcerIfU4TP7e8C5qz72wrAn6ADb2oQ
 80zI+t3zxImQpmNV4kCFzcsb9WS/2wXs9qbhlSS6lAS1w43H2phmPtAs7GTigdm5y1zS
 tJxVedVHUdePAzUzqvziHNjQnkaukFikQ73mITssZjcL7Sm8F+bzTQZcj3kWZARJS4AI
 kScySqKDeya8TQlmMmNOd8kt9EIXxp9EupLbwO6X3Oph2GlF332GN8rmc+1Z9XiTxBvN
 Me1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=tJo3uciM39NhXlTu5MfFJc8kc/AFbixp4LrAaMojqpk=;
 b=TFdXcDhLy340DA0Fv9jRBDDs89oX2nxyFkfalELUwN3bN1xo2L3Y8nGVzvZAdxGx/W
 a7EDyaXVk6ON3cZ4Ibkko47XoI+q4RZc6MYpPj7Q2nYo8jTTZY9wi6boEpWsFbBQJNTh
 FV+fiUbHzmu9nZa/Fp9T8c+F0OFZXtXJSCV/NXYYZiwV9RltRPV+ZYRZqsL26OIAXa4u
 Idabn8fd1CbGGVA1kcS2ly/HWHtSEfB9BLglVB5/CNZ+cOmx3J8VecIkl2rkn2WPmkOH
 5UYA5uCdFaILjYNPUH3v0Z2QBuMubpiv0w2yNXzUUjrRp39TnUIWCQhS1qgeHITGY1xJ
 m6dQ==
X-Gm-Message-State: APjAAAXWGYU22ezYPZERXQa2bal6nYoYihlm/67ZRDtBlzFxt/ORkSjB
 yf16Y2HcEYmTUO6U+JnFhcc=
X-Google-Smtp-Source: APXvYqxugiHnbPs2QU9XSjsowDZTCf1y0ys8JdnXlYVGUbhhqp9t1jVMiFFqTE1QycN1DQI3IhHQDQ==
X-Received: by 2002:a63:5702:: with SMTP id l2mr12925683pgb.2.1551985671593;
 Thu, 07 Mar 2019 11:07:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id s79sm11183894pfa.61.2019.03.07.11.07.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Mar 2019 11:07:50 -0800 (PST)
Date: Thu, 7 Mar 2019 11:07:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 03/10] powerpc/6xx: Store PGDIR physical address in a
 SPRG
Message-ID: <20190307190748.GA21622@roeck-us.net>
References: <cover.1550745320.git.christophe.leroy@c-s.fr>
 <297f30d8ba75cb0e9ebe0a776d96c19750105570.1550745320.git.christophe.leroy@c-s.fr>
 <20190307141143.GA26761@roeck-us.net>
 <2acc1691-0f74-8843-ecdd-64ba8705de20@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2acc1691-0f74-8843-ecdd-64ba8705de20@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Mar 07, 2019 at 06:14:09PM +0000, Christophe Leroy wrote:
> Hi,
> 
> On 03/07/2019 02:11 PM, Guenter Roeck wrote:
> >Hi,
> >
> >On Thu, Feb 21, 2019 at 10:37:55AM +0000, Christophe Leroy wrote:
> >>Use SPRN_SPRG2 to store the current thread PGDIR and
> >>avoid reading thread_struct.pgdir at every TLB miss.
> >>
> >This patch causes a number of silent (no crash) qemu boot stalls
> >in -next. See
> >https://kerneltests.org/builders/qemu-ppc-next/builds/1080/steps/qemubuildcommand/logs/stdio
> >for an example.
> 
> Oops.
> Could you try the fix below ?
> 

Yes, that does the trick. With this patch applied on top of next-20190306,
all my ppc qemu boot tests pass.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S
> b/arch/powerpc/kernel/cpu_setup_6xx.S
> index 6f1c11e0691f..7534ecff5e92 100644
> --- a/arch/powerpc/kernel/cpu_setup_6xx.S
> +++ b/arch/powerpc/kernel/cpu_setup_6xx.S
> @@ -24,9 +24,6 @@ BEGIN_MMU_FTR_SECTION
>  	li	r10,0
>  	mtspr	SPRN_SPRG_603_LRU,r10		/* init SW LRU tracking */
>  END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
> -	lis	r10, (swapper_pg_dir - PAGE_OFFSET)@h
> -	ori	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@l
> -	mtspr	SPRN_SPRG_PGDIR, r10
> 
>  BEGIN_FTR_SECTION
>  	bl	__init_fpu_registers
> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> index ce6a972f2584..48051c8977c5 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -855,6 +855,9 @@ __secondary_start:
>  	li	r3,0
>  	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
>  #endif
> +	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
> +	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
> +	mtspr	SPRN_SPRG_PGDIR, r4
> 
>  	/* enable MMU and jump to start_secondary */
>  	li	r4,MSR_KERNEL
> @@ -942,6 +945,9 @@ start_here:
>  	li	r3,0
>  	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
>  #endif
> +	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
> +	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
> +	mtspr	SPRN_SPRG_PGDIR, r4
> 
>  	/* stack */
>  	lis	r1,init_thread_union@ha
> diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
> index 1f13494efb2b..587e4550d83e 100644
> --- a/arch/powerpc/mm/hash_low_32.S
> +++ b/arch/powerpc/mm/hash_low_32.S
> @@ -70,12 +70,12 @@ _GLOBAL(hash_page)
>  	lis	r0,KERNELBASE@h		/* check if kernel address */
>  	cmplw	0,r4,r0
>  	ori	r3,r3,_PAGE_USER|_PAGE_PRESENT /* test low addresses as user */
> -	mfspr	r5, SPRN_SPRG_PGDIR	/* virt page-table root */
> +	mfspr	r5, SPRN_SPRG_PGDIR	/* phys page-table root */
>  	blt+	112f			/* assume user more likely */
> -	lis	r5,swapper_pg_dir@ha	/* if kernel address, use */
> -	addi	r5,r5,swapper_pg_dir@l	/* kernel page table */
> +	lis	r5, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
> +	addi	r5 ,r5 , (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
>  	rlwimi	r3,r9,32-12,29,29	/* MSR_PR -> _PAGE_USER */
> -112:	tophys(r5, r5)
> +112:
>  #ifndef CONFIG_PTE_64BIT
>  	rlwimi	r5,r4,12,20,29		/* insert top 10 bits of address */
>  	lwz	r8,0(r5)		/* get pmd entry */
> 
> 
> Thanks
> Christophe
> 
> >
> >Unfortunately, it is not possible to revert the patch due to subsequent
> >patches, so I was unable to test a revert.
> >
> >Bisect log is attached.
> >
> >Guenter
> >
> >---
> ># bad: [cf08baa29613dd899954089e7cc7dba1d478b365] Add linux-next specific files for 20190306
> ># good: [1c163f4c7b3f621efff9b28a47abb36f7378d783] Linux 5.0
> >git bisect start 'HEAD' 'v5.0'
> ># bad: [6cc8f3499ec8d31904ab9083980a91736512cb37] Merge remote-tracking branch 'vfs/for-next'
> >git bisect bad 6cc8f3499ec8d31904ab9083980a91736512cb37
> ># good: [63bdf4284c38a48af21745ceb148a087b190cd21] Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> >git bisect good 63bdf4284c38a48af21745ceb148a087b190cd21
> ># good: [520b5fc601ab760fee7ea0c403b42d04e8ebfd93] Merge remote-tracking branch 'arm-soc/for-next'
> >git bisect good 520b5fc601ab760fee7ea0c403b42d04e8ebfd93
> ># bad: [d7f54e4e0d4e90f5df78da8d6a830bafad3b535a] Merge remote-tracking branch 'xtensa/xtensa-for-next'
> >git bisect bad d7f54e4e0d4e90f5df78da8d6a830bafad3b535a
> ># good: [0c1a78523542fb3d2e6c5ac7955c8ca8f6482e6f] Merge remote-tracking branch 'clk/clk-next'
> >git bisect good 0c1a78523542fb3d2e6c5ac7955c8ca8f6482e6f
> ># bad: [fb0b0a73b223fc113e961b1d921322844e9c30d9] powerpc: Enable kcov
> >git bisect bad fb0b0a73b223fc113e961b1d921322844e9c30d9
> ># good: [d0055df0c9c1471c389197a69f43e300185a75aa] Merge branch 'topic/dma' into next
> >git bisect good d0055df0c9c1471c389197a69f43e300185a75aa
> ># good: [0df977eafc792a5365a7f81d8d5920132e03afad] powerpc/6xx: Don't use SPRN_SPRG2 for storing stack pointer while in RTAS
> >git bisect good 0df977eafc792a5365a7f81d8d5920132e03afad
> ># bad: [665bed2386e5dc29844ad78c7ef1464664b103ec] powerpc/8xx: replace most #ifdef by IS_ENABLED() in 8xx_mmu.c
> >git bisect bad 665bed2386e5dc29844ad78c7ef1464664b103ec
> ># bad: [78ca1108b10927b3d068c8da91352b0f4cd01fc5] powerpc/book3s32: Reorder _PAGE_XXX flags to simplify TLB handling
> >git bisect bad 78ca1108b10927b3d068c8da91352b0f4cd01fc5
> ># bad: [a8a121995b2e4f227fddc534c6bd5f1c02cbe2ee] powerpc/603: Don't handle kernel page TLB misses when not need
> >git bisect bad a8a121995b2e4f227fddc534c6bd5f1c02cbe2ee
> ># bad: [2c12393f577396a51b7e0537bd3eb29dcc26dc1b] powerpc/603: use physical address directly in TLB miss handlers.
> >git bisect bad 2c12393f577396a51b7e0537bd3eb29dcc26dc1b
> ># bad: [93c4a162b014d238a287f8264adb25c009c79e61] powerpc/6xx: Store PGDIR physical address in a SPRG
> >git bisect bad 93c4a162b014d238a287f8264adb25c009c79e61
> ># first bad commit: [93c4a162b014d238a287f8264adb25c009c79e61] powerpc/6xx: Store PGDIR physical address in a SPRG
> >
