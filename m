Return-Path: <SRS0=Q9Ec=BX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AC6C433E1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2020 12:16:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D4D2078D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2020 12:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o6fKCM6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D4D2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BS5Bp6S1NzDqMd
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2020 22:16:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+f680953178fe677ce029+6199+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=o6fKCM6F; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BS5804MSmzDqcQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2020 22:13:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=MoNf4Mx4XC7fe6KmJ8o880rA+JoSPGYo+uyoKENVrZ8=; b=o6fKCM6FCiq2M0ZQGg/tTVWKwQ
 QU7l8IUWbmo1nAdhRGEh9kLJr+YW0aDnT4199tlI4cVNaJWDNHKnlfGa6/GyovFXMfLgem1GO0LcP
 mEGZSHsvk8F8yATMkJdGoBqQ/06Bl+B1olKtgsdt7u1IZ6lfhPSzNhfzMLuCutEHLZNO/lpGDCQuT
 mLLEF9vnTVXbv+FDYsEI0i/nFpV0LzMoUGvbi7hFpR9wXnrmdSzV71dTvfboOZew5eJKTtY6E/7Ke
 kIB+Irk/CvKEqwQYLPxn2fZ/P7aS93eC10wdcwaGcDGmtggTZE0iW3WXd735iqF1tjHEeloKbyS+Q
 KNR8O6Nw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k6C6W-0004Qh-E8; Thu, 13 Aug 2020 12:13:08 +0000
Date: Thu, 13 Aug 2020 13:13:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/5] powerpc: Remove flush_instruction_cache for book3s/32
Message-ID: <20200813121308.GA16237@infradead.org>
References: <11a330af231af22874c006302a945388846f8112.1597313510.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11a330af231af22874c006302a945388846f8112.1597313510.git.christophe.leroy@csgroup.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Thu, Aug 13, 2020 at 10:12:00AM +0000, Christophe Leroy wrote:
> -#ifndef CONFIG_PPC_8xx
> +#if !defined(CONFIG_PPC_8xx) && !defined(CONFIG_PPC_BOOK3S_32)
>  _GLOBAL(flush_instruction_cache)
>  #if defined(CONFIG_4xx)
>  	lis	r3, KERNELBASE@h
> @@ -290,18 +289,11 @@ _GLOBAL(flush_instruction_cache)
>  	mfspr	r3,SPRN_L1CSR1
>  	ori	r3,r3,L1CSR1_ICFI|L1CSR1_ICLFR
>  	mtspr	SPRN_L1CSR1,r3
> -#elif defined(CONFIG_PPC_BOOK3S_601)
> -	blr			/* for 601, do nothing */
> -#else
> -	/* 603/604 processor - use invalidate-all bit in HID0 */
> -	mfspr	r3,SPRN_HID0
> -	ori	r3,r3,HID0_ICFI
> -	mtspr	SPRN_HID0,r3
>  #endif /* CONFIG_4xx */
>  	isync
>  	blr
>  EXPORT_SYMBOL(flush_instruction_cache)
> -#endif /* CONFIG_PPC_8xx */
> +#endif /* CONFIG_PPC_8xx || CONFIG_PPC_BOOK3S_32 */

What about untangling this into entirely separate versions instead
of the ifdef mess?  Also the export does not seem to be needed at all.
