Return-Path: <linuxppc-dev+bounces-20062-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C67FE5200
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:26:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g28Jk6dYNz2xnl;
	Fri, 24 Apr 2026 20:26:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1336" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777026406;
	cv=pass; b=bugZRbEUC0PD/BCXZwDGYqeIV0YbRBCLitbcnXUVYTg3vMNJEg4wDFv7nO42isyKmpPKk6d0NRlvXQmx4PagZlAfOvspTxKmaotMuSFioHT6l34ny6ueJE81MfWiYbZ0y3F8yo2AA9zZj7LH9UEyZElBrCL6B/mIbOxEQGFay/RDpdLp2t/7hlJxsHUzNd1qNZ3/Ae2Y1NZONTGOA7E3ZuXJE9078b5i+c+akFf/EmJNYvTgOLfQTxv59NMYrK/qIoDKtU+AN+iiD+UB6l3jLaSRcelZG3+4wpgtDG7MJbB3z1Hwn6iDBzJ6dnwD9quIBWedF8NDe+2fNKjF/dwNJQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777026406; c=relaxed/relaxed;
	bh=j0xKFe1jeJhx1ESLTH8WRadcy9BjbQbmpsMi2ljEDVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neNtHWRwsFWir4QfNBUeW91JaHVxPgsTfPhclNZ/i/QpnJAVIQbnOfSylMfRtmvSt2XyeNlBJ2bBx/sQe45itrhxzh7B57YGsBMmu24xrMmTZANickIQ/w5V7krgT3wYwWiLQIG4ibsw88sUOLdGp7o0wH6UIDWuUunCl2DsgBlwgL8dypg3cU17a0u0snHWXwnNvp68LYwn0g+BX8nqg+7K7GBP2/WNP+2LIEvtkDcHFr3d5wsluAQgzFV2tlHb5T6tEZKdUCfmKUMVCh41yZIlbegAad2pjw5brwwXDgpXLDrgc01hG1y6H2b7PZNrsHLy+LXZFsTlexCKQYqSXw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xb3vh13m; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xb3vh13m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g28Jj2Qstz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 20:26:44 +1000 (AEST)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-2e6b6167d7cso355591eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 03:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777026402; cv=none;
        d=google.com; s=arc-20240605;
        b=Ekx6yOcrE9+M4gZOrlbQKLs2XyhO2Awocm3e9NdGTrR0KyEojk9xJ1NCeWeo0JGJwt
         fjMyxHyoyy/uUuSClHsbpTuWVzqm/DSAKMAgiom28UbpEpBh9obxumA4Kp8lJL0erpwo
         inGZWNU1pKG3i09C1onfeyvTC2yJ945erkBUq9t3dvldalH2HbAGG9D7d4FwRDZXB7nV
         5KrTIEGhTNkZl3qISWVVme7hGdyqLebevbWd9A9UEjTVAloXFnHrTkDACRlqdQ8oJiHB
         Uwc6HRcl8ZbK7pWeCYyzguvkIawQ/aTxBIYc/soxiezqr8bJyVoN4/R8b0bfnby5s2rQ
         8/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j0xKFe1jeJhx1ESLTH8WRadcy9BjbQbmpsMi2ljEDVs=;
        fh=kYOJ9br5C4nQP/9eyGnu7AzBkSox9X3k9faYQEfgxUg=;
        b=YHj+qqF/+EKmo0ugXBn5PZ06GnNSgHpjTqdjIIuddDjGaXnGiEj2+blAUQxYgEriaC
         T1NdhV865aDwIX4qwesbTnKC4KRQ6NzRRcQLxppbA3oeyyrI+yJIr0FYZH54xGmCoQbE
         8bgmBtQpGTYnPBOMkaiey79jvouRk9RlWVeeDgh3/yg48awd64omxwBEYkn81bVoNx2R
         TAMDtuo3spBUFizlOiW1o7TK6+VeVoktKg2W1nWFk0VWfh6YVKADG4etuQb81/YAKOrg
         tfTbnD7ySHyHcsbCH8c0TeRxkYUmi1CQiS4tXljLlQajekYwBo6kcUE+0OfvQeVi3o5q
         puHw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777026402; x=1777631202; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0xKFe1jeJhx1ESLTH8WRadcy9BjbQbmpsMi2ljEDVs=;
        b=Xb3vh13mbD5btOeivqfFvuQHVRu+IewTPHMspUWSaHuU5VW633AafvASn9ZBoaGxXF
         HFvv1XY2MNYWwicxOAL1RK7IsShII+uY0w+R0BPJ5424RGCLce1q7O2FkEKsg+q3KBjz
         YNVxIQQ9jgMn0h8H6Z5Ep+qhBWie4LYU3iJh3ESD1woLqhIudJqrY/RTU2MqFKm0knCg
         Hkhxr2B9gq77E9HMrjCwvHNvJsoDS9vV1kBZxdKJRx92Z90uBZibHNTLz+8hBKh4CSbU
         JRMB/wnVExLgQS0ZfqYILRV1Hyyerz83W+tX0qws6sZtUQGlnsSWZNDmxlwYLcCLh98U
         53xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777026402; x=1777631202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j0xKFe1jeJhx1ESLTH8WRadcy9BjbQbmpsMi2ljEDVs=;
        b=U8LIdq3IfEEM4/HTBUf7Gks2X5Vq+8qeePvFozskH3PnH5uasEHg48NHUbyg+OvibX
         TocE9YF3WhXXPx+KIJf+yjN5gWvBBHo/jvSZKv0aqaYvC2cUY841B0vtHyatM/xvQol5
         KE7YtqG5EY8CjqXOA6wgDNBnp3Rbttfcq5/HYjth8YRT+2U5tfnUnod9Edq9mOyIWHlq
         Do0mCHnC/y8+dpbOxItCb6bit2J7c6vU8KYjkV9GfIx3nmtBy3Bb0JYN/1b1PunS/pgR
         vA7ZUd3iwt6QSuqvGvUgJ65qO7TZAG/DuCOgf91yC6s83KIrB/m+Xpu8pxi0r/7sgVl3
         Zgfg==
