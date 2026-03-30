Return-Path: <linuxppc-dev+bounces-19005-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6DBFB3CE5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 09:24:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkm6D5zDpz2xpt;
	Mon, 30 Mar 2026 20:24:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774862660;
	cv=none; b=YEw60Imlj/mcRSuuTIVjztH1flT22s+at/JJ5mYFKTXEz2XaRrwwx35nJxUtmxUE4+2qotBPK/jWYFN1AlBLNfTPXrGJ0YTNx4Qqc+Nh+iozjlsEAdqzH6dhJclGqCa4GXJs0Ok1OY2crGV6M/jThvUYZ+reKzKl6sJlkhnY3qNB4P9IDiO0k3wgyL2xazULwTNECKZ8kXwwZe2K5VAiTqGX3r/1Ke4QjjPuQ21xvApck0Cc3nj91pEEIihPNx/xKadyauMdbkn/Z1GpKLghYdApOuraeA6nhJcOMSEq38ik/4oHZy9nQFKVdi9SZVt9Pv/II3pPY2FH5HP8pttt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774862660; c=relaxed/relaxed;
	bh=VejqlhjlbI/gT949Cn5NLzomruuFcFBXo7MUfzbOCSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeLAVpOv3kxmFMk7iQTVFAUAiuoFrtTomYEcg3LeKZmpJQA0mQoPr7yFenSR95w16IBWORdmB5htHxMBJune+x17KOVSxFmBE18MwrL95N7xg0zWIVB2wSUKvzqqRbufHtoDw9kuOTUzk3CBSOmi8a4ivL1Sugvttobl8YmmCkto4bSNLt8+2WXUtYMGO20e8irUhhaNb5Pe7zdiiXsKi0/hQlNzadsjbY4b5REC9zqypzLlSx2th9oG8MOvcmcS+SsLKnutvFk3paC2QVFTLnhKnsOgYy/b5P5pfFXr85UeeQxYbe/UzjffjCm1HpAxEJjlwoZEG+PtuJTnSdBWnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OUv/qqcn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OUv/qqcn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkm6D1WJjz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 20:24:20 +1100 (AEDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-829a9d08644so2198958b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 02:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774862658; x=1775467458; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VejqlhjlbI/gT949Cn5NLzomruuFcFBXo7MUfzbOCSM=;
        b=OUv/qqcnx3hnFqd4gh5F1Ylh44jd/4Ai0v2G/4YCBawo9RBu5nOmg8Hiymf+n4zURb
         iDmIQpVjkydYCVWTtvRF1MKGeAdfldxG9CTu4q/iukGZoXTO8H/qEsXxeJjgo+lnwrj/
         mhGQlvU0CTM8woPhG+f/Qx7cD3irdl7G73VUakJGC50fXgpI7hEogNZlBbsWdvyEl4xu
         QP8kBCC38d//f5HVP6uxgryDNP3ceVfnwk80XGc3QEML+yWWXm/dz0yYzF5IFIJrJ+xF
         iWSlV94hkqZ4KZz/8YJtsEPg/0ysCL4eSktM52DLUHRbTVwcIddYKPEf1A+lSRY+SFFv
         /Bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774862658; x=1775467458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VejqlhjlbI/gT949Cn5NLzomruuFcFBXo7MUfzbOCSM=;
        b=ouk7CBDp9V6aqC3lwaE0DZSzciIz9QVzaufN8W+AWiNBRUi0RDYoU7t0kY8dAwq0UM
         Ei9NJG7DWFtAemiIeEJ41iLFVMZzu0I0o9kJKKKvKtyXBq0GnAHiAtcNBEPpJaqG0UxU
         FAnEr96ARZ0B7mCVN7IQeVVf6c0CT7f2L9Zj27S+wOBFVeJEA6ppqQbBZm5VWPrxotK+
         hUDX0PoUwBANxIc7kPDztxfij/Rpa1HRJgBcCl19lr93+FmnWGcioIdrnZEkJUp1v5/J
         HXpqUB1027lGxK2uR6sz8cSQydTM6Pdlx2jIPfqAxnxAgzFEuZiuXFOqppgYITai0ZTu
         ghVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBRmt28yzoWIo1TMW52O2OMLFVS198NTzeKagWQ14ApLatCh4rz7lDAKe0udMz4jQV8KIomqRHh4/CwrU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxZqWUpdJzi0I55aKFleMkR0Iq67GNJYIkJIl6YNOz0Ecm668MV
	evxHpMR+r9NkEE3AzuON8kQ8rhg7+ZZrXZGenKrxao3xZJ8Hp/jeStfD
X-Gm-Gg: ATEYQzxunNLVB0F35Vg6LxwFFn2p9swAUkmMQ63Gc77Rj31VP/stq8X7CYf6Sc2JtcC
	cdEsJ9McqVlI291Xp5a1f8SVSQXcJNkzQFkfVDQSWJdLOU9A8B3vM9o4dKNTBrU5yVCGi4K80jl
	KYiEQdEF9+Jn56Z7bul/EU2ci7/OP6YvloU7AqRCgXQEfbI6cdE9WcXQIxbqK7YJnt7MSE4B6vK
	FWH9aUgT1yx3LntsLi8PSHD2ltfJBg8TwrB4X2hHnwjjvyO0rwdgT3RXBRCRLrPD2hQnSZ2YvvX
	kl+/jtmILFU4SJacT1gJMT5YhOt6Hcs8hU2FAJ4iB+mF6wIJaUNA8ahIez3x5e2QLTcPHdqyX2U
	h3N0daURdKjCIdb+LpZsv4lIYtPHa0Nm7l6Prjm3R/RJunm2QJz9AzQdW+Et5qnKCvUZM18ndrf
	7jYBPKzUUZiKtwMSeT0QbdbswbOsNPELFC6uZbpJwqTmnulMrd2pqNkMG4VBioYH+jr7GyI34WO
	A+PHg==
X-Received: by 2002:a05:6a00:bb0d:b0:82c:70a8:fae6 with SMTP id d2e1a72fcca58-82c95e71d96mr11402726b3a.22.1774862658110;
        Mon, 30 Mar 2026 02:24:18 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caf5408efsm5752207b3a.2.2026.03.30.02.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 02:24:17 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:54:08 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Link Mauve <linkmauve@linkmauve.fr>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH V7 4/4] powerpc: Enable Rust for ppc64le
