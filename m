Return-Path: <linuxppc-dev+bounces-23788-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821D2C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 08:26:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwB5K1z6Wz308k;
	Wed, 08 Jul 2026 18:26:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783499189;
	cv=none; b=bBRToCpysnjnHLcLHe3/+S34tSb2nUp7vkPjzFVk31bGaF5EeGpbDdRUjnEXxb2wnEsIQqsfFQ52GSMr6MupbteE1oOZAZKeDaVbEbF3bSeKGJpdhuKgMQsZyrL88R8QCtfjGKkUtq7LEyQQ7TyFHpVCLfT6PQzgDO4b4VhHaLUiP4hKHu2VlrKHoKXl7EtL7/fmXekPYw6FJ0xBDascio6qALAJMxjz4p1hqVy9+MmJGy98SauLDQ5J/CTJCiGOE/xGLV0wKbhAL9sj2zLFIeZjjiM5KWiVzpFajziPPazQ89mlXUSiqUZROoPitw2Xl3OWT2AwoD/q3V7gjCxQMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783499189; c=relaxed/relaxed;
	bh=R0yp5asYUErIc5N6oB8ZeLiWd9F6L/qUlus8Ea2ATCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B9XInQqh6NcJmDSM1c9gRVnRc8gUmK60jnF6N97XFqXnduYcC9rBvfl8cwKBJ7ZDmppva87GV20+EwPkMQkNUvOelUEpg9I8+60F+daBxFJcK9bQRpnxFBNh/BLzp6pNF8mvZ3VjmHBUelsmpxK+3+NKrg7LMijqtIdMHWzqSkGTSpRBLdfYLcBd4QR096FkZqNS7XFXrpRIJV1MxVm8nQ6cx3HwsP91plG7Bvch+xhBatsFNJVLr3RFRb/6NHM2xHznEorhSz//Fi4aL41J9hGs2Gqfpt3vq/Qr6LptwOQju0sWRc5ttqX3xd1WMNdYENmfC/v8G3qD3Bc/M1R2JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OSD4q34X; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OSD4q34X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwB5J4NhTz307v
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 18:26:28 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so225681a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 01:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783499186; x=1784103986; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0yp5asYUErIc5N6oB8ZeLiWd9F6L/qUlus8Ea2ATCY=;
        b=OSD4q34XLg6j+GhCAEFU6BSLCtlwMTBAKfrYCPKRy+OB/m5uWohJk41YbujDL60gi6
         hlvGns4XVdAp9hQ0L7wwPoyyr4KbqtEZ51RmSXc3Vl7mAgeqmkksKfdgp3A+7NGy43Cz
         mcCKwa8PE4LUe5ccVTFZNn2O6LuJ0eaYrGIbLDxHoMbJVAHzpFEnGGeM4LAfIhMBmEXI
         X6Th816KmRaY1sSVJI1j76dBlNZ8KW/EKQVo1aw+EQMTfXm1wGYtsZDoa0xIlhmBqlYs
         8rijJiyYOtz617iLgiCKN9tm4KKv3fx3oVLH/kKFlFQNYikEiHD2+7V1gF/HcaOKNmBy
         Xp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783499186; x=1784103986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R0yp5asYUErIc5N6oB8ZeLiWd9F6L/qUlus8Ea2ATCY=;
        b=gUq2RiBRyvvHVUn+06bHcRDCBkfKpon8Msrq7OKcZFa60dDF2+gckRodjUBEA/yOJ9
         k1MIgSEoTElK3ajcsXs/KQgBk516QPvbG9DBmzYqLX/u+b6te0rqOfdz5o+6Tjp9i77u
         xjbDqhJrxu5OA04kVFW7ZHTvsQMZFT7CniEYCzwZDKsER6rTDr/Af4LMFJntCE4ulZGR
         SeU43js8CuGmMQHqcAV8j7IyIrrMlDznGRN9RxQddXRKxImPw5OuNHqKu1C6JD8RQpHp
         DSa6MIQajQEV/JSG0GrErbIsKkZ8xmX+fn0TT0cpN+3f949izBU09GKN3O4EX/onufvG
         ZJ0w==
