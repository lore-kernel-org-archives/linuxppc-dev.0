Return-Path: <linuxppc-dev+bounces-23724-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64F3C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 17:12:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvnpM66djz2xKh;
	Wed, 08 Jul 2026 03:12:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783444331;
	cv=none; b=mgzks/w2EQOwtlC+ZG3bkxs4D6XHLBwHZ0hg0q3PGKxMJHBb0e0wR0BdqUi25nM5HyCfGaX+yrFh5t2dv/VOEYi5t0gfu0qOlIzJh+1X0yynj2fOD3CZMmeeeqBnJgS9tZPdeSQ/1iVSoBrk/aEBX4bl/QGBCuyb8pqWHxQm/k3gzrzODiVLmazQ/OojNE9fSO1rh2HQj2bbfgIfR3aHq5Aks5E3K3F00LCu3fmQ2zWYcXqu9OjNXl7KQyUbOytr0zY2gV1a5V/qBCn0fFQ0jibz5agZLcYYGJLtg2dAVt3Xx2ZAwzYwDA8RhCnqKrqfs64frsZ3VeiSF0IyG58Kzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783444331; c=relaxed/relaxed;
	bh=maQBLqx55rvjjXzubLY4/j31Yf1uTR7Ozp3LJ/moHrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPUDO+5Y7yA+9RsgrgtxQIC7MAgWvYN6x67+FDcnvkIIOjE87elHem/+ztsJQmr0BnqdULd/C3XVxkhXl1yEF1eyf5o6JHvKfYkj2Fe37rzzo62RicfO6pjT8MSlawU64mgLyBafxnFcu6dvvOOuU48ugDFIzVrO9zXjtzPGu6sAROGa4R80230LZSFHd4tw4HhMnEtSWnnNApEPGNRmTY89Z0cg7MAO+IYWLcd0reW4nR3uPGtfpHvU36S3VVuaLcP0K++HySw/7jHcfraUU4gBskt5ea9NwFf8V+pc283+rwLbcsuudLAqfM7Ok6eLCIax5TJQ5yzI6upUwje51w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ODwAlQxm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ODwAlQxm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvnpL5bzNz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 03:12:10 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2cace91f112so38944875ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783444328; x=1784049128; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=maQBLqx55rvjjXzubLY4/j31Yf1uTR7Ozp3LJ/moHrI=;
        b=ODwAlQxmK/2PpKcf0VFqcu8OH9FGgyqfv9bwPl5V7Z/V1xqpB0IKXeY3cI+DehaFqz
         bi5Et2Cu1Oo86vm89Vy2ebDuCBSqZFEimMOoIaoT1opMQaEyBzWMxTEEl7sqCw2VqUqF
         3esUqiS5LeLHomTy7z4y80YmL3M8Y7u8A2p0Mjmb4mxmySFxhwLnbomi5r4GqpnQETx2
         H3GTrjRHnbCv6qA34oUoWReCkAXDLrV7J+KG7YpoC6w72l5FxBDWoT1hV6nZ08CPJd7R
         IIKYhKp8If+9sTBrxYEGzstQXtKrs7enbJ46plTon4h2SFo364/CRl5qkDPiP5YEN/PZ
         rmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783444328; x=1784049128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maQBLqx55rvjjXzubLY4/j31Yf1uTR7Ozp3LJ/moHrI=;
        b=cpt6cRdbV9P4jdjqbNct4A2VkT4i6M/Btr89THyeUEWdykTzmUCOV/WtC5yVON0Omw
         iYUWRFMfzjQmDILCnrkIThgn4Sp4qNKE/gAE3SVC7wtzxs8h5Q8oefe31cm9wrb+CYWW
         s7IQ5dLEk0ayyzXD/rntYB9yR0hcyp8JYrV4GUqDGXoFthUMQya48wqmYxbOaApQu7i8
         QpiLRfxISVES5JFR0UOueV618sbXoQhVscjriO3XCuOkOU8h3peTD/9BmsCUPxIWbbDL
         4YewoIkPjHg9Gn2AwN3LJnUUjAk2VuGxPhmbrzrCLEhZusor70qYZSG3gNJ70G+mXS+a
         MeYw==
X-Forwarded-Encrypted: i=1; AHgh+RoU5h63tyyUe4mJjnrFes6Ga68IgfWDEWCTYNPOm/d323mDPbTG93GDm4J+YB1OQXyzrKtlZnQbku2/Zlg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwhHlTBXr7nH9Wst9OCoEvn5LgIVbgv/TCi76NXoLeVhB/koDAi
	WCJ2nquyiEeiBh/ZwNFsvmWgI1pL75q9a0MFU63Vcm+TRoKBtEMtmLde
