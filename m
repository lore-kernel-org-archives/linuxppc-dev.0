Return-Path: <linuxppc-dev+bounces-29069-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECB7CA600C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 19:29:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j10SH4Rnxz30Vb;
	Fri, 09 Oct 2026 06:29:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::230" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791487791;
	cv=pass; b=OzZaDSLC64xEt6Hxm6qdnIZT+Ctsd3FBPUcoRcFxYfYgM3l2ybI/b5YLkSXdpFoTtxLviLOODgt4uemMu6WByaLS0CS+fDkRVOtS9Dq2pNmmL56eitUqTFRY2iyAOXXojuniyVs6wpEsNs6VfK8GgEluwLFmoaoAY4aAY4YkTjMktROq2LWBDfBPUL8HzFpMYyA3CWnKekVrbkM66cdYI1o2YT5XvHESheoW+Ya8eOXpGU62j7M420MhQTNIGYa6PJW370qYZScGs5TZjR6p2dEUzd/NXP9mmuo0GYGYD40/w442uirKhMLvF1Zm8LDX3K2E4N5o6Mxk2uESPEJRIw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791487791; c=relaxed/relaxed;
	bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6Js+2AT6YDb1krBJ6MHaY622EU55gq8nPClBgH8h1A6UTYy3nfWc2v3LCc7Eyxx9jERdyNoPv95sjcswWq//fMLrqsTyQQgA4iZXsJNz/tdobyag0xelRnhj7zEzM9v5XRGS49frSSHCHkYVm8grpsNsXsjZmaCwT9l+l7FG1eKV/72H9ah3S042diK+3kZF8M85dv2mTVr2eNUYIYDE7wVsyiPPc2wGjXcJ6IVkpa+PQRKEgWTnSR/TcOMjfLU6sN6BDYDgR+B2gFL5xX8FFOBmEDtNlTuo+y+SguDygxuwSCtLeVfgv/WcRlEAtoDLIprMQKmJZOGHyZVV8budQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jnm7YV9a; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::230; helo=mail-lj1-x230.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jnm7YV9a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::230; helo=mail-lj1-x230.google.com; envelope-from=mattst88@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j10SG2PQFz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 06:29:49 +1100 (AEDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-3a65ed9c7cfso25808301fa.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 12:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791487781; cv=none;
        d=google.com; s=arc-20260327;
        b=GrcDw8bM+rQVbx5ly8e4c7H9iXjPMusJ0SlSpThBEe5gmF4wq41bXXNsUdyyZQo43b
         WuN7bpYTbv3DaCVVwCcMXDjyaq85Diy1hXRhM5b846bgpFfKHtU/+jvXnfaRwwmhMgQB
         97iOLI/cPdROnl+LmxsGStv6/7w1pouMwrUdJ+AQqHaftMR8gM5WuabOTUVQu0men0Ix
         Zzb1p2jtDX2zr/UV7KO1RcC2sPJiIYLUVlUKVt8cUsCxpdiilUcU2BIAYywywTn7bzsh
         qXfqCIZUOvdk6iSZQmHSo4kWXtFcHL3POy/bRdQImJmOU9VASWSzgKSpARFc6zhiHz4a
         leVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
        fh=qJ/zPTuh4olSn7HizzoAd1BGFIWzxMma5uIIeoeSMcw=;
        b=SvGdrjA2vroIVbnH0kF2OaGfNZ911rKvW4oNO11BQGbPsDRgf5dC+vwicxLJmgyJiT
         KU6FOyyakhjaG09TapKK+F6ViomXhIQWMTPKM/L32nvHRusmyt8naVHibVaIBsxXzEjj
         FCKQIP1r1xcvxs0mCFK4b2cD6XbYyJQ10JJe2gKvVJakDlx1U+KQj283LBEgMWVuQPKn
         WU8chvcIm0heh4ikMBDJOIi0NT7scsogen0hs7vH/hzopkyy19UY+qWolVnp0t2MxbBb
         lu5IEXmKTWk76v9SQ62cGEhaYD3YFbiipqZvG/+IWdjhsg9X2gMbKYm9gfXdQH+ViE1K
         Ecjw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791487781; x=1792092581; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
        b=jnm7YV9aZ5PvlV/qtK4revQPgSMs/+Ev8tJDd2ttQuIilO7LL1QSiVbCjX9bc7OUsG
         2NrtKkT5dDTU8iYZQrW5Gzz47rN9c/YlWVAmzlZpu+wcqSxDecpY9Av5GqjeivSf2CKo
         lGetewYtnOAMcr2cHi7XLGOCYfWFRcBMgqbb2WzBiiZo9GoOUmeb+u9AgoZUnzwx0R+b
         FgaWynE2/Gz9oplHJHN/iT8oHAcdMcHuEn7p8l85wuji8RmqhK6aoHGUJk/hQI4Fbp91
         zPwPSQy3m1YFfyCY+mJg6WNi8isRp+d7cbmUZmxtoWKP8e5eWKeA/XDSoCDUgQjwQazg
         Yo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791487781; x=1792092581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
        b=GqsofF5dSccHrdODmi4B53avQgLAXTLiWHMrIbU394mDX5gc+4qrUV9qpnuEeVgYxX
         +MjpU8pu/7mw9qoUakSfUD19uM9qA8+Mh3ek56kMDYG3aD2BBhPrQJaUL/Z/mkeqY0R2
         uIqQ5keVWBQnUaQ+PmB5k2lcQ/NhJVt417i0lWtlbJC19Xp+J9hrpTmqdJAp1vy5UxYH
         AIcgZnZCBHRWbSCwPuIeMC73kA3vpqlSBFwIIKdMxmhKlp50Ux8e5mk8YbLP082AzefS
         QJlub7inEatrx264+8DHRvG4RXLtw/ZmcAHhUyowvvJnDnlNNEYY2C/S1kY78gCKA1JY
         zKcQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbJfr4LGukQkZZwam19LZRHdwALlPmLA9ojrygHQDoLulDSsUXGuRAw+6Wb/duRiTlhHl9RxnpNWV5op4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK/MVNNLyDppVfiTZSBvf35ebqn8l0Hz2AYjiOTrqvJ9u7bSuoo
	bh12sobTjBd/GVZozCFy9bW263GtJl413ccntR2DALRQp0IonWpbx/LbPogMCTz8cQnNQ6i/4cO
	8XzyTeD+Ze86QdQj7ZEdPtYSyv+vETOE=
