Return-Path: <linuxppc-dev+bounces-21515-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC46CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 12:21:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPsLs2bXZz2y8t;
	Tue, 26 May 2026 22:21:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::132a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779798117;
	cv=pass; b=PP1DHc4TYWknJePFQY/D0i8fLGddq+q8sqLNFUJYWxj6VTprUIf0jlPxlidtYTmM2FeX2Tyyne4FB2kmeubt8b+5qi/5bCmkM4G0CD6SMoqT0Xc2hRreC0oabCrFbY4uvNx5ba7Vybhc196cetaxXP4ltRKqN914Uaj08GsYjvzinB7srEPIdXXLRsdfWJAn1OkErHUYo+idkFpB3KI6JUrbq1CYE58pFNeCdNCKWImY6Mw2QaE67oS+1a+8ZflPiQxJWyx2wlKQEsF7+B9cn12Oh6TAY/HVOxg8ZDNnSEtn3U6rVY9w7vku5lFZtx35dwwCb3Z9NpZtqJaYgbLztw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779798117; c=relaxed/relaxed;
	bh=HJn5baRVScE6xD2wHYFVG8MdWdyU6wVQsFxtKnoFAoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZixAUOHC/6QpXVoYsnAN5bgsBYtuEdOdpmKJGPVT7DHZUN/utTijq30NN9h8J9GbujaZvdzPCRqIqEKjdDFHP1Q2GLfoYOlnckD3vnlhuU5xhpuvMVC7W5tay4Rfo9zrYY//m+9D60KIPWLp51zBCGCcbttV1Mx+vY5hZ0QxL4fkPBfZ8qQPeL4VYefpP4Fp//m8oJQ7xX9QuUruvUH/o+fjX98DnLa//AuSbpiywXOHBE/JZlOGbfYW1dVCaAQ1Vtz8z6EoHEOHiqSwfVt57bGzPuSUp+mLPDBIYAPm8JebVqZ6+k3u6QcYbi4CIbmMHKg7BIlE+uN8ShNNKBdkdg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XPNPd+Mt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XPNPd+Mt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPsLq6ywGz2xjQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 22:21:55 +1000 (AEST)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-303da604df1so963146eec.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 05:21:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779798112; cv=none;
        d=google.com; s=arc-20240605;
        b=Jk3TTTQsT9a3zJcDOc/8Qy/VTSEsWFz6Dj7CPLbAvGg/INtFtMuGeeseU1krXCOUYa
         9k4q0+BLGTy2sJbO9BptSmJrfUO64N5IdwOn0USsIqcVrWebMOcbUH1WsmspFuVvqZst
         gISrwt+qMCZNeE4rijRcSc8D0ZUen2HOkifmDElkdhhUCaVukEBVqw9b4mNrpAa3W5YX
         oglpYMT9fyzxDhoVgY1OM36dyhDLjNW5BkIKBZqdgKL11ImY6aMzQbHdju8dxcu8vylY
         eQxrErcfZ5z2bJrkme4fgSUExgqvviArYYhaO23O48BQYUgT/oqyCWO4ogmVw/mEQPDU
         oHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HJn5baRVScE6xD2wHYFVG8MdWdyU6wVQsFxtKnoFAoU=;
        fh=zJJGXGbS47P6C7ZIqIhgwV48/iMlDzBQLQ2pGRo1rUo=;
        b=DCc22goNEIO2qt3SVtGJ2cF7mxUDF5hPpxUsQ9FaS+tCjsji5XgaNbN9q04FeHAOId
         hAiXkyDb8PuyJOgi5UcoWZGgfEksj38/ye5f0eGAxgZ9EjhsJr9ohBGMehqTCDFOKX9S
         5ACwmpDvpiD2eE3wP1jg/NT+HpdT9Q/MOPZ2okpffRHKFI4kp61t22Q36PCfaTgw4soZ
         9HHd6BmSNs/P3iWY1y0ZGIuV2F8+kvymVHRkMzQgXisEgJ4cKZP9vgFbvi5ucFEKft16
         Wtr9T8I0I3oYu8RLTc6H+o/lpvERdAYHJyJLDgRQEQFXFnAI0F21j1TSYR1TKYcyhWrK
         49tA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779798112; x=1780402912; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJn5baRVScE6xD2wHYFVG8MdWdyU6wVQsFxtKnoFAoU=;
        b=XPNPd+MtgOS4v2UTzAlzFOVRsg2osYHcReh7zv3ZL8ei09Kmaqa1cev4yajtV+lmVZ
         sEKELgbnaNctjsSjoBDs8189BZInQCGtVQQf4ZZ0N/EdoDL+EMQ62h6ocJ2+DTwxmZov
         tJlSbpVxjtm4hys/3FigJUvwMXJPZUJ5/PrZgZC+k7X3ACD17b+NjxIT3f7bPkum+aSh
         mWsnCusjnmuLSPzmbctItktvW4psabF7ap/sh0YvutqRcaWozOJNiKFXrXRP2zsTjwZF
         WPkhtLLwyvC9at1RviAeXIrx/NQ+NuCqD3DQv4Du0InKP52FQsFySdxK/nj2p9JNJ+ih
         nkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779798112; x=1780402912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HJn5baRVScE6xD2wHYFVG8MdWdyU6wVQsFxtKnoFAoU=;
        b=fuED5Au8hHum2nPQtkbljk4OtZkXo6b4InpOAKaWLDG1yrtqZxPBDRJVpq0CgtlJOr
         qB+EZeC2HR5tCd0tXJGw8YzLbQ3XYv7ID2hO+KUr/14N55DmOQHCnHRFyzuYkaTBK/YK
         PtpqOZgyzZSqdwNhey8dIb+2Xu45sDa3UNq8hyV0I9/fNJK25P8ZkBoBFAspLq9P/7MM
         lBkZaH6Y3Mk+DY6GU2R3bxb3fOW4b309GZPGepby5RVxYwqd76BjtmZT7f74hQs0DoHu
         k/YJT55AQJdCFIPMV9nK/cnv6AG1v26GJzo6hevjt3pPK3wEySWbHEUE0PxIvRcXbrCn
         K7hg==
