Return-Path: <oohall@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09EE51A01EA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 09:09:48 +1100 (AEDT)
Received: by mail-pa0-x233.google.com with SMTP id tt10so23749120pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Mar 2016 14:09:47 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH] powerpc/process: fix altivec SPR not being saved
Date: Tue,  8 Mar 2016 09:08:47 +1100
Message-Id: <1457388527-14575-1-git-send-email-oohall@gmail.com>
In-Reply-To: <1457303588-29173-1-git-send-email-oohall@gmail.com>
References: <1457303588-29173-1-git-send-email-oohall@gmail.com>
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
Signed-off-by: Anton Blanchard <anton@samba.org>
Fixes: 152d523e6307 ("powerpc: Create context switch helpers save_sprs() and restore_sprs()")
Cc: stable@vger.kernel.org
---
 arch/powerpc/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index dccc87e8fee5..bc6aa87a3b12 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -854,7 +854,7 @@ void restore_tm_state(struct pt_regs *regs)
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
