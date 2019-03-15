Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EF0C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 05:04:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4792186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 05:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWi27k78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4792186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LD5X1D6LzDqRG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 16:04:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="WWi27k78"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44L8Xh4QQFzDqQT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 13:24:20 +1100 (AEDT)
Received: from sol.localdomain (c-107-3-167-184.hsd1.ca.comcast.net
 [107.3.167.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 26D7521872;
 Fri, 15 Mar 2019 02:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1552616657;
 bh=6Tu6ZXDuZstWKNqYrk1xEdRvRnFacskNZS6z3x9RlX8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WWi27k78tp3oVq0Tq4gp/SaiMjBjfWPebth9Im0zEYKOFjC/9Uzdfg7YQBLlQKWhP
 FG/o+wsTPKyNBO7yqQJKG+NunsytFo4ZVuZkkjajlo23fJqlz89ZkhS78p4aqoOipx
 9xrlO6INDNLfi9eCphPIMhsGoEe0Y6qLz9gUzio4=
Date: Thu, 14 Mar 2019 19:24:15 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] crypto: vmx - fix copy-paste error in CTR mode
Message-ID: <20190315022414.GA1671@sol.localdomain>
References: <20190315020901.16509-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190315020901.16509-1-dja@axtens.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Mailman-Approved-At: Fri, 15 Mar 2019 16:01:23 +1100
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
Cc: leo.barbosa@canonical.com, Herbert Xu <herbert@gondor.apana.org.au>,
 Stephan Mueller <smueller@chronox.de>, nayna@linux.ibm.com,
 omosnacek@gmail.com, leitao@debian.org, pfsmorigo@gmail.com,
 linux-crypto@vger.kernel.org, marcelo.cerri@canonical.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Daniel,

On Fri, Mar 15, 2019 at 01:09:01PM +1100, Daniel Axtens wrote:
> The original assembly imported from OpenSSL has two copy-paste
> errors in handling CTR mode. When dealing with a 2 or 3 block tail,
> the code branches to the CBC decryption exit path, rather than to
> the CTR exit path.

So does this need to be fixed in OpenSSL too?

> 
> This leads to corruption of the IV, which leads to subsequent blocks
> being corrupted.
> 
> This can be detected with libkcapi test suite, which is available at
> https://github.com/smuellerDD/libkcapi
> 

Is this also detected by the kernel's crypto self-tests, and if not why not?
What about with the new option CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y?

> Reported-by: Ondrej Mosnáček <omosnacek@gmail.com>
> Fixes: 5c380d623ed3 ("crypto: vmx - Add support for VMS instructions by ASM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  drivers/crypto/vmx/aesp8-ppc.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/vmx/aesp8-ppc.pl b/drivers/crypto/vmx/aesp8-ppc.pl
> index d6a9f63d65ba..de78282b8f44 100644
> --- a/drivers/crypto/vmx/aesp8-ppc.pl
> +++ b/drivers/crypto/vmx/aesp8-ppc.pl
> @@ -1854,7 +1854,7 @@ Lctr32_enc8x_three:
>  	stvx_u		$out1,$x10,$out
>  	stvx_u		$out2,$x20,$out
>  	addi		$out,$out,0x30
> -	b		Lcbc_dec8x_done
> +	b		Lctr32_enc8x_done
>  
>  .align	5
>  Lctr32_enc8x_two:
> @@ -1866,7 +1866,7 @@ Lctr32_enc8x_two:
>  	stvx_u		$out0,$x00,$out
>  	stvx_u		$out1,$x10,$out
>  	addi		$out,$out,0x20
> -	b		Lcbc_dec8x_done
> +	b		Lctr32_enc8x_done
>  
>  .align	5
>  Lctr32_enc8x_one:
> -- 
> 2.19.1
> 
