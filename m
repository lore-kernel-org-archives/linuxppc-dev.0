Return-Path: <linuxppc-dev+bounces-20111-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77138FF885D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 08:59:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3LGW1JpYz2yqt;
	Sun, 26 Apr 2026 18:58:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777193939;
	cv=none; b=AXF23P1NSA/loAK3hZag95kGqdZLgfD7bxl5PVoflercwwKqNrUguFIvOekAWwuZRPnqCSjD/9jZGv+utmXv5c8ijRVjFaJfflbLdQJMen2v2m2QRX6WgASd5u7T3k7sxAcfVwbv3tcUDsgErP75hRrz4cknK2zgAxBNVzhE5pcjLW5nZSouyXMo7QY3udrXVND5joqcaHbZQVgutSDAziQ3pyD+WeXGc5CfUiwsUiMik1EXn21J4uQIknwsXBfoCAu1VJtElAuzKh0Wrh7l79g7cf/nKD3woP0LJ0bex4JPbS6KiGD1QaqVUyyu2JZN28p61OdPxm+wrOhxCBMiwA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777193939; c=relaxed/relaxed;
	bh=AMHiysWjfyDRuRD5lpg8f9BCP2bUjUGrNK0xtp2jPK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J95P6GdhrUhNSepuDPKwitSwPEHL44GDXCqEqwLo0gLWUSlSays4/0owU6dKisvCOL9bEh+LRDR+OEfbqXcL4OqggIGqgiZONFL4yAgUM1uCTF4cyMgIvxtlSJxAtqHHJAwlnuX+/Sc1f4tq9VTgKpx1UjF2hyaZ41Bo/tsMtldCh9VH5CvOny0xok1xe5mnAtxB0W+eyN4uEFKxJqzL2yOCrlOVxFcaHm0ZtOfD+Jta0JNCfC50LGE/hsWu2SgaNn0HxFdqDwROxjly/cgtpLH7GnDsqfyEsx4uoZYjFDSFqG2AeG9dR4dOC72+LxIFQsxsOPSFAkcwH1p07BHWpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZqSQ9iFB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZqSQ9iFB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3LGV42lTz2yqT
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 18:58:58 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so6010832a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777193937; x=1777798737; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMHiysWjfyDRuRD5lpg8f9BCP2bUjUGrNK0xtp2jPK8=;
        b=ZqSQ9iFBmn5YYtCLslsAuZq8gQ3nOynckL5W/CGMt2pyhjA1iwElWsa53lhwCvEgrq
         DoLM2y5lx5GFCpoJc7UrSMvB3Xgpo5BevyQfrOyjabtfbu5xkcG+9i8g1NZi46FGrzKi
         97WCwBgBOO8akEbPME+LpakwP7FeYAJ4gqu05FFlZkAOHgznZ4Xu8Xi0lxonj9ZLFnKF
         Gy2UiKhBTwsMYbSRiNPEvgbeTaL9Ks0YMiPI7W1dQfOVdUW/HIRD5sqQ9cvU4eTpLASQ
         P5YAjOvh9UrReVfKzVWBe4EGyzsbZWzsK/EH6AORe5M2IZikctomDUpot9sBLxcOpJzd
         HXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777193937; x=1777798737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AMHiysWjfyDRuRD5lpg8f9BCP2bUjUGrNK0xtp2jPK8=;
        b=pXA2kae3w5Hddx6b0WZljKTdOtrDFC/Yoi2ujjKVbsQtyarM90vaWfTljZKaGhScxc
         FjdSLltgZX1AyZ6Pg2FtXIF1r7xaFH1+CZMfzWHwtX6Zx9/dT2D43siDSjo58qQV4sht
         8Jo+fAvIsj3HTbkmo7pbjSGmjzckNUyqjou6da1AOArHIupr+nSC3GOZnK9edq9ECGgY
         tqVoRUkwfwvSS+1EF3o8BtIDhRPYfiYCM+ygqCvJFaIR25ICiiuayUmQVp33PxQKi7cC
         EZkwcykgh4UsMysmR3xshoe/9ZVzuIVJxWcpflDHMJRSBOh5D/29HVrhPooF0JNtCZT9
         sNIg==
X-Forwarded-Encrypted: i=1; AFNElJ/18gnC8lMN35lWVxumGgX3WVNxeBtu4H3kRWqCL7q4eCzV6B9l+L49J0sgH7N2qbFy2XL9v3onDry9NA4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyDsID+piTUjxx30RG7nVClcqb1bchtFcfBbF0gfpERsgx4IlH4
	FW5ssfC8tJSYGNHneDPu2lT3pcd+e/tYOjEUbQlimznqmbKNczmaPYSE
X-Gm-Gg: AeBDies+IOdlBxvbmyyO+/87hilr+Qd7xiVUbTRr5UFZdAzrgfrytYQO1PCt/MnDqaV
	2urnuQwtvQ1as/mYFUnLF2X0f3BPa7GVRUllYg1vxuWwyPwyMaoMTo7JYQ9TAP/7TVPXT0of6d3
	9jlyTAZV43fIkqB3EXemX3L68Ltii71eEeIxAecRd9XdPC8VBptvyIC/rQ47RxgRIBMz6fGViXy
	FXTVj/j0zpHk6gQWS/vHx8L5LIGUGaqSN2v6QzZhUfq5Wd3qFkbyAtjR7jjPFrbC2+MZT0WrH56
	6zNYplxcRBOdu++lj5l52PQy+IS2r9jIYozVq9Y4t3Ho3V3+nYvSGH2gYRWduB0TXErGx0kWOLH
	rP0aHHP41chkvGndoC1AGc3bO3NSFIRppJLsxN15pzt/Qp8gdlS9qfH5PNXlJ+hbUb/QBvryUW+
	6hRjQ2TFzXr9XbhMA3h5BnyBdvdFQZjcXWAgRTN84/YhUN2FcjWwEbyPCHUd5omn+dpzpUJtuhy
	fx8qAT24msZBCI=
X-Received: by 2002:a17:90b:1809:b0:359:15c8:e8e1 with SMTP id 98e67ed59e1d1-361404a8241mr39217733a91.25.1777193936535;
        Sun, 26 Apr 2026 01:58:56 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm27718937a91.3.2026.04.26.01.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 01:58:56 -0700 (PDT)
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
Cc: Link Mauve <linkmauve@linkmauve.fr>
Subject: [PATCH V14 6/7] rust: Add PowerPC support
Date: Sun, 26 Apr 2026 14:27:24 +0530
Message-ID: <20260426085725.2090827-7-mkchauras@gmail.com>
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
index 9aa18cff2fae..03926a451bac 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -399,13 +399,15 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
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


