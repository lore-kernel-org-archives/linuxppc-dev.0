Return-Path: <linuxppc-dev+bounces-18338-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021FEFCD0BF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2026 06:16:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbJWH3bYHz2xYk;
	Wed, 18 Mar 2026 17:16:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::530" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773814603;
	cv=pass; b=FDmMy5oPgcr3AHEDNf0HTlvmNGsrvy7yOkO3nomVzkUzXLm3EMf4gM1i74RWWuFAPaPLiJ5ncJWHnzJbWs+mEU49jS1aPaLDhwsm59Kgkb3xJT5H8M/1AoXmydk9jo0vrDKuTg3JqNgTPxkUwZ7IamBGYsP0MwvtB1tcaR38VTt2odUZdwfUOwYIW93VLcw/ZWZh8XmdzfZG2m/C9DDWssOQ/znYvAPfqG53eQ8XWKWKa8+7ZpzjhZZgbuxI6KG8JySgq2vVfVi/ZLQJQvexVomrcvpsTGl7KVtT8hfMVoODQO8SFB4jPDAoZ61qSVjaG0x+HoWLL6ZpHNCI0FAZUQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773814603; c=relaxed/relaxed;
	bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfdhZd9VfA6wfLvUNHA57oO3WEKMricIl+PY+Xhh8FVF1g0QftTSq201PON8prAw3lCU10in+XoYPl7yiLaCofAXlS+ZJzKmxRowolEfp/jAJh+N2/qRP6ygVSN/rbwntcO1Xi9y1ZjmpBJHYrAmcAuEMwGmM8Bn1hWhl6/1vj6QJ03dIK3+yzhDXZBnbh+hO+A/WHgslkq/GRrdq/GBUhjGUpVP86avUIfHwE08qb1kglQ/Lqy7qV1MMKMKjsZr+hume9l7U+V+AanGyqSmHgtjQvGZHe68B2X2A8AImUNg8HwoH1DSRpIIRmL6HPq3JU2GAHHjG4owvaqB0sfsJA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MXPdevct; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MXPdevct;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbJWG28XTz2xQB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 17:16:42 +1100 (AEDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-667cc4ec065so838453a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 23:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773814598; cv=none;
        d=google.com; s=arc-20240605;
        b=F04IeovLRfbTJsDlvx1oCPk3VAITbh6/Kogk1DCPMG3P2QQozLuJo3CkC61fPR5y0k
         /9WjheRLXyLkrCL/UPMP7eBwfHakj+udGlO+tOe+cnpf3rqLqVimBK7gCf3Ofix9/c0e
         JS5kc/wwFer5R17GpoVh7+8yAhee1iSyfIahDk9fN6lHSFZ1aNrwNx8UsMpJ6kw7slg7
         cJZTblUjT+1NUdnhIMr26emRjmY/VcHXRgOb3D+2paRLlYSFyxrlED37NUeqQ6fEzMPI
         eiAqfrjUxlVczfuAT07EVMe9ACQ2G8G6mK5ULNpe/WyhQcJfZamVFCFkZQWk8qPx+O/A
         qeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
        fh=jg+iAbLcJ0dZniHLst0sTcywniTUt1B9momTtPUmPXE=;
        b=CYWyTLTaDEsPb8yuPPwpKawVvjynQlw4sLy2Z9PprWrbemJjdRzpQeKSvMVG7D6UqA
         NvQyMjWQB4+Ume5cnYAxCtydBKyuUjcoIlTWpd+9LKZT/f5Tmg7YcgQB6XcCBcAomkQZ
         RgBM5MVfyLsizR88XNwJGor/G0lO/au3/PUnFGwjKTS0/iNuLqf31zsAECqTAmD1CB+r
         N3JYxX+ibKQCo6F1uMszb+bS1JX6plmX3QrpoF6VB+YFbK/OAIAP774EpWNq8ZT5Ph26
         ggjMD84qvHUair+dIC3OLtyQxJdEiMVOSIUealoN8tuHQ6oEYN8aNuGxFeO1kctPJ4Ts
         XueQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773814598; x=1774419398; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
        b=MXPdevcttv0Q+JznbzByu2G0M/CwJ9IXnEca+ZzfEfVJHc/Tu9ohLsBx39A00sgtDt
         nW3uXOzMpBtx12BhR5FeKSH3zw9z1Ern1Yw6JJgaPdmWP/jmAwdExwhmSglZkW2i6Uqo
         wYVw2ZTqQqcYKZUb6nJRK7dSIzh611E4IL14bMmupsjYzqWaxAesIbsEMBH6yWg6TjLY
         AD79lvjGjHbNb3H6wYOP4d0qRxd1P9MpOiQ2ah4pV6+HWVWdTIubPaFjtb43dDIRrcHB
         4aZGQyv/c8N8dtHTDqukuImDPM6Jt1eYaK8pKPaLPZeLeoHwipnLk5ojRsWpmm1wYYUS
         mBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773814598; x=1774419398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
        b=Jb2taT/Jhwkfz7E8QCXeRehZ7+jx4AKkvl1BWapV0UoX0Wm/ECc6u3FRfHjDmR2y9j
         8oP28JHrSQ6Y9uF+ijwJx95FCZF+St6jMhilLqMLDfI2H23eKdup2HuG9n1HWz+WspOS
         0aDx2f+P4NTFFShOhUaGcll7vKj6CAgFHGI5d6xO8Y+mS8sSJ++Yl5TtW50AJ5UP1MCT
         A+ZA1wzOol2iB4c3abeXSgkAPjIAgFxSSbpkI0swpvILTsGTupMdlqdcbTgLCgYQpneh
         /FY8nx57WgpvtTyxT6QzIFHlMUbIKHyUo2zpl/qP+ceFf6Dq3NEIUDY1kZxhbiJfUypz
         SHzg==
X-Forwarded-Encrypted: i=1; AJvYcCU7HvShEh3jJcm6vMtGFFLslAo5qwLx0ccDhRBLahW+aL9+rLuB47I9FJp1BWUgzNJ1EjzgRMAE+HHr06g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyqE+hMAw5fqddCXV3fBWvlQnD+l1PO+Ay2r0IKenS7iIdzK7gC
	wiDvGYpF0D0PFF1PxVcYOgOgngwvMUTz/ccdFw/X/UVxG6Tix+8DAkSMYgtc8Ufk4R4ZzJUWLrp
	2lvUGjv4ZwhwZdgHx1LODtaiknoY7Qto=
X-Gm-Gg: ATEYQzzh8YJf1K/kp6RD5m41izwFQ9d/S95eYGR9dTdcsSpuNBS5TWMHxyE7kCIEx+r
	9a4w3jwoMysQonhAUZdaInKqaASlfvPA2veggwAPI9r6mVTpeIPjUX1mKNVJzkZZK5Jhi7hcNB+
	q7GsSlmsR8uWJCoquN39+tENPaLBGWA/Zav1Sxz9bn3+09pGgs3e3unpfsN/4iGiJIDBXDBGySX
	+f7F9a5yeDMUBHikDFTf30kGc7472IQ1De6zk1paAFSLBarZ0w9laCbYcnn5PEL6JtsJ+/xR3/3
	WfpH9s5bBU+YdtoQL1rNAX3IDQWhzeW1/UZ4rmLCEMLCW5DSdvQ=
X-Received: by 2002:a17:907:7b93:b0:b97:cc05:61b9 with SMTP id
 a640c23a62f3a-b97f4801ab5mr133040366b.15.1773814597747; Tue, 17 Mar 2026
 23:16:37 -0700 (PDT)
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
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de> <20260302-at-vector-size-arch-v1-14-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-14-a11f03ba2ca8@linutronix.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 18 Mar 2026 07:16:26 +0100
X-Gm-Features: AaiRm51Xx89jeaivgNYAhMk2LxpIu3kD6j5N4SuQDZ84WCnP1EAzJIW2dMNKGiE
Message-ID: <CA+=Fv5RLtUPp9BhXfFEUk3roE3Gah0iUamDEZ-MXCNM_xKm3PA@mail.gmail.com>
Subject: Re: [PATCH 14/15] alpha: remove AT_VECTOR_SIZE_ARCH from UAPI
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 1:32=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>
> Move the symbol to a kernel-internal header.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/alpha/include/asm/auxvec.h      | 7 +++++++
>  arch/alpha/include/uapi/asm/auxvec.h | 8 +++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>

Build-tested on alpha, no issues here.

Acked-by: Magnus Lindholm <linmag7@gmail.com>

