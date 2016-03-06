Return-Path: <oohall@gmail.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DBBC81A0225
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 09:34:01 +1100 (AEDT)
Received: by mail-pa0-x22a.google.com with SMTP id tt10so4768572pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Mar 2016 14:34:01 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH] powerpc/process: fix altivec SPR not being saved
Date: Mon,  7 Mar 2016 09:33:08 +1100
Message-Id: <1457303588-29173-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In save_sprs() in process.c contains the following test:

	if (cpu_has_feature(cpu_has_feature(CPU_FTR_ALTIVEC)))
		t->vrsave = mfspr(SPRN_VRSAVE);

CPU feature with the mask 0x1 is CPU_FTR_COHERENT_ICACHE so the test
is equivilent to:

	if (cpu_has_feature(CPU_FTR_ALTIVEC) &&
		cpu_has_feature(CPU_FTR_COHERENT_ICACHE))

On CPUs without support for both (i.e G5) this results in vrsave not being
saved between context switches. The vector register save/restore code
doesn't use VRSAVE to determine which registers to save/restore,
but the value of VRSAVE is used to determine if altivec is being used
in several code paths.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 8224852..5a4d4d1 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -855,7 +855,7 @@ void restore_tm_state(struct pt_regs *regs)
 static inline void save_sprs(struct thread_struct *t)
 {
 #ifdef CONFIG_ALTIVEC
-	if (cpu_has_feature(cpu_has_feature(CPU_FTR_ALTIVEC)))
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
 		t->vrsave = mfspr(SPRN_VRSAVE);
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
-- 
2.5.0
