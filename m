Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E13606A329
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FnQ+UGvu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSgH04rVBz2y32;
	Mon, 16 Nov 2026 18:58:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794815932;
	cv=none; b=l8JZ89ZF1QdlNuWMXV/dn3tSe3CM/nP4ZCWozi47fO20+k94KCgTMVjAqAkUpfUI/PSBC8VH3SZG6kKkb3ADTvnr/+OM4Ic1UK78aUn3flt8buF1fj+Iw6uhopEQZD7kf640QsZTCZeNtrjA59pdScYyFJ6TAMVp7AhyiO8GMJ2t8xmxdE1d/uY1qWAO0WUvTELrym3kQHf5TjYT2zmlJpKwrBMfISOPEhBrQwagyY0vq7KuLErx3lf5dsySQu1mxiAocKKhN4kd8DkwFHWQEfxFLizVAZGjh/UUusxxv2xLCTKjun009vtfsvtVWzmrjj2leGo10MXrYSkBnzoNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794815932; c=relaxed/relaxed;
	bh=RUWz3ZPMUxA6+r9kTNI2D7JNnedpd8n5diTIAYYVkok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aSTUxtIxdmBOpw0BUO9eexCBmGfZ6cHhXOfpA5iEHWXb1Fw0nXAbQb1Z9NVV/YI3kCHqPexpa1PpZJHP0M5YpnWQ92V5Ld39C1fwxlkgwSua5c2onJNalx05gpuoEJIGwWrxW2nByYk6WgVqPdE62Vbdx3gE2CTxv59zzJVZPFENpsiWShQ0k6f3uGlSxCOgCQX5gx+ThGVZTdPXFP9VZnJvmQXxGDm3BwXVRBMdMwf9eN6429EnnhS6HYDkVmVfIkexh9pGjjLN/2d8ly0X8DEJr9His6w3yW8nFJSrNdQwGhPVh27diKVMZLmHV1erGdrfqUd1X78ZSUpVg3hjjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com; dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FnQ+UGvu; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org) smtp.mailfrom=amutable.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=FnQ+UGvu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amutable.com (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=alex@amutable.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSgGz5lRfz2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 18:58:51 +1100 (AEDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so6958755e9.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 23:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794815928; x=1795420728; darn=lists.ozlabs.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUWz3ZPMUxA6+r9kTNI2D7JNnedpd8n5diTIAYYVkok=;
        b=FnQ+UGvurzvgtlY79MjnBSahfrkbKYn6ttLV1q2bpx4nVRIu3ntR+u+TYfIqScHjXu
         qgHuyjCtsDx/UrKQzFckprT2GyJ4Vto+c/kgghhlh7bd9dKpKBbP9spwj8kNBDYclbj/
         KNH9Qgj3KuMBqzALISPPxM67k4PqcpdjtQ3cjsUbNYAGRiunEPpa5gJ2HJ2Ubj5JvRcn
         ejq8YnbRq8Wi9E2HkS3D76Jhj5TUsRpwiKa2KqKos5oGEgT5qOWaQVBMfNTqZio4S7TX
         l8539KSbuAJVDwBVV5TFlhgsek3wgYZeBONvcgqmbz/TpOfrpOETfQ8cBs/wHOlSLe+1
         PwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815928; x=1795420728;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUWz3ZPMUxA6+r9kTNI2D7JNnedpd8n5diTIAYYVkok=;
        b=RGuZ/AeP+TSxsZ4oRFpsK13B+mCbLUUd9pFpo1I67pVlXkuK8vP/c1KERvAsv0X1d/
         MtNDJMeE2nmRF3TELv315Uf0P4L0a0s9zf28cm6rlbzQyp+1UEKceyg1DF43xXG6vd6X
         ctmatChE5WYfczI3mkcTjukDl8hb70eOSR5n/sl0V69zYC5BJXxFIftg/wY1/m+1vwJu
         l7UBA0b36Dbim7lN6PwdC8HQkH3PVhSTyXjxNt3PVbcCF7JhFrmXsvZwJIrIxc9MAMOm
         2U3v8zViiiD8Lt+WagbilWg2cpeqs418vR4lZFO2T4IO+i0f1YYwExN/I5gFAzFS8h9R
         Zr+w==
X-Forwarded-Encrypted: i=1; AL+hErEfw4KMWy6052hpXwXQ91XC5KS0WC4qrTTLXO77MU+Ev/IpOaEy4vl1cA8aJQl8TFEIBYxQpc2H0SBGMI0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8+ntKs1hBOqreSoUaE2vlIiYidhUl1F8l1wYn/IUGxAsmQr1Of
	6sRy69XwYRKCXaJ2cTqYyivEf6gyGs/dmxq9yG7gqeJHDN5toMx7E1W+e/tZdJllb8bj
X-Gm-Gg: AYBFou1grktdCL5vGp5X7zR6m3b9JNMUekdYTqnKLn+NZ0lrVEVFqlWG0aqPNiMMXHR
	IRF0UGYCkYBDvGwpz16INLIlWDnX4X4srAd9GkndZwAhGhqnd4qS0JcNKFnUlcD1WnQxc1gjMMP
	j+WV+2IisH4eCm4VYLZIv4zQ9M0Xjtlwcvo6AIEukGn0E4orTQmc8TuYqY7Oad5PQUg/dMux8Up
	9i1cDM2pTHlvI0Bzrq15inxpgDhwUYz1bchfwjkLAn/pvIzqgQvJhHepNGTeGyhQtFnTcsc1F3e
	2M1T8aTHCToBTQHf5WUjZMpsLP+jnaqLYRAPKLLxdfTyTNVcNUmLdS7lgbpAglT8Qej1gb9rkcW
	whvgGdBvWMTglgfXQQ7Np7TSAjbmEUzqIe346Ukh0hgjqIpbxyLggdigq65peRwrBLUTATPGYhw
	SmB9nZCjbB3940Jpc+DBUgXBJoCRF5xqzXf4QwMOusIHw+mCIb+9c9DJkgBzftVz1fUxLLAzZZR
	4fWVMj6L/NOixE4vOUFGgC2PH4XKyEOE+RqEQVsyY3ZkgDzLAd4XpH9f0SsV/OOQDV6kw48kW67
	QTvxz1M/Ea18QKdHzucMQxNCikpJWb89YbQa60KHafobDviAHXcqvlhRjEQApSs=
X-Received: by 2002:a05:600c:3b07:b0:4bb:5de1:e912 with SMTP id 5b1f17b1804b1-4bb5de1f216mr172834365e9.1.1794815928232;
        Sun, 15 Nov 2026 23:58:48 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e252f7fsm375768305e9.2.2026.11.15.23.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:58:47 -0800 (PST)
Message-ID: <aa32167cd3865049bfe0281b8b651c47f5e1c05d.camel@amutable.com>
Subject: Re: [PATCH RFC 2/4] sh/crash_dump: check ioremap() in
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
Date: Mon, 16 Nov 2026 08:58:46 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
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
> copy_oldmem_page() maps a page of the old kernel with ioremap() and
> copies from it without checking whether the mapping worked. If it
> didn't, the copy reads from an offset into the NULL page.
>=20
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns
> that into -EFAULT like any other short copy.
>=20
> Fixes: 4d5ade5b29c6 ("sh: kdump support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/sh/kernel/crash_dump.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/arch/sh/kernel/crash_dump.c
> b/arch/sh/kernel/crash_dump.c
> index 19ce6a950aaca..85c0e58f1a59f 100644
> --- a/arch/sh/kernel/crash_dump.c
> +++ b/arch/sh/kernel/crash_dump.c
> @@ -20,6 +20,9 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	vaddr =3D ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
> +	if (!vaddr)
> +		return -ENOMEM;
> +
> =C2=A0	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> =C2=A0	iounmap(vaddr);
> =C2=A0

