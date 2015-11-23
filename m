Return-Path: <linux@rasmusvillemoes.dk>
Received: from mail-lf0-x22c.google.com (mail-lf0-x22c.google.com
 [IPv6:2a00:1450:4010:c07::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 307E61A029E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 06:52:05 +1100 (AEDT)
Received: by lfs39 with SMTP id 39so117390447lfs.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 11:52:00 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Rusty Russell <rusty@rustcorp.com.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2,
 resend 1/6] powerpc/fadump: rename cpu_online_mask member of struct
 fadump_crash_info_header
Date: Mon, 23 Nov 2015 20:51:35 +0100
Message-Id: <1448308300-22582-2-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1448308300-22582-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1444144919-25143-1-git-send-email-linux@rasmusvillemoes.dk>
 <1448308300-22582-1-git-send-email-linux@rasmusvillemoes.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As preparation for eliminating the indirect access to the various
global cpu_*_bits bitmaps via the pointer variables cpu_*_mask, rename
the cpu_online_mask member of struct fadump_crash_info_header to
simply online_mask, thus allowing cpu_online_mask to become a macro.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/include/asm/fadump.h | 2 +-
 arch/powerpc/kernel/fadump.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
index 493e72f64b35..b4407d0add27 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -191,7 +191,7 @@ struct fadump_crash_info_header {
 	u64		elfcorehdr_addr;
 	u32		crashing_cpu;
 	struct pt_regs	regs;
-	struct cpumask	cpu_online_mask;
+	struct cpumask	online_mask;
 };
 
 /* Crash memory ranges */
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 26d091a1a54c..3cb3b02a13dd 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -415,7 +415,7 @@ void crash_fadump(struct pt_regs *regs, const char *str)
 	else
 		ppc_save_regs(&fdh->regs);
 
-	fdh->cpu_online_mask = *cpu_online_mask;
+	fdh->online_mask = *cpu_online_mask;
 
 	/* Call ibm,os-term rtas call to trigger firmware assisted dump */
 	rtas_os_term((char *)str);
@@ -646,7 +646,7 @@ static int __init fadump_build_cpu_notes(const struct fadump_mem_struct *fdm)
 		}
 		/* Lower 4 bytes of reg_value contains logical cpu id */
 		cpu = be64_to_cpu(reg_entry->reg_value) & FADUMP_CPU_ID_MASK;
-		if (fdh && !cpumask_test_cpu(cpu, &fdh->cpu_online_mask)) {
+		if (fdh && !cpumask_test_cpu(cpu, &fdh->online_mask)) {
 			SKIP_TO_NEXT_CPU(reg_entry);
 			continue;
 		}
-- 
2.6.1
