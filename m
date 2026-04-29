Return-Path: <linuxppc-dev+bounces-20258-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8800FFF8867
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 05:17:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g55Cy6HR5z2xls;
	Wed, 29 Apr 2026 15:17:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777439870;
	cv=none; b=jWjzDO3sg2xlEOD/GuKp1uXizUJg88xwCSX3clxJwj5b2TZE/BlG69CM1A+4szXdgmTzecI0DfFE0VG3NbrxYSjQeVr9Lf682G0E6ar8NWwN3ln/DLLXzk0Wsa/OMXjHyz9eUuibwe1ojURdMqxaC0iDaPdrHopNP5bmTtvd6ul/APQKv2I8Udxc8d5SfgRHZQp9vj5Y00wIFEeC0yttqtIgHJjSgzxVcnktrhd+NNRyJJCOC/sPaWCPEih9FF84VzWc4V8Jgac1BJutG5z/iF10TI3QL0UgAeggT/ejWEqEBQ4rS2VguseAvZgME9s/MJVpByg03WkFO6gXRoVi6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777439870; c=relaxed/relaxed;
	bh=nFH9tpK7B+S7aXPOWaeNme/auM7m2Z9UCGcNKdzQWvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2T1yRnbYhc1swYtg2mpkfIECXNCLFgPnHXq8Vs8UKPDUwjO5aUiFjFnZwC9RkppJVJ7PbKA2EVLOY9jah33Qd/ZJ9HWMLU3UTaOw33E6Shi4u0YrrUkzQnLd6mvYl22qoU/8u+a+C83r4p+MCIlTo9UGrvvF/yLTM1C3LSN968EttlQdHqr9QnDJgq6lW/5MI+6KQDDKiAQUqYpxhwD87/BykQJXch1B9lkEmoR/ba8UxTi8oPgx5MKMvJLwdcwd7FeY1/qtilrI1Fbrbh7tPuKCmtCTpACUc0Xd2TyA3Cjn2N6NA0CY0oS8HsPyTksctl4Opv4CZqSgPwt/wkc+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RP9c4BDX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RP9c4BDX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g55Cx3HcJz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 15:17:49 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-35fc258aaa4so7641078a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 22:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777439867; x=1778044667; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nFH9tpK7B+S7aXPOWaeNme/auM7m2Z9UCGcNKdzQWvs=;
        b=RP9c4BDX0K9mT5NLDwMsmTHxwrv5UhETnRLbWwaVeEihjEXDcqpnBV1lB1nAyoVkjM
         E69LbLdjV4t2OBqEE7I7ZqsZxWhjSAnl1Ds1+p2DYsDzC/Qe7fIzEepmYV0N54IKusRR
         eMNh76x7nnVWrKL7Iqz2aid39H93PBj8QT8nHPea4gKPM7dYynUpOyJFfOXVNs06GTj5
         Fb0ZNa35d8sm4ZZE9w8vyg1X/kFE62/qTtexEFzKzgdiIhbF39ZdnS3K3ik5xZ9yxIpI
         tt52wa3Cbb6Jpzl9m2HkAydFl6jIzN+ZHFE0R+lRt1WbXoPaFNqr+OnRToYMHqJ1/yLL
         qe3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777439867; x=1778044667;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFH9tpK7B+S7aXPOWaeNme/auM7m2Z9UCGcNKdzQWvs=;
        b=Ye8k2tSeRvxLy+99sOFKbNva9z2iu9ZKmLjksRMsJ9fCRAOFUnpMsORfoIfuJKkks+
         ufiUUoHciQi/KyAG73Puf2G35ZqgcFjTC9NjIhlT3VtfCzNT8wRMwx1nlo6kCqF8Q4Q3
         q+EtjNFLUbQhm3VubN9H0i6Hbk0haEm6GHHoguj6c8DYbnT+4/NEbzJck0xEHHAacCEU
         ZY5Rq29LU+95k46niN9m1+2ZW3RyKNwcYMeNbwKL7qN0k/vaodY+CKSvwLxuSGJhZfsB
         PkaLWQtXekAPNUTIbtnjt4EF1UrYLODs6tjMyTlVf1QdIBdha1peeHAPPR8rn5CYudHs
         UVMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/qlYyIdTebABu143RAHg0BJOQlBoRujQcIwedoHBSwIfF5UP6Z/TPQAN0BD1+22i6YOtdFDNypuNmekrM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxSyfyXDEEgf4oe/fxPJ2ISvYaHJVA7czMUV9ypnGk+5UtxNefU
	pPmaK8+TasV5O99ASQkYYCPGSfGywftvTzsbeNk1qqLwn4ot0Bfi98k1