X-Gm-Gg: AfdE7clg+lvZNh26UHTadoW16c/iKS1BsLDPjZNThQ+WTm3znNIWO8mtZVmpMZx48en
	hH7dPYJ3FJukVlR+UO/++Xn/1nvoBnL8Rt/d2WIJdO2shvnFkjzPNFEyl6hujvT7DseCAUALXQt
	7njoUUHOpwtlgWTKYAKUvafOJ7jOp9BBST3WAuO24IIf6aNe67tU0/bOwxhy7tB7b2wpOZsCelw
	P7khodUqUSx8uIFygPLL7a3l3DUCKW5P+7mvEEndJoOLrBHxH2gCmD6uS1kExY+8VqoCONnubfv
	MeglTgHQqmQCj0AVH3xp2cVqrpPz2tN+AUDj2xbvvi8fAwgVJIib4cxqB3Qi7RAo8GInYSttAkd
	poQKMS3SF8Ft23V+ahb0A7bwiVahU6EacQgyt3oUiFkPkjb3dxxx5kVl+HekIwFd7VUE9frIbsQ
	CIraVk3+1FBmcbY9Dq6VvDvcNxDfAPBNGsQ13I5pkebk3Mu1AKsaSLp5z9NICq
X-Received: by 2002:a05:6a21:e098:b0:3bf:e94e:e38d with SMTP id adf61e73a8af0-3c08ef09cdbmr7227999637.43.1783444328420;
        Tue, 07 Jul 2026 10:12:08 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm15539333c88.14.2026.07.07.10.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 10:12:08 -0700 (PDT)
Date: Tue, 7 Jul 2026 22:41:53 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, peterz@infradead.org, 
	jpoimboe@kernel.org, jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org, 
	ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, daniel.almeida@collabora.com, 
	acourbot@nvidia.com, fujita.tomonori@gmail.com, gregkh@linuxfoundation.org, 
	prafulrai522@gmail.com, tamird@kernel.org, kees@kernel.org, lyude@redhat.com, 
	airlied@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V16 4/7] rust/powerpc: Set min rustc version for powerpc
Message-ID: <ak0yWkEQtCzBt9qe@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260520064630.1785283-5-mkchauras@gmail.com>
 <CANiq72nPOMkZXpMpwTLFg4xjFfmyf_O_x2FN_nrNBsxeNu178Q@mail.gmail.com>
 <ahVb4k-2rC4EYZF9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aj4gAdy2siBxONpo@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CANiq72=EVsTFkQK3LWrT2Gs5UKKViemGkv1WuitY6NOEtvcsNg@mail.gmail.com>
 <akH6yuDH9ZwXVoVA@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CANiq72mj1P9QykK6vbPK37hZkMLwd7RcgVWEcxxuE=9OL+4bAg@mail.gmail.com>
 <akNXvfSfue7_3tyd@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <akyiZBPCaZOOyTw6@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <akzTCxnSgxba7Yen@luna>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <akzTCxnSgxba7Yen@luna>

On Tue, Jul 07, 2026 at 12:20:59PM +0200, Link Mauve wrote:
> On Tue, Jul 07, 2026 at 12:41:37PM +0530, Mukesh Kumar Chaurasiya wrote:
> > On Tue, Jun 30, 2026 at 11:15:03AM +0530, Mukesh Kumar Chaurasiya wrote:
> > > On Mon, Jun 29, 2026 at 11:11:44AM +0200, Miguel Ojeda wrote:
> > > > On Mon, Jun 29, 2026 at 6:57 AM Mukesh Kumar Chaurasiya
> > > > <mkchauras@gmail.com> wrote:
> > > > >
> > > > > Sure i'll bisect. Meanwhile i would still like to get this upstream.
> > > > 
> > > > It is very early on the cycle -- I would suggest bisecting first.
> > > > 
> > > > But it is up to ppc, of course.
> > > > 
> > > > Cheers,
> > > > Miguel
> > Hey Miguel,
> > 
> > I was able to bisect this. This got fixed in 1.87 with
> > #![feature(asm_experimental_arch)].
> 
> On 1.85.0 though, with this feature allowed, the kernel gets built
> perfectly without any need for 1.87.0.  You might want to require 1.87.0
> only with altivec enabled, whereas on 32-bit we can build on 1.85.0 just
> fine.
> 
Even without altivec and vsx disabled, It's not building for ppc64le.

Regards,
Mukesh

> > 
> > 1st commit that contributed towards this is
> > e4f539ea17a3 ("Bump to version 1.87.0")
> > 
> > This caused another issue to come up while building
> > 
> > ```
> > error: extern blocks must be unsafe
> >   --> /home/mkchauras/.local/rustc-src/lib/rustlib/src/rust/library/core/src/../../stdarch/crates/core_arch/src/powerpc/vsx.rs:38:1
> >    |
> > 38 | / extern "C" {
> > 39 | |     #[link_name = "llvm.ppc.altivec.vperm"]
> > 40 | |     fn vperm(
> > 41 | |         a: vector_signed_int,
> > ...  |
> > 44 | |     ) -> vector_signed_int;
> > 45 | | }
> >    | |_^
> > ```
> > 
> > Which is fixed by 
> > a78d1b092c9c ("Update stdarch")
> > 
> > Both these commits went in 1.87.0 and fixed the build.
> > 
> > Regards,
> > Mukesh
> > 
> > > Sure, I'll bisect it first.
> > > 
> > > Regards,
> > > Mukesh
> > 
> 
> -- 
> Link Mauve

