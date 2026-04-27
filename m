Return-Path: <linuxppc-dev+bounces-20164-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F053FF8860
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 12:29:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g42tR25DQz2ygY;
	Mon, 27 Apr 2026 22:29:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777292943;
	cv=none; b=AhsYhosIBLm9f5Yk7YNJleJa2kGsVURaP34+ycVhhHIzN7g1LNy/88WXztaNGJSfdd/sG5D6N5koHlu/TNUFcY67DDUsePsvpBvpy/EOHJLemV9Qr8DI4GG9Vx2HWaFjp9bkyMcppCbw5mep0iyxwj+5BjZkfP8ZFCkX1KR5G8aA+r5nutUAJcibNuR/wINg+wB9dFw8daLAGGVoba/856Z4Y6zJpwBI6sJkepeqgJjR1OHtUTe59yLhc0E+D7l9qkGrpXONXbHYeM92oQFFs0G/rI6RQ92dAi+u2lsLUqyxf/Rw1f09UrTYiVp6Epkvcou3rZuFJOhKHjBZ/VfEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777292943; c=relaxed/relaxed;
	bh=Adw8Ukg8Z1VgthZeBUplRBYQ4WVreFSnBBYdxTE8gIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GnO+x/5fWzXYB5sY4ESC4StZK3WnFWWMpdO8Xv7JVw1rzpY/OyhG6lDxNhspFlA8JoIvbRqLuIAZUiXrlD05Pla9T8DPQYyU3Cb/2VZauo8J7o/SOfbYF6pD6hKHlcFWNXEUwE6GW3EFxe9VXutmqaZiYRH1Mq18q3j/A1gBk+Hk/zQshUzwYiPl7DQpG2HTe9sMEm5OFf1VUrV8UJxSJq4JNH7UCXBh4nVJk8GEaFQ3QL3WGW5ykxmpcYgBfwJ5s/VHSQgRQbOI5+xCutIHlq38mmRNlyKZJb6Zg5j80a+XC+mC4ny5BrFXfp5vL32pdnUipWWgdoqwFi5gW6ROjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VrJvvZj9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VrJvvZj9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g42tQ4W66z2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 22:29:02 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-83178c0f29cso2788309b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777292940; x=1777897740; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Adw8Ukg8Z1VgthZeBUplRBYQ4WVreFSnBBYdxTE8gIg=;
        b=VrJvvZj9P2t81KvDAp/87J1iQbOUKfYC8h6srM892N1FwajY34Sg+sZc1EiDcdbfhm
         rFQ5IWt3pV2ddHxvSXV+ikAX10ELWg/HfMKZfB5roF6pGbpF8TLtMJ+O84CD54hbLACD
         q0++LTaY4aakf1mFUOu8sq9Mk6cc2IsL1A1sIqMkxT7Clf3gCOmz2ToBipVG/x8Cj+XX
         hc813jfG89BwYFezePny+YZIP7OM9r1rl7eJlp3IJJueIhEy4HsGQwqXD5xrPjGz54Fh
         swe1wnLenp2HOq+eS52F2VpowP/u0cMxJZUdGiUL/60Ha0eArEAijwF7hGiTx3NBYdDW
         CCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777292940; x=1777897740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Adw8Ukg8Z1VgthZeBUplRBYQ4WVreFSnBBYdxTE8gIg=;
        b=mIuX9qPupIbgeYGGPQZplpoRV4zUVzJExfaO4polvhz/ckEzZYmRQoTQpQfXSLaTRu
         Uupv6DxBGRXCHIhz527nAiejyhJkEGWdJdZcXGBnqm7gL7bydcBbnH1DIm5dv+OS928k
         4MAbQIuhnmkaHzjIHoD5nNQ32Mq73uMXczptDqYC3lDyRJ7E0CrAqRiQM9f5UbF2Wt0g
         b7Ue6I/KTY/0VtpiyUQaBiShHMLG9LjCwCgYfwEPUeYKo4/EltKqfsg7dRtGv6dwSMZa
         7TYyvaOV2NXcW/mv/Iqub8nVaMS9h8OrlY1BbkE1y0VSyb8v1RkqTXjNImyzSvL3pWEf
         E1NA==
