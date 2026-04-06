Return-Path: <linuxppc-dev+bounces-19410-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B804BF46C7C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 20:02:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqKxQ3QCdz2yfs;
	Tue, 07 Apr 2026 06:02:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775505754;
	cv=none; b=gSxyKqkewi+unmsvQ941C35vEF6E0oh/AU0dnPX8CIsHH3EFJjmYUV6hlgsYWsUenzil24zOXEYszynphhmhS6C8oyt53ImTBRFHucS8XT4GxS2b0l9/cft0GxE7NYUsyl9gbzEUBXjNZc84NMdg9/pAgNXWgeVKJhJ6I5R0GSlHnnC6C5fkXA4SAyCUch4Ew1BadHT4T4xp22xvts265OvJkuygNWe17MGLkROflKp7xv0Ec/XTcNkLFbyK8Bv4JuUiZlEPscra0IacRfZ9/uDjxYqF4Ti1YIeBopqtV2jvYgExr9RiAXajcjKZNDkdocVgZB5hfyfv4F56r9iSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775505754; c=relaxed/relaxed;
	bh=epCQc4tGVXz1xefMqDUFYXuettxlTI+7sX4tf8abt7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDft8SelSfbCwf02B6przqHWOnFM7GIPUCVB54Xiyt3TNHmJYzdhmw9AhFpl2J8XLDZDEYQhmkpc0oKADIA9Byso0OUzgVZmukBcrwLHmTyPhJa1+mCyUux1XUC2Mh9BTTGNuxUcoQHvHurY36q5nvWlsci7iSh5b3mQKG8wnHle8Am4ajHoudQuD8Mtz5uYM9GJnJ31Bfo7m1wP68/VC9PXsegt+rbETVqM4D4s5PJjCiWB9g6AZxqzGdneBJ0LsWbMUazuWaQJMANuqKm6wfx+NbwvwFidgeNouXJdGg/wVA2EiZlMXfh7oWt0U43U5bg+0opG1CmhFR+XhO/pKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OU0yxPQ/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OU0yxPQ/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqKxP39xXz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 06:02:33 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c736261ee8dso1323365a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 13:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775505751; x=1776110551; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epCQc4tGVXz1xefMqDUFYXuettxlTI+7sX4tf8abt7g=;
        b=OU0yxPQ/Rr5F0XpS/CfoUDw7d7GPmwleaPGnmD8ctw6xyncyUNO9CyW2BChWutjeFE
         wrMkaoN8omejr4Wrj8KYzRau845pGWZmkU78gpwyabXEXfTTnRqUiDu3vlvyx19cbKO8
         fnZEau4AhwzzjYeLH/yyW3Lbr5pdhvVAq0ugZ1+aL4hW+rvwB9HYsogz1GGFcgjCYIbI
         61pDrZTWjJAD+dWuwvlmWURkCNG0/mJveuPZYUhNKHaJOhaMaIx9CRh9JgsXrOK1j3rq
         Blf6nVukb/QPceTAWlDcPKMGtKIDKRzszHoPYl8n93XbZ5YT7uwZrzo45ivw7uqBWmIP
         r+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775505751; x=1776110551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=epCQc4tGVXz1xefMqDUFYXuettxlTI+7sX4tf8abt7g=;
        b=MwYxNsFMEP+1a4xFhEeLdf8uR4lix0VbGD+2mHN5wcNvJiHfqgZRWh8Z2wQCmasL7B
         i2kILup2nkB6wglFoMLYqBnF+GPYhvBXdW+p7mHBmhOuTc8yCBzHuvDRpBvKJB5knYnD
         /I5uTJq4t55260QzMEwkDXqQ8YUb0KDI7xaUb/YwPhDXjP+P6AWV2vU2xFsT4eKQQ67t
         Tw3Wc0TAtj6YBzd5hwIfBAcRU43KHUUcD1eL42xdJKrWa1FJyGsllSHA8pFYb0r57vj3
         BcKJ4QQYMtRvlOcaGvo/v+98azLmouTFVRnvWy+cc90pdbKkC6GiD/mAzL0WjnP9pP0u
         YxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgqXy90A0VIafGe9V09stzLCK0WiCe1SeTPDSF4jKGiCsWZXmaKp1gdfgkH1opVfint9BK5rQIbG/XNDw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzYEz2KDPAZV6Sp03rsidRPIG/Owuk1WkCfeDp5oaN9wak2hYLl
	W51/USvMx5ypD6vxB1ivcdtuwW3byT5ZwyM1/ACRbGD8zwOdxjgjt4fG
X-Gm-Gg: AeBDievKmfgoQN1AzwnbyS/PC1undxQ/MYYox1g0MG/uelsKUA4ZCQbktm79QRdeMKm
	9Bas/6LDmJECKQ7z5QsKgRDte0cGK9nOyzvoYWCLuunPJDt6txpdt63YbxurX6nGU9KpCnpOymS
	GfNU+sO4eT0d8w/a8ZMPoiNfPYuhW/DrPur+F9Kyhm+d5e3qKo2LGFwimiOa8kQ2+Tb76ra74gX
	wB7xKxZ1Ea/zRAVu0cS2tnlp7e9EEsIoSuLoqomnmsmIIBaC0ZQMoBUWCxPM/A/2Oh12YUV4tiZ
	XMYrNg5tGA9/9xphEweBJG2bgcdR3uA5eO25fVutSv1Sze2KknngrdNMhT6evyWinobo39NTFLx
	ooqN+MYlG70i0zjYDS/zaTYUfJ7BGPbTcondB/No3sMAjW368u1YtZz+9WgzoBQpqIpO1XQ31Ma
	p5sdZ9Qc4hMiSLMFIdqYE0ji5Tz9gDo68ljZ8OyIpaH0wYiz3Xk5lrj7mrJN58QzaDbhOTSmKoD
	7w=
X-Received: by 2002:a17:903:1968:b0:2b2:4fc1:f657 with SMTP id d9443c01a7336-2b2817d8be9mr145070895ad.6.1775505751253;
        Mon, 06 Apr 2026 13:02:31 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af26sm151098205ad.49.2026.04.06.13.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:02:30 -0700 (PDT)
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
Subject: [PATCH V10 3/4] rust: Add PowerPC support
Date: Tue,  7 Apr 2026 01:31:48 +0530
Message-ID: <20260406200149.3727922-4-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406200149.3727922-1-mkchauras@gmail.com>
References: <20260406200149.3727922-1-mkchauras@gmail.com>
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
index d8f34c4858b8..e53cb16c06c1 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -405,13 +405,15 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
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