X-Forwarded-Encrypted: i=1; AFNElJ+VNtr4bqpwExkuHJK3sUFgQ/cHvoEqU3wTVPS+RwxQ50uhrWi/RQA/f+IwMjXcvVsP9MdBVxLEFL8KGlA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YycjjBN42aHjIP9sU+SulEjIcXenw3YD7EL1pvhXKe+w85+M2ZV
	f629hXekmvGdEFFN1yFlyeO9QKhAORLZNAWSmabLmAA2gygB/LQsdKedm22n4+9ToZpK0rlQ8l6
	xEWX3kWJaOMEIyouqWrG3BaI6wB4G0Wo=
X-Gm-Gg: AeBDiet11UCmQnGftbUzO2TxeEYS0v4ZxD7ss6hqnc6qemyK22vauxIdjEhsNmuUmXp
	how57kcTaRlQrRzXs/YSoezST6xoYiwldPCH41fsYv/D2BYzbtlbsO0veAKSf/fU8JldPldNODQ
	urqDdaTxPfByCzwTv5Uv4SJDsLtnq6GrKzAE3CtARbo3xVdQztB3AWikW4AQPG3T9vVZ3Sh9mrS
	GfVdfbsItxudFtgG9TvLLF+CMv27xlLPhloAuo8KxKo1ipvGWehNKWF9p/1i+I+09YOwQSHtnFr
	iSHtMbeKKaOmaX9e6ECGy9y968a4PS6NkwW11L9DET4mdDwGhufpDqqfn5WayXCLkWeNDVXWthN
	xZpXI+styj258UO2jvEd7mf7miW1+x7JkBw==
X-Received: by 2002:a05:7301:9f03:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-2e478a2e850mr6554300eec.3.1777026402324; Fri, 24 Apr 2026
 03:26:42 -0700 (PDT)
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
 <20260424101425.6bde0e17@pumpkin> <aes7L3M1d_LvvGKa@luna>
In-Reply-To: <aes7L3M1d_LvvGKa@luna>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 24 Apr 2026 12:26:28 +0200
X-Gm-Features: AQROBzDET6d-0hjNl0HV899j9TcLUcNjD1kIJArKfIFhDWI5iKiWhVLnvOkXFjo
Message-ID: <CANiq72nsYy-EUSMynykb=6QyR62M7hT61RoTO3F0-vw1oBMh+w@mail.gmail.com>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: David Laight <david.laight.linux@gmail.com>, 
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com, 
	rostedt@goodmis.org, ardb@kernel.org, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, ojeda@kernel.org, boqun@kernel.org, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	tamird@kernel.org, arnd@arndb.de, nsc@kernel.org, simona.vetter@ffwll.ch, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 11:43=E2=80=AFAM Link Mauve <linkmauve@linkmauve.fr=
> wrote:
>
> A possible solution would be to change the core crate to not divide
> u64s, but the last time I tried to do that I couldn=E2=80=99t quite figur=
e out
> how to do formatting without it, maybe I will just open an issue against
> Rust.

Yeah, I have some context at:

  https://github.com/Rust-for-Linux/linux/issues/2 ->
feature(compiler_builtins) and a way to avoid certain intrinsics (f32,
f64, i128, u128 and 64-bit divisions/modulos).

We have discussed it at some points with upstream Rust (including
related discussions about having more `cfg`s in `core` or a
`cfg(linux_kernel)` etc.). I don't think we have an open issue
concretely for it, apart from the Clippy one to flag the use the use
of the 64-bit division, but if you open a more general one with some
details, that would be great.

Thanks!

Cheers,
Miguel

