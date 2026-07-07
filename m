Return-Path: <linuxppc-dev+bounces-23677-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B22AC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 07:11:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvXTm19Gvz3brt;
	Tue, 07 Jul 2026 17:11:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783408316;
	cv=none; b=gmPkxc6Lw4N3EkhtT1KwkBI+SYpW+Bvx9Vkayr7DrMw9hzWr4ojNvNXprKKSgr53j5cyfNMmBUjpGzNtdE+82UDPqgf4giGocFbI6g6RuIRmxnOa/D0eZILhKLFa84IICFN2O/8oyG7T+Muu5HbWg9WCqdOYyd3lgsR0dx8x8AaoW5CKKf8pbraxf2YHWYUXPMQbj8GuzhwxsZwS6OIq3uLNiOdZNsuvtirnGau1btCGcN/gtQuAJcVhHXGZu2GT+iTlRcvZWSnw1EdWwKICdLT4wD1E78fiTQphFg6PpjYsntm9Z08UUNJVJbKcuFLMLgl3qknOqeJ8SgXPn+GyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783408316; c=relaxed/relaxed;
	bh=uKV78wv3WbZUmoFpUcsGcDjAxX6ML3nr/lm0iF69y48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZV/UPyywjxfd7fpy4MqET4JDWGHXUD8t0mFcuNnAHtXaoZIvjy/7xp7z+VNSMu/t6rHg42CxY8DsXcUJesvMRFp+TsTeKLRoVyEEfNC8yMmdxABF+ZD/vVd5iaxJ3iSG0/OutD4LD6pPJtMr51qsMShurbpOTqr2SHdY7CGuwDTQCuBMXza7OoHh7D/VbxfxeK6GC0YqBnqTxNjm6IUdd+kGIgIopQOFPxbuOy6L6bG4lDZqSs/8LzberxclwznJmS9ZavB10x5sVa2RVBZvtZvj3U8IN03dNrj2C45BW5JOoSPeyulGEGBNqybNxhLe7jlj+ohQm0R3+kwat7UEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WRNFYBYE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WRNFYBYE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvXTk4wRSz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 17:11:54 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2cacb8416a1so31925265ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 00:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783408311; x=1784013111; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uKV78wv3WbZUmoFpUcsGcDjAxX6ML3nr/lm0iF69y48=;
        b=WRNFYBYEiRNfgPtB0KLHM7+qTIMdlOsx0HGiEBdThmJxIkAnn/Xxj5l5J79MnduP5q
         YPxnad459qH9ZBlSVTVj3sG09Hh97Upx/Beevyilrq0XYmXh3/V3X++p/cTB+jkMvfXo
         lL//l8Gh7KZWTeSPySQb37nEEsgNf/8AvtUKpnP+vACH6QogLR4oODNJSidVUQwvRGhk
         wrkN51NvP222uwFVpTN1oI6GMhbgn7zjTa0BLnDswbGWUwzrqHWqrsN6kcjqAvpyAfqE
         2d6tZW6w9AIAD8r1f+Rw3W0XSYFpIa8wC6Xyl9pLTE8ID1EAfS7abPcdi3oQVt6nDrBt
         ptVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783408311; x=1784013111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uKV78wv3WbZUmoFpUcsGcDjAxX6ML3nr/lm0iF69y48=;
        b=qCQCI3EQ8M5siJEfPjFc3EnvuUJa5Hf2E4koGBJALXvB49rkPaqMPLZZkw5TQ/o4P+
         hd7FU7q5DtF0KIRXXpASDsGCX380u9oNHc5dXyJ03ZNd3ovAo6pIU8Gx9MGmcHn9uJom
         IOkZH9wzC3Q8ncK1BiSCF30/VRPE2N7m1gxlNQX8PmpJ6npF1ZKjdKQQdezhOEU8Vg4S
         HD9nZy88mNTUmJC1jxykBneBbp3my+K/yHBsfROgd8SJweSPitGAIN7GvCH3ZFKEopcz
         /PT40kUcR+1AE0gZ4P/j0LXzpyMvTJ7OYhmJTpX5xrL1XruzgsstQWA+OCja8xB9ycAX
         flXg==
X-Forwarded-Encrypted: i=1; AHgh+Rru5fcOpWdBsmJXjTzs0tOFGNATHa+9wD/nYqZRK9a5XlEKcyQmFUxndmKopgjWe0cTSKsPXaX6ijx8QWo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwJ5yHnGFTyjLS2Q0LC8dnHkhJadLiWlQqyNNuAq0qzbXweXFRs
	dH3b7ZQ3rs94h7fUrd0mEyS0jP9sGHdW54G41H4cNX0YgGSyXNC58dH1
