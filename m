Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0B2606A31E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BwQTlps1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8sXF4Mswz2xjv;
	Thu, 22 Oct 2026 01:45:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1234"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792593933;
	cv=none; b=eh07k7G9xL+PX378rDkySf5b26w+vIX9AX6/OBLPb9fPrzCvA+chhIZT2+A5eMYO03yvIpUswR3x1k8tu6u6Dnsn/CfnahgRRADG5gU/oZKHi+k1Dln8dooT1ZJDxr4ldA27EU65FdSgqPyA3IfssmVAQ2EpwvDYAGAHZQ8ici+2ubxJsv8S/zUYppwME8vZu3sq2W3DPYPhrTJW0TDFj0TnVub+B1ZI26jrhufemmxDvW31zU5f3XmkasZ5DGzyGas3E7kvQKG6x0ae9wPuHw3HVWSVa/iAyXRIzsyfkn3vAy/lEdDBigtrY6U7WdbmqHod0qSBK7kvp0I1F16sTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792593933; c=relaxed/relaxed;
	bh=GjBHhwWOEQdir2yWO0JK5yCpRCfdUmaiz711T6ehhgs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BdEmyoWefsGEzZZoMIbIXkh/d/rrADoyRPPzYvrMGK/KslLS+EaUmK+M34qEdRDExMJB4Eo45A6T4OmQ6RK3inTuTcXpZiU99U0oKcO8Cn1YgIxoFrjMnW4tooQLKB0M+npVaMOAEyJKF6MzeC7+Eu2e5eNmvLbM+0kY3zqPMtyYnW2UPd4Qjqm+pbXzbTYfIepVFMJZr1BjjWJDvchTkR3fezmhxOWdrMjxqho2Zhke7/c5/qo8ZXQAh1HSKhLlOCIeO59p3QZzNUL/wXNY/1Oso0G7eZcAQPiO+Pb63AD5o+oubxy5D3Fmj1qcCpyCoe5p1U+ZKGHrm/9p3KvGXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BwQTlps1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BwQTlps1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1234; helo=mail-dl1-x1234.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1234.google.com (mail-dl1-x1234.google.com [IPv6:2607:f8b0:4864:20::1234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8sXD2H3jz2xfj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 01:45:31 +1100 (AEDT)
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-1846bc43c28so112593c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2026 07:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792593929; x=1793198729; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GjBHhwWOEQdir2yWO0JK5yCpRCfdUmaiz711T6ehhgs=;
        b=BwQTlps1hQ7qGDscDna2yenif9p91SCvDCDzsTFr/oiB/yoOqoaPER9X1trV4c/FL8
         xUDR05+ZwpqwX1lwJy2JDBcvuRwuhLh04vrsCosV0RrG1J5DtRts3sjgAKoIZuXDzyps
         bVw2ztZBIxNEgBUyLvw+w09Ii5NBLU5ZX9mqI4JqjIiuT+bCGhsf0NUVJOYg1LfXbmGM
         EobVsmcQ0K35DFjJPXXXGdBxwrRlhpnOhadxyd78LHhreRulcUhf7ozT8pbk0fGQF95x
         /PzinyUczywobxITdQtEmTl3eBfgQvdMhdjfQq2Mq9dLhuZDFNj1Gw9dOmJQAbOxs8ZH
         bHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792593929; x=1793198729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GjBHhwWOEQdir2yWO0JK5yCpRCfdUmaiz711T6ehhgs=;
        b=NhVZ4ECacU9g6RcyBVVBcKVvSMJJSa4ilaX4EzZ/KKskyJxOCUy3jk+EZZ4xRkeSNh
         bscy4CheGW0g/qR0yIKfnc2wyW55C+4B1c9quLW/cHOMm6zcBeNYGBUKLzaWAXZk2/bm
         KrFzyeL8Km+0aujI5bKtlfLw7D/6F5rrhSwhm/5MD/FBxA0eBz9NKZ3uUoJdUz6aQ1ji
         6026OKtxsBR4LdbUjOw26T1XWtaSKuVqALDFUZAtk68eyoGZQD00MmQyb24yjasTsMFJ
         s86HxIlXBaQ6K3ttUy0E3/Pixt/tbNoWK1YJqP5xGLAqxLQmsyHS3Xgi3/+9slUGOVcp
         saNw==
X-Forwarded-Encrypted: i=1; AKwUvBx6qbltGOMMLEWqxJ84QzKs79Ew+vEEYfz4yNQkggll8ZjURgG1nAE6aJzdIEL/WEADe7VAaJfZzZxZyh0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLQpgNNT6Hq+3aSdHfQtTwYQMlH0oADVMYjbSo7rd0gwU8W0Wsg
	A8Ham2fgDlO0JcfjQ8Ln+6laSHoM+hcylO8/uIO6+1HLRoMf2+msM3Iw
X-Gm-Gg: AYBFou2kHTSjkODvm/bUYFjPkF66pjCN8UVKSZTaHyoKVl0YuzvpiXFqGXn99lV+aOW
	5IGSD9ilHLdkqb9TEk61JohwgWlrui8T7ZoLJqSD7bbkQ/sZ37aLgcvnRbDUyIJjVc4mZPzltVt
	ZFV3irendouctqIlSj4M3Z+NP9XkoF9/cRTDZGoc6Inf/XwLpdK2jJd9/KjWOwy9jUzyBBUOyJO
	pPn+W727SHluoa772gzKwQbVl7mAiI14Y+cSpwP9F+Dh/1Hungv4Vgvh1QoDl0XBRmyqruDPgGR
	z7DMpcLDt89oM40wzSAD38yiZumBNh7IV4YZPZd7/DDzFcVv2+bJp/ndXbbr/0L9BBxSicrpx36
	tbtYFGDMQ0sBkmW8vPIplNtS9Ubc8PoXwsEc940tcr082gYrRiHrDDvlWVBYYARcVQLgdQ7+IiB
	f88C/fglcZjXxmDiZRVUbVhTFtT0OC9IDPmLO6a6T3wEE8vI95P8B5CoIhO7JS9/qifNYHctpxk
	afKfj1od96FOCnmhYrUh2Jya0AVkMdfupH/9dbdVxK0Dz7hSIcqmuATHhSoUu451ktHQhwwfKun
	DpmlR4jAigAPpuCpWwW+ht9FqQ==
X-Received: by 2002:a05:701b:4550:10b0:150:1cea:31a8 with SMTP id a92af1059eb24-190a4ffa89dmr2992796c88.19.1792593928842;
        Wed, 21 Oct 2026 07:45:28 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm6415308c88.3.2026.10.21.07.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 07:45:20 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ritesh.list@gmail.com,
	sshegde@linux.ibm.com,
	mkchauras@gmail.com,
	msuchanek@suse.de,
	akpm@linux-foundation.org,
	yeoreum.yun@arm.com,
	agordeev@linux.ibm.com,
	mchauras@linux.ibm.com,
	bwiedemann@suse.de,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Support for generic tif bits
Date: Wed, 21 Oct 2026 20:14:54 +0530
Message-ID: <20261021144453.232372-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After the support of generic irq entry/exit. powerpc is now ready to
use generic tif bits instead of arch specific ones.

Enable generic tif bits for powerpc arch.

Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
This patch is applicabe over
https://lore.kernel.org/all/961c058f3f3e03045552186c083a68a0fde3f43f.1791975972.git.msuchanek@suse.de/

 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/thread_info.h | 36 +++++++++-----------------
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7f7910f38a67..e5527b56159a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -255,6 +255,7 @@ config PPC
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER		if !COMPILE_TEST && (PPC64 || (PPC32 && CC_IS_GCC))
 	select HAVE_GCC_PLUGINS
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if PPC_BOOK3S_64 && SMP
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_HW_BREAKPOINT		if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 4b7ec1db3034..4df3f4b5bd56 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -93,44 +93,32 @@ void arch_setup_new_exec(void);
 
 #endif /* __ASSEMBLER__ */
 
+#define HAVE_TIF_NEED_RESCHED_LAZY
+
+#include <asm-generic/thread_info_tif.h>
 /*
  * thread information flag bit numbers
  */
-#define TIF_SIGPENDING		1	/* signal pending */
-#define TIF_NEED_RESCHED	2	/* rescheduling necessary */
-#define TIF_NOTIFY_SIGNAL	3	/* signal notifications exist */
-#define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
-#define TIF_PATCH_PENDING	6	/* pending live patching update */
-#define TIF_SINGLESTEP		8	/* singlestepping active */
-#define TIF_NEED_RESCHED_LAZY	9       /* Scheduler driven lazy preemption */
-#define TIF_RESTOREALL		11	/* Restore all regs (implies NOERROR) */
-#define TIF_NOERROR		12	/* Force successful syscall return */
-#define TIF_NOTIFY_RESUME	13	/* callback before returning to user */
-#define TIF_UPROBE		14	/* breakpointed or single-stepping */
-#define TIF_EMULATE_STACK_STORE	16	/* Is an instruction emulation
+#define TIF_RESTORE_TM		16	/* need to restore TM FP/VEC/VSX */
+#define TIF_SINGLESTEP		17	/* singlestepping active */
+#define TIF_RESTOREALL		18	/* Restore all regs (implies NOERROR) */
+#define TIF_NOERROR		19	/* Force successful syscall return */
+#define TIF_EMULATE_STACK_STORE	20	/* Is an instruction emulation
 						for stack store? */
-#define TIF_MEMDIE		17	/* is terminating due to OOM killer */
 #if defined(CONFIG_PPC64)
-#define TIF_ELF2ABI		18	/* function descriptors must die! */
+#define TIF_ELF2ABI		21	/* function descriptors must die! */
 #endif
-#define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
-#define TIF_32BIT		20	/* 32 bit binary */
-#define TIF_SYSCALL_RET		21	/* syscall error value set */
+#define TIF_POLLING_NRFLAG	22	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_32BIT		23	/* 32 bit binary */
+#define TIF_SYSCALL_RET		24	/* syscall error value set */
 
 /* as above, but as bit values */
-#define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	(1<<TIF_NEED_RESCHED_LAZY)
-#define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_32BIT		(1<<TIF_32BIT)
 #define _TIF_RESTORE_TM		(1<<TIF_RESTORE_TM)
-#define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_RESTOREALL		(1<<TIF_RESTOREALL)
 #define _TIF_NOERROR		(1<<TIF_NOERROR)
-#define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
-#define _TIF_UPROBE		(1<<TIF_UPROBE)
 #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
 
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
-- 
2.55.0


