Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20CDC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 15:17:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F1120651
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 15:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F1120651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lN5Q5kpjzDqS8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 01:17:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gondor.apana.org.au
 (client-ip=5.180.42.13; helo=deadmen.hmeau.com;
 envelope-from=herbert@gondor.apana.org.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gondor.apana.org.au
X-Greylist: delayed 2876 seconds by postgrey-1.36 at bilbo;
 Fri, 19 Apr 2019 01:16:00 AEST
Received: from deadmen.hmeau.com (unknown [5.180.42.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lN3N2lTwzDqS7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 01:16:00 +1000 (AEST)
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1hH80y-0004pE-5M; Thu, 18 Apr 2019 22:27:48 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1hH80n-0004Ez-GG; Thu, 18 Apr 2019 22:27:37 +0800
Date: Thu, 18 Apr 2019 22:27:37 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] crypto: powerpc - convert to use crypto_simd_usable()
Message-ID: <20190418142737.ks6csnjjcfluacnz@gondor.apana.org.au>
References: <20190413053312.8783-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413053312.8783-1-ebiggers@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: Nayna <nayna@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 12, 2019 at 10:33:12PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Replace all calls to in_interrupt() in the PowerPC crypto code with
> !crypto_simd_usable().  This causes the crypto self-tests to test the
> no-SIMD code paths when CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.
> 
> The p8_ghash algorithm is currently failing and needs to be fixed, as it
> produces the wrong digest when no-SIMD updates are mixed with SIMD ones.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/powerpc/crypto/crc32c-vpmsum_glue.c    | 4 +++-
>  arch/powerpc/crypto/crct10dif-vpmsum_glue.c | 4 +++-
>  arch/powerpc/include/asm/Kbuild             | 1 +
>  drivers/crypto/vmx/aes.c                    | 7 ++++---
>  drivers/crypto/vmx/aes_cbc.c                | 7 ++++---
>  drivers/crypto/vmx/aes_ctr.c                | 5 +++--
>  drivers/crypto/vmx/aes_xts.c                | 5 +++--
>  drivers/crypto/vmx/ghash.c                  | 9 ++++-----
>  8 files changed, 25 insertions(+), 17 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
