Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rHdhL3qKhzDqPm
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 May 2016 22:04:02 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, acsawdey@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc: Avoid load hit store in setup_sigcontext()
Date: Sun, 29 May 2016 22:03:51 +1000
Message-Id: <1464523432-12605-2-git-send-email-anton@ozlabs.org>
In-Reply-To: <1464523432-12605-1-git-send-email-anton@ozlabs.org>
References: <1464523432-12605-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

In setup_sigcontext(), we set current->thread.vrsave then use it
straight after. Since current is hidden from the compiler via inline
assembly, it cannot optimise this and we end up with a load hit store.

Fix this by using a temporary.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/signal_64.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 2552079..7e49984 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -104,6 +104,7 @@ static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 	 */
 #ifdef CONFIG_ALTIVEC
 	elf_vrreg_t __user *v_regs = sigcontext_vmx_regs(sc);
+	unsigned long vrsave;
 #endif
 	unsigned long msr = regs->msr;
 	long err = 0;
@@ -125,9 +126,13 @@ static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 	/* We always copy to/from vrsave, it's 0 if we don't have or don't
 	 * use altivec.
 	 */
-	if (cpu_has_feature(CPU_FTR_ALTIVEC))
-		current->thread.vrsave = mfspr(SPRN_VRSAVE);
-	err |= __put_user(current->thread.vrsave, (u32 __user *)&v_regs[33]);
+	vrsave = 0;
+	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {
+		vrsave = mfspr(SPRN_VRSAVE);
+		current->thread.vrsave = vrsave;
+	}
+
+	err |= __put_user(vrsave, (u32 __user *)&v_regs[33]);
 #else /* CONFIG_ALTIVEC */
 	err |= __put_user(0, &sc->v_regs);
 #endif /* CONFIG_ALTIVEC */
-- 
2.7.4
