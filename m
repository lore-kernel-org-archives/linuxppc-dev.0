Return-Path: <SRS0=7u3Q=IU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665D5C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 18:45:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D339561990
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Mar 2021 18:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D339561990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F43Nj2nT4z3bVZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Mar 2021 05:45:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=qo5BG2Dy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=qo5BG2Dy; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F43NF3vXJz2y6F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Mar 2021 05:45:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
 Reply-To:Cc:Content-ID:Content-Description;
 bh=YDznzbC9kBnOi1zDch9k5axeMze5seDath3nLiBy+3M=; b=qo5BG2DysvkxUXCcJ06pf2+KLD
 8bb/t3cX7/pHAE8yb+KNs2krAaLmp09LLeSmc+3vnFnw2T0fbwtsNtNw5tgo6g7xQ8gZ/gliuvFYY
 fTQuD3mMHiA58nnyKg+19caAEFdhbAaHR9iyi9wAQ11DO0n0UAGBBYLUstkg2sWL6M+/iRa405FiJ
 1GGQ2PgMN6gx8GKIMYLoLaH2VgdEnAyNUt5WH0AmbozPdGEMjKdyQX9y+0bC8/7tljgKTPTeFukAs
 ZkL1VWUcGjpyJ2weUFl9WXZczQoENEAswYFDFYwgwIhtNtv6lGZiJkFzUZb6oCWb/OFrpE5K4VKf6
 YByS4n/w==;
Received: from [2601:1c0:6280:3f0::3ba4]
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lOPY8-008vxO-P2; Mon, 22 Mar 2021 18:45:16 +0000
Subject: Re: [PATCH] powerpc/asm: Fix a typo
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20210322113254.2081445-1-unixbhaskar@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <96eda8ce-1d89-1491-51a2-92ba9883912b@infradead.org>
Date: Mon, 22 Mar 2021 11:45:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322113254.2081445-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 3/22/21 4:32 AM, Bhaskar Chowdhury wrote:
> 
> s/poiner/pointer/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

However, it would be a GOOD THING to collect multiple similar
patches that are in e.g. arch/powerpc/ and send them as one patch
instead of many little patches.


> ---
>  arch/powerpc/include/asm/cpm2.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/cpm2.h b/arch/powerpc/include/asm/cpm2.h
> index 2211b934ecb4..bda45788cfcc 100644
> --- a/arch/powerpc/include/asm/cpm2.h
> +++ b/arch/powerpc/include/asm/cpm2.h
> @@ -594,7 +594,7 @@ typedef struct fcc_enet {
>  	uint	fen_p256c;	/* Total packets 256 < bytes <= 511 */
>  	uint	fen_p512c;	/* Total packets 512 < bytes <= 1023 */
>  	uint	fen_p1024c;	/* Total packets 1024 < bytes <= 1518 */
> -	uint	fen_cambuf;	/* Internal CAM buffer poiner */
> +	uint	fen_cambuf;	/* Internal CAM buffer pointer */
>  	ushort	fen_rfthr;	/* Received frames threshold */
>  	ushort	fen_rfcnt;	/* Received frames count */
>  } fcc_enet_t;
> --


-- 
~Randy

