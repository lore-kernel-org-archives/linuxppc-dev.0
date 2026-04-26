Return-Path: <linuxppc-dev+bounces-20127-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A222FF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 11:01:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3NzX0vZsz2yjx;
	Sun, 26 Apr 2026 21:01:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777201272;
	cv=none; b=KAeHKIkQJes/w70uEL+jSGT+6OrBbHrDpBUtfwpFqgb1HBSDB3Ifq3V6yYbBFN4wkUWC08hnj0UMjaI1qd+pfur2pPBhLGwZXoWpa2JzkvCtdvGHS8Fo1UXcN3qPH2/84AkCScAy6aD8ancMH3Sew6Yec3ZtpaZwzDIPANJBU1TWmMK5y0S2tx4n6so388o+m0dX+fcjVMpqCgiaY9X9ezDpCxmR2Bhc6KFKINB4zkZm4Za7obHdtM27H8w5Cyzu6gjt/cv5SiW+lUB6EXmbRRHXot5UklxZ51ZE95e0S4i2lDML5TbaF56eanMkeeDvIJj2VX9VU/AR7z3oTD9ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777201272; c=relaxed/relaxed;
	bh=zD1QHbTvqlDponwM5P/F4+a1PSB3+J8FyHG1ndeTEn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dszADyTLvFct+6E9H3BSIxrkWOosrYgGvtBZa91RbFYBFIP1RT+lyDLgLc8N5Z5KDtWxLgg7CQM0caGYPhcXeHY4OutgnobiPY7NOrUyxiNl/3lNe7eI5yOC6gkOtZHs6dGfoL9HgIenpBkJNU8qPlgpFIRH2E0J0J4A0sEMmnY5l1wTYXNWbbrJMEE+EIptlZ3Rh6Ku/YGFRqK2gpVVWb30YQOOfi6pFmNSoSr1uGugb3n4biv4iqUo7YfPQyUNzjTrZ6CPfTwTSYIlGqioutvZTyW1Q1J6iG4Ep6IsPtWB1D32UdZ9dPzsGZZmbrcdClbDFasY/eZXP7q6UVwPBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hwaiv+Fc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hwaiv+Fc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3NzW3FfRz2yjm
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 21:01:11 +1000 (AEST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2aaed195901so39906055ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 04:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777201269; x=1777806069; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD1QHbTvqlDponwM5P/F4+a1PSB3+J8FyHG1ndeTEn0=;
        b=Hwaiv+FcIJg1qAN3NgIbVaDp8CRrSFmNuigYDQUoh6r2/FG8KGwiMj5SIN3Mhef1sf
         3+TARaZHI/9+60w6LOw23EYjZ/v8+U0y4hMmBbBsmJEVu26mukg3JHY5n3AJ7uth1/mD
         OVKbSTUimtAwuKRKm2vmf5EcZ9uJj9JTpE3pjvCu5GykBscksLqBPkpUR1r4YTksBy3S
         YOE/9ZKcWfB3hEIgDmMmgjX3pOjmyMKIs9k9zAZ8/KU7Re448LhdvQMcGHEKtxlzQdls
         hXUr06NTA9O1P8LEq/c0JLr71zO8hasOjZxHPkT6LZfsZVnav9xsGhiOor9tz1Gu42qS
         bVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777201269; x=1777806069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zD1QHbTvqlDponwM5P/F4+a1PSB3+J8FyHG1ndeTEn0=;
        b=RdrKcmN6Z05CpfXjd18mGsp40C9XvvZZHDvJXBT3WeWif22sk+w+6oCOjkXJCdj/+7
         CG6UwWgjmAOR1DJNx6uNw8Zc6CfWWsREyqBeFbIFfedd2IwRqvNejokN5fFjGg8eAiVf
         DnQlB6YQs6OtYLIkA6SaXupWR7CXnyXRJMBQ1o1bcRmnvsPjj376T2FwWCG0o1rW6ca3
         b+qLpcy9QKpYrhRSY+9t3nQSks9KA97iUqijx31I//p5MbRz6Y6d9ObFyPwXSUtyYHkc
         +Zk4MTAWQ7Wpgfd7BOEvA9iLxz0TlLbwxZMavwTCcCtU8tmKfFhE966LZBxUGB1gLc0A
         OxDA==
X-Forwarded-Encrypted: i=1; AFNElJ8sixa+acu0sTnubDimwrD1pVjBkPdVa2XYJRqTCO6eeSLOKbcV4dMd5YDBP0ScA66Gl7E8XH3ro/kB3i8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyI3jv6eCr5UwITTa0iiulir2XbY2BucLXd5uVS7O/GQSwoGyOi
	lFJTC0jB1/pj/qqhNzZQrQkyPYsSytST1O4jXcVNSGWIkvF83rNxTVFy
X-Gm-Gg: AeBDietpklzqTonZjMOJ5nBZOys5liqMIt4RWE56d71ggag49Ljt3str9PSClMTGwo3
	mthJoDNmjMWRX9zY3IYVu2zbp8iM7MxROo25yswEhwE1+kyyJODRAMucf9bg0st0aCJSI2y0mFS
	fKaylC8k30HsMjUmrTfZvGjL6YVyWikiv+rX5g1pWyGYzLhiLNgV24I267Bnzdo21z1YdLqYuy4
	mpp1fIXAVQ9soy/DZfxYfEkxbsy+j9wYYXYNy+owbIAQEd2qlCSIjULGR3hj8Iw6dSfxPwEmxpW
	GAQjF2zb59ijdZHrpZ41hjG2WPF42F+uCxpP/r4pIAJqv5m8XGiI4J4wyukiocyjbQoupiThVwg
	HQKT2ALn3TpqVxWe7B4Sq+whCjuwzBYorCYIsqQkYmWFoWRoSoppSGwMcaZgew4ylZdChNrMGf+
	wUvf7ebEav9Jg5xNXzjWFEvJBP7+IqWwYN5TAeu0e4aRYbGBh32n+c0qv3xcUJgh5L9enaaso8g
	WGqujMBtuvXDWc=
X-Received: by 2002:a17:903:2287:b0:2b2:be01:5532 with SMTP id d9443c01a7336-2b5f9fdbb6cmr369613895ad.35.1777201269202;
        Sun, 26 Apr 2026 04:01:09 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa2f129sm256667235ad.29.2026.04.26.04.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:01:08 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	aliceryhl@google.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	dakr@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	daniel.almeida@collabora.com,
	fujita.tomonori@gmail.com,
	viresh.kumar@linaro.org,
	prafulrai522@gmail.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	tamird@kernel.org,
	mark.rutland@arm.com,
	mkchauras@gmail.com,
	lyude@redhat.com,
	lina+kernel@asahilina.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Link Mauve <linkmauve@linkmauve.fr>
Subject: [PATCH V15 6/7] rust: Add PowerPC support
Date: Sun, 26 Apr 2026 16:29:31 +0530
Message-ID: <20260426105932.2270364-7-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426105932.2270364-1-mkchauras@gmail.com>
References: <20260426105932.2270364-1-mkchauras@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Link Mauve <linkmauve@linkmauve.fr>

For now only Big Endian 32-bit PowerPC is supported, as that is the only
hardware I have.  This has been tested on the Nintendo Wii so far, but I
plan on also using it on the GameCube, Wii U and Apple G4.

These changes aren’t the only ones required to get the kernel to compile
and link on PowerPC, libcore will also have to be changed to not use
integer division to format u64, u128 and core::time::Duration, otherwise
__udivdi3() and __umoddi3() will have to be added.  I have tested this
change by replacing the three implementations with unimplemented!() and
it linked just fine.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
Link: https://github.com/Rust-for-Linux/linux/issues/105
Link: https://github.com/linuxppc/issues/issues/451
Acked-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/Kconfig  | 1 +
 arch/powerpc/Makefile | 2 ++
 rust/Makefile         | 4 +++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e93df95b79e7..4ac897b650d4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -285,6 +285,7 @@ config PPC
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
+	select HAVE_RUST			if PPC32
 	select HAVE_SAMPLE_FTRACE_DIRECT	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SETUP_PER_CPU_AREA		if PPC64
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a58b1029592c..589613eaa5dc 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -61,6 +61,8 @@ else
 KBUILD_LDFLAGS_MODULE += $(objtree)/arch/powerpc/lib/crtsavres.o
 endif
 
+KBUILD_RUSTFLAGS 	+= --target=powerpc-unknown-linux-gnu
+
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CPPFLAGS	+= -mlittle-endian
 KBUILD_LDFLAGS	+= -EL
diff --git a/rust/Makefile b/rust/Makefile
index d70fb186cae9..54096ce8a675 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -400,13 +400,15 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fstrict-flex-arrays=% -fmin-function-alignment=% \
 	-fzero-init-padding-bits=% -mno-fdpic \
 	-fdiagnostics-show-context -fdiagnostics-show-context=% \
-	--param=% --param asan-% -fno-isolate-erroneous-paths-dereference
+	--param=% --param asan-% -fno-isolate-erroneous-paths-dereference \
+	-ffixed-r2 -mmultiple -mno-readonly-in-sdata
 
 # Derived from `scripts/Makefile.clang`.
 BINDGEN_TARGET_x86	:= x86_64-linux-gnu
 BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
 BINDGEN_TARGET_arm	:= arm-linux-gnueabi
 BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
+BINDGEN_TARGET_powerpc	:= powerpc-linux-gnu
 BINDGEN_TARGET_um	:= $(BINDGEN_TARGET_$(SUBARCH))
 BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 
-- 
2.53.0


