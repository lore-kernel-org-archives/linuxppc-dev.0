Return-Path: <linuxppc-dev+bounces-20289-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F9DFF8877
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 12:52:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5HJZ6MHyz2yVL;
	Wed, 29 Apr 2026 22:52:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1333" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777467150;
	cv=pass; b=fWGFDNrGPKp4CLxAa0bCbhOaIwcr/wiTipPqE/vLS1BWG799DHU/+zo1ELnmIZ0+2izLxlLEeta0pekPRUmYx5jHRPHfnBxSFWVsRddGuq3HC0vnCE8O+Q274eQgIXdu/U4ZZu3peMgT18c55L+jujGcAiNeMpEJs8af9yvKaPedAp0+N1c5+CQ+N9TPxSoDcBBbycOADy2QFC9SinTLhehoMUJIFa4GNvkglLu5ahQBF4MCGnRKtjvEmNhnySltJvhbbRz280O08BVTssRDofPEQLzF3odRjYpaRnaWeb5t9h6mut5X6IglViKtmo6TMMu9K9SbwnIbrtNCn3f7Sw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777467150; c=relaxed/relaxed;
	bh=EqJjoPB0QzUXNbWp06xPCuzyg8lj2fAXwhNqHbKz/S8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zqk5dDgWEKAVKHcjUEeC4vHV9Yk5uyf9jcJvO7xb8kNB4UVytXjwYNnNQm9r2rhaJkj+TwPNIk6SuC374c0lx3QoouaEOgav2U4DberBJgZ+5SOi/aJa3k08uvO8i7mytivsiwPrO3W5mFkg+e4gQ3ifs/VxKjtN/BfDOEKlImz6wZbTI6OlpW+0dzSddEFYnRVx3Q2Qnhhi8p/0MvUgrsbSdNms4FZ3lDx/qw/7Dhs7vc1tIxSivHXflVeS54b56rp2wySR5gtvDJTGmH8wCsB5ykFOa9Po0iVy1grRpkHbbFPlVeVKWpXuTLcHC4Kbb+iMtfpC51tJx/e+u8azxQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c2JVGpO0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c2JVGpO0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=miguel.ojeda.sandonis@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5HJZ0ksvz2y7M
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 22:52:30 +1000 (AEST)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-2dd52990758so865010eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 05:52:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777467148; cv=none;
        d=google.com; s=arc-20240605;
        b=YBk2oSWJBTJQVwPAn57Zpzno7hB3/qLMynm5FmD50BU0TWHaY29WIIpEGMy5O3RF9V
         ENCvylEZ0v2CRRnnAbSI9YNRUObsrmwmhMQwEfxwTeKNo11wxHG6tBe4DWh9j1Hcbolq
         lpFmJGV8X65cMHW1f7ez0eMztsMc1zngLW5Z3EX8kpD3FNynfRemh7eybRI4YhdGak3P
         AffGZWC+Hrlwmjdeb5Qj6LyWZnzN+t3HckhnqcJD8vfF4O2cxDPyariixJBR8yqeEbPQ
         vjrrYD2Yvk9Ce8yQrbtI0lpB6YpCj9bZehtfNqrMBlS+FZjz7hehGVqwMo0rGsCet+B4
         ofDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EqJjoPB0QzUXNbWp06xPCuzyg8lj2fAXwhNqHbKz/S8=;
        fh=AjsZjV/eSNjj1vTxKNrSbswvWUywNOCDQtChKaV2o9g=;
        b=bsAsV2rvolDnIpxmhZEoc3DP6+2JUrdJE13YRHQQm+pzDxgpy5BEp/5PsvJ+M2p1mU
         Z0yGQzVB4N6v0cyEdcHMDWFChZOHgxO6W4KwK6DSymowZiiAiEjAF0u7DX/g+WjOT8Hm
         6+ONPw9QvOdifU25sx4NYJHuhFdhNqKbKeNdBYSU5cI98o2HzEbKcAxsRF37gIRW836v
         4w0asEvM+s6Tppvr4Zl0Y1R08zJ/xJW4TW9gqipBGdStrrTO1mMz+riZrg27fvhcKQsO
         +sJsgbR06QjCRuIMz05wTJNNp0aklpVmPOHw7Y7lm9W8gFdX2doTVKypWd7ay5kNJp3j
         NX8w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777467148; x=1778071948; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqJjoPB0QzUXNbWp06xPCuzyg8lj2fAXwhNqHbKz/S8=;
        b=c2JVGpO0dYkzHG21EGtuwFxWJkv1b8y1EIRseN4cx15fcMnn7QPIZ+u77wZbWLgJrD
         AtDkywJjgUMri9kTHKnwwUTT17BZQH9JZDuTkR8ngFrJy/Jotp+tNkcwJbve+q8QNcLf
         1tHs+5hch26/yZJR0LhdJglfssb+rvl0C8okFdNN7DsYagnIOaaGiILYEcxcrUEJiZKf
         Pdwisl+0AXiE4lpBcQOUzGLV0IvSOz7AdwxWllMJgDpib/JyMqxg/25dY4Bwa58Klo6o
         ZIW7G3JbB+YUPUZVzHfpThzBroE9tz8aSgK42swU4IQ2akfGw0VW+fwK5w2WfdUWFrzX
         eM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777467148; x=1778071948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EqJjoPB0QzUXNbWp06xPCuzyg8lj2fAXwhNqHbKz/S8=;
        b=sjMlV4gwhMWX3D22qxCZEnEYkpcnAqHZmdfTe+M02AceaoNPW+gKHCCyZwxeqwd6pK
         8e3WqnwENRtEb1XPYS47hEkr43wi6s5ooLF5z4ksCuqUuRShGCFDQEsaql40pDfuXIUj
         h0sCE4K5agx/+ooazu1mQtWp3IdJ6umQGf2ZqvmwrHH1ZBo+8Ik8mTHKQc8xMK3T4fom
         fjz4utGOLjIGyhkQ8eN11vcwFGhidFqD13gipctN6eAjzbdh3LObMlb0S1rZtjsdDIUl
         16UP/d6Hqtyj1xO2dn0DKIrlxx2KS2NRn2S02lG9KykChpNeIGaOWR+eYL8Ije+93Nyr
         Z4iQ==
