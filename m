Return-Path: <linuxppc-dev+bounces-21213-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04862CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 06:48:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL2DP5D9nz2yR5;
	Wed, 20 May 2026 16:48:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779259685;
	cv=none; b=QdUgJbl319EQ9MTTu8ADIr1QhJGU61h/rkXnEUgXoQ22Usz7yTzNFuzcQujYCjvwY2Bim7O94MeVQ++SkaMGZGWTjSCpjPnMf5xhmsgQi1CBrutxl4OC4u4mIXADvx61TiueDVOtYkAZhVibIg61GkDMUon88AxIthUbEa9O07neRx9Iyzoot+gJt/Xh1lei9KVgO0nQeTFjoCajltKmlI/UBddJJuP8uZTFjjWRz4XADJE2Gp4Lg5h2y0sjfAyM9+/8PqMtWD4vN9wPFad/64H93JiZWVO29oT+eqeUEIARYBVAlZy27nlAtDe7wVywdnxQWlO9BX/6BGB0eGl+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779259685; c=relaxed/relaxed;
	bh=lh45/E2QV0l24qGJ1aJPt1vt91dvBjOv4kmA2J8HuiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3vk/CQ5yo0UI1LyEBOsN+8VSXCzC95fpNyiHUZQJqhL8MSAR4ZdJyc0Ji+FJQSiAp7o/cLQVJv33gU7AfMZIQTNvPhsavcmaZ9Pf4d0q4JLE8VrsYDGfjnGTxxXGq8YrQL0ecKw6Z/WgsptfY7Ytrb4VevENHfmiXlfD0t2GdRk9jveUFTJ8IivWNC2f4Irr78Nd3KyihL/mgYFblNQFf44U2aBbo1EX5DufWAt9m7bAn4wA97yR41A+AyPTQoGj4mlGCltZbWLRqb3YsaFoZClz1jKdqZAgOoS2XrWDqJ1A4pShoRe2eP495VcZV8dqg05Mwc7Pe6c+OziU0KhtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ah8s9ZZj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ah8s9ZZj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL2DP0b9Xz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 16:48:04 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-369742178f8so2704748a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 23:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779259683; x=1779864483; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lh45/E2QV0l24qGJ1aJPt1vt91dvBjOv4kmA2J8HuiM=;
        b=ah8s9ZZjIIJybOxGHsbCV8VtqqPdhcx4DypQFw8JJ34tXX9jPtZhdUmTmpm5vzg8BA
         VG/ekgLr6voXbYDhDssf6mTVo6bLBeDQ4DLMkuuSh86CmJd06Hvrf6QomtYHe951UxOC
         2cNixvcZpsat4tbfeOtOul3BqrehPT/5MoXwUaqmU1Ofa8fkzS/y6ptxWBqdNAtx0u2n
         1ZRkjr4na8gh7csi5bJQZ/JFWE1Xw0rPFwZK9bTGuNLCFtl50eCjWw6BEekOsYNR1pZl
         iEaN38+PMFUfG7DqpiMUBI3Qvgadm5luYGZPZT24qsUaif4KT/w/5YTvkF/nbOxS1V6l
         rGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779259683; x=1779864483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lh45/E2QV0l24qGJ1aJPt1vt91dvBjOv4kmA2J8HuiM=;
        b=qER0CpNPOnmAA3YElVTueFV07Jy60eC65pS/0JP2fYWTGRarqFzVK0x0sgj66H/bh1
         AsJXCUePWXu+cWgg+eQAW8Uc1DLBHYCpvrmul3Yoj+vuvthFXb1kduA52FudGl2+jIEk
         Iw8eOEh6Bkg/kvdpL+NpP9pqKXVUZ/qhQALa4X/4VRl8xO5VUBPY0LZ2Og5gThF/U8O5
         uN/pYiTXNn5sPvcq1+ipbp9p01TZt4GRVlf84c2Ps17lozkAu6NuEz6Z+nGR748ApOyO
         YazbHCiykzqANMpYRhRSmKLiLdTzLVnpflNOGZZj1Cy+lotW1+x2tt615U8zZO6xTp6g
         O9OA==
