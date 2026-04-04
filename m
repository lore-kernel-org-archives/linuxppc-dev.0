Return-Path: <linuxppc-dev+bounces-19312-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B48E88D8B
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 12:17:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnvj64r6fz2yC9;
	Sat, 04 Apr 2026 23:16:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775305018;
	cv=none; b=D3UZVXNPCDhqc4aIhqG6Z0J4OQqzA+OuqVhRex496H/AQZsK7RDlhUZWcZQFO18/syPtbIjsskuTUN91nYl9x65ht/Zw0nMxt3PP6StnX7EzItP0Qx0ref8QN9NtqbZrOk11B+5gGQKbERM6T107u04C002iFpnKtQ14nqh5lOPn7LxoxbSgoqb2/lBHAcgUMfyIweoEa1ah4llHf7FWVDUvp1SVZqJDaZXuX85CO/NOaBvVfr+uKa9gDINPD6JvFGRT5pTHJohdX7v8DUAypZ31NWp6w9zBzpN3D4ALN2K7eQLNRxLtvOuqHcvsJZTbipmXHypHVenbFzI2KoOxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775305018; c=relaxed/relaxed;
	bh=BKm0GCc95U5yVYTop7PGOFzPahS1W34+eH7uQUagHv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqxWf5dsnuXfrzAMqcKi1iFvxi49NzgTuMWNY0dEGFrQQJF5rA06m5zJBjuZTM6ZHl8MEdMhS3gJ3uVWUYW/Zw3QcZSwOxTjPn/H7VyuF0ZKywwHbItFR5VVGtBGFWiHixsZEQi0KoftAeSOguvaVoJSmqvfuIiBMEjRi7DedSm1ppqofOOKAe1Tmlia+9pX5ZI/D1OpwTI6OmwmqH9MYr88czQgD6W4gX5Q2lTfB/r1PE/j0rMRYCxK24Mtt8nnI6XdS5AiKUOw8dJAH7AQtp2TO52qvC2RVVT2gsd/ZzhkIEuMrhczv9h2TS0OaEK1IbNRgamO0URJedBMweZv5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mUZEOc9i; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mUZEOc9i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnvj5729Nz2ygd
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 23:16:57 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-35c2fe0d90fso1539899a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775305016; x=1775909816; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKm0GCc95U5yVYTop7PGOFzPahS1W34+eH7uQUagHv4=;
        b=mUZEOc9iVK/ULe71LDfKPMXxBTwMLofO1t5c7T1887ZDcGMZ2/z2QOxhgKl4Yz2PIH
         SV+GGv59s0o+hZoWU/ODc73kkHwU+J90uThuRdWqFMi0jDbkcf7CIu+aG+iV/l4l//KX
         2UA+e/SzW9NI75dU0xiWuQli0xBYK4pJV61ft70g/IHZjZxkXFStR+UY4wl460LvejqR
         egBh3pdMdJ3KPUmXSEZxcsqHgOW4q/3chNAVubWy4HDpBsn+pGaVozBABDPhAxa133h/
         RfT6SdwoBGsOSGSm+KfVeeXWMl9hBz0YFkoUfrUbJRC/jlvTFS8V4XpMytxJZQTTjkUg
         obTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775305016; x=1775909816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BKm0GCc95U5yVYTop7PGOFzPahS1W34+eH7uQUagHv4=;
        b=J6mIjkdk8Z0x01UmKGNU8Mf6ATmf5BySF1NebR40UcCer+Mlw5jIoosNrRrul5/hb8
         O2RwMPFd9cFVQYrG+FCfgWaBheddxqdRl3V0nVuP+0CqN/zrpT/1vXdMiV1oJekrSnGQ
         dF2R0PTojoLJFyU5TpE65lj+a2qq9zwACbuAQoRvY0tc4agVHNnliNduVzq7cf3DF0Iz
         JUBvVHVZxIqnLC19L2xlJ3/J1dUds3igOJrA1lc/rA+Tm0XBm1asXX7WA77Lgf2MLlRy
         SZeCu7w/n4mWMAAfcRHyaudgDqSDK5CJkOV2X47GFc1H0XkWSizG/zCh6eO/6nQhPEbi
         sn1A==
X-Forwarded-Encrypted: i=1; AJvYcCWeJ9bEuK9uydmECExmt5V3eUXoCL8AQTMNihKiAreuWPNNB/Lb1VHvuboS07SFzEZejXhHl2r/oPA6Sd8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxA+9wKmD+zp9Lc9GGDB7cTLN8W/vK5VDUyM1tPF+xdCiJCLCB3
	Y93OfQxwrLVv1sypejFZTrSStnWmHTwQw2Zmf5lYfzophspvJpVSISqX
X-Gm-Gg: AeBDieu4n37Uj/Tfb/D1y4MGO+DNHWTsrSBb+TidEQ5h8C5FP4aeKALq/RP10n8tufB
	yvEumhcR13Gg6ue47ch8KVj95fOOa4dF5FnYtIlHUhUx2UAOthehgP5Gj0vRxgJn+VRIk7kdKzy
	icPv6HUE7ZTSgLPMT0zhypYMEynW9VK1jgnfwpIXhnjSkeb15Mlkw6hQC4OsonSY/k7vMWbCfCt
	mSdiD5sF9NObOuKyPLIcWdhvI+gKa12blqJX+Pv7UFMt46rfhYCwtSvWUQMSUisUYQxBNJm6ik5
	pVVkNJ2dJdYPUOXbeK0Mo7OUDxl1pxjah3TTqLwuHBNNc/bASvY2nLi2gFbq0zd3oTryFwGfUNw
	y6QXBqinHw/cUu2+oaZBn+IqvsRWwvEwL94vwE1VblEj62vgjygqvhY6aez5ipjd7MYH+N7NImF
	4nR0+c4VUptq0Pb5ImsTU50J4vBu3Xj4pvaXcd0DbsgpSF7nQqEsRSb+VBmwbqUbaOEMsP8Um0z
	38=
X-Received: by 2002:a17:90b:2888:b0:35b:9894:f6f9 with SMTP id 98e67ed59e1d1-35de68f7f89mr5794773a91.18.1775305015943;
        Sat, 04 Apr 2026 05:16:55 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de500c42fsm2702745a91.0.2026.04.04.05.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 05:16:55 -0700 (PDT)
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
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: [PATCH V9 3/4] rust: Add PowerPC support
Date: Sat,  4 Apr 2026 17:46:09 +0530
Message-ID: <20260404121610.1956528-4-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404121610.1956528-1-mkchauras@gmail.com>
References: <20260404121610.1956528-1-mkchauras@gmail.com>
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
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/Kconfig  | 1 +
 arch/powerpc/Makefile | 2 ++
 rust/Makefile         | 4 +++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 10240cb80904..1246b3add8ff 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -284,6 +284,7 @@ config PPC
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
index 5f726a332d9e..04d8a849c6e4 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -410,13 +410,15 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
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