X-Forwarded-Encrypted: i=1; AFNElJ93UsDvj//lYMDRrOcA3RkzXf9OWReUtKsf0NElFD8yi6UYQb/tu3u89NP8aae+Vqc2X5Y7DBB3/Fk+yTo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwDnG2SWxkAHJqlYP86lB3SfvnHnGryd0HMxy95JWIFJLn3MFAt
	whXEZq5KZbHYFE8bMy7zbgoj/wjKR/ZKlSkAFTH3toijdVHRfsxNm7kjn67XyUesElLOoEVOUqt
	a+DGfyz9VCGIUy8q8zetG6iw/mGSEOY52q8/rL1c=
X-Gm-Gg: AeBDietE0VDP50HQNByjwn7ZRrunf8XxE0aJ2nnLvZF8pNh0CYDVGX4Qw2/8wT26tK5
	wUpNvjSJFTbtx5G5VCWNRlIkvC/cX5PQWfSPi+3pnAxC+J7wCyFTj98N4M0kzFoQJp7YthMLar2
	MYnwcSBvHHPsxgjzla65yiLjYLY9AULdGRw4AO9A8+sq9cCRHan4DTXzscyQTZ5iivNk33Hex5Y
	wrIPaHXluukR2Z0MVVGz8TZmvcdkkz7iQFUUgRhb1r6l77OpLZsxaj4QQpr3QZOAckFcGbvzVgj
	cjMA80DEmoN3N4pPUmEf0fbuHtZ6UPHN9Q1V3ze2z+tnXYxGcHTgi9hnmNB9oHZy6e4TPglz6EC
	c04qnjMpOVzWg0h4/PbsFQlCo5aN0evv0YQ==
X-Received: by 2002:a05:7300:a148:b0:2c4:acef:291a with SMTP id
 5a478bee46e88-2ed09b6b8a5mr1583361eec.4.1777467148218; Wed, 29 Apr 2026
 05:52:28 -0700 (PDT)
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
References: <20260426105932.2270364-1-mkchauras@gmail.com> <20260426105932.2270364-8-mkchauras@gmail.com>
 <afGT_RB1-PZVKzE3@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
In-Reply-To: <afGT_RB1-PZVKzE3@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 29 Apr 2026 14:52:14 +0200
X-Gm-Features: AVHnY4KoUZeS1E-bxbPJDpxvSamSjAegTpsH1f0vqRtt_t4Wuwp8ZSXNfFVNGW8
Message-ID: <CANiq72ncgvqJ_TExZP9ebe6vGroYReGzqn8NuhBCPpNWmnnMVA@mail.gmail.com>
Subject: Re: [PATCH V15 7/7] powerpc: Enable Rust for ppc64le
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
	llvm@lists.linux.dev, Link Mauve <linkmauve@linkmauve.fr>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 7:17=E2=80=AFAM Mukesh Kumar Chaurasiya
<mkchauras@gmail.com> wrote:
>
> Upstream issue for powerpc64 and powerpc64le target.
> Link: https://github.com/rust-lang/compiler-team/issues/987
> Link: https://github.com/rust-lang/compiler-team/issues/988

Great, thanks -- linked from the PowerPC issue:
https://github.com/Rust-for-Linux/linux/issues/105.

Cheers,
Miguel

