Return-Path: <linuxppc-dev+bounces-20163-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13D8FF8860
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 12:28:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g42tB51nHz2y7r;
	Mon, 27 Apr 2026 22:28:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777292930;
	cv=none; b=A+oE7YSJxv1ZyKe/Zd+2i2kN+65BwBcgWdc0eYBTLRA5inovxDGuGzMh+D7hOjyiV6fPuVfXqEzuuYfenZ8riS9OBilpAYseulVHEC+iYkfa7WnsLgY2OUIvEGmNmRz3f6WAUTPtQIbbCqSscQJEmQVacsRiDPuhEdeR/gqPV65o2KwdVU/HgfWOZTZwN9DuOqm8dA87v2JJQRXaYbKNGh2XJtXJ23AZ9aUNKzxqyxg+E6Gj3u4GarLfSmCTbaAWP0xEpTksGiRWGDDjBnXib+MHkDY8txsuFwCuYCTZ/D3k2P6WzjRMN2mJBYKAapz00hmuS18UF4cKRWk4NdbGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777292930; c=relaxed/relaxed;
	bh=Prf45VRePEkbJ9bJmHgdAkS/+1uEQpgga1mrG9S2bCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kus5FbDA7DRBlgYZfcn/ezqMts23U33XLBz0+cU5L2fsCvJm9jRg0QccjdBwGxzcf1YaBpI5hAQ9bO2hUe5FIcv/zFBOse40dHPld7SFCBO0SYmyaPdwAdj7JeptwUFV250ubHIXujHFFqn+Rt4w3CkBw42hZm1f/hBCBxGADCcBLWUyPM5zsDZC2JNso5yZjN67E1apBoemi4YUBQ0Fv/JDXTJEhMSQeRr+rUga893pKRVipziPSviGXAgSGLw9t98xzqVAUq6z7MRjw5niwwkoDXeeAZRcH7/BmzXO47k8mXPOiAIOTzVWCpRIrABPa8XKDMQS+HdPvgnKQiyzLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y+VYFkhm; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y+VYFkhm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g42t96p13z2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 22:28:49 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-827270d50d4so9088439b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 05:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777292928; x=1777897728; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Prf45VRePEkbJ9bJmHgdAkS/+1uEQpgga1mrG9S2bCY=;
        b=Y+VYFkhmjWyfnf1XDZ4V+l3hrq0n97G6JUbugGcYtT683gyvyFdknIT3oLTKY0h+Tp
         GzdJLwdHvWfXvew6MZoDkp+T/4zhxg5B1+ddZWphxmhhpBzBZqna7ZN0T57hrBxyO0A+
         xQo+5a8jrpfz0WlioBP8uZJVUd+gGf4yUaflQdBkRrMFhr5yw442R4Tjz2sj/acBUT9X
         flZY4xDLezewhSc1jvFG17fV2GfQQMbQSXGJTt3NYdLuJpBxKjRYv9AtYisR6lXmxLmx
         mHsd0Oy7ZwUi2giItoDQjzX97ZCOmxPGpgXRadY4PqemhnNnoGfsQ9tf5FGpZPzlGAPX
         90rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777292928; x=1777897728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Prf45VRePEkbJ9bJmHgdAkS/+1uEQpgga1mrG9S2bCY=;
        b=WmUFCN/WMdz67Qe8/YJ2eg6BV3395RDbu5lJ9doM3RwoTn+WjlKj10It4dRY9Qendu
         GMPJKocD8NlBzzMjueFi1cjdfH3HhjtRMWDDbjtyb1a/uKocHvAB3VQqSUDyvEwBc6oO
         5hqnb8hEuMK5rCXnTLttjAPf3HPlw737yDkMgpz2JoJIl8FG+aw7VnKEDPo3L7NuX7ws
         QoNy1bnHYcXs0IQ/uaYSkwUYz5qKlu9ZdM2Dr1GSqWh6mwHAu+0rCnpNDgaqk9bw9wC+
         rkf4srkl9Bb8vHUaj1on4puAaKxfRzowO17vwQOSLgnz3zeAX7NrmMiIxq+UUy582NtV
         vFtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Cj2LdC0HLz2wLUnrKTrCeHHinTIOQFTexeKtSopVu5NDPZIGUqAp1c9c1owgooR/uLdoLyOEd4SD+5eA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxx/mXIZk/ajbA2TLpbGdNJWq292wgbJVvi9WVDAUvpSunPSdxE
	2TMXszkjr05tNRicfGpofCAdarnXOsnrGKVNmHtJFuYYcgn7/cGECH2w
