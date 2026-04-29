Return-Path: <linuxppc-dev+bounces-20288-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0278FF8867
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 12:52:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5HJB0GGxz2yVL;
	Wed, 29 Apr 2026 22:52:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::132a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777467129;
	cv=pass; b=j/kq2SjNEVZm/g9IZX0MxpFGt8rFkw1dHOO074sbIhAbt+mn3Jl8cBGD+zxSVXYHYdGQmh5ENYJ88GLfLJt9bgnb2qUXXPiAcsvDdMHOQ57PfD6lz6CrqpIhsHc1jTnvAxX8I1FcPGGFcKsL3lueIYEjD50p0I5YHrp3sUZIrHf1o5knP9OZnmHnl17kr7+xJXIOzFvEj5yUQImC6Ura64X287868sVdxBQscWUb+HeiA7FQtisiQSs8l63f+2fNClfqLDvee9jpHyDJgLdBf8MTzn7h2SaM7IBDnWMM63r70dfgrz5WOBRpgxNZlk4hsRpwf7x6QTRI6rqg1lAmpA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777467129; c=relaxed/relaxed;
	bh=E2TZSITLTsrNHHdKbUhVgqhN1rXI3sRd8ys1HWWOTps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuSPzRP8BF2KTBiQrpasD1EknvK5wWfuTvijiSljDmPjmVHlslMC1b8mbxUaozTynXAEiur2RpwLVRyextZtFuT/t0ooTyYBeI8JxkkgDhJrq18crqT3i0Gmctso/SqdsPz2wqiHsNAoP/G/IRnXbuINQi1Gw2plm0p3Y/wz+WHbsErACVVRchUtajnqqGkY9wEPLK7wj3U5mS2meeXqnjJ6AxYCOm0Tu7fhb0L3OzJjh9p9gtXG7M0KhSo4QhE0McevVp7kq+R5LyhdU/KuV807faqzSxJaCPOgmN8cIpf0etc/cLC75/SH/8MiRt49Xjnxp+Iaqvic3DW3ZLMKmw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ayiXWndr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ayiXWndr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5HJ85dKPz2y7M
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 22:52:07 +1000 (AEST)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-2df943e0a96so652948eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 05:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777467125; cv=none;
        d=google.com; s=arc-20240605;
        b=a66MKBWAnw5lTl6cgdMWh0bPvrRP64f4hIEwH2Je4G27a2QrYhF+s9D5Eye7iSovZJ
         5m15U2YSISotXqODQRm1y92BBxrFY4VG4uU5FwHLcJRGTi2gF5s1tbUBwrO5uBMWfgZ/
         Iai9JcL1vwvr87vzGV+OLcr0nLZ+XxAc7f6bdId2K/8fxNSxXZG7EO93FZHKYKL4WGTs
         GE9V7RHKC0hHhlPaiWxy296pRuzKdelDgW91EmMRZtP167/SgaTYNTDIbZ+vkwffuHPt
         D/dcyNhr5alCuD0jqVEzdhZ5k4BJckoPqQt6KleWe2vRFe+7EvCWNis38keWvS1g9B2f
         Tq1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E2TZSITLTsrNHHdKbUhVgqhN1rXI3sRd8ys1HWWOTps=;
        fh=61LKE7fN4Im49fIRIKMMnnb7RlIUFqEfz5jiuUKXRwg=;
        b=WP8z7R8yVDd5DpaMwjcWmA4nn5f6UanrGd+JfruyXX4c2Q7f2p9abL7u1YOivZ7Y+s
         3B2ieCICy6x3ypp5/LF953WnVYQJv7OR+Ec9CZyqubUwX7a3XD3GJHEjiE2Jy9Si+iVW
         K5Pss4TC6bdOysdY1tvvivpdYQjYbO/B/9Kn7Rsombj0Z84g8BJcMhZYirA57rzoK175
         inRwJlQkpoaqQpDTOu/EQvSz0zWDNpaHyuwwnJATn99ZDP/OVNoIukyMHB2blp3+VsES
         XyLIqwScAyM5Dizp5SLFfMhoBJ3osXroGpVGJOqbkEp1iJzzih8MgK9t/sDHZ+DPH/sC
         OeXw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777467125; x=1778071925; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2TZSITLTsrNHHdKbUhVgqhN1rXI3sRd8ys1HWWOTps=;
        b=ayiXWndr80tR/dVrQega3FFAnr24bdLmetnaE52Wg/awPqEQfecRFxbr6CuPyjH6pe
         Ht6akc7T4LVPHanBC8c/3s21KbQWvPnDvp6UldhUhUH1l9x5/R1NmExWN1rU5FY8WtbX
         8mqM75PYluka4IJgQ8/g6SA190o6eAKvm5mBSS/s5NXsy2Q//Rh4cpZ352dXwS7C+fWI
         nR2ZD7dtLBXft8Z0E3OUO+gqeKIv4aP9ANE8GRSoE9azOEzuHmlizfzoX2ZOLlrA+tkz
         vch7jOR+m+Tdz/H4spgqHToWigmtcwqok69v82zg71ksS8a86XZ47PHepDokhEFAwwjw
         8c6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777467125; x=1778071925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E2TZSITLTsrNHHdKbUhVgqhN1rXI3sRd8ys1HWWOTps=;
        b=M6n0AoPR3HcsvV2TsqkVanauqzT9wCcnlD5J4hSpdJRDfG575aUnw0PkX5viNwNbGT
         IGw/IFOEzdzfNu8JAQBTZveEuCxbEmk8gQ67qCybYdO0M5bSxqDnLFtsSZsXUzg3bp+z
         ZdRC+zgMHxMXcH2y46YS0lsjW+L8pLSyBV/bHki61XFQp1KuAZ83mvzRD3vfBEsYe7pg
         oGt2tfum46g+TmPFnGcNtyZlLQ2hwdyHFjnEo3SqbGyGZLP+R+eIXdUkR92E3XHC26f+
         OiPHCXaWOkrjJqOHgUmanjJvCtapyHM/s8w2IPhRPmHA1BOBwfgErojtqRWK2B/UWBo8
         l0lQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ue3a8JIWDyQJ4Kene+CX9XgmstrtCHm55wwpm86tLFtDkvXz3UKombe3X84qQ0nYDwahxcth64Uf8t9M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxEmD0ejfjgArqjsA3KVAf4Nn9dGI37WE2S3kiaUYBznZfnMTzQ
	TXtVSSG4P4oAzLDvKSMtmIMpNWpR/QRZkuX9Yi0ma19HwUh1PxmVxzeTKwSKhlV72spZijV+8Ig
	/EDTjaL79BhFTjWamkkf0obbTgK0atoE=
