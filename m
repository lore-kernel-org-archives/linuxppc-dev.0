Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QHd93h3zzF21F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 17:56:29 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/misc: get rid of add_reloc_offset()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20180417075624.962AB6C038@po15720vm.idsi0.si.c-s.fr>
Date: Tue, 17 Apr 2018 09:56:24 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

add_reloc_offset() is almost redundant with reloc_offset()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/setup.h       |  3 +--
 arch/powerpc/kernel/misc.S             | 16 ----------------
 arch/powerpc/kernel/prom_init_check.sh |  2 +-
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 27fa52ed6d00..115e0896ffa7 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -17,10 +17,9 @@ extern void note_scsi_host(struct device_node *, void *);
 
 /* Used in very early kernel initialization. */
 extern unsigned long reloc_offset(void);
-extern unsigned long add_reloc_offset(unsigned long);
 extern void reloc_got2(unsigned long);
 
-#define PTRRELOC(x)	((typeof(x)) add_reloc_offset((unsigned long)(x)))
+#define PTRRELOC(x)	((typeof(x)) ((unsigned long)(x) + reloc_offset()))
 
 void check_for_initrd(void);
 void mem_topology_setup(void);
diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index 384357cb8bc0..2711b10ebdb3 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -39,22 +39,6 @@ _GLOBAL(reloc_offset)
 	.align	3
 2:	PPC_LONG 1b
 
-/*
- * add_reloc_offset(x) returns x + reloc_offset().
- */
-_GLOBAL(add_reloc_offset)
-	mflr	r0
-	bl	1f
-1:	mflr	r5
-	PPC_LL	r4,(2f-1b)(r5)
-	subf	r5,r4,r5
-	add	r3,r3,r5
-	mtlr	r0
-	blr
-
-	.align	3
-2:	PPC_LONG 1b
-
 _GLOBAL(setjmp)
 	mflr	r0
 	PPC_STL	r0,0(r3)
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index acb6b9226352..ee9f63186b72 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -16,7 +16,7 @@
 # If you really need to reference something from prom_init.o add
 # it to the list below:
 
-WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
+WHITELIST="__bss_start __bss_stop copy_and_flush
 _end enter_prom memcpy memset reloc_offset __secondary_hold
 __secondary_hold_acknowledge __secondary_hold_spinloop __start
 strcmp strcpy strlcpy strlen strncmp strstr kstrtobool logo_linux_clut224
-- 
2.13.3
