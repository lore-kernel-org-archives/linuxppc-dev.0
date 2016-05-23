Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCsZj74P7zDqMb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 18:46:05 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc: inline current_stack_pointer()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160523084602.53F771A239A@localhost.localdomain>
Date: Mon, 23 May 2016 10:46:02 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

current_stack_pointeur() is a single instruction function. it
It is not worth breaking the execution flow with a bl/blr for a
single instruction

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/reg.h  | 7 ++++++-
 arch/powerpc/kernel/misc.S      | 4 ----
 arch/powerpc/kernel/ppc_ksyms.c | 2 --
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c1e82e9..7ce6777 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1301,7 +1301,12 @@ static inline unsigned long mfvtb (void)
 
 #define proc_trap()	asm volatile("trap")
 
-extern unsigned long current_stack_pointer(void);
+static inline unsigned long current_stack_pointer(void)
+{
+	register unsigned long *ptr asm("r1");
+
+	return *ptr;
+}
 
 extern unsigned long scom970_read(unsigned int address);
 extern void scom970_write(unsigned int address, unsigned long value);
diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 0d43219..7ce26d4 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -114,7 +114,3 @@ _GLOBAL(longjmp)
 	mtlr	r0
 	mr	r3,r4
 	blr
-
-_GLOBAL(current_stack_pointer)
-	PPC_LL	r3,0(r1)
-	blr
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 9f01e28..eb5c5dc 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -33,5 +33,3 @@ EXPORT_SYMBOL(store_vr_state);
 #ifdef CONFIG_EPAPR_PARAVIRT
 EXPORT_SYMBOL(epapr_hypercall_start);
 #endif
-
-EXPORT_SYMBOL(current_stack_pointer);
-- 
2.1.0
