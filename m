Return-Path: <SRS0=FDsq=UQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC317C31E5B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Jun 2019 21:49:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EAED2063F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Jun 2019 21:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="rFQ6wPYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAED2063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45SPxY20cNzDqYd
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2019 07:49:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="rFQ6wPYm"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45SPvc2f3nzDqSg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2019 07:47:40 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 45SPvX6TlFz9v2j5;
 Mon, 17 Jun 2019 23:47:36 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=rFQ6wPYm; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id kfOc68UfSeIR; Mon, 17 Jun 2019 23:47:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 45SPvX5J6hz9v2j4;
 Mon, 17 Jun 2019 23:47:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1560808056; bh=ZZO4LfmpEKhCUXBijrOkaQcSAOYgGw2UTduyEJKqtUM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=rFQ6wPYmQaExzXDJpuiuwF99J40FOd3hnE2uSehyW28k5885nTWUowJdEwZb/P5d4
 pbBu5Tjp/FYB046ADolt7U/U7qWYQYalbvkkoGof6+o3NdbtRi3HPYmJrOZ8UtiWPx
 95HrQPIJjHuHmOlx0hiK/+SInH+u1YZMgtadrHos=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id EF6648B84D;
 Mon, 17 Jun 2019 23:47:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id OwA-rgv9DTHK; Mon, 17 Jun 2019 23:47:36 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 50FEF8B7FF;
 Mon, 17 Jun 2019 23:47:36 +0200 (CEST)
Subject: Re: [PATCH] powerpc/mm/32s: fix condition that is always true
To: Andreas Schwab <schwab@linux-m68k.org>
References: <cover.1550775950.git.christophe.leroy@c-s.fr>
 <1e412310cc18ea654fb2ce4c935654d8d1069f27.1550775950.git.christophe.leroy@c-s.fr>
 <87muif52lv.fsf_-_@igel.home>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <58297c81-430b-d615-fa11-55136ae924f5@c-s.fr>
Date: Mon, 17 Jun 2019 23:47:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <87muif52lv.fsf_-_@igel.home>
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
Cc: j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 17/06/2019 à 23:22, Andreas Schwab a écrit :
> Move a misplaced paren that makes the condition always true.
> 
> Fixes: 63b2bc619565 ("powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX")
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
>   arch/powerpc/mm/pgtable_32.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index d53188dee18f..35cb96cfc258 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -360,7 +360,7 @@ void mark_initmem_nx(void)
>   	unsigned long numpages = PFN_UP((unsigned long)_einittext) -
>   				 PFN_DOWN((unsigned long)_sinittext);
>   
> -	if (v_block_mapped((unsigned long)_stext) + 1)
> +	if (v_block_mapped((unsigned long)_stext + 1))
>   		mmu_mark_initmem_nx();
>   	else
>   		change_page_attr(page, numpages, PAGE_KERNEL);
> 
