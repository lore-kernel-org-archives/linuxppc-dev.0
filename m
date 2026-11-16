Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849F606A32C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e8qv39vj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSgGg20Bgz2xnn;
	Mon, 16 Nov 2026 18:58:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794815915;
	cv=none; b=i64EvjPVXI1u9yLiYwrXmktUaXfBO0DmFsQDX1Lm7zHtdQxVxea7FqMi7YZ2gxDQG5JW9YKTFIDMLMPTJm9ViSmRYJ5PaYKmCn+3VqR4dh3Qa/yiN1D/6/RoykiXppizTmgFgjSPlhG87sNeMdHQ1kGqITs/nkhUwDfpXC2s6SY0lrxKkTTagNcz8K7+MXDQihX8sEuwfjfnIKuelDRSBbouBGnQ7TPcYSbn5wpLiI3snZdeSyFsPlss5H+pfVaje1IlGn9o5uvTXGIZOwA9MGKg43ekH+b4ucaed0ipmt0MKmApw4fl5COskRqQj2POrnCsbOmO0SsBzDj4fQXG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794815915; c=relaxed/relaxed;
	bh=MJ7d3rNHeUtNAkSjUSjsQ3HRQiSBTnNiLXOBSu1liKw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Awp9gWr7d9xRl7oFLBjGHzBckHml/i+nl7i6C3fx0/6DVvMZNjJzA7qTWFajoPDGpB14bnik0uMa19qWZ2t2wyJ4ZRl0yXqc6Am8nPQ5BKliRNy2+YTET9g2+ZRmpXJ1+QUqiEh1dykBY7z1HGN3LrRfVPjkXPHfxoAv9/EoV6HKaZeFCkUMBunPaYZq35UOjUQ4SlTpVSDVqU9jtBOT8VA+7bLJqjitnk39ll6QHr8GIhMAMW7Fkp2+heC7i1q9xwo9GXdhoBAL+0XSZH2WxO5epFVVa1ubxVRZ1S9RZ7mbRzjmed1zkmw+Vh89srrGqVoepcCt0aiseJ+92ln2PA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e8qv39vj; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e8qv39vj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSgGd1Sf1z2xly
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 18:58:32 +1100 (AEDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-49412eb1474so1449600f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 23:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794815909; x=1795420709; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MJ7d3rNHeUtNAkSjUSjsQ3HRQiSBTnNiLXOBSu1liKw=;
        b=e8qv39vjRFwypUPbwwXA8rSI/JJxKTIqMQoCxdgy2i69HDAGFwbGFPfnL1PL2UV7RJ
         jzNzfeoydmAvLb+NtgTfUMFfTDpLtsT3KLfzPakkOHPj4u8SZLFLjjJzC2uz6LOI83VY
         oupI0tDWSVOl+E18cZcaD6IGBjrfJ2keL7riq17i2MM+W0MvhhTEE0Rg4zmpsRK6Z2Pa
         Rkjxp3olk3tgZCgqq/iyda5opRurXnctPnIpB4uKfn4aHhzxbVY5NjQWPrzuuZHp4PYI
         mb38Uyc4ahhsHicVxijCqJ2KyDXWwEzpMvJovORrhp4bfpRaRX3oQmYUf373phciLYlh
         GGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815909; x=1795420709;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJ7d3rNHeUtNAkSjUSjsQ3HRQiSBTnNiLXOBSu1liKw=;
        b=GFsS05uS5bzKfxPS+siQ5MdUbC6VfamC5bEaRBonCwo21QW1tBBwNEB139Ng2be3YG
         pP4s8g8kgV4NfR2165jRQN/qvjesoFJpSQGwmfGUr9ODe/0FSpDCFT0amMqLgQJJ4H5f
         2572mlxiRDjFUA232MVfzGrUri/nuEaLlikWSbqMlJ3MdMPp/oNYoasUwG6Y3r+ytohV
         m6S+WgzmQsm7lpofALJeY1eYv2SoqxBKLFl3oySHTtikjgKCFOemOev8GeKvTBOWH/46
         VDkGN3VpvfFvCqmzMkkERLLNjXc1tUH5lBXDJAngJTzUaDhZtyQkvuoaSy1O2MX0SYSf
         MlSw==
X-Forwarded-Encrypted: i=1; AL+hErGTzIW1kF6s/JJwE2nV4bunv7NnLtluO91F+TFBVryLzj8gjzu/HBrXMqekM3DVtwK4Xd0cjsklhD344nk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8/yrDpQcCf77fPmmP+4kgezfEbWoeDGXaz6nM45svcI6P+mNie
	FfpKuyQQB6C64pPkOiCCPYDiTJn4EjzHvgfz5hSuzrYn4hpv3rPgaH+R0hxlKfEo5jfI
X-Gm-Gg: AYBFou1wuvCVGyfjivkoTFdjnlgA9eTIhOQ6r+ECSUlhXBar0n4CNtVq+EiaEcj8sBO
	afrL03yBQ2ge8QP57OhV/ucFHlskVr721FuPde7xEb+cpNwSo0uHjTvM8Og5vxMJTyakGi6OczH
	c4rKMRf08VZhRx0Fi4K6Y4ATX3AV98jJbrwPAjvUoDlAFZJAb/aSpTxn3J/HB3pvXFg45khJMAv
	kCGGkpV0oF3QIrnxtvtMpA/cswcBgw7Dmw15Xuxz1hhPc3BkfNxM8E0cmt1jGz6f7ZQH5zZ1uBV
	sa787JK4M8edrTQKXQOkjEvmZJJa0NEmYmayQtTFiVcWbl/FzyQzqEdPDHogmVR4tfaQJ0SmDIS
	kwyPPZVLi+URfTVGpLfKA+ZFKUHFWP5sv77MBpg0K8ZZWV3mlIqrwevKPgGtZlOJYGJt6g9NdUS
	dlVfPVljYzbtknGHgSPsPcPW5WGq3hsLhfut2uS5GhJD1UrnHWc0F2Tp99KVkbLKGpcfPIs7iGT
	nTW37GeQ1oYAkM0bcHpGDD79805N7naM5uVMOHQz/SpQASw38p0b+I0bI0mv2FYdQchL8IAmzrX
	RVsQV3y6UEKnTZ38AjqONiXM8x4n+UFQfw5WPPmBPncqJ553iBf7CsK2lTpjObY=
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr20084703f8f.45.1794815908942;
        Sun, 15 Nov 2026 23:58:28 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm21124748f8f.28.2026.11.15.23.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:58:28 -0800 (PST)
Message-ID: <19b4c35c016a91302bf6bc3380bfcd3d21dc50c0.camel@amutable.com>
Subject: Re: [PATCH RFC 1/4] powerpc/crash_dump: check ioremap_cache() in
 copy_oldmem_page()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao
	 <leitao@debian.org>, Chris Mason <mason@kernel.org>, Thomas Gleixner
	 <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>, 
	stable@vger.kernel.org
Date: Mon, 16 Nov 2026 08:58:26 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-12 at 17:37 +0100, Christian Brauner wrote:
> copy_oldmem_page() maps a page of the old kernel that isn't in the
> linear mapping with ioremap_cache() and copies from it without
> checking
> whether the mapping worked. If it didn't, the copy reads from an
> offset
> into the NULL page. That oopses unless the copy happens to be a user
> copy, whose exception table entries turn the fault into a short copy.
>=20
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns that into -EFAULT like any other short copy.
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent
> copy_oldmem_page")
> Cc: stable@vger.kernel.org
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/powerpc/kernel/crash_dump.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/crash_dump.c
> b/arch/powerpc/kernel/crash_dump.c
> index 103b6605dd68f..1543917bd3e1d 100644
> --- a/arch/powerpc/kernel/crash_dump.c
> +++ b/arch/powerpc/kernel/crash_dump.c
> @@ -86,6 +86,8 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0		csize =3D copy_to_iter(vaddr + offset, csize, iter);
> =C2=A0	} else {
> =C2=A0		vaddr =3D ioremap_cache(paddr, PAGE_SIZE);
> +		if (!vaddr)
> +			return -ENOMEM;
> =C2=A0		csize =3D copy_to_iter(vaddr + offset, csize, iter);
> =C2=A0		iounmap(vaddr);
> =C2=A0	}