Message-ID: <acpA27Q6y6YjALAq@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260329160254.2592207-1-mkchauras@gmail.com>
 <20260329160254.2592207-5-mkchauras@gmail.com>
 <DHFHD1CAMGX5.28WBF05Y56EEM@garyguo.net>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHFHD1CAMGX5.28WBF05Y56EEM@garyguo.net>

On Sun, Mar 29, 2026 at 07:33:43PM +0100, Gary Guo wrote:
> On Sun Mar 29, 2026 at 5:02 PM BST, Mukesh Kumar Chaurasiya (IBM) wrote:
> > Enabling rust support for ppc64le only.
> 
> This line looks inaccurate now given previous commit just enabled it for PPC32
> too.
> 
Oh yeah, will fix this.
> >
> > Tested on powernv9:
> >
> > $ uname -rm
> > 6.19.0-rc8+ ppc64le
> >
> > $ sudo modprobe rust_minimal
> > [  632.890850] rust_minimal: Rust minimal sample (init)
> > [  632.890881] rust_minimal: Am I built-in? false
> > [  632.890898] rust_minimal: test_parameter: 1
> >
> > $ sudo rmmod rust_minimal
> > [  648.272832] rust_minimal: My numbers are [72, 108, 200]
> > [  648.272873] rust_minimal: Rust minimal sample (exit)
> >
> > $ sudo modprobe rust_print
> > [  843.410391] rust_print: Rust printing macros sample (init)
> > [  843.410424] rust_print: Emergency message (level 0) without args
> > [  843.410451] rust_print: Alert message (level 1) without args
> > [  843.410477] rust_print: Critical message (level 2) without args
> > [  843.410503] rust_print: Error message (level 3) without args
> > [  843.410530] rust_print: Warning message (level 4) without args
> > [  843.410557] rust_print: Notice message (level 5) without args
> > [  843.410594] rust_print: Info message (level 6) without args
> > [  843.410617] rust_print: A line that is continued without args
> > [  843.410646] rust_print: Emergency message (level 0) with args
> > [  843.410675] rust_print: Alert message (level 1) with args
> > [  843.410691] rust_print: Critical message (level 2) with args
> > [  843.410727] rust_print: Error message (level 3) with args
> > [  843.410761] rust_print: Warning message (level 4) with args
> > [  843.410796] rust_print: Notice message (level 5) with args
> > [  843.410821] rust_print: Info message (level 6) with args
> > [  843.410854] rust_print: A line that is continued with args
> > [  843.410892] rust_print: 1
> > [  843.410895] rust_print: "hello, world"
> > [  843.410924] rust_print: [samples/rust/rust_print_main.rs:35:5] c = "hello, world"
> > [  843.410977] rust_print: Arc<dyn Display> says 42
> > [  843.410979] rust_print: Arc<dyn Display> says hello, world
> >
> > $ sudo rmmod rust_print
> > [  843.411003] rust_print: "hello, world"
> > [  888.499935] rust_print: Rust printing macros sample (exit)
> >
> > Reviewed-by: Link Mauve <linkmauve@linkmauve.fr>
> > Tested-by: Link Mauve <linkmauve@linkmauve.fr>
> > Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> > Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> >  arch/powerpc/Kconfig  | 1 +
> >  arch/powerpc/Makefile | 7 ++++++-
> >  rust/Makefile         | 6 ++++++
> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 1246b3add8ff..a5f50434daf3 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -285,6 +285,7 @@ config PPC
> >  	select HAVE_RELIABLE_STACKTRACE
> >  	select HAVE_RSEQ
> >  	select HAVE_RUST			if PPC32
> > +	select HAVE_RUST			if PPC64 && CPU_LITTLE_ENDIAN
> >  	select HAVE_SAMPLE_FTRACE_DIRECT	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >  	select HAVE_SETUP_PER_CPU_AREA		if PPC64
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index 589613eaa5dc..9385db478c59 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -61,7 +61,12 @@ else
> >  KBUILD_LDFLAGS_MODULE += $(objtree)/arch/powerpc/lib/crtsavres.o
> >  endif
> >  
> > -KBUILD_RUSTFLAGS 	+= --target=powerpc-unknown-linux-gnu
> > +ifdef CONFIG_PPC64
> > +KBUILD_RUSTFLAGS	+= --target=powerpc64le-unknown-linux-gnu
> 
> It looks like all it takes to enable PPC BE is to have
> 
> #ifdef CONFIG_CPU_LITTLE_ENDIAN
> KBUILD_RUSTFLAGS	+= --target=powerpc64le-unknown-linux-gnu
> #else
> KBUILD_RUSTFLAGS	+= --target=powerpc64-unknown-linux-gnu
> #endif
> 
> (and similarly add bindgen target)?
> 
> I think it might worth having PPC32/PPC64/PPC64LE all enabled in a single
> commit, and then you can just claim Rust is enabled for PPC and have an
> unconditional
> 
>     select HAVE_RUST
> 
> Thoughts?
> 
BE still has some issues in the compiler. We are working with our LLVM
team to get those fixed. We can still add the support for BE, but that
won't be compilable as of now.

