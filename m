Return-Path: <SRS0=Pmlw=YI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76131ECE588
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Oct 2019 10:35:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151382067B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Oct 2019 10:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpsPmLAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151382067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46ssK35Gb7zDqyH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Oct 2019 21:35:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2a00:1450:4864:20::443; helo=mail-wr1-x443.google.com;
 envelope-from=ard.biesheuvel@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="TpsPmLAp"; 
 dkim-atps=neutral
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ssGY5CSfzDqx6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2019 21:33:40 +1100 (AEDT)
Received: by mail-wr1-x443.google.com with SMTP id b9so23217910wrs.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2019 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YSK25mgLP2qGujjcVZMaYH39R8jkExhb9pHpMqbi9GA=;
 b=TpsPmLAphUhP91H2zfTGmqgMFc+tf3x2s40xaEMXb4jarRvDtFZ5Re7Oq97V+ovVBm
 JJba+t1emP9U++I0ssZAbA1j2VgnXDVbnUzdzo75m8UWBXdGcQXSzI1NHBlood8xkfs9
 LDNoJSG14R2jBhOuZwa4ijGXTSdXsAFyDC1ZdEH0/2Q9CSy4OG33qNfW67KQcDIfPemE
 29VJuwe7H83hKYkJpz06O82aT12VYY+/RzuNmAYrqZMFZzB+/yngc9eeGfaZXMeCDQ4J
 Y+zu9ZpcKV9zQODZ1SzuefzABwyShTteUlgYkDBVNjMeSzHywmaiNZ8OcFpWt31pIj5R
 itrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YSK25mgLP2qGujjcVZMaYH39R8jkExhb9pHpMqbi9GA=;
 b=O2PZwg/ZK1xZ85D3fufGFD5MiRJLtO6njRtaPeLoBEOmoeEijTleUGd8DNIadGrvPz
 f+9mlUpgRDJhArYmvhpsqo8dxysA7KdIPkj21hf9CmrbDGuV53InnqvGES7OwEcM/DRL
 684fyMwDKziAAVE3cNAFMqAR8ximt7mETVAtOBbGVpktAVsrTUi7HtykvGMpCi9N1+Iv
 bS6YHeffgzmNjTK5ONNHQkk4Cz7UpUaI2fRHAu5sVY4TQUmavSasbOIWj7piHDJGM6cw
 Mzr2XpujsbORyFTwZcO6DtF4mQqN6F4T4CJgJR+wg7yLqE0luCrR/WSuhIJmuzI3hyS6
 JMuQ==
X-Gm-Message-State: APjAAAV26TSCNfqbhWzyw+AnaaWW6EGhiFcMavpaR7QiFjDy3pEy1+SX
 3q3vaT077X7QyhEnM6qrqrWPpAkvv4oTt8QpXUFwsQ==
X-Google-Smtp-Source: APXvYqzAzVDkHsjTVyzfvOTUBgHd0YjSgoANEEfLP1CwlPZ8hBLoj9oAW8bPSfn3FKN8hHgs3zbYuM4bXtcIus5kXCg=
X-Received: by 2002:adf:f5c2:: with SMTP id k2mr31748636wrp.0.1571135616941;
 Tue, 15 Oct 2019 03:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191015024517.52790-1-ebiggers@kernel.org>
In-Reply-To: <20191015024517.52790-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 15 Oct 2019 12:33:25 +0200
Message-ID: <CAKv+Gu8V50wZyoP8gLAEL8W=w25Ra91E+KyH7-kD18qUyuEOmw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] crypto: powerpc - convert SPE AES algorithms to
 skcipher API
To: Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 Markus Stockhausen <stockhausen@collogia.de>,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 15 Oct 2019 at 04:45, Eric Biggers <ebiggers@kernel.org> wrote:
>
> This series converts the glue code for the PowerPC SPE implementations
> of AES-ECB, AES-CBC, AES-CTR, and AES-XTS from the deprecated
> "blkcipher" API to the "skcipher" API.  This is needed in order for the
> blkcipher API to be removed.
>
> Patch 1-2 are fixes.  Patch 3 is the actual conversion.
>
> Tested with:
>
>         export ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-
>         make mpc85xx_defconfig
>         cat >> .config << EOF
>         # CONFIG_MODULES is not set
>         # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
>         CONFIG_DEBUG_KERNEL=y
>         CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
>         CONFIG_CRYPTO_AES=y
>         CONFIG_CRYPTO_CBC=y
>         CONFIG_CRYPTO_CTR=y
>         CONFIG_CRYPTO_ECB=y
>         CONFIG_CRYPTO_XTS=y
>         CONFIG_CRYPTO_AES_PPC_SPE=y
>         EOF
>         make olddefconfig
>         make -j32
>         qemu-system-ppc -M mpc8544ds -cpu e500 -nographic \
>                 -kernel arch/powerpc/boot/zImage \
>                 -append cryptomgr.fuzz_iterations=1000
>
> Note that xts-ppc-spe still fails the comparison tests due to the lack
> of ciphertext stealing support.  This is not addressed by this series.
>
> Changed since v1:
>
> - Split fixes into separate patches.
>
> - Made ppc_aes_setkey_skcipher() call ppc_aes_setkey(), rather than
>   creating a separate expand_key() function.  This keeps the code
>   shorter.
>
> Eric Biggers (3):
>   crypto: powerpc - don't unnecessarily use atomic scatterwalk
>   crypto: powerpc - don't set ivsize for AES-ECB
>   crypto: powerpc - convert SPE AES algorithms to skcipher API
>

For the series

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>


>  arch/powerpc/crypto/aes-spe-glue.c | 389 ++++++++++++-----------------
>  crypto/Kconfig                     |   1 +
>  2 files changed, 166 insertions(+), 224 deletions(-)
>
> --
> 2.23.0
>