X-Gm-Gg: AeBDiesABzx2dub95edHCJslPXGZJSAVj5Yk3UoaKEYqYHzVB8KAmmY3O/KkWrjXMV7
	VS2dlnIWZFXG5YZWXuRr8fF0mZkYaoueRwf4kQwgquCOE93OOAPDgrqfFy1X5STrfegvz8znMMM
	XBAi52eymIuztSN0ZI8i48/2ez9nttgJ9lBMW8uylW6aRMjHXvRRihDFugG6ELNOROcsN0pUL/l
	4ReS1e3h4XQHPWIVY24jEFARpfq+KewqRj+yoO057UM+PF1TykHLfv16ineCFvHeFl4uQOenDN+
	k8JDovLeVb3fYiksh+AYRWLn28mVrfQyxnqrb0bGTZ2vgOZfk9QtRH1+JJzBcs9PecNp5e2uRAv
	c7o5jxmY6/fJvKAxUOQwXmDDLKlEx4X108MnNxOpQcJH+IOQrSIWpIasHFzuy3Epzf/6r6E4Ds5
	CngJsAumgjcEDTBTnDNIeMRnwDCWkD2/P8dmei85Dy3hoH0sjt174NeBpAbpTLxfotSZ2elb0rA
	ngFZMpCG8g=
