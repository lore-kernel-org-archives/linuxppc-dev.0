Return-Path: <linuxppc-dev+bounces-18974-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578BAF3D60A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 16:03:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkK1L6Tryz2yYs;
	Mon, 30 Mar 2026 03:03:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774800214;
	cv=none; b=T7yERlA+fxLk9djC2hJX6Mg8Uynj3UEs0toCMGhd0EsXW01ZAVtIEwPxL7DzfIsHC0itKJb/jr79Uq21tzmg+MQA+310H6dfG+kO2RQ0Zlm+J/MklvKUCrcICPKIcV/UFrNOx5IWNYjVE+TvyodNjSRc/dWFaytuKu0iJcvNOnzApf1HQAtFvuU61vL0ikBX0DQKroFG9vq6Xm7dvI7aHiT3Lu8oorrjlZOXJKTTZsItlVunGOYwfUuRtwshZuLmsxnnhAA4c05X3QKwsSqTAk3RqM1QXT62uOGYC3w71GJSsFOBGR4skxRvy/p1d92r/ogXezUoJlKIjEarriiVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774800214; c=relaxed/relaxed;
	bh=pYhd+KU2GoaXLmfUSCyKUY20rRmYV/7gtISAKLxYEYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVCY6YtPLJU71KlQCffuuoLbc67ZVbqgEFExwLrzaTvZHr0OWy3KefnubiYGGn9JQvIrtfsrNb6N+XpE7hcfUzU5SQ/ntVxGuRyk+GcodDENXUFb6GOt0/ElpCII5Epd1FVpPdazgVqNOb/TxOspqLwJJqi9efHBNEKS89OQhr90cotU4kW5n0g+fkLlAf6YUSHhzNaEZdJVXfEz30pEBjLzQD/IRJEgG4DpyGR2StZhQcSgiBE15qf8Ulj+OQBgCVbaacLb7pBPuFbN0XwGOYD6+9T1uC4TkPHfpCGXPHtRv/kqhefor8DT3vUO7qSq6JFxT2lWhPKB7EhjvoHmOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ViSRc4Uq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ViSRc4Uq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkK1L17j3z2ySS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 03:03:34 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-35d9923eec5so575016a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 09:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774800212; x=1775405012; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYhd+KU2GoaXLmfUSCyKUY20rRmYV/7gtISAKLxYEYg=;
        b=ViSRc4UqtbnAUlqeZZ9wB9WlZIO/sQFNhHUm8Tz+T/tQqujxQ2UQmPJ/0yAT/iVYdw
         FJrL4OOLIbwpmRp8HTOHQ8b/PLcQXZsc3e1iWfUpFxu6wkRcmbZfY1uolsNn77HgDox4
         EjryHPEY5SYutD+LEvAN2y9NP/ZhKakftEIs5BEkGv9lAZtccsfTAoDW0w5+luOJI6KY
         PIj6dqHOiJUu4EWT6cILIq1c0BWJpPuALVQ5YNRDi0grHukbfZAwM7tAPq4yJ0jAjxuj
         i1R/93BHQQuNUAuvvRlettu23MV7XFhJqGhTjrB92+K3bgVmax+z5GsKLCEaJ9eq4P+y
         tuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774800212; x=1775405012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pYhd+KU2GoaXLmfUSCyKUY20rRmYV/7gtISAKLxYEYg=;
        b=locYQ47Bxaq3Oa1/nbYdByU1ULJWE54+2KT+YG/Mmqr1+hYqaL2Fojnv5BYKNkbL8A
         FWehXWMJ4OipjCYXDTthPikQ1uvj6jVS6wZ9lyOT0LoS3+OrX9nCIKmnnUF3Ho2COUXd
         ixkzRsXA5jVHRcU2pMe5ijkciqOsQCTlJ0XTdwG24yoGj+GEzMHbaRdSIVXupDPt6JtC
         5zMlwDGzLbtAdiXxDMVmNDsAI2egy/Bi4kHGzc7rmFInK5QWeOAN/WJKU+TRDxoigp3n
         uxtNoqUXi/Wlj1v8eZXBQEmBQQNKR5DKHShdIy+mbuC56eE0qrQJVRUawHFUQGg/R/Ks
         zBBw==
X-Forwarded-Encrypted: i=1; AJvYcCUIr8H5q6kwkRJItlg5n9yghA/xE9zdHjGOT+/BW0lgd+kETflFD2Nj0AKf5tZNkUS2l905oNuNLCJbI2k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy5LpyiMaZiiLzTQzV1ajkKz8kLo5TogEmIF5uGa2UV8IRwDbtF
	O9kaUhxvvjyhYKDmCyPS4a1u2l7bvTgrETQ8Ezg+yOioBul4b4g1E2/2
X-Gm-Gg: ATEYQzyHwQsB+4UnuZGrvbHLDWloe0mEvrEI6amvaSFrPMeUm7NKUMQwT+FUdzTrZ4n
	GgUqFZukPXBZ+IW+l/gRL6aUggcTRHjklCaMEbQadJNes0b0NIs6FUe9YjWAavNapwscG96YsP5
	QRe79qfzCbMvQI0YB1fhOtd2gh8Kc9FdeBCmjTII3TKwQ8waNEOzYmhRYAPx5LTLQ46S0tXyMko
	ROiI7sRgESlzLHjNVlLhosdb5JEr9slPjOTCdB9xj82Os2qOJvJNVQskmDp0zknKLmpRJSS9GI0
	XUBb9eGDxp9a2OJG08bZ1xRqYvUe1uO1hC0ksXN27q4qpP1J/yr4dHy6IWwwoHVeXE/jRiIZzxe
	GQyR5yfaBF6aGmJJeJj8bRAl4OK2gqzwX1rRpAqwSILKdk+wZfst46lvthW0X+XqPtryjnQ1izL
	rnJz+IE/BnJSqbQjyYjod07Rc4VDLq0oHLhil5pw/dA6KbYKN4ZOt0rkxWVppwXj6S5ETWArp6w
	W54Kha/bRwIJQ==
X-Received: by 2002:a17:903:1c7:b0:2b2:4b4e:e4d8 with SMTP id d9443c01a7336-2b24b4eeed0mr28485965ad.4.1774800211716;
        Sun, 29 Mar 2026 09:03:31 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c176fsm52521175ad.77.2026.03.29.09.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:03:31 -0700 (PDT)
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
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: [PATCH V7 3/4] rust: Add PowerPC support
Date: Sun, 29 Mar 2026 21:32:53 +0530
Message-ID: <20260329160254.2592207-4-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329160254.2592207-1-mkchauras@gmail.com>
References: <20260329160254.2592207-1-mkchauras@gmail.com>
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
index 8e62f6fcf94f..7ea7570e3f17 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -402,13 +402,15 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
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


