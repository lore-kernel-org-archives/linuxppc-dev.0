Return-Path: <linuxppc-dev+bounces-20112-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BC7FF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 08:59:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3LGm4crHz2yjx;
	Sun, 26 Apr 2026 18:59:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777193952;
	cv=none; b=iuTmvjWpwkSxdvTa10T4PjojxL+VmqLDbkzEyFDeHdIyuZIJrvJreOasoQgJDU0jIQkMdJBIlQ5OsanU8DzoFQ+FbgcFSkLTPI673+KkELQeIjAhaeA9Q6v1BotdllaYwxfH1uFoLMKBEJwpRoIjb+VHWBhslh7ypwCZIkUdd8+1yo3QC5WbWh3i2nWzzrPpfWtdUniM4KH1AMhGRePxJxKMCecWj/6JjHBKfbVKTCyFx7dP9mW6k/YsqkJuSdg+dHl8HqYlBj6y81EQrY9hMmC74YqmcF0WhU7ulA6vEbKEeZLA/sO+c5fu7Y1Y0yZ4SMHFtwN8zIXnhEuXSUb3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777193952; c=relaxed/relaxed;
	bh=55+b7l5F3zlZQ0yMZrz5rEYbg5vrZhPlJC+KY+nm9CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHaqUQOfO/H6HqIJ57DkOuZmieB94pgK6tEeMIIT0WZgQcqpyg500r6/mXPvqdNU5Bx3ZmZUPRHJFFsEgPvHdD/IIV3bHgaNF4siq88jm/NoN6KWkUfSXkRIRwvDeUN6SYC+RwVWQ6N1l0ZIzqvpP6nXrk0mnbVWr4cRod8/i+YVS4ivYaa8YE3jI7FmdT/gtb+ts80WcDiwZiFQQzzy/YCPCtQ6KTpPtHN9YVeddGT3LrcQRB+/uDzkgS9Apt0T2YYfSTmfP+fSTwLBpRiEmTtl+zinTr8SpHBcBxwvMxstUs+qrR3TdHOdBvUdPNbqRrIWqVEqTWthxjPf+2My9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TKn/D6C1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TKn/D6C1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3LGm0HvVz2yjm
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 18:59:11 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so8579694a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 01:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777193950; x=1777798750; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55+b7l5F3zlZQ0yMZrz5rEYbg5vrZhPlJC+KY+nm9CU=;
        b=TKn/D6C1g6nuwuUyuQYs6szjOR0AnbJhlcYvUG4iqX6d0r2v/RzUynKHtbkPM8OWuW
         m16rZP+XpA4wrNLCUIp4lPD0M2ZwEUDGQcxofj0SS6k9in2X/kRQ02s2Z0O7AQqZRniY
         H+IZNXGWlWIXaQ3QpSMgsb+LhRCsyfUcQb1Tktg2MecOR1wTfnpz93YY25HITu+0dlhb
         kbekzrwXElUNoAUzCLiNODNUYVcq3jAmLbGLZVL9MWXwHZEbGzXFwfNFnXvl8jSUB62W
         7DDUdW/s6abM2Cz7s6TKNu/AnTgf3XsFv3QsOqpsdlH3r+ax+hcaj2ovm7yScjXKw0jb
         +yCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777193950; x=1777798750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=55+b7l5F3zlZQ0yMZrz5rEYbg5vrZhPlJC+KY+nm9CU=;
        b=REZkcsqGhwY0xwHsgkZ1UQLyqfc+hQzEDEBglwx5Tym592yaN2WchdmDj2lAq2cDGW
         Uy2tjaicwrTpBcV0Rj2W2xQ1iMME7TIl0xzJYC7opPYqqeNX4oHusCjT9Cb3m9UcCJHm
         9O0T6dAgxno3oue82M0SoVgr33KYdEV5qJRZJqQZN9F6N2J+NTp9A6c2HbN0OjlIGEPz
         G0o339HYC7cIIllCAzzu7OVRmNvk7HAJv90B6vYL9MPJB2im8zertJ/ulpjZR8+pacfw
         xPi9xY8juQiWgyIWRwVkEKCagKIrrwPyq+ZjrKhoG35FDc6D8sqQai3Z2Zx2R2gCNeIF
         UNjg==
X-Forwarded-Encrypted: i=1; AFNElJ8lkJI5lyThgo6FeGaquV8GqSm7ZdK46MvG8ktsVYyyEHRI27eqz6fgtiXDr8O1LwYH9aQ1Ja9dm7JDQlc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwnhYT4KhEpEgzwCNuRVELAxpJh7HSVNVsM/siiUlPK271cSRuH
	62ypMZAueVWpUJ42El7wdNxLOV06ZQV9rlGQ9XFHofSNbRWhzRHhXIJL
X-Gm-Gg: AeBDiesflXiijH8jVrgmfnW2qbX8qeVLWvMiAKqjSRasuCSd/KEuaacThR27zsPO6sL
	TaFmkAi6g7aqQXNlMfa57z2q9MGwpwKlFqU8f4Pg7UZn7KZaTviZFhSR/6cnXPj+TDFFNRSJxpc
	HbTQvRY/TLG/pU14Z81mE1pVRyz7vDv/n2JnhS+b7WyKEN7uGqF3/csgauaxSar7+O9uwb/sw81
	+AHv+a5UqpPtYJ3lW+h+haTctYNI5YeqIDA4klB8oD+mn9w5k+KNHz1Bd+94eXWQccGPlFo6YYK
	UrF3Kt27tPyUKHwkPqi2EiERKMP2QgF3XWYs4KGDF15Buii4zXUmwfjxSGhEVBgOYKztTGRvSUx
	SQmJsGfoKllGF5E2j0nw57QrwgRJbAjDQsvzPg8/W5obYVUQTZCOKYMAZjfoxV/HiKFs9wswmZ4
	XvdAjw59xjpm7RDgwAkwguYv4vHq+ZV69UnGpcE8gT9n5OZWZDUMfsVEvLA1kDg397oNRXwVrLG
	r1aCfM+W4zokdY=
