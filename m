Return-Path: <SRS0=NHc8=OL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F237C433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 22:00:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3EEF61019
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 22:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3EEF61019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HDb2T4LNNz3cPv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 08:00:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CNv6IJ+I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=CNv6IJ+I; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HDb1n1pyYz2xYN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Sep 2021 07:59:41 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BA5961019;
 Tue, 21 Sep 2021 21:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632261579;
 bh=2pzwqy6lIqIzqKUOtcOetgKUkFn022GfsoxI/JVuA50=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CNv6IJ+ItHvfpI9kKpFXRsKE44FdSPdiTYTJ//cZyeKrD64OgUgLFKypkwE+KPo08
 qDHA09VhX/Z76tOXl8C+1+QlwTdBTIpVyS7sPL3uOjYTmQF2Ukxp1rG9edwApOPKN8
 /dV1lSko4LSOAfqSlmTgRfQH2c6c2QLIp69UN9vSSQIv8j6/TO2kYFckN52YjtWZLd
 KI1+EETZscWQ0YZbvxVnRJOhdHmFbQiHmmfrFA+5SOkS7LgOdbmfjBBZQHhHHBhXLt
 z++MouszFcOPocs+oB08S1yAqzuFb4bbJO/O328GwDoPZHRluk1PZZk5USSFKBoTLz
 3XJzfTrdbXIjQ==
Date: Tue, 21 Sep 2021 14:59:37 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Subject: Re: [PATCH 0/4] crypto: nintendo-aes - add a new AES driver
Message-ID: <YUpVyTN7MQbMShdf@gmail.com>
References: <20210921213930.10366-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210921213930.10366-1-linkmauve@linkmauve.fr>
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
Cc: devicetree@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Ash Logan <ash@heyquark.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>,
 Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.ne@posteo.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Sep 21, 2021 at 11:39:26PM +0200, Emmanuel Gil Peyrot wrote:
> This engine implements AES in CBC mode, using 128-bit keys only.  It is
> present on both the Wii and the Wii U, and is apparently identical in
> both consoles.
> 
> The hardware is capable of firing an interrupt when the operation is
> done, but this driver currently uses a busy loop, I’m not too sure
> whether it would be preferable to switch, nor how to achieve that.
> 
> It also supports a mode where no operation is done, and thus could be
> used as a DMA copy engine, but I don’t know how to expose that to the
> kernel or whether it would even be useful.
> 
> In my testing, on a Wii U, this driver reaches 80.7 MiB/s, while the
> aes-generic driver only reaches 30.9 MiB/s, so it is a quite welcome
> speedup.
> 
> This driver was written based on reversed documentation, see:
> https://wiibrew.org/wiki/Hardware/AES
> 
> Emmanuel Gil Peyrot (4):
>   crypto: nintendo-aes - add a new AES driver
>   dt-bindings: nintendo-aes: Document the Wii and Wii U AES support
>   powerpc: wii.dts: Expose the AES engine on this platform
>   powerpc: wii_defconfig: Enable AES by default

Does this pass the self-tests, including the fuzz tests which are enabled by
CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y?

- Eric
