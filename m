Return-Path: <SRS0=q/i5=ZA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17318FA372C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Nov 2019 09:45:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63240214DA
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Nov 2019 09:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fR/E8RyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63240214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 478b3P0dQhzF6Km
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Nov 2019 20:45:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 478b0X688hzF6nG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2019 20:42:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="fR/E8RyI"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 478b0X4LcNz9sPk; Fri,  8 Nov 2019 20:42:36 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 478b0W3jgtz9sP6;
 Fri,  8 Nov 2019 20:42:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1573206156;
 bh=HX/zf896+L+aLj5O52hjw0t0TJACu18gwzubsdQDKao=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=fR/E8RyIIV9SH5jJ24k4CkSnV7QgtDW3LJ+kkvk99VO/lnDNUOeEMuzs+17FqtD9s
 f9aDOFogdkIoR66y2NBPqigmk+WXxeltzF0G18vpZNKTHgjj1tVXNfIl4qcwr49R+4
 KjvsjjfYuOPp1jNkkvlHTM308O3ZfX5yO6V74oyTLvNWwFqPkL1vDIlRqjih0EXEeZ
 /YnjCKOb7FacQDI7/ZRvygb/VyPh+EZRIvOhLR9gsJ9Jp8PPUWb//aUfqzafQDh4vo
 roR1lEI0zAvgko5ZtaCyObtNxgeQDkeADjto2j3KY+ZDFRFBaBnwMwY+aVCteqyxZ1
 JhwFXFnfFOOPw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Eric Richter <erichte@linux.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7 4/4] powerpc: load firmware trusted keys/hashes into
 kernel keyring
In-Reply-To: <20191107042205.13710-5-erichte@linux.ibm.com>
References: <20191107042205.13710-1-erichte@linux.ibm.com>
 <20191107042205.13710-5-erichte@linux.ibm.com>
Date: Fri, 08 Nov 2019 20:42:26 +1100
Message-ID: <87eeyi4scd.fsf@mpe.ellerman.id.au>
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Eric Ricther <erichte@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>,
 Matthew Garret <matthew.garret@nebula.com>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jk@ozlabs.org>, Elaine Palmer <erpalmer@us.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver O'Halloran <oohall@gmail.com>, George Wilson <gcwilson@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Eric Richter <erichte@linux.ibm.com> writes:
> From: Nayna Jain <nayna@linux.ibm.com>
>
> The keys used to verify the Host OS kernel are managed by firmware as
> secure variables. This patch loads the verification keys into the .platform
> keyring and revocation hashes into .blacklist keyring. This enables
> verification and loading of the kernels signed by the boot time keys which
> are trusted by firmware.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Eric Richter <erichte@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig                          |  1 +
>  security/integrity/Kconfig                    |  8 ++
>  security/integrity/Makefile                   |  4 +-
>  .../integrity/platform_certs/load_powerpc.c   | 98 +++++++++++++++++++
>  4 files changed, 110 insertions(+), 1 deletion(-)
>  create mode 100644 security/integrity/platform_certs/load_powerpc.c
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index cabc091f3fe1..498967a5ef4e 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -939,6 +939,7 @@ config PPC_SECURE_BOOT
>  	bool
>  	depends on PPC_POWERNV
>  	depends on IMA_ARCH_POLICY
> +	select LOAD_PPC_KEYS

This gave me a warning:

WARNING: unmet direct dependencies detected for LOAD_PPC_KEYS
  Depends on [n]: INTEGRITY [=y] && INTEGRITY_PLATFORM_KEYRING [=n] && PPC_SECURE_BOOT [=y]
  Selected by [y]:
  - PPC_SECURE_BOOT [=y] && PPC_POWERNV [=y] && IMA_ARCH_POLICY [=y]

I think you should probably just drop the select ..

> diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
> index 0bae6adb63a9..26abee23e4e3 100644
> --- a/security/integrity/Kconfig
> +++ b/security/integrity/Kconfig
> @@ -72,6 +72,14 @@ config LOAD_IPL_KEYS
>         depends on S390
>         def_bool y
>  
> +config LOAD_PPC_KEYS
> +	bool "Enable loading of platform and blacklisted keys for POWER"
> +	depends on INTEGRITY_PLATFORM_KEYRING
> +	depends on PPC_SECURE_BOOT
> +	help
> +	  Enable loading of keys to the .platform keyring and blacklisted
> +	  hashes to the .blacklist keyring for powerpc based platforms.

And instead make this default y, if you think it should be enabled by
default when its prerequisites are met.

cheers