X-Forwarded-Encrypted: i=1; AFNElJ+nohbbxe032yj+1y0DrW5shkDX33ticaMD5JrcEpL0QhF5PSvMYBveSYuarRFRWRVyVYxTKHBAZws3cmQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzh1mYdWVEP5oQF9PxKrkqp5evRiLTxbINts1uIs4m0eDQ6PNrf
	GAf2Lg39zgYVrWPSW0jVqBa6+jx1Ei5owZSGU6bzRMGlpJ+Rg5gBfqzC
X-Gm-Gg: AeBDievylCb3KEWB7/nCnvj9TJ6Nbd99k0pKoLKmpTEBJ9j/UdTNy17Ne/TE6pRoHdi
	yYaiJNBswJA8sSnWJ25Goz/ULe9GPECiaTiZhM6IMs1CxOpec+ft/stTEPISSJYFOwQT8TN/ApM
	BUODCwyEZDwIz9XJBrjavv3Vy8D7XhmYthUYKvCk6YZDNEfq43UHUaCaII6GIELCeJ/lmEbBszV
	QakXeRILH3X0k7Ahw8Oa8DNy+jq5/p32qc2DpHwvtRg5dkOdBBPsrRle+Xam81+Swv1QQJUwRmv
	tJOQBbyqcaNxiEza3Y1fKmyQqHGD9qRw190Y83hz7qfagJn3U1PB+UR+SMrT/8ndZZTX91hW0PP
	PeoIv+6bXATlq3GD5C+uf1uQIYS7tmKjpF4LmT2gZH2lQ/KPndBXNZP0CMmeAFOJvp2Lqj+vID7
	1uJWXBKo1MHlhP+MxaCil1p6jqEnPUOOYi7Oh4QIaDPadY5DWQV7wsRyDZ4MVsQ9wl3YM0+AB0E
	KKzSQ==
X-Received: by 2002:a05:6a00:cc1:b0:82c:2555:b9b2 with SMTP id d2e1a72fcca58-82f8c7db2b1mr47085497b3a.10.1777292940292;
        Mon, 27 Apr 2026 05:29:00 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9f7735sm32733466b3a.21.2026.04.27.05.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:29:00 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	oleg@redhat.com,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	mchauras@linux.ibm.com,
	sshegde@linux.ibm.com,
	thuth@redhat.com,
	ruanjinjie@huawei.com,
	akpm@linux-foundation.org,
	macro@orcam.me.uk,
	ldv@strace.io,
	charlie@rivosinc.com,
	deller@gmx.de,
	kevin.brodsky@arm.com,
	ritesh.list@gmail.com,
	yeoreum.yun@arm.com,
	agordeev@linux.ibm.com,
	segher@kernel.crashing.org,
	mark.rutland@arm.com,
	ryan.roberts@arm.com,
	pmladek@suse.com,
	feng.tang@linux.alibaba.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com
Cc: Samir M <samir@linux.ibm.com>,
	David Gow <davidgow@google.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH v5 5/8] powerpc: add exit_flags field in pt_regs
Date: Mon, 27 Apr 2026 17:57:39 +0530
Message-ID: <20260427122742.210074-6-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427122742.210074-1-mkchauras@gmail.com>
References: <20260427122742.210074-1-mkchauras@gmail.com>
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
Content-Transfer-Encoding: 8bit

From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>

Add a new field `exit_flags` in the pt_regs structure. This field will hold
the flags set during interrupt or syscall execution that are required during
exit to user mode.

Specifically, the `TIF_RESTOREALL` flag, stored in this field, helps the
exit routine determine if any NVGPRs were modified and need to be restored
before returning to userspace.