X-Gm-Gg: AeBDieuxV0ljoX+7gSZcPFAx+SL0tsf1K5SZFDv/8vzKO4H/8nujPcOEvTU48OzrcA9
	yZiPT9QgDJ8AEmumTEfXokkBYozv7Gt0oxOhDe3MIYuO5BY6jR1Ww3ayTzKR0+mDh3CempcoXRL
	MVB6M7eFlItomQBxhQZas6mjb28KbTirapWskxdvkIJKnJ0DaludWd2oHYnNkGoP8a9bohz49/A
	JL9ckv7CWmxSnPeQitTwaL5xAPnyQYm44y1eV6WtsJlypbynuxfkRB7myTb3j/fq3Lo/1GG+JJN
	gvmcKFWTqeGet6GS/og6JyS0+f2rn6qrPaWBHi/EqslARtjwlzw7XTLUETlaWgpOhTQYovx6Oph
	F90NtHP4+UEIBG9z4IlG/V1AvOrxEk7EjZqyrMDvi2bd9
X-Received: by 2002:a05:7301:fa0a:b0:2de:6c38:707a with SMTP id
 5a478bee46e88-2ed09bac677mr1577805eec.3.1777467125286; Wed, 29 Apr 2026
 05:52:05 -0700 (PDT)
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
References: <20260426105932.2270364-1-mkchauras@gmail.com> <20260426105932.2270364-7-mkchauras@gmail.com>
 <afGUgjRQJgu34Dfh@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
In-Reply-To: <afGUgjRQJgu34Dfh@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 29 Apr 2026 14:51:52 +0200
X-Gm-Features: AVHnY4LAv2pZvQgraP8cIf9jLSC31NFom4mG99W3yyif_zP68nmwU1vFvSNRIOU
Message-ID: <CANiq72k3X34X_fN8cOyE_XWoGF5UQ21FLhxrjZ7AQKWe1a2s0Q@mail.gmail.com>
Subject: Re: [PATCH V15 6/7] rust: Add PowerPC support
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	daniel.almeida@collabora.com, fujita.tomonori@gmail.com, 
	viresh.kumar@linaro.org, prafulrai522@gmail.com, gregkh@linuxfoundation.org, 
	arnd@arndb.de, tamird@kernel.org, mark.rutland@arm.com, lyude@redhat.com, 
	lina+kernel@asahilina.net, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev, Link Mauve <linkmauve@linkmauve.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 7:19=E2=80=AFAM Mukesh Kumar Chaurasiya
<mkchauras@gmail.com> wrote:
>
> Upstream Issue for powerpc target.
> Link: https://github.com/rust-lang/compiler-team/issues/986

Great, thanks -- linked from the PowerPC issue:
https://github.com/Rust-for-Linux/linux/issues/105.

Cheers,
Miguel

