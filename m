Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2279CC07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 06:26:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9152420838
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 06:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cnKqAAjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9152420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43B2YH5QNQzDqxH
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 17:26:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cnKqAAjP";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="cnKqAAjP"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43B2FG1qjszDrf7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 17:12:34 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id t13so1319226ply.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 22:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=O2M3lHo2o6XYI5wC/7SaWlJ8PncIq3R9Hnh0sXXFTvk=;
 b=cnKqAAjP9jlcqhK6twsk51NnWoOU1mUU3AlEKlOGoX96vdmfeoQGwkb2BbHX9pgjI5
 WDfCkFh8PRfUHQrpz54MaqzDVovc3snXdLFEUR9/wWP36UKcNgJs6CnqNN7jG0xtISGB
 dC+QNUMl0vMjOX8U9s0Mq7q4f2RU+LoNtWnF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=O2M3lHo2o6XYI5wC/7SaWlJ8PncIq3R9Hnh0sXXFTvk=;
 b=WeRR7iDSefMuQ0JRgF/E6h01FCNi3+ANBJzOZmvDRvwMyuVVITn0x0Ar//mRn9LrtI
 I2eO3lN5VIwJCUGrb8acwZ//cnHGMlAyrNfzw92vcfydaQF1a/9Bk2Vmhe359PQkf/Uy
 5HhVq54bguOHzJqiyOwcOSEd/R/5x4TI25rUUjyxkw4XT74UHS642YNsVReeTv8AV5fd
 rqd4yDwvcDJZvJS8ZZ+Owrf4qaOObZ+omGgdQYGBEL+0VrUTRDDuPLrSPgMMK9DG+uxH
 LGWvGBCXriF8GcSXeQLpx1XnYWQPfZHKdYvV7L90cwXUpAhz0wmhMrX3OMYo+GqBeobM
 AkHw==
X-Gm-Message-State: AA+aEWbZgET/QeNzN2c1dhZjDOaIVgugrXDpFtYrd3OvXS9eTlCrA/0P
 rfEbc4/WF+7LOF9UPDYvDGSeXUsQrPM=
X-Google-Smtp-Source: AFSGD/U7KXOPNgEZ4stindDXT0VzsqzBQDeAbU7ZNLspO3NYrzHO7zhVDZ42SCiUbL8qbIHakiFWOw==
X-Received: by 2002:a17:902:583:: with SMTP id f3mr993058plf.202.1544163152372; 
 Thu, 06 Dec 2018 22:12:32 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.25])
 by smtp.gmail.com with ESMTPSA id r4sm5719862pgn.54.2018.12.06.22.12.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 06 Dec 2018 22:12:31 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Ram Pai <linuxram@us.ibm.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Breno Leitao <leitao@debian.org>, Boqun Feng <boqun.feng@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH v4 4/5] powerpc: split compat syscall table out from native
 table
Date: Fri,  7 Dec 2018 11:41:39 +0530
Message-Id: <1544163100-15510-5-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
References: <1544163100-15510-1-git-send-email-firoz.khan@linaro.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
 linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org,
 firoz.khan@linaro.org, deepa.kernel@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PowerPC uses a syscall table with native and compat calls
interleaved, which is a slightly simpler way to define two
matching tables.

As we move to having the tables generated, that advantage
is no longer important, but the interleaved table gets in
the way of using the same scripts as on the other archit-
ectures.

Split out a new compat_sys_call_table symbol that contains
all the compat calls, and leave the main table for the nat-
ive calls, to more closely match the method we use every-
where else.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/powerpc/include/asm/syscall.h |  3 +--
 arch/powerpc/kernel/entry_64.S     |  7 +++++--
 arch/powerpc/kernel/systbl.S       | 35 ++++++++++++++++++++++++++++-------
 arch/powerpc/kernel/vdso.c         |  7 +++++--
 4 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index ab9f3f0..1a0e7a8 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -18,9 +18,8 @@
 #include <linux/thread_info.h>
 
 /* ftrace syscalls requires exporting the sys_call_table */
-#ifdef CONFIG_FTRACE_SYSCALLS
 extern const unsigned long sys_call_table[];
