Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFD5C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 11:16:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE0220870
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 11:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="i0+z0gOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE0220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44XqXZ3jD1zDqNX
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 22:16:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="i0+z0gOY"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44XqVP1M1czDqLh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 22:14:21 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44XqV96HgSz9tyfn;
 Mon,  1 Apr 2019 13:14:09 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=i0+z0gOY; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Xqopo6qslUS8; Mon,  1 Apr 2019 13:14:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44XqV955Zlz9tyfB;
 Mon,  1 Apr 2019 13:14:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554117249; bh=t8JxzHNnysGN5V5loKvGifZRjTCZPzfpZTeMykqXsHA=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=i0+z0gOYpUl3h8iC7LwW5M/BmSffYCp7liEXJ9anK06n2uppP8ZxTgKCXmGEHkATp
 sO+KZaldbOvvfoMkZ3R/thcBdiUOXInX04nECgKC+9Pga3JsTxA5RzuTY0Vqe0zTLW
 KY8fhRsa+Qmg6L3IFGR1DPIjd5PL2mTdAcXxomQs=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 716E08B8A7;
 Mon,  1 Apr 2019 13:14:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id cjT4FUAP7nAG; Mon,  1 Apr 2019 13:14:14 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D5418B841;
 Mon,  1 Apr 2019 13:14:14 +0200 (CEST)
Subject: Re: [PATCH] powerpc/rtas: fix early boot failure.
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Larry Finger <Larry.Finger@lwfinger.net>
References: <aab41779cac995ebdc03e700a9dc7cfc30a28770.1553503163.git.christophe.leroy@c-s.fr>
Message-ID: <558fbb7e-a454-055e-ca29-a2e4dfb6cf6a@c-s.fr>
Date: Mon, 1 Apr 2019 13:14:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <aab41779cac995ebdc03e700a9dc7cfc30a28770.1553503163.git.christophe.leroy@c-s.fr>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael,

Looks like you missed this fix for rc3.

Christophe

Le 25/03/2019 à 09:43, Christophe Leroy a écrit :
> Commit 0df977eafc79 ("powerpc/6xx: Don't use SPRN_SPRG2 for storing
> stack pointer while in RTAS") changes the code to use a field in
> thread struct to store the stack pointer while in RTAS instead of
> using SPRN_SPRG2. It therefore converts all places which were
> manipulating SPRN_SPRG2 to use that field. During early startup,
> the zeroing of SPRN_SPRG2 has been replaced by a zeroing of that
> field in thread struct. But at least in start_here, that's done
> wrongly because it used the physical address of the fields while
> MMU is on at that time.
> 
> So the virtual address of the field should be used instead, but in
> the meantime, thread struct has already been zeroised and initialised
> so we can just drop this initialisation.
> 
> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
> Fixes: 0df977eafc79 ("powerpc/6xx: Don't use SPRN_SPRG2 for storing stack pointer while in RTAS")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>   arch/powerpc/kernel/head_32.S | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
> index 48051c8977c5..e25b615e9f9e 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -851,10 +851,6 @@ __secondary_start:
>   	tophys(r4,r2)
>   	addi	r4,r4,THREAD	/* phys address of our thread_struct */
>   	mtspr	SPRN_SPRG_THREAD,r4
> -#ifdef CONFIG_PPC_RTAS
> -	li	r3,0
> -	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
> -#endif
>   	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
>   	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
>   	mtspr	SPRN_SPRG_PGDIR, r4
> @@ -941,10 +937,6 @@ start_here:
>   	tophys(r4,r2)
>   	addi	r4,r4,THREAD	/* init task's THREAD */
>   	mtspr	SPRN_SPRG_THREAD,r4
> -#ifdef CONFIG_PPC_RTAS
> -	li	r3,0
> -	stw	r3, RTAS_SP(r4)		/* 0 => not in RTAS */
> -#endif
>   	lis	r4, (swapper_pg_dir - PAGE_OFFSET)@h
>   	ori	r4, r4, (swapper_pg_dir - PAGE_OFFSET)@l
>   	mtspr	SPRN_SPRG_PGDIR, r4
> 
