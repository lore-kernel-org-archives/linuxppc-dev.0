Return-Path: <linuxppc-dev+bounces-25421-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4F2C55822
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 09:29:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFQ8m0Wflz2yLY;
	Wed, 05 Aug 2026 19:29:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::532" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785922151;
	cv=pass; b=cTHDubZhBbRQHNWt6njmZJVMzy/ho1KhLFq6VUwMTLmhadR9YfGIeLye2DF6pSvcF3KJivmPs6ivJ2UCN6rnA+BwsfiyxIP3oU//mDpD9i8nmPsonQA+EU27/5L9umtWv0tIGqxm4cJDINLDsC7gBnwVrGTQDUzPThrpquf3VS68ZKj36KhrjVn0GBI36iOFSM8Wvpficvl+HlitMd7btuP0frWJehN0/xPi8G/NVsqjnbdmGUZu35nI+A54sJ24iTUyiC10vfnuAAP0KXwH7bJG/47jV+flKzD1ZMMnuN7budE3qt6lPHsbTtKjFiVJVpWSDKC4QKOKCcxfa3RpJw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785922151; c=relaxed/relaxed;
	bh=MyPWfyEFm2OExA3jphd/8vOHsrgk8sKB4KgKaoO1auA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSpxbRB2/uaZYDroWl5h5j4WZFldpr8jP/IJgUuoBSMq6fgQwhb4bXQEnj3x4H0K4Q6x1t9nGCmI8yQedVDl8L8neJ5O2Nx3qyM+UYtiJPEPOftBx5ER9/SKdLLrdOayyaQtd89clqH0nyrVaBNRx3GkFjDdb1+LxzDFMHG+0q+CcwdNYewtAGAvH5SdTPiWesoGL3w9LizfpUeUuL1xIbr4Wb9KJvSICOM1iwPT5myapWjxMndt6oM0CpVgybsgJc2C8hbylsuStN0DOA37fWVFa3pT+KNdAPtBL6U1qlof87G3UzD7j+EjSqA9C+63s1dlhKGXzdGM0Il+C7z0PA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=crsIXr5k; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=crsIXr5k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=linmag7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFQ8l1bbXz2xqM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 19:29:11 +1000 (AEST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so403121a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 02:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785922148; cv=none;
        d=google.com; s=arc-20260327;
        b=sjBJeJMQNainZIny4C+z1rTFvLllsGQrgJjfz4qICwms60fOwR9oiicmkgFFw4KFcN
         dTwo8/tP2CVtodOGRYM9VwH8XTIa7zQ9rvvSe1g7Ejj2ILCf+C8gjS3xadUl8MreZcTv
         zX0/aMrBJHBMEZC21iEZX2HRbOmdXXNUdacDBgJYhA6AWtJFMXp2SWGweiDjnRJRGNxK
         cxS3czEuLgSd1yKpNJ68RjHynsLD4Cg6RsyFLyfVtsrnHlJAOe349LxXQ38QymAwm2fN
         Yq3GUkYZ7PgFAeCBed+NmqVsUExw4wwFADfSKnEZZDmJ2DvBDRtvucGZ11vfvJaIVreX
         lGwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MyPWfyEFm2OExA3jphd/8vOHsrgk8sKB4KgKaoO1auA=;
        fh=LOy7sixr92tfJZTz+InjhTeWnNJqowuvfRKNbGOJdzc=;
        b=R8SHz+uAbLyz27fHlSph/+umUrvFPJSKlLNAO8RYHoYHwgQEBj6qP1dz2Ver+k9STu
         b7RplgToYbGIKzLGvxU6Usyrq3IUlH9aClclTCcqVXYV19hAmU12I6K/JtmTk2u7gQZV
         FF7IcH6LdThTuNj5Q6YguqfGBVbkH/si8lrMPeAmRnyiHvt8hl4xKhPuk1HhIPIzMgtw
         QFR861LSKYd99DvT+ZSzZkK1MQ6QNhQ9Mey7uQy7tity8/D8/4TOsAJx/1Wq/Y7f/X9g
         uHrGAZdSwH5YdGUwdNwy0+eo835+Xr1rLOXj8WpEpnapz6MXknOdaLHNkafrxtFaP2Bx
         kXgQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785922148; x=1786526948; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MyPWfyEFm2OExA3jphd/8vOHsrgk8sKB4KgKaoO1auA=;
        b=crsIXr5k9/wCbcHXJI4qs2u/6dB7o5C7fMJUN3IRVDT3XgN9yZlVDD/jcR5Y8c3sXa
         1gz2PQ62PKAKcUx1LVNkiIrOdE4AUzLohhvwYPGhzvryJdlqPry6jYY8dU4jBe+rhUQH
         UwpJ6f8zIE3ljKrTZZJikJU3oeHbLYS07yK5SdHDvGu3nHiYMRU0WdrUE9FIC9f4ocBQ
         tYC5Oeo48StAvpLufsTtJtlZ6ovLMlIOHib4swz0B/eAqiNJa0bdHDKstAN+CpnOJ5kf
         4TORLHiLZ6d52FdPL+K7eekJC6ALQs0h2sx/oTjpIBbcoqxWqPgnrSOJWoPEJNldRiLN
         5fSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785922148; x=1786526948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MyPWfyEFm2OExA3jphd/8vOHsrgk8sKB4KgKaoO1auA=;
        b=pi8MdNEhfI2vWfcTTLTyd9ifXkhUk9xIPUieCCOZhQ0E0myGy1OhZwkaCq4DIg/+i9
         wdGFlNkkV+s+cCTa3S0kp7VXixHoNavJ0FIh4gC5IVI6QO0MQOJvLz660mD/TDFQOkka
         yOI5j5a8FEQT0BrulMfz480YylcbaGYcrYZSY42d/4WvvXweericyMAE1p9GQlIDhxq+
         zAwUfvlPaxhTsKfMdvd6Ysb0D3gKFYWgpfkr0RVjBh4vY+Xxoa54QWCVy76dj9O5LAEW
         AB8PFn4ugrzLkCK8Zl3+EGmOfbt7yEd0Jjd4vBMpxv9CD0TNVpgUGU6qYLKi4mZKfUbD
         1WFg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0/5dh6wfp6uVn/CuM87FzXWuQnRulJSumZsawxnZ+qTSyFqiDgFAgOPPpGGvYLuMlerYQB0/0SQlvl1s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YygTyOoFxwGQ4d6B30/GmnKcT+HBQ0EGsLBBd9+to01/K8kVtNP
	9OwJSd1VW3S1Wz9K0E7mfNzC+osGl3RF8v1eRcUvlq/Tj+fmerxARN3CrSIWeGdptHHNzaWr0x4
	Z6INoIlJxOjM3ucbunYIIDGnntnlvX0o=
X-Gm-Gg: AR+sD13/AV/NkVmH2Snf6gk3KX6rBoHb0PMfJ4JEbRTPbDPRex0Bc4C6SJWqfh1TgLt
	NatFYSSRAZ5JQuXpOqIib1vnaGxlH8HGwcxr+AHmFybOtmZsVwlldTqsaYrzz4tNEzwJzmUtjv2
	cymeifQjhgRj+g3to+Lh2VVEzMNJh9vku4lJx+BAuAh0YblHzM2FEHW0Nl8XWvHUrGacIdMtlJn
	4hymE7Yl7VOENxBv83qyaLm/MsuFdsgiodQ82cj1Ecga8IPfY2L+Vl+3uYNj4QPwP116iNc1C+5
	XUomGrNRua7bnjvcS2n6lK74T4ZFSY4I5qYTUudtrIsGEijRKIzR0FuxwoF08s2O1qDRAaXoxXW
	0hSRqJW4BQee+eRYHGbcmgxSemHvqh1I=
X-Received: by 2002:a05:6402:4543:b0:69f:2c1d:d83c with SMTP id
 4fb4d7f45d1cf-6a14f2893e6mr2121332a12.21.1785922147806; Wed, 05 Aug 2026
 02:29:07 -0700 (PDT)
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
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com> <20260803-alpha-fp-exceptions-v1-1-c99d75608e60@gmail.com>
In-Reply-To: <20260803-alpha-fp-exceptions-v1-1-c99d75608e60@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 5 Aug 2026 11:28:56 +0200
X-Gm-Features: AUfX_mytZOAo7u-Z1H4SHvHV7AI6aSPHWr2nPnsXtr8HsGmlt0ibWkok5AeeFvA
Message-ID: <CA+=Fv5RaZZeRvixhLYZVmNsWowBw7oWC5Z6AvbL8=c80CM6XLg@mail.gmail.com>
Subject: Re: [PATCH 1/3] alpha: fix ieee_swcr_to_fpcr setting FPCR_DNOD unconditionally
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:40=E2=80=AFAM Matt Turner <mattst88@gmail.com> wro=
te:
>
> ieee_swcr_to_fpcr() converts the software IEEE trap-enable and status
> bits kept in thread_info.ieee_state into the hardware FPCR format.  It
> contained:
>
>         fp |=3D (~sw & IEEE_TRAP_ENABLE_DNO) << 41;
>
> FPCR_DNOD (bit 47) disables denormal operand traps: with it set the
> hardware handles a denormal operand itself, treating it as zero, instead
> of trapping for software completion.  The intent was to set DNOD when the
> user has not asked for SIGFPE on denormal operands, but
> IEEE_TRAP_ENABLE_DNO is clear by default, so ieee_swcr_to_fpcr(0) always
> set DNOD.
>
> Instructions built with the software completion suffix therefore never
> trapped on a denormal operand.  The hardware silently substituted zero
> and produced wrong results, affecting every program compiled with -mieee
> and default FPU settings, glibc included.
>
> Set FPCR_DNOD only when IEEE_MAP_DMZ is requested, which is exactly the
> case where flushing denormal inputs to zero is what the user asked for.
> DNOD then encodes MAP_DMZ, which ieee_fpcr_to_swcr() already recovers
> from FPCR_DNZ, so drop its attempt to recover IEEE_TRAP_ENABLE_DNO from
> DNOD; the DNO trap enable lives solely in ieee_state.
>
> Both functions are in a uapi header, so the encoding change is visible to
> userspace, but nothing outside the kernel is known to depend on DNOD
> carrying the DNO trap enable, and the kernel is the only writer of the
> FPCR.
>
> This must not be backported on its own.  Re-enabling denormal operand
> traps exposes a second bug, fixed in the following patch: those traps
> usually find an exact result, and for an exact result the emulator did
> not write the FPCR back, leaving hardware-fabricated exception bits
> visible to user space.  Taken alone this change would make spurious
> exception flags more common.
>
> The bug predates the git history, so there is no commit to reference in a
> Fixes tag.
>
> Cc: stable@vger.kernel.org # 5.15+
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/uapi/asm/fpu.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/fpu.h b/arch/alpha/include/uapi/=
asm/fpu.h
> index cea9eafa056f..d28dc36786e2 100644
> --- a/arch/alpha/include/uapi/asm/fpu.h
> +++ b/arch/alpha/include/uapi/asm/fpu.h
> @@ -101,7 +101,12 @@ ieee_swcr_to_fpcr(unsigned long sw)
>                       | IEEE_TRAP_ENABLE_OVF)) << 48;
>         fp |=3D (~sw & (IEEE_TRAP_ENABLE_UNF | IEEE_TRAP_ENABLE_INE)) << =
57;
>         fp |=3D (sw & IEEE_MAP_UMZ ? FPCR_UNDZ | FPCR_UNFD : 0);
> -       fp |=3D (~sw & IEEE_TRAP_ENABLE_DNO) << 41;
> +       /*
> +        * Disable denormal operand traps only when denormal inputs are t=
o be
> +        * flushed to zero.  Otherwise they must keep trapping, so that /=
S
> +        * instructions reach the kernel emulation handler.
> +        */
> +       fp |=3D (sw & IEEE_MAP_DMZ ? FPCR_DNOD : 0);
>         return fp;
>  }
>
> @@ -116,7 +121,6 @@ ieee_fpcr_to_swcr(unsigned long fp)
>                              | IEEE_TRAP_ENABLE_OVF);
>         sw |=3D (~fp >> 57) & (IEEE_TRAP_ENABLE_UNF | IEEE_TRAP_ENABLE_IN=
E);
>         sw |=3D (fp >> 47) & IEEE_MAP_UMZ;
> -       sw |=3D (~fp >> 41) & IEEE_TRAP_ENABLE_DNO;
>         return sw;
>  }
>
>
> --
> 2.54.0
>
Hi,

The new mapping of FPCR_DNOD to IEEE_MAP_DMZ looks correct to me.

I tested the complete series with CONFIG_MATHEMU=3Dy on the same machine
and using the same glibc build. The kernel boots normally, and the
glibc math testsuite improves from 48 to 28 failing test programs, with
no new failing tests.

Reviewed-by: Magnus Lindholm linmag7@gmail.com
Tested-by: Magnus Lindholm linmag7@gmail.com