X-Gm-Gg: AeBDiesWn3ePnd8w2YTB/QJow/0PUv8rFVEPsFs8OA2Vohq9n647pVzq2hr57mk1Bq3
	vWUMvsSUfykokYbDpNoLkteYWU3b6pXpIiLfo6nFOJ2vtJit/iOd6/bKNiSaIUGA2KIpXLOYvGf
	IoX0y6LSXStZgqFLAzG5fkJShERbygVi46wJ20KEd8trMBSez4qcSHVEQSxdeH0qSxUYn0fRbne
	pYaq9DgkWwNJLKETe4jcsxF9HFyGHReJEA3Qt16xAnM59SrJaEB7hNJX7yZ0V8ygtZ6UW60qfXq
	WuWhZqxxYPc8QjKmH98eX7WIwsMbG9j4m7iqtTEveMcCzEULmx1KvSp4JcvCg6GCBvzJO+ED5X+
	gdW1anM5YMOQlR8ukppiuMmMmRpPz2AYFxN4DEjkHZrM7iyULj+b4e5TdkJjDHWc7ZyvD+RZnb2
	WfYXaogEJ5k+Wi2K7oVGWq5ls58isWvYmlQ7VcxxHqEi9xinoJTNK+tu2cqJFQ2Rt2I1TU8A9z+
	hDpGj0R7qq034dC
X-Received: by 2002:a05:6a00:8b0f:b0:82f:c1b4:8ba2 with SMTP id d2e1a72fcca58-82fc1b4931emr20643060b3a.47.1777292928001;
        Mon, 27 Apr 2026 05:28:48 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9f7735sm32733466b3a.21.2026.04.27.05.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:28:47 -0700 (PDT)
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
Subject: [PATCH v5 4/8] powerpc: Introduce syscall exit arch functions
Date: Mon, 27 Apr 2026 17:57:38 +0530
Message-ID: <20260427122742.210074-5-mkchauras@gmail.com>
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

Add PowerPC-specific implementations of the generic syscall exit hooks
used by the generic entry/exit framework:

 - arch_exit_to_user_mode_work_prepare()
 - arch_exit_to_user_mode_work()

These helpers handle user state restoration when returning from the
kernel to userspace, including FPU/VMX/VSX state, transactional memory,
KUAP restore, and per-CPU accounting.

Additionally, move check_return_regs_valid() from interrupt.c to
interrupt.h so it can be shared by the new entry/exit logic.

No functional change is intended with this patch.

Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Tested-by: Samir M <samir@linux.ibm.com>
Tested-by: David Gow <davidgow@google.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/include/asm/entry-common.h | 49 +++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index 837a7e020e82..ff0625e04778 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -6,6 +6,7 @@
 #include <asm/cputime.h>
 #include <asm/interrupt.h>
 #include <asm/stacktrace.h>
+#include <asm/switch_to.h>
 #include <asm/tm.h>
 
 static __always_inline void booke_load_dbcr0(void)
@@ -123,4 +124,52 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
 
 #define arch_enter_from_user_mode arch_enter_from_user_mode
 
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work)
+{
+	unsigned long mathflags;
+
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && IS_ENABLED(CONFIG_PPC_FPU)) {
+		if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
+		    unlikely((ti_work & _TIF_RESTORE_TM))) {
+			restore_tm_state(regs);
+		} else {
+			mathflags = MSR_FP;
+
+			if (cpu_has_feature(CPU_FTR_VSX))
+				mathflags |= MSR_VEC | MSR_VSX;
+			else if (cpu_has_feature(CPU_FTR_ALTIVEC))
+				mathflags |= MSR_VEC;
+
+			/*
+			 * If userspace MSR has all available FP bits set,
+			 * then they are live and no need to restore. If not,
+			 * it means the regs were given up and restore_math
+			 * may decide to restore them (to avoid taking an FP
+			 * fault).
+			 */
+			if ((regs->msr & mathflags) != mathflags)
+				restore_math(regs);
+		}
+	}
+
+	check_return_regs_valid(regs);
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	local_paca->tm_scratch = regs->msr;
+#endif
+	/* Restore user access locks last */
+	kuap_user_restore(regs);
+}
+
+#define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
+
+static __always_inline void arch_exit_to_user_mode(void)
+{
+	booke_load_dbcr0();
+
+	account_cpu_user_exit();
+}
+
+#define arch_exit_to_user_mode arch_exit_to_user_mode
+
 #endif /* _ASM_PPC_ENTRY_COMMON_H */
-- 
2.53.0


