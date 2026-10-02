Return-Path: <linuxppc-dev+bounces-28716-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03E0CA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 07:08:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx0H83XWPz30Bd;
	Fri, 02 Oct 2026 17:08:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:36::f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790924884;
	cv=pass; b=T2jazyg/uSlFhwdxsRb/ckJ950rAPFP+I+Umdg7Sn0qphIk5sh2wTJXG9lWI/jfDbEM807TkOIxobForXZ/3gJPfj3qDdGijipnuz7pl+UjOjHEAG9Y04EBUsAOPl7ml78Ql3KpHD9b10HVoLleOJ8FPrQQRIUXPNpEwCyCfx/z/rwkmeCUZgD9ELLU8+oodCuKhkCNJduIvYkV1/BxtPdN7wCEhvzSKOaLMejjXDis5NvvWnHk9OiJIbE7QFHLr6ziTgy8tC4M0abQ4ukhfLoi8ZqcYMG8/oSrmgT34tiTTApH1mTvFcJSa7cJM7iwwLXO8W/jEXEoZ1xcI/VlCRA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790924884; c=relaxed/relaxed;
	bh=Ydpe83lA41yCIuGVNyMdAFh7MZn+N03Wctk3bDM8jMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYdoCcT86IeN9mC9h/p7vpKXSPPhzrg7FxKKQY3CtB7mIkfW6msTCGd1n5M1/S+BY4Sm877otrjbz2+AyRE+Jb2siysAxRJc4pdTpaGNSBJaHbcgV9uUaG75vE1LU+RU2z/JMebZ9fyXSF+uVy2kdjKbsEIYOTIOtwAn23CU14Cv5Df9CQNVbSENixyVNRsAowP2E9mgdZDNGklUKJca726pMncp0B5o+bqvrmjWjfr5c3+UG4HGKibyBuWykAa0E/hIcRDHCJudX8t6V206i27P3EQmM9d0LCIVwAiaN4wr9ZGhk1oUYrea+FGRtAi0+Equ8D3DrKPt36yhtGX/UA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KG+B1kSa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KG+B1kSa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com [IPv6:2607:f8b0:4864:36::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx0H724jGz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 17:08:02 +1000 (AEST)
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-33e4e75342aso589617eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 00:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790924880; cv=none;
        d=google.com; s=arc-20260327;
        b=VDwrGVYYtNJhCZqI/58NizRkefWB++TT7c6UvEFMtg10WHb9pTKKbWuzZYlblGg0ms
         Q3LyUcgk/UQF267ZaUob1+w9TvQSYmEtI+M889XqsHYJy1YLR+ipQV71Dcj0OUqVeFsE
         zfqfNxcPjt/y/l287F6Kme6l7JPjnESW5Vfzj80BNhSnK/95x5WhJx2uUCMB2uqhxoeD
         gAHvq3uiRKyZAZYCXCZmxtwpI3yd71p77wop7/IRTPzP+jAz4f2eXULq9svSnLHqR7If
         VYWE09PrcdEWQto+w/AGLcOtmT6IhRWowp2B5nhvEnjGmsOemxlaiTIxV+Omlgvm2Kfz
         6ORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ydpe83lA41yCIuGVNyMdAFh7MZn+N03Wctk3bDM8jMg=;
        fh=cZfE4BRXSRIZkNj0ZacnZ+CSsiE/UNVOcqm2QnAZrhs=;
        b=RyUGCnOVPgucSOkgEWZB3P8LxL5suN5TS2RUsm2tDwQR+2DWsp+47Z+MovDwr5Qcwc
         Ojk9uWchh1I8RQSCO3+gjkdQrNVfamDGrmP1isKcUAcL7+u1XZDhNid6guosOwjBONMz
         +Td3W+Hb5BQQJ5Xjv1N/uYE3r1SkPHR+IvD60V7QixVhvNYkfl3rs/yUqkxmeHN5C9cH
         uimFQYA0T4/JsXO4Q+49WtVJRZg+J08mfrVv+qjCMMsKfNyieBy019HdnxD8mc/7LDUR
         zicp20ZOd3iUMZO7zzBfA/9OcOzBUK0SqggX1Twis6hjMZp96s/Oe9O/ouLz1rSFQDh4
         orpQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790924880; x=1791529680; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ydpe83lA41yCIuGVNyMdAFh7MZn+N03Wctk3bDM8jMg=;
        b=KG+B1kSahQnBsY4UqFA6Ymv4ZBAVvOrSMfBliC8P8Ru5hd3HAIRK/VM95/mw8sFWT/
         lwxKGjfFdQJVPq4Wt9kmkj6C/J+DKkO/pQ4xKtTgn6V4JurM6Tf8/H8pcNZC1rVLAOv9
         r6cDpgYfzH0CIDtMh63lKgXwMLmCsIIc5ZDDx05u7hv/WArmWIcrsnV5Yw5AOUSCiQE3
         wLpWkM2si6VwVfgCcYc56eRmPazJl+4SY3IO1HtJgBVO7dfGymRCCbPR1E8Z04MVKFkz
         NH0zLwwcE3huK+TPq/N5iW+4+azhPxSmd6Tvzl+dGMh2KRUhQTN8PdAHS6xeyOpPKZEq
         X+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790924880; x=1791529680;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ydpe83lA41yCIuGVNyMdAFh7MZn+N03Wctk3bDM8jMg=;
        b=KsxJ/+Yiojd11SocaHsjUS/XXcIa/ZKCWiKpvCHkxqsk7vw1aVMLhY02pZfoEwBqpN
         umy3RiugqUDQYDj5FQN1/59r15JjsDLHqZA1Yu3FU762Lh7goLmloaXDXbHzA399Gep3
         Jaf23aMDHb6Re4oMkNAZbFmCeZatzyBTFglzo9ogarv42h9e5X6oJVHcmBLIiVaqr6ko
         RrTWAKY5ypMn0g71m0k7KHUKd4JSmVpZwew2WKQipLfPMwERxRFxbyK1l1JpRkEoVloq
         K0XMdqsCKZXNO2JP07I6zlwIb1svX0UH9rDthANJXW/WWIlgqQD6Cc5nOaeugHFIomp2
         huzQ==
X-Forwarded-Encrypted: i=1; AKwUvByDFpXPCrLEC0xbwp/dCV4gAbR4ic8EU3JtGZGtqTyG3ZRFNM1eGPVVRCmWIQLEzxNOv9wSZsEj2SgGIC0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKZUqU1aRlp/NAtxbdkGk8uWrJP8yLygOrsbjdELJtRYHZusipq
	/O/Go1LSSWXsQ5Xdf0cnjKMc3FlH/AfpT2eJSzV2Pj0wVtv4NnJ3B0WJpUQhYWGXTmiH2o7mdD9
	WFo3FV5z7yrbWa0kSfiYJ9oAay8I+FjM=
X-Gm-Gg: AYBFou1qMhWNTecYryKzpAG5UeK9akwBGyQYGkQ+qqO4Bc5AsfR1sbYtwrG8yhhU+pe
	25IIrXcCzzDIC4lJgjDB3qoV4V2YyXVx/1/92tCj5/NZDhmNJ47YM2csN1Tiwer1hW97n9xgdQz
	/tRKeOBktb+ZgILOzLgS9XSsHq6Hwi2bggchu6ath7Opri2qOZZmFTm/cHK1LYASKKZr2TDYfzm
	/o0sCSh6vQ2ex1I5hciV9N1dwp9GzSRtbQiv5yOQ/MgexFpazgf5Rhe1Shur75IhAPzVWTurDJh
	AhdoQtea8JYFSPw/voOLm/86q4WfLgzGWsoxAp6AiptTMvDiNsb4jB5kqUl9zxREmj5NQ+kGBTh
	LQBb9EwTAnSXufhxg9s44wevkwxSqYiBUCdmMJOWTrLMgLyETUPgxyMP9u6/oU7AC11eqYG3spQ
	YDiRDFC3bP1HN+B+5Wlx29uhlfJZMtMI4worEUlr/W8yiVUOPooZo=
X-Received: by 2002:a05:693c:8951:20b0:34c:15b5:b4e7 with SMTP id
 5a478bee46e88-34f1503d60cmr3285553eec.2.1790924880358; Fri, 02 Oct 2026
 00:08:00 -0700 (PDT)
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
References: <20260916140952.3290924-1-tomo@flapping.org>
In-Reply-To: <20260916140952.3290924-1-tomo@flapping.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 2 Oct 2026 09:07:47 +0200
X-Gm-Features: AclHuK9Yq_tH1nukS-9Fts_dqm4uruSBaNfzWTiLEcRyMGMpTUoth3myfAIkIlU
Message-ID: <CANiq72n=fV7v-pdodt1gW5YJ89s4qcrLZj5nhjvq-3crZtD+Zg@mail.gmail.com>
Subject: Re: [PATCH v1] rust: bug: add a KUnit test for warn_on!
To: FUJITA Tomonori <tomo@flapping.org>
Cc: ojeda@kernel.org, a.hindborg@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	dakr@kernel.org, daniel.almeida@collabora.com, gary@garyguo.net, 
	lossin@kernel.org, tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev, 
	rust-for-linux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	mkchauras@gmail.com, FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 4:10=E2=80=AFPM FUJITA Tomonori <tomo@flapping.org>=
 wrote:
>
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> The test runs warn_on!(false) and warn_on!(true) inside a KUnit warning
> suppression block, then checks that one warning was counted. The counter
> is incremented by the kernel warning path, not by warn_on! itself, so a
> count of one means the warning was really reported.
>
> warn_flags! has a different definition per architecture. The test does no=
t
> look at any of them, so it runs on every architecture that supports Rust.
>
> The new CONFIG_RUST_BUG_KUNIT_TEST depends on BUG. With CONFIG_BUG=3Dn,
> warn_on! does nothing and no warning is counted.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Applied to `rust-next` -- thanks!

    [ Added newlines for clarity. - Miguel ]

Cheers,
Miguel