X-Received: by 2002:a17:90a:e704:b0:35f:ccf6:69a5 with SMTP id 98e67ed59e1d1-36140478a16mr39086684a91.20.1777193950059;
        Sun, 26 Apr 2026 01:59:10 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm27718937a91.3.2026.04.26.01.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 01:59:09 -0700 (PDT)
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
	mkchauras@gmail.com,
	lyude@redhat.com,
	airlied@gmail.com,
	j@jannau.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH V14 7/7] powerpc: Enable Rust for ppc64le
Date: Sun, 26 Apr 2026 14:27:25 +0530
Message-ID: <20260426085725.2090827-8-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426085725.2090827-1-mkchauras@gmail.com>
References: <20260426085725.2090827-1-mkchauras@gmail.com>
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

Enabling rust support for ppc64le.

Tested on pseries Power11:
╰─❯ dmesg | grep rust
[    0.225728] Initialise system trusted keyrings
[    0.270961] rust_minimal: Rust minimal sample (init)
[    0.270968] rust_minimal: Am I built-in? true
[    0.270974] rust_minimal: test_parameter: 1
[    0.270983] rust_misc_device: Initialising Rust Misc Device Sample
[    0.271012] rust_print: Rust printing macros sample (init)
[    0.271019] rust_print: Emergency message (level 0) without args
[    0.271023] rust_print: Alert message (level 1) without args
[    0.271026] rust_print: Critical message (level 2) without args
[    0.271030] rust_print: Error message (level 3) without args
[    0.271033] rust_print: Warning message (level 4) without args
[    0.271037] rust_print: Notice message (level 5) without args
[    0.271040] rust_print: Info message (level 6) without args
[    0.271043] rust_print: A line that is continued without args
[    0.271054] rust_print: Emergency message (level 0) with args
[    0.271064] rust_print: Alert message (level 1) with args
[    0.271072] rust_print: Critical message (level 2) with args
[    0.271077] rust_print: Error message (level 3) with args
[    0.271083] rust_print: Warning message (level 4) with args
[    0.271091] rust_print: Notice message (level 5) with args
[    0.271097] rust_print: Info message (level 6) with args
[    0.271102] rust_print: A line that is continued with args
[    0.271110] rust_print: 1
[    0.271113] rust_print: "hello, world"
[    0.271121] rust_print: [samples/rust/rust_print_main.rs:35:5] c = "hello, world"
[    0.271129] rust_print: Arc<dyn Display> says 42
[    0.271130] rust_print: Arc<dyn Display> says hello, world
[    0.271136] rust_print: "hello, world"
[    0.271198] usbcore: registered new interface driver rust_driver_usb
[    0.271207] rust_faux_driver: Initialising Rust Faux Device Sample
[    0.271227] faux_driver rust-faux-sample-device: Hello from faux device!
[    0.271297] rust_configfs: Rust configfs sample (init)

Reviewed-by: Link Mauve <linkmauve@linkmauve.fr>
Tested-by: Link Mauve <linkmauve@linkmauve.fr>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Link: https://github.com/Rust-for-Linux/linux/issues/105
Link: https://github.com/linuxppc/issues/issues/451
Acked-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/Kconfig  | 1 +
 arch/powerpc/Makefile | 7 ++++++-
 rust/Makefile         | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4ac897b650d4..2e3065bce9cd 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -286,6 +286,7 @@ config PPC
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
 	select HAVE_RUST			if PPC32
+	select HAVE_RUST			if PPC64 && CPU_LITTLE_ENDIAN
 	select HAVE_SAMPLE_FTRACE_DIRECT	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SETUP_PER_CPU_AREA		if PPC64
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 589613eaa5dc..9385db478c59 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -61,7 +61,12 @@ else
 KBUILD_LDFLAGS_MODULE += $(objtree)/arch/powerpc/lib/crtsavres.o
 endif
 
-KBUILD_RUSTFLAGS 	+= --target=powerpc-unknown-linux-gnu
+ifdef CONFIG_PPC64
+KBUILD_RUSTFLAGS	+= --target=powerpc64le-unknown-linux-gnu
+KBUILD_RUSTFLAGS	+= -Ctarget-feature=-mma,-vsx,-hard-float,-altivec
+else
+KBUILD_RUSTFLAGS	+= --target=powerpc-unknown-linux-gnu
+endif
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CPPFLAGS	+= -mlittle-endian
diff --git a/rust/Makefile b/rust/Makefile
index 03926a451bac..8e5891563777 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -407,7 +407,13 @@ BINDGEN_TARGET_x86	:= x86_64-linux-gnu
 BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
 BINDGEN_TARGET_arm	:= arm-linux-gnueabi
 BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
+
+ifdef CONFIG_PPC64
+BINDGEN_TARGET_powerpc	:= powerpc64le-linux-gnu
+else
 BINDGEN_TARGET_powerpc	:= powerpc-linux-gnu
+endif
+
 BINDGEN_TARGET_um	:= $(BINDGEN_TARGET_$(SUBARCH))
 BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 
-- 
2.53.0


