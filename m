Return-Path: <linuxppc-dev+bounces-19837-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1BEF436B8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 15:23:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxzDs5hdVz2yh4;
	Sat, 18 Apr 2026 01:23:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776439437;
	cv=none; b=hNRbvJ6iRiqJIlB7W8m55Bd+Qg4Gaq5NJlo1/dByQP61ru6yE1hMfiPmlNX75Lx07HYJPvPCELAA8kMkPwGxhooTtOe+8kln1eEtlaHtyNEIhxE3m4UcfjDEuxnkFpkJrLsm/LtOZ5tsY4PjbhRn1dg0LHtc6W5wmyZ7BoJi7KRjWRu+XsyJ/UFXk1A9MdeAs+3HB95KQETH1DFLNLfxXMX4JYhJeZ5W9WDfBrw00As22UFOZh4NfUGVh48HiHbROfgqJvCS2Jycf+6uTBW9jFKbLtHz7NpGVXcPIpwVpiIrSAiw/vIiB9k7verH6C/o75QEWyTjipub+lg86b8qfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776439437; c=relaxed/relaxed;
	bh=ww02/jkdVLSyp8HOStmgEIcppt5LBeLhIRfQtuTFtSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MR7VmNkk0xwtuIk2afPPhK7xwARxE9oLXDJk3pJfP9OOTPnPOFUG7c67xjy+obea14IHpSqkBWl2ojXlN/bvXKp31EMf1BxHtXpvkFAtn51MubXquj2tEEHFe16ooEBQK64QE1FixZJ/u8s3QCUW232VC/tqUyXxeMOfpURNvZZGYYmY7mZvVklBD77Nx01aeTmB+q4LEMvXPRm3bjq5hy6Q1ISOBUxzauymP75oAq0dPhB3oe1z2YPq65XjmpCrgnmvboAVKvhwKW2RbWQOVSOcQuywe+cSyTE7reCoarQr5+BDdIl5HQR88n5YwREeVLnHefNMjTPbxdQ2NnIyqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O5g8F9Ze; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O5g8F9Ze;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxzDs0yrnz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2026 01:23:57 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-824c9da9928so463744b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776439435; x=1777044235; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ww02/jkdVLSyp8HOStmgEIcppt5LBeLhIRfQtuTFtSY=;
        b=O5g8F9Ze+u5tzauKkRckojVjMhlR3L1Oud2t92b5x6DLFyKR1I5r1DJuL3f5XR5exU
         ZidhFGs8nuOfyBj1AsPggInvmbuYjYotRRBS1eCLmZMu6ZYSWPP7plgfQQoORD0TGvzg
         Wg+aBZXWSKUj1DrKU/5bxgQoYo7VdTHVPnXl1suimJbyftK0ccmDUmxo6zEiLABogZrN
         Ku6Esz6mDKmg7rOJatLllvwFyTzo0RX/oYof16rLymTAY9mmsDXF4KSKlHz/eW2j2w2/
         iIGg/2ARkaS01q6DdzZGOZotv+UsutUwBoBLOT2c0JySXzeR5xjl0TRWMgYPtuRdXn8g
         1SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776439435; x=1777044235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ww02/jkdVLSyp8HOStmgEIcppt5LBeLhIRfQtuTFtSY=;
        b=h7y5LFOGZX6kMoLzcUExJYvWcUqChq04O1ZaNZLoStIK9FlsI2G50+Z6MzV6Z9QJus
         clVl+e57bn8DprsH8QZm6QZeyNZrhlEl0Et3zkRAb8N2LbgeZ36KfsRoeJtjUvqNd/mo
         dC7GVAM78YtDHEz5ZyYcJCqS4zwTAcXsdm5MAhnAb3Su0NmwOJZOWnPqJbpCu6F59sAG
         aL21F54pRvnaOYp4oSRxLV2lcyGo/tOaS/JNA+UWtBq+VcvV7nPHQHncds+Uur0ljsvt
         SCVDEqBT88ShZooX8DsV8Kzh7/bmmcre+/1vnTrXVChR0gPOfKtVKhTOIHEaRCSAD8VA
         EFTw==
X-Forwarded-Encrypted: i=1; AFNElJ92VeCKs7RmAmFXcwKPi7+BqbFZS8ximHhiI2YMM+KSzybzuq66pob8yaTpNGuhSeJc2qJVaYQwSd11T7Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxz2/ywm8CaJJ5W7LHz2rVlnNvk52TQID0k80h0uFNKLev9rdto
	SCZrkvdkcQGNe3FRORtGxshZ1g5DSF8X4mnv/2p3AIOiqz8oWx2Dqp2t
X-Gm-Gg: AeBDieukFgKscv+PAonB0ff2uq4S3KNYTyT7n58uOePSk/1hAWJteYgum45EhRQJ3rn
	KPlbOrn4hRZ1ukOOjdSkfqlgSs185D+XIN2NtZrNnUeLzUPEBNyL7YhHP6U3zHuWJaaR0S/Rztk
	bStEx+PKuJuJS5njjwEG2y8JAMJPnfRYYfKi01r6DLM6KYUU/ZqFQQPLnICLRsJkImLMYjx+BDh
	KQyKqM6o8UaVQoVFoRSeziKfLziyvyA8buBTBXM8oleNcl3rhWTfhUsk3G2sewWCE/qujF70QtJ
	qko0aA2vA9B+1yqGMAJC2/o99wqne+tHYFVTp3vr6Ckea0+q4xhWonr8rZJ9az7lc9EZ7mDCVKt
	TZTQ2qf5l3dCNlL06uur/whP2nVIaBobsv4e6tFXalQRAWakPcnsXFJ5AyrCHxDV+9NEbRXmWjC
	mQz9A28ER9ZDx10OR2WDyQsBnNj9LS5GqMfduiuTwAR6XG4Rz21708OFo0PDnUjxKjQLFE1kga0
	RVa5zndwKPnws4=
X-Received: by 2002:a05:6a00:a883:b0:82c:e09b:3f76 with SMTP id d2e1a72fcca58-82f8c9b6728mr3532095b3a.41.1776439435073;
        Fri, 17 Apr 2026 08:23:55 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb3829sm2384373b3a.31.2026.04.17.08.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:23:54 -0700 (PDT)
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
Subject: [PATCH V11 3/4] rust: Add PowerPC support
Date: Fri, 17 Apr 2026 20:52:52 +0530
Message-ID: <20260417152253.2312961-4-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417152253.2312961-1-mkchauras@gmail.com>
References: <20260417152253.2312961-1-mkchauras@gmail.com>
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
index e234b8a39358..af0c8ab2e5b6 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -406,13 +406,15 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
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


