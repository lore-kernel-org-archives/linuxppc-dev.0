Return-Path: <linuxppc-dev+bounces-23001-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79990CDE008
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 06:50:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmmX95hXGz2yZ6;
	Fri, 26 Jun 2026 16:50:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782456633;
	cv=none; b=FAvcxJItDLcrQBEwcEyYXtTETweXTWMoYy8s2iKlgf2o2dPr/RD1VRAf+x5x480C3WIbUZ80qr4HkuQsUNekzHzoisj3es8Z8lzMuXNZ7sXkqHyBspEDiaHnDUN/0LYxDc0G6JAwMEr6MZBRodkxltowB970PyJmDwX4Fke1XrsmfOOygCdOC5rGLPYdtxXI1Rse9ubTApmSixjn98sW+FYuqOGY/uY3i2AB7zBhCOCfhC3GIhDEWYiUPY+PN3SFdwG0+7NcLpE3Zzj/bPaHdqcCj0k0oZL5nfV2fWG7HAhsOyZqthYezeR30+4ciMFEC69TVuQD26NfHJhqBuX/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782456633; c=relaxed/relaxed;
	bh=Aba3H/t6EYUlyXlaVKq50Xkb65xKw4DsCtr12qP1nzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBQbI4JQ6R2afodSkUefqUDlobL8HvE0YtH3L7Vggstnm0gnASuQufv8C3zEfOhgKbuKz89bfG1/7nQOyeyNneg/yUaO7XwQcZ7j5RkDPMEAmR1rTRKm/bwoRJfEzz09qu02NKuvsrrbEsP1R+8Lh1vXspsnaV15x3ojU2TIsEHyhtGVrYwOCTWoJLg6BDZLiI4+Z9vMGaCO1eEJjirfN54bNlGZBo6tTnVo4UBs9IHckW0FBoE11wewCHe5RTnFpfYY9mMYUpIZdMl8TWaQCXh7kPw4TJWUm4Xv548CaPoja7AfK7Q6IxdlGhOUhrIdig6VFFqwDnsoDEkscvTU7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mwRH2iU2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mwRH2iU2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmmX74dZTz2yVv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 16:50:30 +1000 (AEST)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-30bc871ecdfso864302eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 23:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782456628; x=1783061428; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Aba3H/t6EYUlyXlaVKq50Xkb65xKw4DsCtr12qP1nzs=;
        b=mwRH2iU2Mh+C7TPB/4emK4r7zRPvZjG1Kicl3cKyNbxyJtwl3D9/fGIt7LqiQGnaiS
         yvjPb/oP8kkWasuwWQl2hePM7bbEaag1dZHmnHjYssbH8vT6wBj7fbDydqeVQWySTEeL
         D8+PsSdRcl4CAeR3HTBlBTcCvx0bWI/xyL5+v9NhAGkGmsklKebXmc0Xz3aGTZVI8kds
         cxUGexlFqJYjnERt2rIFOyRLWwjh2BVFohaBrq0YGh6z57YBfYhdPrLForh2pZrBLStH
         9a7Lm4Izvwp53ZkS5f8EvI3YBTI2N1naDPvNnhP+i5AfJHfBZV8YaMD1Pne1UbnsMDU7
         L60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782456628; x=1783061428;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aba3H/t6EYUlyXlaVKq50Xkb65xKw4DsCtr12qP1nzs=;
        b=C2eFZnv7ggk/BeNishbErldhE6tCj14pI5/KegaNVUsIDppEyTgQYq16Q/9pVQP5Xt
         jMucnEXMQ4UGn6nZ1C9RXB+x8oZdakNn5vMdZQPbNCsTcIxFFKsFrbGt3AL7p7/FQw0p
         6+Mgc6eeSOFonea6f13j4D6wQQp09MtajnyDqlgPwM3gjqdDLkwDTAtYCPvGhzAEbiXG
         YP40p5W/nzzKom9+dFqdDSyKKpJMs+TFczZQ5AttlITIxbJbZRrIsdZ1Njd+WDDqjqUq
         GDUqHrS69NwXdMD32y/Z8OOLORkrYDM1HGJyqYeJ7gMJrLvKynUPKWm8xAhDYHTCQ/kQ
         UJcg==
X-Forwarded-Encrypted: i=1; AHgh+Rpc96q17ZZGd9oMzPuj3S+Y8XpyS7Asu5NFAdhNFXafuqZpGyxFVhpa2OkdskR4V+sSIYXxFmuHj0gX/QQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxufL1ja585/miBHxe4aphhiwod0rDY9M4Vq2KILZ5i4+gQ3yH+
	2VIY85Y/ICioejGLewIhh7NLrBYtRAQdc/8X9wrYAEz9S8Jey/iNVYI5