-#endif /* CONFIG_FTRACE_SYSCALLS */
+extern const unsigned long compat_sys_call_table[];
 
 static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
 {
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 7b1693a..5574d92 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -54,6 +54,9 @@
 SYS_CALL_TABLE:
 	.tc sys_call_table[TC],sys_call_table
 
+COMPAT_SYS_CALL_TABLE:
+	.tc compat_sys_call_table[TC],compat_sys_call_table
+
 /* This value is used to mark exception frames on the stack. */
 exception_marker:
 	.tc	ID_EXC_MARKER[TC],STACK_FRAME_REGS_MARKER
@@ -173,7 +176,7 @@ system_call:			/* label this so stack traces look sane */
 	ld	r11,SYS_CALL_TABLE@toc(2)
 	andis.	r10,r10,_TIF_32BIT@h
 	beq	15f
-	addi	r11,r11,8	/* use 32-bit syscall entries */
+	ld	r11,COMPAT_SYS_CALL_TABLE@toc(2)
 	clrldi	r3,r3,32
 	clrldi	r4,r4,32
 	clrldi	r5,r5,32
@@ -181,7 +184,7 @@ system_call:			/* label this so stack traces look sane */
 	clrldi	r7,r7,32
 	clrldi	r8,r8,32
 15:
-	slwi	r0,r0,4
+	slwi	r0,r0,3
 
 	barrier_nospec_asm
 	/*
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 9ff1913..0fa84e1 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -17,13 +17,13 @@
 #include <asm/ppc_asm.h>
 
 #ifdef CONFIG_PPC64
-#define SYSCALL(func)		.8byte	DOTSYM(sys_##func),DOTSYM(sys_##func)
-#define COMPAT_SYS(func)	.8byte	DOTSYM(sys_##func),DOTSYM(compat_sys_##func)
-#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func),DOTSYM(ppc_##func)
-#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall),DOTSYM(sys_ni_syscall)
-#define SYS32ONLY(func)		.8byte	DOTSYM(sys_ni_syscall),DOTSYM(compat_sys_##func)
-#define PPC64ONLY(func)		.8byte	DOTSYM(ppc_##func),DOTSYM(sys_ni_syscall)
-#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f),DOTSYM(f3264)
+#define SYSCALL(func)		.8byte	DOTSYM(sys_##func)
+#define COMPAT_SYS(func)	.8byte	DOTSYM(sys_##func)
+#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func)
+#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define SYS32ONLY(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define PPC64ONLY(func)		.8byte	DOTSYM(ppc_##func)
+#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f)
 #else
 #define SYSCALL(func)		.long	sys_##func
 #define COMPAT_SYS(func)	.long	sys_##func
@@ -46,6 +46,27 @@
 
 .globl sys_call_table
 sys_call_table:
+#include <asm/systbl.h>
+
+#undef SYSCALL
+#undef COMPAT_SYS
+#undef PPC_SYS
+#undef OLDSYS
+#undef SYS32ONLY
+#undef PPC64ONLY
+#undef SYSX
 
+#ifdef CONFIG_COMPAT
+#define SYSCALL(func)		.8byte	DOTSYM(sys_##func)
+#define COMPAT_SYS(func)	.8byte	DOTSYM(compat_sys_##func)
+#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func)
+#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define SYS32ONLY(func)		.8byte	DOTSYM(compat_sys_##func)
+#define PPC64ONLY(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f3264)
+
+.globl compat_sys_call_table
+compat_sys_call_table:
 #define compat_sys_sigsuspend	sys_sigsuspend
 #include <asm/systbl.h>
+#endif
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 65b3bdb..7725a97 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -671,15 +671,18 @@ static void __init vdso_setup_syscall_map(void)
 {
 	unsigned int i;
 	extern unsigned long *sys_call_table;
+#ifdef CONFIG_PPC64
+	extern unsigned long *compat_sys_call_table;
+#endif
 	extern unsigned long sys_ni_syscall;
 
 
 	for (i = 0; i < NR_syscalls; i++) {
 #ifdef CONFIG_PPC64
-		if (sys_call_table[i*2] != sys_ni_syscall)
+		if (sys_call_table[i] != sys_ni_syscall)
 			vdso_data->syscall_map_64[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
-		if (sys_call_table[i*2+1] != sys_ni_syscall)
+		if (compat_sys_call_table[i] != sys_ni_syscall)
 			vdso_data->syscall_map_32[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
 #else /* CONFIG_PPC64 */
-- 
1.9.1

