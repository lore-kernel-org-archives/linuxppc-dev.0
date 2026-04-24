Return-Path: <linuxppc-dev+bounces-20064-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF996FE5204
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:34:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g28Tw21bcz2yTQ;
	Fri, 24 Apr 2026 20:34:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1336" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777026884;
	cv=pass; b=kGpkzSmqaqNlJXvv+24SwjYWD7nriYLmceWW4/17AWa1rhxxD7t8vzgXlVEdu7YlpP186u9DizFMnc9dHQjmtP2Jt5LqS8cECXlIeBYQ+KgAGeSEdvV8RP+GFebD4Xsv4lsd+naMbdLcLSEGfS57H7RCgL+GeFWfHY0QBweAc+LdOkqJxnKYRRMH4pacEtGbEyftFFfRGAEwU84AA57MQ11In4xZLDrKOU26kGjb9fpZJ4mAPtRYf8zKIk6Ca07qKgUIs1fkXUsVc1EzQ66NdCHRA+fBKbHRfCv7vxl44Z7PJ8xRbAMLonr/sigFan1Wva9wnRfx/rxn/Z/EeGbH3w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777026884; c=relaxed/relaxed;
	bh=yTJizOE+aTFx68oE3PlVDChTaWYKzRYowl6JulRmua4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ih5KTkeZ9jJ6J0licEut0pqe/3NNZooxe7R1R8WYZaRPhV1/ZZpzGVqEGeHXFkqlSUbEYphIIazMi7tl8SEWiFilhs1T2gbpwEi8vV1ACQ3JLmJAe/2kFq/a5z6PKUpmaVSa7caCHgcgOVOBoN/NdgI4ZcUQrAvoCpgqcX5iENM2zWoORHr6FGO0UQWETr04BWaOFzxF9639jvy4AjsuTJhcfYGBUuaGgHvftXGh+reBh6nVN70jMufEsEe/RUgNz5oWdSYWeS7feXvnp2PfG3yCWUYiOsDe4oT5tNB/EZbUoK7+OCR24V0UWyuWZE/xmqmiKjn7hw9sJBtFfmpgjQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dP727mik; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dP727mik;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g28Tv1rbKz2xnl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 20:34:42 +1000 (AEST)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-2e92c54bab4so798206eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 03:34:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777026880; cv=none;
        d=google.com; s=arc-20240605;
        b=NmU9vmLNDw4xnrmJwqEy3wnTTAS/czSmw9SM9gsT5LWtX/GyIKmKtH8w9IeOan+5Ld
         uv9TqH9c6sJ1zrpds9eJ8sd171iKS0kDlwzKmfJb8ott4cK40/TM3OjLmVwZUHk/BxFP
         7oSJykMILCYnynfH9ISQ+e0Yh6Fm1IhLZhkzlV8FMO8Y/8mtj98/1glBNTJYd0A+V05w
         NDXsCrANHrzx0O5FBnJOH/1OPqP2mFitUR7sFQICiO+4YRaPTe7RuACH2OU0Gl5L0BL5
         krzXgxmGZ3IvU3EawwWB4mgxNQIxpaykMtbEbgGB78yDyp4W+J9ZAj0/3iJ0OWXMv3uz
         HY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yTJizOE+aTFx68oE3PlVDChTaWYKzRYowl6JulRmua4=;
        fh=oLfGVKWlJYkmeFlg5XZ3jQKsvJAp2EKamQYI3lT6R5s=;
        b=FwLmUvfw41svScWC4W+UCZrq3gNtt8aNp+gSaaDhOfrH9G4L1zcU4TQWDYDU+sCst1
         uEHboSjjfjuskWYNboYElRWE9vZJlYQJNZpIE5RpO0DHDLuBYzYFH5RHG/msOoU+VeFq
         +0s11x6OtfKb5hVhG9JLriu9rvKvXUENCOvujPhiDFvlK5+N5ouMKK45b4uexV/Hi5en
         m9xeUjoK/e5+B2xTR3kh3T/HJgic68hiYFYPQwYFpcfNfmlyVjHnxvTUSlCEWcnYsEKk
         mOmsp+tQko3KQkjLvow3ZtSPjb1DfnENhs8BcUEEKPqBcnlLS7mj6OjcGoRuLpnwhmdQ
         EUXQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777026880; x=1777631680; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTJizOE+aTFx68oE3PlVDChTaWYKzRYowl6JulRmua4=;
        b=dP727mikmjPmM3d2sNexSDiBrTyX8M34xTxalpehaxvrW2iiAyF5O0hIoT6/GQdW6q
         B1paB+i+hVGvOwNSideCki3MOuyApS7KR/hGdeIyEgnSRoc49s7uWPAc9bPRRgP+4q8s
         nxEIyl8fAwDNQIM4Mto0uDbHPWbU3+JIDBsKgDaNAiYbgdRW+Oet/oElkOwo4HBbtrPh
         +I6rjBMkhW1R3oJLXZZZh1cEqsvwQQ8tWWa492aa9WAMq9w1w5160DkM/rLfoH2pXOQ+
         4Cusj4i3tfRd7KwpO146uXENygPzHzSEttfuiZRwd01V/phu27GsSYYBWNwtOJi6OF6X
         609Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777026880; x=1777631680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yTJizOE+aTFx68oE3PlVDChTaWYKzRYowl6JulRmua4=;
        b=qfBBx0Pjqc0elO6S1eqOZgCt5CF9y+ms3ScQgU/TTsiYcyuPvT6p6J2zVCmQY8ZER7
         O4AtyNbzsKovTSQj3psLMkgw339PCPXx9NW/xxOSb4fb8htLmo7z6OtNMU1Q5B+AuEL/
         v86UC2Qlygzv4TfssCSri3ETkt4iw2gmWM1Umpz9Ftn7KbzohpnIOF37GMIcx/LQgT/m
         0i5Z5k3EwDaXiG0RgWEBsPqDAdHih+Els7YIZa36RxDs37FG3jgRHE6DyaCAUBMk+rfZ
         18nQs8tOKKbZAGFcRmYss1vvsHrBpCo6AhpLVGCFZCrbSXvzaFiKfiv9WguRmmXtpOQ4
         Ys0Q==
