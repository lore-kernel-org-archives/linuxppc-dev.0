Return-Path: <linuxppc-dev+bounces-29541-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D32CC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 03:21:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4tf62Mx4z2yqT;
	Thu, 15 Oct 2026 14:21:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f2f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792010396;
	cv=pass; b=hCInKxKRTXw8v2qDhsPPdZNFjyKaQWMJHIhcxL5ymHef08RU9LKqgCBCifZrflnhVV0D8jgHFM3bUmjFYseAl++1uNAmemRrrFQYj/vL1rj3IeTX2IJsST8AkSoxXOlK9zo45QSFhB4khK1Y3stjetT1ZyO0v6X5sZby/FMum3n7Ezv4xr6LnDdfqZUtCQTmn7zFQiy+9pbeeuPBSMe/x4ZfRn2q9Hgg3tTr2a4ywUvF+SMLzkmg1avUyiukcHzpX/8lxiCObsNIiKKAOAkhTpDurJC5dchZ7gozgHCQlxE1zEExLwoxqhkAl+1Y2t/JPcagyx05zs21q+6uV53azg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792010396; c=relaxed/relaxed;
	bh=Hvbv4h83/gh3e9PL4i/Jed17SUFA0/98By/JOQOBZh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E90VNgEpQbk/0W3Fdu3UL5Xfe3WLiVglYQVVD9avx9+0V2FlJvfS0SUs3hqobGtgC7HIkHHvI2SVVn3JRCi4zWKKLuDGetSyZg5Dn/LTxtH5q5Fs3T5au8VTb8bc3dPMUl+n/5LzCVahVYEudwQXUv0/rm0a5e/EEXlE7ZXLgYJnER/ilfLRWv36TIWZtnEtS3hafUXb+AvX4zE6l+8MdlmYbh3D5WV6KkZSdjx0nImKNydcSJknws6rqZJax2VewPmBvmfk86EnYCLwAFwH9M77DpRDPINgsOgyr+hbSO9whdL7cXHV3B8qvJyv074i0EcLsleDYc63/rYMpmD6jg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=genproof.com; dkim=pass (2048-bit key; unprotected) header.d=genproof-com.20251104.gappssmtp.com header.i=@genproof-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=lMOTz0u4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2f; helo=mail-qv1-xf2f.google.com; envelope-from=vladimir@genproof.com; receiver=lists.ozlabs.org) smtp.mailfrom=genproof.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=genproof.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=genproof-com.20251104.gappssmtp.com header.i=@genproof-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=lMOTz0u4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=genproof.com (client-ip=2607:f8b0:4864:20::f2f; helo=mail-qv1-xf2f.google.com; envelope-from=vladimir@genproof.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4jkM07j3z2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 07:39:53 +1100 (AEDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-917ad52d7b6so8964336d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 13:39:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792010391; cv=none;
        d=google.com; s=arc-20260327;
        b=FjkPFm/We9zxEbaKkhRGVcgmqxekEgumLfkMQPrOUeGt10xw6UMzXrxi7axhE5Tc0t
         XOkNeuvTWwLeCuC8uIND9WclePYFfZMZ2ZjH0yWPYvCpLvv5BtMcLuhq98fkGtIYagOU
         Eewb3iQFs3rjbEBnDSZl31SNwK+GCIE/ANUe106T9iBp8nk6D8WDEy6GJieXD0jH93ku
         W/ATKPhBtlmuqKr7FP68igUIQIE8UW7YuODPzF7AdCIUTJ/ElFr4WBKwPB882J8Zzw/g
         Bvcm0SiJxU2dp2eHE197IVaxY3EVxkvNxQtVhQ43RM+intfGHblOC5bXBmp520eL64w2
         ldSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Hvbv4h83/gh3e9PL4i/Jed17SUFA0/98By/JOQOBZh0=;
        fh=MNtOKxbGTeltHMBV/w89dWOYPofIF4vIsHr2MuWlHPk=;
        b=YUeh7eoJoNQBRbNHxx2gXXrURXPMSPj+eFLXGFjBtwWcKWG5NVUtd0wiwMQ4Y5HbKd
         Mk2l/62MtvHmpCqmo2fIA1xPJqO5o4SBGI4yVNVSkpWXrup2A8Aw69hgaV2M7nzjtYme
         hH7h2lJ4+HnV1oOcxh28IQq3JWgrLoNki9gWqZzfn4LAkpK1+E8b4vZ2Bo8IDHL+iY4o
         Kqv3nCmVhj0p59hwDSdE8uUM5c5RV6+0sN8TRnWvJQMd2OCEce7Gi4QywoE2DkINNYS2
         XqIwboEZeRgMcce9jhOSPaAtdY0L9RZr2JJDBd1sF+nwGYE/dvg8aIMpqLdfCwKWS/hA
         5q6w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=genproof-com.20251104.gappssmtp.com; s=20251104; t=1792010391; x=1792615191; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hvbv4h83/gh3e9PL4i/Jed17SUFA0/98By/JOQOBZh0=;
        b=lMOTz0u4k7YaPgnEWErbCnbUO40ZihLi9Z+fu5TO766ZarbU7JK5XTLf5IQGzoXV6w
         KggrNeLVtQkRmAKPoRJhWEN6xV58CPo/gcTdv1Ds43YVoLOxvDW9JCFjTVN26S6HPgPT
         8Uv/NCvKWoSFWNNWY6nfLFfgQ0VexD2XgNUAz+/3q2IFaZyjrFcW+gdN1dC5qnrDPJiC
         G9n0m/Fim5zDiLL07Zqp2ZaK90Sb7HRdvQQObOY9PvrBy7CWHcXIOqB2xrKAwkRzHIWz
         Lbjw9MRHciWeUv8QW/4/u+ARrrw6mX0bxi61YZjlDmWsng2fETQ2cu+FLTP2ffNOXY0h
         FhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792010391; x=1792615191;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hvbv4h83/gh3e9PL4i/Jed17SUFA0/98By/JOQOBZh0=;
        b=KgiMiTVjcs3gUWj4q3ZbR0mCBRTEji4YZ0VjNjUcFfux0TT6zP9vA4fPcG7lrzvyvr
         ApEBySSSTYywex/bAwtJjsqFZdnu8dYitfbc25h15Ty8ZzaZfHACjM0vJhiqD3wpaGs1
         pI36vG6+fpZFGgE6rgHMa0J2chqowXvasV2Nk2mB+fmhgWkb1QFl0J1dsdiCsh05Q3jW
         J+B0xygRlqVQLFJ8KPXyk5YHiU7a03CL5hJZ1aJ3aIEwNG18IfFt6//sQjihTQg89Yne
         7cmKYxzCcPXOc1G3VOgQZkc5TtXFEeTV2CUchNNVTQPFpun4KjveYp2Ncdhn6hbsRwTp
         yakQ==
X-Forwarded-Encrypted: i=1; AKwUvBygYh8nHDg4ltzx3ua4MlDTGEMgXvooimL+3mM5uO6lW1P9+aHlyjb5XkGsBhhCiC1djYoqCHF7nP3Wnyw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJTugK3WHVIfuIS6pShT5xTiyQLqlP3O2eJnDDc+mmEaylsyRpx
	u8r1XYM2S7eFhbrthXI9KSmIfC2e2Ynn/ukSWR97e5Z2KglwUs/wlZxGzEndfoOZMc8fgxDNo20
	IVtZ5Orbj7HGJ+3OoSvLYL/VZIMNnjv937RAknkr2Z0o=
X-Gm-Gg: AYBFou1xfnbSqi8BtRVwbTxDF1XclUJSjMg8qtAuJRZMc0JK/ULykOEzE/Jm8SOFI33
	UrbgYH4lov3lN1kLMT+kSzHErjYtkHgQP2Z+BwqKsudF/cFQ4ebMjnX8x1/QtuYVtdISMIaTqc+
	kteN9LqLJqaGRuyRqoGwqf7o/Gh2Gmz7haa2OY/fernsbBLO8e3Er9Gy42Msyw4qyDuUZO6YJZ8
	e7EP85d4h1QtKhm1IsdGwug0oi7JdCs40ZfY/F5wXX2qs9oHrg2XNKaMbRUsWBSygEsDamX/P7K
	ZgEtL7fCdEw4zf9aSrS94vDSIOeHaTAQtUqWvPu3xhpz/UTPC1n2tZazUJSoFtzrkANUwzYqhF1
	1jlivaM8P04RF
X-Received: by 2002:a05:6214:5082:b0:91b:80ac:66ea with SMTP id
 6a1803df08f44-91b80ac67d2mr172010016d6.24.1792010390916; Wed, 14 Oct 2026
 13:39:50 -0700 (PDT)
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
References: <20261014152604.323310-1-ebiggers@kernel.org>
In-Reply-To: <20261014152604.323310-1-ebiggers@kernel.org>
From: Vladimir Kukharenko <vladimir@genproof.com>
Date: Wed, 14 Oct 2026 22:39:39 +0200
X-Gm-Features: AclHuK9hyj4qEGknIGYgSBtc9GBfZkkTP8Pl6YErh1Uue02KgFYR-0JbdSeWHNE
Message-ID: <CABB2QaKKvuTFt5fHa6+=n3siom4TFYCqZ67bcHyHTrD+PogojA@mail.gmail.com>
Subject: Re: [PATCH 0/2] lib/crypto: Use size_t lengths for Poly1305 and ChaCha
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Eric,

Sorry for not replying to your question on v1. I was already reworking
the series in that direction and should have told you.

Thanks for doing this. I tested your two patches with the lib/crypto
KUnit tests in QEMU on x86_64, i386, arm, arm64, powerpc64le, riscv64,
mips, mips64, s390x and UML, plus temporary tests with buffers over
2 GiB and 4 GiB. Everything passed, except for two things that fail the
same way without your patches: the POWER10 Poly1305 interrupt context
tests (I force-enabled that code, which depends on BROKEN), and two
Poly1305 tests that crash under QEMU with AVX2 because of a QEMU bug.

Tested-by: Vladimir Kukharenko <vladimir@genproof.com>

One gap remains on 32-bit arm and MIPS: the ChaCha assembly there
treats the length as signed, and size_t is 32 bits, so lengths of 2 GiB
or more are still handled incorrectly. On a Cortex-A7, which always
uses the scalar code, a 2 GiB + 4101 byte in-place chacha20_crypt()
changed only one byte.

As a suggestion, I've sent two small fixes on top of your series:

- arm: use unsigned conditions in chacha-scalar-core.S, and
  DIV_ROUND_UP_POW2() for the block count, since DIV_ROUND_UP() wraps
  above 0xffffffc0.
- MIPS: the partial block code also relies on the sign of the remaining
  length, so a small C chacha_crypt_arch() passes the assembly at most
  1 GiB at a time.

Feel free to fold them into your series or handle it differently.

Thanks,
Vladimir Kukharenko