This addition ensures a clean and architecture-specific mechanism to track
per-syscall or per-interrupt state transitions related to register restore.

Changes:
 - Add `exit_flags` and `__pt_regs_pad` to maintain 16-byte stack alignment
 - Update asm-offsets.c and ptrace.c for offset and validation
 - Update PT_* constants in uapi header to reflect the new layout

Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Tested-by: Samir M <samir@linux.ibm.com>
Tested-by: David Gow <davidgow@google.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/include/asm/ptrace.h      |  3 +++
 arch/powerpc/include/uapi/asm/ptrace.h | 14 +++++++++-----
 arch/powerpc/kernel/ptrace/ptrace.c    |  1 +
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 94aa1de2b06e..2e741ea57b80 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -53,6 +53,9 @@ struct pt_regs
 				unsigned long esr;
 			};
 			unsigned long result;
+			unsigned long exit_flags;
+			/* Maintain 16 byte interrupt stack alignment */
+			unsigned long __pt_regs_pad[3];
 		};
 	};
 #if defined(CONFIG_PPC64) || defined(CONFIG_PPC_KUAP)
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index 01e630149d48..a393b7f2760a 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -55,6 +55,8 @@ struct pt_regs
 	unsigned long dar;		/* Fault registers */
 	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
 	unsigned long result;		/* Result of a system call */
+	unsigned long exit_flags;	/* System call exit flags */
+	unsigned long __pt_regs_pad[3];	/* Maintain 16 byte interrupt stack alignment */
 };
 
 #endif /* __ASSEMBLER__ */
@@ -114,10 +116,12 @@ struct pt_regs
 #define PT_DAR	41
 #define PT_DSISR 42
 #define PT_RESULT 43
-#define PT_DSCR 44
-#define PT_REGS_COUNT 44
+#define PT_EXIT_FLAGS 44
+#define PT_PAD 47 /* 3 times */
+#define PT_DSCR 48
+#define PT_REGS_COUNT 48
 
-#define PT_FPR0	48	/* each FP reg occupies 2 slots in this space */
+#define PT_FPR0	(PT_REGS_COUNT + 4)	/* each FP reg occupies 2 slots in this space */
 
 #ifndef __powerpc64__
 
@@ -129,7 +133,7 @@ struct pt_regs
 #define PT_FPSCR (PT_FPR0 + 32)	/* each FP reg occupies 1 slot in 64-bit space */
 
 
-#define PT_VR0 82	/* each Vector reg occupies 2 slots in 64-bit */
+#define PT_VR0	(PT_FPSCR + 2)	/* <82> each Vector reg occupies 2 slots in 64-bit */
 #define PT_VSCR (PT_VR0 + 32*2 + 1)
 #define PT_VRSAVE (PT_VR0 + 33*2)
 
@@ -137,7 +141,7 @@ struct pt_regs
 /*
  * Only store first 32 VSRs here. The second 32 VSRs in VR0-31
  */
-#define PT_VSR0 150	/* each VSR reg occupies 2 slots in 64-bit */
+#define PT_VSR0	(PT_VRSAVE + 2)	/* each VSR reg occupies 2 slots in 64-bit */
 #define PT_VSR31 (PT_VSR0 + 2*31)
 #endif /* __powerpc64__ */
 
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index c6997df63287..2134b6d155ff 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -432,6 +432,7 @@ void __init pt_regs_check(void)
 	CHECK_REG(PT_DAR, dar);
 	CHECK_REG(PT_DSISR, dsisr);
 	CHECK_REG(PT_RESULT, result);
+	CHECK_REG(PT_EXIT_FLAGS, exit_flags);
 	#undef CHECK_REG
 
 	BUILD_BUG_ON(PT_REGS_COUNT != sizeof(struct user_pt_regs) / sizeof(unsigned long));
-- 
2.53.0