X-Forwarded-Encrypted: i=1; AHgh+Rq/JgrMWWRdDJ59c6xe1snbVLlYksu+4dLiKO3A8OZ8IkQRvQt+F+G3RFYGVM8hLrHArfQnLCqIb2eW0Os=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxobjwu62lK7sfByWylrH8m2cFzXgl7bS5OyQV88FOsDmiqGYfY
	T+qdDtWa29Z/DyG2ejhktIEyl9ADGSxS/KEZikqJ5n+lBVP4NHbKlFN0
X-Gm-Gg: AfdE7clhWo6C4BByI7Q6A0SO8+j28P5ZHLxCR0H+/SyO2LQW4CD1KE/x9WddAC+AXaJ
	uHfygEez4jWNYFBuSiw5gN7jqOkosf7cdM5R23rPGtovu5dvH0AHdZmEdjMg6VCJbPX5B0hytuP
	p+F+mIS7Q8EWl1rXTWAbYyqvHpLfY1FjxaQbrXIbw+uf71McX3Abd1w01k/p4lgKXN9dW+rP+Me
	G5lWNrdtT+5pLVqXYwIWj/LVdtEyF0JajWtE3sTII0iZvQ3UpPGM4LLXRNUQAMeGICD4/12WJky
	781hVCqcILM0M/8RxpM0T6GPcOS0uSclEgH8NuZwvp6nNoNwfmEDx3meNVCCU38Eoc+b4e1F0Pd
	ceaA3rfSiLCqUg0vqYRjz7vn9mWlNS3MwhUC2T9LEog1eXf+NGZmwNq07BQ18osrlN3MY3UI5Mt
	dwe8BSzGhKvT2CKuH1aDYAAe/BCmyhSPrg/L//oo4zwbHdXHi+ixPie7o+YQ+/rd5wQFFilJHLv
	YzL
X-Received: by 2002:a05:6a20:d499:b0:3c0:9c19:659b with SMTP id adf61e73a8af0-3c0bd1cbb60mr1995199637.67.1783499186505;
        Wed, 08 Jul 2026 01:26:26 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm19975117eec.0.2026.07.08.01.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:26:26 -0700 (PDT)
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
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	fujita.tomonori@gmail.com,
	joelagnelf@nvidia.com,
	gregkh@linuxfoundation.org,
	prafulrai522@gmail.com,
	nsc@kernel.org,
	japo@linux.ibm.com,
	mkchauras@gmail.com,
	lina+kernel@asahilina.net,
	j@jannau.net,
	airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Link Mauve <linkmauve@linkmauve.fr>
Subject: [PATCH V17 6/7] rust: Add PowerPC support
Date: Wed,  8 Jul 2026 13:54:53 +0530
Message-ID: <20260708082454.1254320-7-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708082454.1254320-1-mkchauras@gmail.com>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
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
Link: https://github.com/rust-lang/compiler-team/issues/986
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/Kconfig  | 1 +
 arch/powerpc/Makefile | 2 ++
 rust/Makefile         | 4 +++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f7ce5fff81f0..badd7c99b87f 100644
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
index 7aa8fcad4c43..61e7dc496fe4 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -448,7 +448,8 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fstrict-flex-arrays=% -fmin-function-alignment=% \
 	-fzero-init-padding-bits=% -mno-fdpic \
 	-fdiagnostics-show-context -fdiagnostics-show-context=% \
-	--param=% --param asan-% -fno-isolate-erroneous-paths-dereference
+	--param=% --param asan-% -fno-isolate-erroneous-paths-dereference \
+	-ffixed-r2 -mmultiple -mno-readonly-in-sdata
 
 # Derived from `scripts/Makefile.clang`.
 BINDGEN_TARGET_x86	:= x86_64-linux-gnu
@@ -458,6 +459,7 @@ BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
 BINDGEN_TARGET_s390	:= s390x-linux-gnu
 # This is only for i386 UM builds, which need the 32-bit target not -m32
 BINDGEN_TARGET_i386	:= i386-linux-gnu
+BINDGEN_TARGET_powerpc	:= powerpc-linux-gnu
 BINDGEN_TARGET_um	:= $(BINDGEN_TARGET_$(SUBARCH))
 BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 
-- 
2.55.0