X-Forwarded-Encrypted: i=1; AFNElJ8MytrcTrL5r6L6JoO6LPMj8pki8exzFF0bAts++IfMo44PvpgxY0kuIHN69sal9mSP+6F9BHL/NePYIpg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy08jsvfZSaYwjsQg5NtV+8rgGyNO74KtoyWuG84G3JVDXKjpZ6
	Eb+r7AjEWITwR2gZITaOW6HOFE0xo30FfNiOa8KMaVdcSN0cMJ7fZSnGSdHlzSEuMRQ5U8krNDj
	g9kLcVjfFQqEY2PRNx06AKXbYX9MjRts=
X-Gm-Gg: AeBDievTuRiCVXo3jvjGh9PGg6lJ87l3rkpf7psP+DW8rJ+j6xVBa4EJGIR5NDiJZg/
	yECR557SFnN1qGHPVDjjIQ6kF9OyXRH/hcofTioSSx1ac+yWcHyhWqTDTuyv8n2SyHPDWyTIZyk
	VD2Hy14fUZKDIbQZoKJBeO5zf46zT2/wFpk4aOwnmU8WhyxWOAMARLOxdM44wZ+W2jZVxLGK6Ex
	9W7Xqoeif1dDhEE2HHsHsgZwnpku+s8BnVzl+vemHI8uZJDDkGOcSBjBiWsNv8CuxK3vYi0BCJh
	HpG7OCGhqy64rtst7eyTsYPkuTSFIXZG8vmJFeGsgeLFxj26yUlP8hQ9tjL1nd+YcQVfbm/2m9F
	aoQqkQglIxvTbFbSmKkWIyOEs4Sc1ZmxQ3A==
X-Received: by 2002:a05:7300:d50e:b0:2bd:d8e6:90a0 with SMTP id
 5a478bee46e88-2e478936a32mr6682650eec.3.1777026880251; Fri, 24 Apr 2026
 03:34:40 -0700 (PDT)
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
References: <20260424054742.45832-1-mkchauras@gmail.com> <20260424054742.45832-6-mkchauras@gmail.com>
 <20260424101425.6bde0e17@pumpkin> <aes7L3M1d_LvvGKa@luna> <0a81f510-7b49-4879-b0bb-3b24dbfc0788@app.fastmail.com>
In-Reply-To: <0a81f510-7b49-4879-b0bb-3b24dbfc0788@app.fastmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 24 Apr 2026 12:34:27 +0200
X-Gm-Features: AQROBzBsdDZLB2GUpMgvGgFgU1KPjXwk3TMpDFKjffQGyp1lulncbpRBZafhAFU
Message-ID: <CANiq72mZGb+mTwP-8pTLe81oM0QnK-WtQeVjKPiP5m8zK_tOnw@mail.gmail.com>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
To: Arnd Bergmann <arnd@arndb.de>
Cc: Link Mauve <linkmauve@linkmauve.fr>, David Laight <david.laight.linux@gmail.com>, 
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Alice Ryhl <aliceryhl@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Miguel Ojeda <ojeda@kernel.org>, boqun@kernel.org, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, tamird@kernel.org, 
	Nicolas Schier <nsc@kernel.org>, simona.vetter@ffwll.ch, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 12:21=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> How hard would it be to have a private copy of the parts of the core
> crate that the kernel actually needs? Since Linux is neither quite
> hosted (using a full libc) nor entirely freestanding (still using
> some library interfaces), the C implementation on most architectures
> has a small subset of the libgcc that we ship with the kernel.
>
> I assume the core crate is larger than libgcc, but I don't know how
> much of it is actually needed here.

It is fairly tied to the compiler version, so it would be a
substantial effort to support across a bunch of versions. Instead of
that, initially we asked to have some `cfg`s (i.e. conditional
compilation) to customize it in the few places we need. We already
pass `--cfg no_fp_fmt_parse` for instance.

There were concerns about combinatorial explosion of `cfg`s, so we
suggested `cfg(linux_kernel)` or similar instead, though nothing
happened so far.

The other option is to at least lint against certain operations, but I
think it would be better to have a way to tell the compiler we really
don't want them generated to begin with.

Cheers,
Miguel

