Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE73A606A323
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 08:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DOrcz4TW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSgLJ4k4gz2y7r;
	Mon, 16 Nov 2026 19:01:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794816104;
	cv=none; b=Jr6fk3R1hOIuWRh1FbK7B18WB0ihg0W1zPR3nOt8KWt1MIJyOb5zf3rNNoZxXOzo/tdQFKSAvbHZ2LTnvs6UuKIVqYTF2d08EVRpnsgv2oh3gyoFnYIe3HI8/TNOVatdn3cI6Eg/qxfmPq/8r7ehgfbYLeiJXLQfKQlLuRhKua5M52K/9AFTnuZNj5rq8+tnxXL8Xn0s3DBMZVMWyTUp5DwFCiRz4jLmtLpGi37G1CicSh26qMJlIsObl0npCHfOW6aWcY1MNJ8ZEbm7nGPPB6BNZ7ZVO0HhYAxqHfdBAWtqBCT2NqhehVveqePvXfpBtwYyCJHeDr507eflbNwUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794816104; c=relaxed/relaxed;
	bh=YsacxGE14wOKz6Pg8TZXlOHyLRTqOTqtvBl+xKa/O2U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AMOuUnyojt2qs2SXkxsgfSS/HyHLNigrkZF8yVXOjgDIVtIn1y3KJksQmWUqKqgXrQ8jpA6qyhIzZVCDeDaXzBSp8/cxkBWLXLiHOfLNyz8/HjI5ecJCvhA7B/Pt0dL6f+40n6VCVuBcfkqLSwzeqX7JzcEpVAdscUZiU2PviYYkEqbK7ILnia1gJs8pqvdu48w9H1XtNKDuWZwbM6UWu/m5RE9zknjedgd53ABgNnm/yCsJInp0Fue2XPo6vgbLnyCT9JXVGmmDCseFBZKofpsCaYzhfngFdtBbg7MdDUccex0cLK8qjy8BqpWRlI9kGBe2AMZvmH2vwhuYB8OxGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DOrcz4TW; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DOrcz4TW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSgLH4TPqz2y71
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 19:01:43 +1100 (AEDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-c4322d310e7so582267266b.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 00:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794816100; x=1795420900; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YsacxGE14wOKz6Pg8TZXlOHyLRTqOTqtvBl+xKa/O2U=;
        b=DOrcz4TW0+hIzm89ho1bqBw06j9mmg4K0VM4RnnSt1iq5Z2ZP1swEj86Zu/nE/PJf6
         29uBlWHxmcKasIUtdW3mwR+qNkVvASFOMl/wXC7/BLt2Al2bQlOo1wyAhy+y7sOrFb0v
         hxn+0S6dIl0MVvZFVW7YR0fayi7W42ShkhiSQCJzho1suMnTcb73we02T7TQva2b2Plj
         PdxCrz79vs/EYnAo5jSCn+cGDSdtfn0CEsqmyXbv07mT4j3MrScrpd4UAJh26bMZ3mdx
         IAYyb8NZ0cY9eBRjZPE5xyrpjBuFAstCBYHlwfS/u4bHs4o4ovKjI0bOUv/OowaUThcF
         KYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816100; x=1795420900;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YsacxGE14wOKz6Pg8TZXlOHyLRTqOTqtvBl+xKa/O2U=;
        b=L71P9vKvuU1AYrC0Ib5Mc2ik4JH6+XbMoiJj76+MGdCVNirH1Qowmbcl7r6BIy2skv
         iSwshpXGkBwThlvW2rfFrEYm+PKwRu8PGVNoO5qTE5r4fOFgpSC6G93ecxMFpFdk8QGW
         yTQXRKK3uBlM9x/3LgZpJR0gixybUsqsio9Q4UPM5cOltdislgkGhgMFP58/LtcAvWE3
         EPDDGGe7dhnQeb8TUWlYRK9QPn9wOYMjmj5tS+fKJXaEAjfqkq5HhwI6vBNVa6BcIX4T
         jx6IdNS+CuJvkSU5Rxmr/oUUOXOcBm0wWJWHFmUu69LUjEhmw1lYyGHl/hnJfDPtkTwT
         jqew==
X-Forwarded-Encrypted: i=1; AL+hErHkInJIr9zHgjo4wu4USI2eTICJILRGUyfiKctlaZgeE7uQpS2rnCGW5mLl6Ak9kTR5JYsv8JO0WVWLrCg=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+F+0q87QzcbE9I/KTzAVg6xSq9tMMyLn03TfnK7K6WzoZ1oaVG
	7QY5eGsirz/KbOqDLEVQBgWpUk70u1xwkZUNIjLadMQGKhmD8AA6xVPfYzLQRBIgHtM5
X-Gm-Gg: AYBFou3GPiPH65An5RrYSyEobqQH3D1hp+/4bU/Ff5n+qOITWpBccYyVMN5kIai3Y7j
	FQyd2eGH9L16Ge39OWO1jKSrBgl4Cn8LjA7T3ZpLqHGplSsFaE3IpcufM9ZkIOMriHebQC9ADUU
	eKuz2E5kUEcsot4qThtKG1sDlpIGUPnwtnWQO9FWwNFHg+1Z/Xr4+12KtC207aWy2/E2Mnhlao1
	uMr0H2Rn0MHLN6w43AnQGh5N06FeMTG++lksZiemS9qhtIT2+/So7zG40uFKoPUVl57U1ZmcPol
	/kzu9p4sc6zfdu1T6bWZVD1jUIrxK851PlbvPu0GBODVEXAfvk4gjzRRe3lWAK9DN9yQlaNMIn2
	ABPwM7V6DPT9H76NsgoCU2KwH1H0aDU7g6QOF2fIyjJ35OCbCI+fS8pLm7MEYIxEoN26ctFG7Tn
	n/iCoF6g5YSxTGTiO7MEr/H9udzClOWdchem5eCbMyjWwNbH1U8f1KPX0B/SybFOmYRKoUuHwYx
	uMR/G1mjUOwCJGJ2ALtMx6j0e448QB5M5rBvFP8f9Dn0SL/T0HNnAns9+C/gDA+aHSe4frNLn3G
	dRzZ08VFCcSN2rOuDfi3zV9ukpg0v5XeXXMUCGAcfUyTfcsixQ/MJcOWZEAIzp4=
X-Received: by 2002:a17:907:1c90:b0:c2e:63ba:1f90 with SMTP id a640c23a62f3a-c50963bc4f0mr777600066b.48.1794816099924;
        Mon, 16 Nov 2026 00:01:39 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7b2c9sm385795866b.73.2026.11.16.00.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:01:39 -0800 (PST)
Message-ID: <dfdd6f4437cbf8f55458b908ec5347f3189bce80.camel@amutable.com>
Subject: Re: [PATCH RFC 4/4] crash_dump: use copy_oldmem_to_iter() everywhere
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao
	 <leitao@debian.org>, Chris Mason <mason@kernel.org>, Thomas Gleixner
	 <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>
Date: Mon, 16 Nov 2026 09:01:37 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-4-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-4-ecdcafd99265@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-12 at 17:37 +0100, Christian Brauner wrote:
> Make the remaining copy_oldmem_page() implementations copy the page
> of
> the crashed kernel with copy_oldmem_to_iter() like x86_64 and powerpc
> do. None of these architectures has a machine check safe copy today,
> so
> for them this is copy_to_iter() under another name. But the copy of a
> page of the old kernel is in one place now, and an architecture that
> gains ARCH_HAS_COPY_MC later gets the recovery without touching its
> crash dump code.
>=20
> s390 stays as it is. It copies the old kernel's memory through its
> real
> address mode window in memcpy_real_iter(), and an uncorrected storage
> error is fatal on s390 anyway (cf. s390_handle_damage()).
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/arm/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
2 +-
> =C2=A0arch/arm64/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0arch/loongarch/kernel/crash_dump.c | 2 +-
> =C2=A0arch/mips/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0arch/riscv/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0arch/sh/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 2 +-
> =C2=A0arch/x86/kernel/crash_dump_32.c=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A07 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm/kernel/crash_dump.c
> b/arch/arm/kernel/crash_dump.c
> index 938bd932df9a0..0f2628872b00c 100644
> --- a/arch/arm/kernel/crash_dump.c
> +++ b/arch/arm/kernel/crash_dump.c
> @@ -28,7 +28,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	iounmap(vaddr);
> =C2=A0	return csize;
> diff --git a/arch/arm64/kernel/crash_dump.c
> b/arch/arm64/kernel/crash_dump.c
> index 670e4ce818223..c774b3aba107d 100644
> --- a/arch/arm64/kernel/crash_dump.c
> +++ b/arch/arm64/kernel/crash_dump.c
> @@ -24,7 +24,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	memunmap(vaddr);
> =C2=A0
> diff --git a/arch/loongarch/kernel/crash_dump.c
> b/arch/loongarch/kernel/crash_dump.c
> index e559307c10929..03a136b8be8da 100644
> --- a/arch/loongarch/kernel/crash_dump.c
> +++ b/arch/loongarch/kernel/crash_dump.c
> @@ -15,7 +15,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	memunmap(vaddr);
> =C2=A0
> diff --git a/arch/mips/kernel/crash_dump.c
> b/arch/mips/kernel/crash_dump.c
> index 6e50f49024094..078c0d1e8df46 100644
> --- a/arch/mips/kernel/crash_dump.c
> +++ b/arch/mips/kernel/crash_dump.c
> @@ -12,7 +12,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	vaddr =3D kmap_local_pfn(pfn);
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0	kunmap_local(vaddr);
> =C2=A0
> =C2=A0	return csize;
> diff --git a/arch/riscv/kernel/crash_dump.c
> b/arch/riscv/kernel/crash_dump.c
> index ea2158cee97b3..0820e3db12603 100644
> --- a/arch/riscv/kernel/crash_dump.c
> +++ b/arch/riscv/kernel/crash_dump.c
> @@ -21,7 +21,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	memunmap(vaddr);
> =C2=A0	return csize;
> diff --git a/arch/sh/kernel/crash_dump.c
> b/arch/sh/kernel/crash_dump.c
> index 85c0e58f1a59f..2a5988b6e9d7a 100644
> --- a/arch/sh/kernel/crash_dump.c
> +++ b/arch/sh/kernel/crash_dump.c
> @@ -23,7 +23,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0	iounmap(vaddr);
> =C2=A0
> =C2=A0	return csize;
> diff --git a/arch/x86/kernel/crash_dump_32.c
> b/arch/x86/kernel/crash_dump_32.c
> index 5f4ae5476e193..cb202d4e1f703 100644
> --- a/arch/x86/kernel/crash_dump_32.c
> +++ b/arch/x86/kernel/crash_dump_32.c
> @@ -40,7 +40,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn, size_t csize,
> =C2=A0		return -EFAULT;
> =C2=A0
> =C2=A0	vaddr =3D kmap_local_pfn(pfn);
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0	kunmap_local(vaddr);
> =C2=A0
> =C2=A0	return csize;

