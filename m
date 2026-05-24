Return-Path: <linuxppc-dev+bounces-21436-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFF4CD5BAB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 May 2026 07:10:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gNVXV1pNbz2xtt;
	Sun, 24 May 2026 17:10:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779606634;
	cv=none; b=aWCinW6Tfw3VOjVNKU1BIRyosGkU8DzTu7YVGt6cnhdifkblwzesN9ethjpS+lXpThsXQz7pdpqdNboRQKKOOM/w+su0IeQ8gHZMmaFEerI6zgtYNIqjQCaLPJ47mgV6oJSlpxW6pGws/74gYNVrEohmZXTopHENSp/4JGMZXc3FnErani5Lr0D0dxWaCuewnw7VvDGHL2eZKVMDLJpZW0cYvQu6IFCCFC+jZdiWRSuj7apWE4owFzObeGHhLdxS6RWhLf7m7AHNlu8f8+lWNui1pSv2wLJYLEuL1tcJ4V0zCFv68bdIo68MVIPvn2qno387om7ON0pCuR5avelpRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779606634; c=relaxed/relaxed;
	bh=xlYkz6g3wbQ9IFHWyxO5Z4osnU5OrF8poVvRpYxaIgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRWqfIwTFXOSaoB8VbzA4tHimO1GE3VTiGRt62uMjqXx39BRJFpXvWJQ1a+c6QgezpxRiXT0boDWcX0fS/1c/nSoGpVrOn4oP+3GXM83Cp/MjlOwPRabikur8pVLM+kKDLjA8u0FCPMBN24nKxtHKPlAXZ8Wvt403QCV1ufxBpS3hheA6Kg4gVF1IxEeZqusb1ouJBtrbeTntT12mW8TZU+gM6tPwv0X7Z92VyjwXF+vShbr1ajGCEtePi1ama7S0lteotpU6JvoaQDhaO0FrWifWcECVXT42+E868C9be/J9f9hOzUlPfXd3kLgTlFQw/g0k/HuFoJIJfjOEZH6mA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass (client-ip=209.85.221.43; helo=mail-wr1-f43.google.com; envelope-from=breno.debian@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.221.43; helo=mail-wr1-f43.google.com; envelope-from=breno.debian@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gNVXT1Gzbz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2026 17:10:32 +1000 (AEST)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44509921fbcso5489278f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2026 00:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779606628; x=1780211428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlYkz6g3wbQ9IFHWyxO5Z4osnU5OrF8poVvRpYxaIgg=;
        b=jlWiRKb1RqqsqijstoADRA+s7fau83vSTdQTH9goKDDBQZ56YZ1AN2I+mLImcMadY9
         aQCAuLY15uTLbExkqsD/0zOY+7K7blOk5wzqyZkps/+LytsKE+I3VPsIYSkJidZ5ToyK
         ztnmbmOyjkbc+XjED7DxHadOXGFJHqzhS3xyeS9ldDr9QM7fPZD56jfLHYJY3EsYwVpZ
         XWuNF/IqnzhIztk8aCbn0XZMM0A0G4EYMK4QHsZBQqXvxKG04vZM139nB5ft6ts2XW70
         QrBCtuKiruf4i9hD4HbB0zzQ85ZsRun6xIsNhEn0PBgojZEEIJLEq41PPFP8vJYtiHg2
         aDjA==
X-Forwarded-Encrypted: i=1; AFNElJ+fpxGrTGHke5BXWMH5UskSY035/+mJ+B7DlHAHUVTaQCGzkKd5yk/5nYXy4ANvJICNaVD+J7SVFNkX6zA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy8gqZ/D028Hx1t6JA8F+PbIgx2UwyfBgNZ0gEVsVn4VehwRZl1
	eBOKU/eBLWwc+TUkNqC3TgV2ZTFvQ5aNQx4kh/IGHywp8Po89dleJ7Yk
X-Gm-Gg: Acq92OF0Vi04Uf8bAEspmLyoLNNNFsfgIduxiGrhIAZJ5eT7F0ZxWMhfBmA1gANW+S5
	SriRvj48dWrk79xJaOKexn/9gZU8jTDOzY3hwHQaCICrfDEWYUksewrtlAx4HW0mS1WiSIPlVZJ
	8oT7xi3za+LbiNZ3VeTIwxrDUAnlMI4Zyq5pCgcuplfrbXhM3yye0HAe0cpl3VmTle+2cwNXM2A
	AuMv2I1buEHWgJf7L8XdzeguGkKCzXeX2KZwqxDQgdR/yechzn1ypPysr8QrigMzPg0LaHxR8EM
	gAAUd1yqjVcOoJRr3iBakJtxgG9kHG4XGFUO3KriDQNjSOn4MhECImOjP+bI/yzwaIXmShD2UGj
	QdFvGpkcz5FkV4kGGjYWUh7Bjz3ycL468NqDxxtZWWy04Qjj+sl41OiKJl9cXacY/2AVHDHKrGL
	D+OrgnTkxeAMXrOXIef9wMiOS9nBWzEKw=
X-Received: by 2002:a05:6000:4b12:b0:43d:7e34:889c with SMTP id ffacd0b85a97d-45eb38b5a04mr16209425f8f.39.1779606627897;
        Sun, 24 May 2026 00:10:27 -0700 (PDT)
Received: from gmail.com ([62.197.47.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9ba2esm18077988f8f.8.2026.05.24.00.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 00:10:27 -0700 (PDT)
Date: Sun, 24 May 2026 08:10:26 +0100
From: Breno Leitao <leitao@debian.org>
To: Sam James <sam@gentoo.org>
Cc: Nayna Jain <nayna@linux.ibm.com>, 
	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Biggers <ebiggers@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Eric Biggers <ebiggers@kernel.org>, 
	Calvin Buckley <calvin@cmpct.info>, Brad Spengler <brad.spengler@opensrcsec.com>, 
	linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: nx: fix nx_crypto_ctx_exit argument
Message-ID: <ahKkTuPAf7UsU1Hx@gmail.com>
References: <a3e89c1e8342ffa415b0d29725a0571a4f355d34.1779472902.git.sam@gentoo.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3e89c1e8342ffa415b0d29725a0571a4f355d34.1779472902.git.sam@gentoo.org>

On Fri, May 22, 2026 at 07:01:42PM +0000, Sam James wrote:
> nx_crypto_ctx_shash_exit calls nx_crypto_ctx_exit with crypto_shash_ctx(...)
> but crypto_shash_ctx gives a nx_crypto_ctx *, not a crypto_tfm *.
> 
> Fix the type in nx_crypto_ctx_exit and drop the bogus crypto_tfm_ctx
> call.
> 
> This fixes the following oops:
> 
>   BUG: Unable to handle kernel data access at 0xc0403effffffffc8
>   Faulting instruction address: 0xc000000000396cb4
>   Oops: Kernel access of bad area, sig: 11 [#15]
>   Call Trace:
>    nx_crypto_ctx_shash_exit+0x24/0x60
>    crypto_shash_exit_tfm+0x28/0x40
>    crypto_destroy_tfm+0x98/0x140
>    crypto_exit_ahash_using_shash+0x20/0x40
>    crypto_destroy_tfm+0x98/0x140
>    hash_release+0x1c/0x30
>    alg_sock_destruct+0x38/0x60
>    __sk_destruct+0x48/0x2b0
>    af_alg_release+0x58/0xb0
>    __sock_release+0x68/0x150
>    sock_close+0x20/0x40
>    __fput+0x110/0x3a0
>    sys_close+0x48/0xa0
>    system_call_exception+0x140/0x2d0
>    system_call_common+0xf4/0x258
> 
> .. which came from hardlink(1) opportunistically using AF_ALG.
> 
> The same problem exists with nx_crypto_ctx_skcipher_exit getting a context
> it wasn't expecting, but apparently nobody hit that for years.
> 
> Cc: Eric Biggers <ebiggers@kernel.org>
> Fixes: bfd9efddf990 ("crypto: nx - convert AES-ECB to skcipher API")
> Fixes: 9420e628e7d8 ("crypto: nx - Use API partial block handling")
> Reported-by: Calvin Buckley <calvin@cmpct.info>
> Tested-by: Calvin Buckley <calvin@cmpct.info>
> Suggested-by: Brad Spengler <brad.spengler@opensrcsec.com>
> Signed-off-by: Sam James <sam@gentoo.org>

Acked-by: Breno Leitao <leitao@debian.org>