X-Gm-Gg: AYBFou0v9JVTMsDbvBJf1jlFSu1giRDjiV5HoUoFpN7RoBFiNZhxa/sJCEJ5qyj44HL
	FlQ24xSnXyUIhix9kFFLS4HR8i4N+MbjgX/hJoHKZ9XPb9IbeHMkdfAP1OuXcw+qwAAs9CP5yxt
	cBsIbyqX96MWjXn+FoxkhJrjUlfDswbytIzNR4bssT+WOjM2v+6TWt1GUWteJrqyoCM5Eq6vxsI
	d8/CbZNiuTwXyFg++FL1s8LfMD2RsqswJyeoMcXpXhOAaDhkGGitv4nhoCDgLlyyrKMYc7u/Udd
	Kicc8v6Jx6nJ6ET2fHzofA5o2z/i7XIghztLH87vvXCN/ezIJqc/TPZEKiZRN3e6vlHKcmHc17N
	IJkcdIz+/KmGT3Q==
X-Received: by 2002:a05:651c:15c4:20b0:3a6:58fb:8540 with SMTP id
 38308e7fff4ca-3a9c2a6f0d9mr491601fa.19.1791487780457; Thu, 08 Oct 2026
 12:29:40 -0700 (PDT)
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
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
 <20260803-alpha-fp-exceptions-v1-3-c99d75608e60@gmail.com>
 <CA+=Fv5QUxT-T0XgXccAF=1_6Dz=nCpY=NQu=ruOrYjbB+q7YCA@mail.gmail.com> <CA+=Fv5S_ZrHedEVPR9Oet2Egg2hwy33pEqEXaQa0zGdQdNjWRg@mail.gmail.com>
In-Reply-To: <CA+=Fv5S_ZrHedEVPR9Oet2Egg2hwy33pEqEXaQa0zGdQdNjWRg@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 8 Oct 2026 15:29:27 -0400
X-Gm-Features: AclHuK-YAox1Xf7NjC5L8Z-SfaibsiX2e4acSu8a9kwaQSKw1rOePouwIqBhWL0
Message-ID: <CAEdQ38EM0FyqYZH6b30oxScZ481dGqnsqu23iePLdx2gCpqzxA@mail.gmail.com>
Subject: Re: [PATCH 3/3] alpha: determine tininess after rounding in the FP emulation
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 2:13=E2=80=AFAM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> Hi everyone,
>
> Adding Michael, Yoshinori, Rich and Adrian directly, although this
> is an alpha series, patch 3/3 also touches the shared soft-fp code in
> include/math-emu/ (op-common.h, soft-fp.h), which your architectures
> build against too (confirmed by grepping arch/{powerpc,sh,sparc} for
> includes of those headers; parisc/m68k/mips/x86 have their own
> separate math-emu and aren't touched).
> The new _FP_TININESS_AFTER_ROUNDING macro defaults to 0, so the
> intent is no behavioural change on your side. The new guard it adds
> in op-common.h is a regular runtime `if` rather than `#if` though, so
> it still gets compiled against your macro instantiations even if it
> should dead-code-eliminate at -O.
> No action needed if it builds fine for you, just flagging since it's
> tagged for stable. Let us know if it causes any problems, or feel
> free to ack if you're happy with it.
> I've reviewed and tested patch 3/3 on alpha already (Reviewed-by/
> Tested-by posted).
>
> Thanks,
> Magnus

Hello all,

Could a maintainer of this code find time to have a look?

We can take it through the alpha tree, but we'd certainly prefer some
review first.

Thanks,
Matt

