Return-Path: <linuxppc-dev+bounces-17492-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3697BD58E79
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Mar 2026 07:29:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPVtm4VgQz2xc8;
	Mon, 02 Mar 2026 18:29:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::349"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772436576;
	cv=none; b=moq6v/xaGL0X7hfSSZbV0IKxjXvw052NdqDpKicpJs5pbzbMT/MCxWIRlekbcg3J/vHKPg8b+iWePmseYFv9RCwIQy/NKP8t0xbyRGt2OUh7VcfMevzB4/pGcaW7Z2gbR6FMEo9PSDhcBhxNaMvzbXWiWljzTrkMqGCc97OT1Fl2uJOn4RnF40Uv2yArJmVhdavnKrygB3QvU5T4X2VNtVMG+jD2bcPcQRBIjetDTMH7sJgTG7U6ngqYv7A7vSqqhsMw2MA1tR0m5PxUZPofUhZVsyemekPh1gp0vptwkt5TBktd4Tff3FVp03wMzMpGbS9gxr9xvfypQOXO1G1GNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772436576; c=relaxed/relaxed;
	bh=B++JTSOCDEejhrrruo0lwnBFAI5zm/KxsIu6HPW4OXU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZYh7gbv8DARoSrHc5p8e8zMZa82SLvK0FkshF8cmjD0bzy/wuQdxYYwfbmUdi1caTW0XGJ03WeOEebMqJ+EiEhHyoWKddD5RRZXxWhDLjRZorRH3XdZY+J2el6yf06aLOgX1+6DDsg68tjdJFuoNLyxEhg1nPu8eKGCQlVXhTsbCVebxJAibxe/t6M2DRWoUDIHQJHM0c+uy5bqcsTS8JFGpElISsNWUThLGsT/D87rbL2fKTF9GLUviMm3k1x3jfs44P7qUVTd/mCvgIGmHwKDvB0SgI6wwhp/DmQIkMT5DySLJF4Z1HuvTUeVgqCNQZqZP1bn7ng2ABNKeMKGB+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Kze8wGKA; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3vtylaqkkdlywheyanudhckkcha.ykihejqtlly-zarheopo.kvhwxo.knc@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=Kze8wGKA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--aliceryhl.bounces.google.com (client-ip=2a00:1450:4864:20::349; helo=mail-wm1-x349.google.com; envelope-from=3vtylaqkkdlywheyanudhckkcha.ykihejqtlly-zarheopo.kvhwxo.knc@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPVtk3Ly6z2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Mar 2026 18:29:33 +1100 (AEDT)
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-4836abfc742so32500415e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2026 23:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772436566; x=1773041366; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B++JTSOCDEejhrrruo0lwnBFAI5zm/KxsIu6HPW4OXU=;
        b=Kze8wGKAt8bxqVNQdTRwvAMDF0xtVSVJSzuzc8n3cHQkPWAzGm1A5TioNWdFprcA9B
         rbPHHoG9Cj04WBLUyEJfBr3eOibA5EtpDqQuv9iqeH7rJTS3sL5Y1RT9aazoQP7Py1gI
         evl/YCDq/gtwEtdbsoKQTP6hj4oNjHbI8+UQWp++rhxAL6zSLCpRLrwEDbrt2zwFDpjb
         1VhlWoHdcdDf//9eyaF+WOCYFqreVmYwvu5YDxToijwHm7O6Nfz7Y+5TAPynRbubsYt5
         vBTmosM4QZj6Qwtvj0r4oYdCwyjGVtsS6YCInPpxNG0Z439WqfzrP1YufKmTKdZExWUG
         LYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772436566; x=1773041366;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B++JTSOCDEejhrrruo0lwnBFAI5zm/KxsIu6HPW4OXU=;
        b=Ja2pPPmHooSXCXNvCjSrVhXDhRcRHeI1Ov4HBs/zjv7EvIlK9fjfwZb6OZmfx91qrR
         qYCm1spuWCXTCB+gMQoCBMjnvG1rgoB4RomGAIfrNKlyo4JX5ED69MpTH5Ak6dj22VAG
         75Wluay1zZD111Mx78Ig9loYyfyNAqj9GD6swj6fBgafEqjcW+EyYDH1aePS3ffvbRPH
         1X68kd/xBjQIYAs3VK6647x7Ky+Wp+7wfY4/hVT9hCHtQzRT+hsm0FWNI4z7UyRRf81q
         biBZf0HXQWSWsG6ovnu17i52jWiB/G8sjR5Qf3wOGwf0yuqmhnn12yDnHOmk+chUGkz1
         XRiw==
X-Forwarded-Encrypted: i=1; AJvYcCWNDY9LZhiQYl7NyXFEaXAeM9WgAfTGg0q0tdUQuS16azBVQsBRMLsq8ey7T5Q6uxmh/2+ye3Q90IeTyHY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzhV1nvirWG5QMroUVErYj6a/nWXWn7d/LDWtifWXoDL7Wees0+
	FOMpTtBMRjHn7S3zCukmElDKaDbdsujTLyGbwnTIcZGaxgYxLlraD82iMnNzXIjoDkYa6T0j2Fd
	XX9eAdg4fW979ZgQRBQ==
X-Received: from wmna22.prod.google.com ([2002:a05:600c:696:b0:483:272e:764f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e8e:b0:47a:8cce:2940 with SMTP id 5b1f17b1804b1-483c9ba2922mr208928775e9.14.1772436565594;
 Sun, 01 Mar 2026 23:29:25 -0800 (PST)
Date: Mon, 2 Mar 2026 07:29:24 +0000
In-Reply-To: <aaUlwfP72ZpshLPL@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
Mime-Version: 1.0
References: <20260210090023.2587534-1-mkchauras@gmail.com> <20260210090023.2587534-3-mkchauras@gmail.com>
 <CAH5fLgi3Owm4=4g8wQ5Rnr7Y63XJ1D8apOdkewW6WpRfg6vV_w@mail.gmail.com>
 <aZtT4MH0Q8Ic9ZiM@luna> <CANiq72nEam8n_daX5LyYrpH=i71k+pb+HLn6EEPdJJc-Zi9Q3A@mail.gmail.com>
 <aZu6cSqnvO91w1m4@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CANiq72mg+D4QZmBhrNj7dB+V3GHsQoZT2cSG1ffHYDYJWXyopQ@mail.gmail.com>
 <0a176f95-eeba-428e-b19b-b08503d9ca5d@ralfj.de> <aaUlwfP72ZpshLPL@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Message-ID: <aaU8VC-kLOKDyYDP@google.com>
Subject: Re: [PATCH V6 2/3] rust: Add PowerPC support
From: Alice Ryhl <aliceryhl@google.com>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Ralf Jung <post@ralfj.de>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Link Mauve <linkmauve@linkmauve.fr>, ojeda@kernel.org, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, corbet@lwn.net, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Jubilee Young <workingjubilee@gmail.com>, Matthew Maurer <mmaurer@google.com>, 
	David Wood <david@davidtw.co>, Wesley Wiser <wwiser@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2026 at 11:25:54AM +0530, Mukesh Kumar Chaurasiya wrote:
> On Tue, Feb 24, 2026 at 09:58:10AM +0100, Ralf Jung wrote:
> > Hi all,
> >=20
> > On 23.02.26 16:31, Miguel Ojeda wrote:
> > > On Mon, Feb 23, 2026 at 3:26=E2=80=AFAM Mukesh Kumar Chaurasiya
> > > <mkchauras@gmail.com> wrote:
> > > >=20
> > > > I think, disabling altivec, fpu and vsx with compiler flag will wor=
k.
> > > >=20
> > > > What are your opinion on this?
> > >=20
> > > It is really up to upstream Rust -- for us, i.e. the kernel, it
> > > usually doesn't really matter much how things like that are
> > > accomplished: whether via flags, a built-in target, a custom target,
> > > etc. However, we need to know what the path to stability is.
> > >=20
> > > My understanding (but I may be wrong) is that upstream Rust prefer we
> > > use built-in targets for softfloat instead of disabling via
> > > `-Ctarget-feature` (and that the other options may go away soon and/o=
r
> > > will never be stable) -- at least for some cases. For instance, for
> > > arm64, please this recent change kernel-side regarding `neon` as an
> > > entry point:
> > >=20
> > >    446a8351f160 ("arm64: rust: clean Rust 1.85.0 warning using softfl=
oat target")
> > >=20
> > > So please ask upstream Rust (probably in their Zulip, e.g. in
> > > t-compiler or rust-for-linux channels) what you should do for powerpc=
.
> > > They will likely be happy with a PR adding the target (or whatever
> > > they decide) as Alice mentions. And until we reach that minimum
> > > version (in a year or more), we can use something else meanwhile. But
> > > at least we will have a way towards the end goal, if that makes sense=
.
> > >=20
> > > In case it helps, let me Cc Ralf, Jubilee and Matthew who were
> > > involved in some of that discussion in the past, plus the compiler
> > > leads.
> >=20
> > Upstream Rust dev here. Indeed we'd strongly prefer if this could use a
> > built-in Rust target; we can work with you on adding a new target if th=
at is
> > needed.
> > The kernel currently uses a custom JSON target on x86 and that's quite =
the
> > headache for compiler development: JSON targets are highly unstable and
> > directly expose low-level details of how the compiler internally repres=
ents
> > targets. When we change that representation, we update all built-in tar=
gets,
> > but of course we cannot update JSON targets. So whenever possible we'd =
like
> > to move towards reducing the number of JSON targets used by the kernel,=
 not
> > increase it. :)
> >=20
> > Kind regards,
> > Ralf
> >=20
> Hey,
>=20
> Sorry for delayed response. I was out of network zone.
>=20
> I am not sure about the process of how to get this in rust toolchain.
> Should I raise an issue of github for this?

You would need to add a new file to compiler/rustc_target/src/spec/targets
in the rustc repository.

If you're not sure what to put there, I would suggest coming up with
something that looks plausible, and opening a PR with that. Then others
can help you with filling out the target correctly.

Alice