Regards,
Mukesh
> Best,
> Gary
> 
> > +KBUILD_RUSTFLAGS	+= -Ctarget-feature=-mma,-vsx,-hard-float,-altivec
> > +else
> > +KBUILD_RUSTFLAGS	+= --target=powerpc-unknown-linux-gnu
> > +endif
> >  
> >  ifdef CONFIG_CPU_LITTLE_ENDIAN
> >  KBUILD_CPPFLAGS	+= -mlittle-endian
> > diff --git a/rust/Makefile b/rust/Makefile
> > index 7ea7570e3f17..7fe4cbbd176e 100644
> > --- a/rust/Makefile
> > +++ b/rust/Makefile
> > @@ -410,7 +410,13 @@ BINDGEN_TARGET_x86	:= x86_64-linux-gnu
> >  BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
> >  BINDGEN_TARGET_arm	:= arm-linux-gnueabi
> >  BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
> > +
> > +ifdef CONFIG_PPC64
> > +BINDGEN_TARGET_powerpc	:= powerpc64le-linux-gnu
> > +else
> >  BINDGEN_TARGET_powerpc	:= powerpc-linux-gnu
> > +endif
> > +
> >  BINDGEN_TARGET_um	:= $(BINDGEN_TARGET_$(SUBARCH))
> >  BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
> >  
> 