X-Gm-Gg: AfdE7cmO9+zMkSrNyTtmOQnI2YvtObJxx17YNoQsgBkbj8oQgiZ8CN8Q+MGuZDXbXMS
	awOYbA4Y8fe7XuCKhaaYBTnTqNq0J1CTeUMYwGOqpZNtB2f+orcAE1VL4vT6iCgWl5x9PCd84mP
	YgdSeUVAu+v5QMdO/LXrklWLwBqPJ6azAJW6pP8y1hiYzR23l0It2FB7dr3l+nKwpsrINJFRrtI
	KqiM0JeunIEaYRLEif4VqoV3sFaIu6BKmrBH1r3jefYYoJkaDxzoV/ijputj8prJI7ofcqNqneN
	3pVI0hAqIs9iC9zVIzB6nmXcZDjkBo4J0xc3llh4598THT87GHN8anEAAIjd3aOIzRzTwzufFrh
	ExX5iswd/X/8yqlGL4wf0afpI5ljT92GnIo5AL2Wp/osRU2QlW4ZCVYNKUk9k6hNQItix0k3Qws
	MjqmpzP2u4b6qnJp52mEi/nMtiQUe+aqU29jui415udCn7VtmgRcjKmi7Gglfj
X-Received: by 2002:a05:7300:8c15:b0:30c:1147:ccc3 with SMTP id 5a478bee46e88-30c84fdbbaemr6195163eec.33.1782456627484;
        Thu, 25 Jun 2026 23:50:27 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c9faab3casm2579526eec.1.2026.06.25.23.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:50:26 -0700 (PDT)
Date: Fri, 26 Jun 2026 12:20:11 +0530
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
Message-ID: <aj4gAdy2siBxONpo@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260520064630.1785283-1-mkchauras@gmail.com>
 <20260520064630.1785283-5-mkchauras@gmail.com>
 <CANiq72nPOMkZXpMpwTLFg4xjFfmyf_O_x2FN_nrNBsxeNu178Q@mail.gmail.com>
 <ahVb4k-2rC4EYZF9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
In-Reply-To: <ahVb4k-2rC4EYZF9@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>

On Tue, May 26, 2026 at 02:22:49PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Mon, May 25, 2026 at 08:16:53PM +0200, Miguel Ojeda wrote:
> > On Wed, May 20, 2026 at 8:48 AM Mukesh Kumar Chaurasiya (IBM)
> > <mkchauras@gmail.com> wrote:
> > >
> > > Minimum `rustc` version required for powerpc is 1.95 as some critical
> > > features required for compiling rust code for kernel are not there.
> > 
> > Which critical features?
> Hey Miguel,
> 
> Right now i can only think of inline asm. I can rerun the whole thing
> with 1.85 and figure out the issues with 1.85. I'll get back on this.
> 
> >
> > > For example Stable inline asm support which got merged in 1.95.
> > 
> > It is not needed that the support is stable, but rather that
> > everything you may need works.
> > 
> I wanted inline asm be stable, I was skeptical about inline asm to be
> unstable and potentially messing up the whole system. That's the reason
> I waited for the stable support to get merged before sending out this
> patch series.
> 
> > From a quick test (with a dummy example that may not be
> > representative), ppc64 inline assembly seems to work for a long time,
> > way before Rust 1.95.
> > 
> > So, which is the actual version that it is needed? i.e. 1.95.0 doesn't
> > seem to be required at least due to that.
> > 
> Yeah it may be true. I'll test out the 1.85 rustc and come back with the
> results.
> 
> > That is why I am asking about the critical features above, because it
> > may be that this works since earlier versions.
> > 
> > (I wonder if this patch and s390's similar one influenced each other?)
> >
> I am not aware of s390x way of approaching support for rust so can't say
> anything about that.
> 
> > Thanks!
> > 
> > Cheers,
> > Miguel
> 
> Regards,
> Mukesh
> 

Hey Miguel,

Sorry about delayed response on this.
I ran it with rustc 1.85.1.
CONFIG_RUSTC_VERSION_TEXT="rustc 1.85.1 (4eb161250 2025-03-15)"

I got a linker error with this.
ld.lld: error: undefined symbol: __subsf3
>>> referenced by core.7dc3da321ed68c1f-cgu.0
>>>               rust/core.o:(<core::core_arch::powerpc::altivec::vector_float as core::ops::arith::Neg>::neg) in archive vmlinux.a
>>> referenced by core.7dc3da321ed68c1f-cgu.0
>>>               rust/core.o:(<core::core_arch::powerpc::altivec::vector_float as core::ops::arith::Neg>::neg) in archive vmlinux.a
>>> referenced by core.7dc3da321ed68c1f-cgu.0
>>>               rust/core.o:(<core::core_arch::powerpc::altivec::vector_float as core::ops::arith::Neg>::neg) in archive vmlinux.a
>>> referenced 1 more times
make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
make[1]: *** [/home/mkchauras/src/linux/Makefile:1367: vmlinux] Error 2
make: *** [Makefile:248: __sub-make] Error 2

This corresponds to a floating point instruction. Although we have
disabled fpu, vsx and altivec we are still generating these. Seems like
we have some issue with the rustc here. I didn't dive deeper into this.

Is it ok if we keep 1.95 as base for powerpc64le?

Regards,
Mukesh