X-Received: by 2002:a17:90b:2fcf:b0:35f:9ab2:a5a6 with SMTP id 98e67ed59e1d1-36491fbf619mr6492591a91.2.1777439867022;
        Tue, 28 Apr 2026 22:17:47 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([223.187.127.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a02c604fsm1322332a91.12.2026.04.28.22.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 22:17:46 -0700 (PDT)
Date: Wed, 29 Apr 2026 10:47:30 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	daniel.almeida@collabora.com, fujita.tomonori@gmail.com, viresh.kumar@linaro.org, 
	prafulrai522@gmail.com, gregkh@linuxfoundation.org, arnd@arndb.de, tamird@kernel.org, 
	mark.rutland@arm.com, lyude@redhat.com, lina+kernel@asahilina.net, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Cc: Link Mauve <linkmauve@linkmauve.fr>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH V15 7/7] powerpc: Enable Rust for ppc64le
Message-ID: <afGT_RB1-PZVKzE3@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260426105932.2270364-1-mkchauras@gmail.com>
 <20260426105932.2270364-8-mkchauras@gmail.com>
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
In-Reply-To: <20260426105932.2270364-8-mkchauras@gmail.com>

On Sun, Apr 26, 2026 at 04:29:32PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> Enabling rust support for ppc64le.
> 
> Tested on pseries Power11:
> ╰─❯ dmesg | grep rust
> [    0.225728] Initialise system trusted keyrings
> [    0.270961] rust_minimal: Rust minimal sample (init)
> [    0.270968] rust_minimal: Am I built-in? true
> [    0.270974] rust_minimal: test_parameter: 1
> [    0.270983] rust_misc_device: Initialising Rust Misc Device Sample
> [    0.271012] rust_print: Rust printing macros sample (init)
> [    0.271019] rust_print: Emergency message (level 0) without args
> [    0.271023] rust_print: Alert message (level 1) without args
> [    0.271026] rust_print: Critical message (level 2) without args
> [    0.271030] rust_print: Error message (level 3) without args
> [    0.271033] rust_print: Warning message (level 4) without args
> [    0.271037] rust_print: Notice message (level 5) without args
> [    0.271040] rust_print: Info message (level 6) without args
> [    0.271043] rust_print: A line that is continued without args
> [    0.271054] rust_print: Emergency message (level 0) with args
> [    0.271064] rust_print: Alert message (level 1) with args
> [    0.271072] rust_print: Critical message (level 2) with args
> [    0.271077] rust_print: Error message (level 3) with args
> [    0.271083] rust_print: Warning message (level 4) with args
> [    0.271091] rust_print: Notice message (level 5) with args
> [    0.271097] rust_print: Info message (level 6) with args
> [    0.271102] rust_print: A line that is continued with args
> [    0.271110] rust_print: 1
> [    0.271113] rust_print: "hello, world"
> [    0.271121] rust_print: [samples/rust/rust_print_main.rs:35:5] c = "hello, world"
> [    0.271129] rust_print: Arc<dyn Display> says 42
> [    0.271130] rust_print: Arc<dyn Display> says hello, world
> [    0.271136] rust_print: "hello, world"
> [    0.271198] usbcore: registered new interface driver rust_driver_usb
> [    0.271207] rust_faux_driver: Initialising Rust Faux Device Sample
> [    0.271227] faux_driver rust-faux-sample-device: Hello from faux device!
> [    0.271297] rust_configfs: Rust configfs sample (init)
> 
> Reviewed-by: Link Mauve <linkmauve@linkmauve.fr>
> Tested-by: Link Mauve <linkmauve@linkmauve.fr>
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/105
> Link: https://github.com/linuxppc/issues/issues/451
> Acked-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
Upstream issue for powerpc64 and powerpc64le target.
Link: https://github.com/rust-lang/compiler-team/issues/987
Link: https://github.com/rust-lang/compiler-team/issues/988

Regards,
Mukesh
>  arch/powerpc/Kconfig  | 1 +
>  arch/powerpc/Makefile | 7 ++++++-
>  rust/Makefile         | 6 ++++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 4ac897b650d4..2e3065bce9cd 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -286,6 +286,7 @@ config PPC
>  	select HAVE_RELIABLE_STACKTRACE
>  	select HAVE_RSEQ
>  	select HAVE_RUST			if PPC32
> +	select HAVE_RUST			if PPC64 && CPU_LITTLE_ENDIAN
>  	select HAVE_SAMPLE_FTRACE_DIRECT	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  	select HAVE_SETUP_PER_CPU_AREA		if PPC64
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 589613eaa5dc..9385db478c59 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -61,7 +61,12 @@ else
>  KBUILD_LDFLAGS_MODULE += $(objtree)/arch/powerpc/lib/crtsavres.o
>  endif
>  
> -KBUILD_RUSTFLAGS 	+= --target=powerpc-unknown-linux-gnu
> +ifdef CONFIG_PPC64
> +KBUILD_RUSTFLAGS	+= --target=powerpc64le-unknown-linux-gnu
> +KBUILD_RUSTFLAGS	+= -Ctarget-feature=-mma,-vsx,-hard-float,-altivec
> +else
> +KBUILD_RUSTFLAGS	+= --target=powerpc-unknown-linux-gnu
> +endif
>  
>  ifdef CONFIG_CPU_LITTLE_ENDIAN
>  KBUILD_CPPFLAGS	+= -mlittle-endian
> diff --git a/rust/Makefile b/rust/Makefile
> index 54096ce8a675..068b6fc3e0aa 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -408,7 +408,13 @@ BINDGEN_TARGET_x86	:= x86_64-linux-gnu
>  BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
>  BINDGEN_TARGET_arm	:= arm-linux-gnueabi
>  BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
> +
> +ifdef CONFIG_PPC64
> +BINDGEN_TARGET_powerpc	:= powerpc64le-linux-gnu
> +else
>  BINDGEN_TARGET_powerpc	:= powerpc-linux-gnu
> +endif
> +
>  BINDGEN_TARGET_um	:= $(BINDGEN_TARGET_$(SUBARCH))
>  BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
>  
> -- 
> 2.53.0
> 

