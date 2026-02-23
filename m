Return-Path: <linuxppc-dev+bounces-17037-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE52E98E0F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Feb 2026 09:22:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKFkT53rzz2yDk;
	Mon, 23 Feb 2026 20:22:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::34a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771838561;
	cv=none; b=JBn/5SVa3UiI7WphM+0VeOcwIKeWq3G2pvP/0t/ZVz1a5ZVeu0dFRFNbhHreXMiuCSHPOf4dkpbaElRtfOqyilbAkPSiFWbTB9+AfGCDXBQnDHNAXHc2xkMDc29HF/WHyP2SOybSzRh9HivjHBgG6HBQBYaoAIWp/JqiVjd0Zy9/05GLW07312P0ftFsga24HQn30VUDzspg4as5p9WR5tBMS2azTyPUhKmh5aKo9hDqL9gMxry7W5ujWmEewraUNiymzorPELShUqIp6plZ2IOEo6iQKYCHJ2bKrcdFVs1TgJ+g1LbiUPsiosaVVGWrNNrJan1xeaz2KaqVT49Mfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771838561; c=relaxed/relaxed;
	bh=6/py8COuiIEGDu7/nY5qfOGmBj2ryx1hQ7/J9NPZ4C0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xa+WQM9Hf/ZR863fBCIPCu0MqS588lvcbvriv91KeJzCZ8ZixAW9gvynDRdyyZILqxgZYySFMgJxa38oLHnbW5nf87N10VC5+yPfbbt1aSqHgbmEXB1l22rdfqfvEV2X8WCKQdjMYZlzemAtFn5cR52+j/dUwTekjIlp0dbO698i2hll8hucdR11R4kwszwO9vuPDjIDifLIRJohVxtK1fiGAlbwZgPEhRFCJpwc3YQz9M5Q6fZTgV39uBcTcLmFS+S/QvH7ykrZER6oiTU8NmHH6+/+jQgvZy1cvLbnd+VFtyAVWftiHsAtvgkL+QdUplH7a1bl7COluqTOuTEwCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=WFR543d1; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3whycaqkkdfcza713gn6a5dd5a3.1dba7cjmee1-23ka7hih.doaz0h.dg5@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=WFR543d1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--aliceryhl.bounces.google.com (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3whycaqkkdfcza713gn6a5dd5a3.1dba7cjmee1-23ka7hih.doaz0h.dg5@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKFkS0JDNz2xN8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2026 20:22:39 +1100 (AEDT)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-483a24db6ecso42057365e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2026 01:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771838555; x=1772443355; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/py8COuiIEGDu7/nY5qfOGmBj2ryx1hQ7/J9NPZ4C0=;
        b=WFR543d1scC+hcqIu/zW/CDPeIaudtJcxjuDjY2ihBfyaCK+KcwLgetTlrE0vz9rRO
         L5ghUHoIyhDTRKpFts+8/03/QDVa6TEBGh3gniJ0Fg2oLQOQCqz5A8ur48NQHmBupDkz
         /wxXnPOwYb3Qfc8UweybGk7MqN69AJuvEQc5tWhI1mXEpQvy9e1fcr7vrHC45Z981LhT
         P4OUKkbFV92Q4ntI5m7Ad15G5Gq6zgN29Zhn/tQlqSeP9SzpXWRGR3LK2aw7zhe4PAux
         vKXPRZUX5Ic6k5aCTNAd7yOBWhUcgLg+7XHnGYDfjFUPxt+coI8I143Pk+haoxwfaZn2
         ZcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771838555; x=1772443355;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6/py8COuiIEGDu7/nY5qfOGmBj2ryx1hQ7/J9NPZ4C0=;
        b=sVpGUY+GzsOJRSKTO40rigiyYF23n672NXMUVakq7p8xIS38ib5qJyQqsBDZAnwBxF
         bXot0HxPirSfPmUdaSrdGxcIox9riQ+EBJemr9Hc6oY81kbJXCsq/NFKXcpg0AHy52tP
         dP0hxb2nf1zlvIDzVczFRRtoygz71aVWZvE9THIx+5xqZVlFKlUtHLExHb1DaRmLdzuj
         5eTzNbOD9CvOpmZrc5xav4fvNscxZS1po0kYTX4sxn+4xnM4L8Tx1cnJ5pVVogjn5lg+
         Xqq1rAWP137yAyJXW69mYz+4K5U6vE42qUf+HaS5e0rUBDodNO6ZGJxjH6hLjuWAx9Y2
         ItrA==
X-Forwarded-Encrypted: i=1; AJvYcCV1cTnLevbcV1PTV/K2NQPGjym6gciYV8QOCnRgP2pM6yd87pkuo+gMdn4xv0YZAmqUuXlBiCMT+dUv8f8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwQq16fDVn3+39EemoESBwdyQHNDWmgQgstJtfGEVEk5mv1IMqj
	vOFOMhum3v9xqRRdKF6YUnaXuS5wGmtLHclVuolLJPlEUcE6MLrhXU28kA3vc6owZPtMPAY2PKG
	Ebh7zdbN+9Fqu/ak3hg==
X-Received: from wmga22.prod.google.com ([2002:a05:600c:2d56:b0:483:49c9:7c2e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c8a:b0:483:71f7:2782 with SMTP id 5b1f17b1804b1-483a95fc09emr129349825e9.12.1771838554485;
 Mon, 23 Feb 2026 01:22:34 -0800 (PST)
Date: Mon, 23 Feb 2026 09:22:33 +0000
In-Reply-To: <aZu6cSqnvO91w1m4@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
Message-ID: <aZwcWfYkBnivrgNa@google.com>
Subject: Re: [PATCH V6 2/3] rust: Add PowerPC support
From: Alice Ryhl <aliceryhl@google.com>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Link Mauve <linkmauve@linkmauve.fr>, 
	ojeda@kernel.org, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, corbet@lwn.net, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	rostedt@goodmis.org, ardb@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 07:56:02AM +0530, Mukesh Kumar Chaurasiya wrote:
> On Sun, Feb 22, 2026 at 08:11:17PM +0100, Miguel Ojeda wrote:
> > On Sun, Feb 22, 2026 at 8:07=E2=80=AFPM Link Mauve <linkmauve@linkmauve=
.fr> wrote:
> > >
> > > Should we come back to describing the target like I did in my first
> > > patch[1] in scripts/generate_rust_target.rs, or should I bring that t=
o
> > > Rust to create a powerpc-unknown-unknown-softfloat target upstream?  =
Or
> > > is there a better third solution I=E2=80=99m not thinking of?
> >=20
> > We are trying to stop using the custom target specs, so we should ask
> > upstream to give you a built-in target you can use (or equivalently, a
> > flag to do what you need, but I think the idea is to not have such a
> > flag).
> >=20
> > i.e. even if you used the custom target JSON, we would still need to
> > ask, since the goal is to remove that script entirely.
>=20
> I think, disabling altivec, fpu and vsx with compiler flag will work.
>=20
> What are your opinion on this?

I think you can and should submit a PR to add a softfloat target to
upstream Rust right now, and I believe there should be no issue in
accepting that.

If there's a workaround we can use on existing compiler versions without
the target, that's great too, but we should get the target in upstream
asap.

Alice

