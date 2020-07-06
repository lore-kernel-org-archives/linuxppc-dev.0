Return-Path: <SRS0=jlj5=AR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0326C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 07:51:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2895A2070C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 07:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ax6ty8ZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2895A2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B0d7Z09kWzDqZx
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2020 17:51:54 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B0d5X59zZzDqZ9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2020 17:50:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ax6ty8ZL; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4B0d5V2yvnz9sRK;
 Mon,  6 Jul 2020 17:50:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1594021806;
 bh=Xxw/mGzJ0dNLG9y/L6Dm0RvN4a7TzCoMImNSqc6scHc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ax6ty8ZLrOLYzmSAF+EUcEp7F1ttLTs87XUUD2W3lpbU3pLVoylD7FXLtUpHy7ugo
 BHv7jnyviByqTaE4DrogD3GdonhNnNQ/xl3CI2ZGAjrytWY9NXmzqztmjrECUYYLtA
 Oeuog5tH+zfuoGiO3mDtMWvZ1mancFpSm/EVuSoY3neeymvRNcRmQJ7fr7VVjB4hkv
 ppM7x2GdVTuYvzCnAHLGi3Ghg6ksMM7K5AjeV8Bmvv1wSEALYOhM2boX44rojUMaBe
 OI1tlhjCPX5Jq2p1fvNnc3/J8MCyenrDRfExADlTvbQP1EU7fXmNiwKVeYPhPXGce8
 kS8q3FxrsfrOg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 17/26] powerpc/book3s64/keys: Print information during
 boot.
In-Reply-To: <20200619135850.47155-18-aneesh.kumar@linux.ibm.com>
References: <20200619135850.47155-1-aneesh.kumar@linux.ibm.com>
 <20200619135850.47155-18-aneesh.kumar@linux.ibm.com>
Date: Mon, 06 Jul 2020 17:52:19 +1000
Message-ID: <87k0zh5bd8.fsf@mpe.ellerman.id.au>
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxram@us.ibm.com,
 bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/mm/book3s64/pkeys.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/mm/book3s64/pkeys.c b/arch/powerpc/mm/book3s64/pkeys.c
> index 810118123e70..0d72c0246052 100644
> --- a/arch/powerpc/mm/book3s64/pkeys.c
> +++ b/arch/powerpc/mm/book3s64/pkeys.c
> @@ -195,6 +195,7 @@ void __init pkey_early_init_devtree(void)
>  	 */
>  	initial_allocation_mask |= reserved_allocation_mask;
>  
> +	pr_info("Enabling Memory keys with max key count %d", max_pkey);
                                                           ^
                                                           missing newline

>  	return;
>  }

The syscall is called pkey_mprotect() and the manpage is "pkeys", so I
think it would make sense to use "pkey" in the message.

cheers