X-Gm-Gg: AfdE7clUM/vzTIDfmJbHzCBS6nsTGfLfFA2nyfQ1DNXAiImXSYGtG0TKX0RlG2akL3Y
	Rj5wf/ecF1oqXFxPnem4WsOcivnGVKJ5iLyqH/++u3aHqTSI/RKFRMh0OsuAe6AKg3lSllPJmqz
	R/erzvClM1pM6o1UvAEe5VZ39LbmfMnZGEjYuz697JTIak50RncJRkH8wXQCTHHizrG2hGsCpDD
	QaBJOOes8xGtpN5CTeyJhpii5llKzub8rWkt6LBTTMMLv/NxQp2a9qWs+B0tkwyTf0fd6ZsYre2
	VsH+LB1Q026eTZX+IuajlsUDrwtDHci+ikl2cw3/PPl1BeHfCkUBzfY51CAcNRjD34mkQTb7Mtr
	OM+sWWwHbGKm7hFuBOGNP61rlQuIr0NDAabDYX2NrNPxnews+fR9bk2svtKzr/KDDpxGOPulpgx
	NeUM7PVqHUfLJkzz2D2okmB5BA6O5T8N7/sLZTIa2+mAm6I0DTpuiSnasTeN/NFWFbbcQe0BY=
X-Received: by 2002:a17:903:4683:b0:2ca:be8:62d with SMTP id d9443c01a7336-2ccbf085003mr50131725ad.32.1783408311212;
        Tue, 07 Jul 2026 00:11:51 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf74cbsm6556115ad.18.2026.07.07.00.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:11:50 -0700 (PDT)
Date: Tue, 7 Jul 2026 12:41:37 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	daniel.almeida@collabora.com, acourbot@nvidia.com, fujita.tomonori@gmail.com, 
	gregkh@linuxfoundation.org, prafulrai522@gmail.com, tamird@kernel.org, kees@kernel.org, 
	lyude@redhat.com, airlied@gmail.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V16 4/7] rust/powerpc: Set min rustc version for powerpc
Message-ID: <akyiZBPCaZOOyTw6@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260520064630.1785283-1-mkchauras@gmail.com>
 <20260520064630.1785283-5-mkchauras@gmail.com>
 <CANiq72nPOMkZXpMpwTLFg4xjFfmyf_O_x2FN_nrNBsxeNu178Q@mail.gmail.com>
 <ahVb4k-2rC4EYZF9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aj4gAdy2siBxONpo@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CANiq72=EVsTFkQK3LWrT2Gs5UKKViemGkv1WuitY6NOEtvcsNg@mail.gmail.com>
 <akH6yuDH9ZwXVoVA@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <CANiq72mj1P9QykK6vbPK37hZkMLwd7RcgVWEcxxuE=9OL+4bAg@mail.gmail.com>
 <akNXvfSfue7_3tyd@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
In-Reply-To: <akNXvfSfue7_3tyd@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>

On Tue, Jun 30, 2026 at 11:15:03AM +0530, Mukesh Kumar Chaurasiya wrote:
> On Mon, Jun 29, 2026 at 11:11:44AM +0200, Miguel Ojeda wrote:
> > On Mon, Jun 29, 2026 at 6:57 AM Mukesh Kumar Chaurasiya
> > <mkchauras@gmail.com> wrote:
> > >
> > > Sure i'll bisect. Meanwhile i would still like to get this upstream.
> > 
> > It is very early on the cycle -- I would suggest bisecting first.
> > 
> > But it is up to ppc, of course.
> > 
> > Cheers,
> > Miguel
Hey Miguel,

I was able to bisect this. This got fixed in 1.87 with
#![feature(asm_experimental_arch)].

1st commit that contributed towards this is
e4f539ea17a3 ("Bump to version 1.87.0")

This caused another issue to come up while building

```
error: extern blocks must be unsafe
  --> /home/mkchauras/.local/rustc-src/lib/rustlib/src/rust/library/core/src/../../stdarch/crates/core_arch/src/powerpc/vsx.rs:38:1
   |
38 | / extern "C" {
39 | |     #[link_name = "llvm.ppc.altivec.vperm"]
40 | |     fn vperm(
41 | |         a: vector_signed_int,
...  |
44 | |     ) -> vector_signed_int;
45 | | }
   | |_^
```

Which is fixed by 
a78d1b092c9c ("Update stdarch")

Both these commits went in 1.87.0 and fixed the build.

Regards,
Mukesh

> Sure, I'll bisect it first.
> 
> Regards,
> Mukesh