X-Forwarded-Encrypted: i=1; AFNElJ+uUoCGaqjTy7yMnITvZy4nUXp3eJZlMlqrdstgECHhr7YBipdVnM4CyJ2DpyNW2GeIHMIR9LJRKYRj4Jc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxFaqclvEVqMcK78+alllmRg5DW6Jw4V+3PoLkRQf8DvqXf8MgY
	5RlQbcUhvB8QJtYBb+DZoL2jXpolgWrprDfRN2EKYBTyaV1r3nivC33p+BTXV8fX1oOZnmX5+eM
	6Rm8bKDB/J8hEKsEJrekTyO4QRmSziXU=
X-Gm-Gg: Acq92OE3vGzpmnUzpOFBSkqcR5+sxg28uS1GRztKnN3AeJJKJi0kvSb9H0C9DgPjud+
	1llf5dJ9SAG3Vs54dAuRguheN4pwn2ZcyY6l+fN20ul9oFFOc0+tKDQcVUh0okLy8kAEIqomiXz
	fhAdvAHmxnX4NagScLg1DCKV5LXgDOveakeoKauJGfP91OiRjotVw12gMT/zbpjLhqmx2+Uqtlu
	RawOox+njGagPPfZfwmaF8xxLI6accwWCKmAVsF5G/I/o2OcLmXrhFRxenImJmq44LeOSWVGd1K
	8gpoPhUw9siFMVOLxd9foawX/VfxlS239/AmU43f0J9A2Kn5dig00WdA8CZaclgzBSi45lDjeDf
	rjuAtJBjBvrge2yXYRAfEix8=
X-Received: by 2002:a05:7301:2c89:b0:2ce:db5e:354b with SMTP id
 5a478bee46e88-3044912c779mr3837047eec.6.1779798111828; Tue, 26 May 2026
 05:21:51 -0700 (PDT)
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
References: <20260520064630.1785283-1-mkchauras@gmail.com> <20260520064630.1785283-5-mkchauras@gmail.com>
 <CANiq72nPOMkZXpMpwTLFg4xjFfmyf_O_x2FN_nrNBsxeNu178Q@mail.gmail.com> <ahVb4k-2rC4EYZF9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
In-Reply-To: <ahVb4k-2rC4EYZF9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 May 2026 14:21:38 +0200
X-Gm-Features: AVHnY4JzDBCz65LWfOhQbkvjD_WZ3wkgopiTtJKdM9xbh9f_3NlkdYUpZbBQgqU
Message-ID: <CANiq72nr8AX68THHi+7u6uU=TshQGDSjT7FVRBpMRfXMz7TyHQ@mail.gmail.com>
Subject: Re: [PATCH V16 4/7] rust/powerpc: Set min rustc version for powerpc
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	daniel.almeida@collabora.com, acourbot@nvidia.com, fujita.tomonori@gmail.com, 
	gregkh@linuxfoundation.org, prafulrai522@gmail.com, tamird@kernel.org, 
	kees@kernel.org, lyude@redhat.com, airlied@gmail.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 10:53=E2=80=AFAM Mukesh Kumar Chaurasiya
<mkchauras@gmail.com> wrote:
>
> I wanted inline asm be stable, I was skeptical about inline asm to be
> unstable and potentially messing up the whole system. That's the reason
> I waited for the stable support to get merged before sending out this
> patch series.

Yeah, sometimes unstable may mean there were remaining issues, but it
is also common for features to remain unstable for a long time without
no changes. So, yeah, we should at least try to know what is the
overall status, i.e. the latest changes that landed regarding ppc64
inline asm, e.g. when was the last time a significant bug was fixed
etc.

(And I guess IBM prefers that it works with more versions rather than less?=
)

> Yeah it may be true. I'll test out the 1.85 rustc and come back with the
> results.

Thanks, that would be great.

> I am not aware of s390x way of approaching support for rust so can't say
> anything about that.

Ah, OK -- both series added the conditional to
`scripts/min-tool-version.sh` and both are from IBM, so I was just
wondering :)

Cheers,
Miguel