X-Forwarded-Encrypted: i=1; AFNElJ8v/s6G4TZREdGkN7gm0lhBXNLFqLrEMIkAWylndSpGrTH+13U3izmGwT+EukAkGvuUPk25b2tTZ9AaZ1s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzgWXRZbP3ZSEXc4UEq0d7jA5bFq0hkaFXe5w1/nCBSJ0T+rksu
	t0Vf8iprgssTveq+WCbl9jwvV/x5jsRH2Ynf0NWC7zIU0CmHfYvqWPTZ
X-Gm-Gg: Acq92OFQDIvzeijicEctlTQ7pEFkqUY0qx/jyOHcKvKz6bNgZEIzC5suvnmsqpdE13I
	ED1fyY8VhnO9jHvsR+Kv8v+X0l1sIj9GpeU3mimOy6S+WjIIrtplQR7wxZfxMa/BdwiIPoqHS6Y
	QygSRmSvOHmFrR08l8Qqw0n/zkyWqbV91Wef4A0xXwN3EP9qyNLLSoXHlmYvkt9XJZsPfPzx5ph
	Y7x1FcaWsbJf8cMzxG1LEJ6lg+A5+rxs7oxLdsxgawmNdvTFF0KVt/39bLtCmJfSNKBx8Hos1wA
	nCQ8aYc4zoKgXQYIvCm57gZLSAuQeM9cJHznoBlFevWw9zDoZafCtIu3oyIRDR7gwX7ZR2HwYzl
	k6ZT0SYNVEdAwtguqsraiq9O9ECLZhEsoNYHHbnFrG9vhv4cO3mlB16RL6FSuUwUHpXelgi4FKE
	7MOH5RXJ6xE4YIbcb+yYOzMc2dET8MqEPNmNoa5rETRhQf32VngkHi3WnIcDsKjpV0AscWrB/hg
	CDI
X-Received: by 2002:a17:90a:d44b:b0:35d:a3b4:2f0d with SMTP id 98e67ed59e1d1-369518b00d8mr22980948a91.6.1779259683204;
        Tue, 19 May 2026 23:48:03 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a0e93e0sm6069970a91.10.2026.05.19.23.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:48:02 -0700 (PDT)
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
	acourbot@nvidia.com,
	fujita.tomonori@gmail.com,
	gregkh@linuxfoundation.org,
	prafulrai522@gmail.com,
	tamird@kernel.org,
	kees@kernel.org,
	mkchauras@gmail.com,
	lyude@redhat.com,
	airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Link Mauve <linkmauve@linkmauve.fr>
Subject: [PATCH V16 6/7] rust: Add PowerPC support
Date: Wed, 20 May 2026 12:16:28 +0530
Message-ID: <20260520064630.1785283-7-mkchauras@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520064630.1785283-1-mkchauras@gmail.com>
References: <20260520064630.1785283-1-mkchauras@gmail.com>
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
index 8ce4fa0e5e57..d9485f5e95e6 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -400,7 +400,8 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fstrict-flex-arrays=% -fmin-function-alignment=% \
 	-fzero-init-padding-bits=% -mno-fdpic \
 	-fdiagnostics-show-context -fdiagnostics-show-context=% \
-	--param=% --param asan-% -fno-isolate-erroneous-paths-dereference
+	--param=% --param asan-% -fno-isolate-erroneous-paths-dereference \
+	-ffixed-r2 -mmultiple -mno-readonly-in-sdata
 
 # Derived from `scripts/Makefile.clang`.
 BINDGEN_TARGET_x86	:= x86_64-linux-gnu
@@ -409,6 +410,7 @@ BINDGEN_TARGET_arm	:= arm-linux-gnueabi
 BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
 # This is only for i386 UM builds, which need the 32-bit target not -m32
 BINDGEN_TARGET_i386	:= i386-linux-gnu
+BINDGEN_TARGET_powerpc	:= powerpc-linux-gnu
 BINDGEN_TARGET_um	:= $(BINDGEN_TARGET_$(SUBARCH))
 BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 
-- 
2.54.0


