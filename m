Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6bdl4XNTzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 17:01:31 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/32: Move entry_32 functions just after HEAD functions.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170418070126.A18EF67952@localhost.localdomain>
Date: Tue, 18 Apr 2017 09:01:26 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By default, PPC8xx PINs an ITLB on the first 8M of memory in order
to avoid any ITLB miss on kernel code.
However, with some debug functions like DEBUG_PAGEALLOC and
(soon to come) DEBUG_RODATA, the PINned TLB is invalidated soon
after startup so ITLB missed start to happen also on the kernel code.

In order to avoid any ITLB miss in a critical section, we have to
ensure that their is no page boundary crossed between the setup of
a new value in SRR0/SRR1 and the associated RFI. This cannot be done
easily if entry_32 functions sits in the middle of other .text
functions. By placing entry_32 just after the .head section (as already
done for entry_64 on PPC64), we can more easily ensure the issue
doesn't happen.

Ex: with this change, all entry_32 functions playing with srr0/srr1
appears between 0xc0002000 and 0xc0002fff on PPC_8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Makefile        | 2 +-
 arch/powerpc/kernel/Makefile | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 19b0d1a81959..8aa1dafb14eb 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -243,7 +243,7 @@ head-$(CONFIG_40x)		:= arch/powerpc/kernel/head_40x.o
 head-$(CONFIG_44x)		:= arch/powerpc/kernel/head_44x.o
 head-$(CONFIG_FSL_BOOKE)	:= arch/powerpc/kernel/head_fsl_booke.o
 
-head-$(CONFIG_PPC64)		+= arch/powerpc/kernel/entry_64.o
+head-y				+= arch/powerpc/kernel/entry_$(BITS).o
 head-$(CONFIG_PPC_FPU)		+= arch/powerpc/kernel/fpu.o
 head-$(CONFIG_ALTIVEC)		+= arch/powerpc/kernel/vector.o
 head-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)  += arch/powerpc/kernel/prom_init.o
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 811f441a125f..eb2db44c5fe9 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -90,7 +90,7 @@ extra-y				+= vmlinux.lds
 
 obj-$(CONFIG_RELOCATABLE)	+= reloc_$(BITS).o
 
-obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o
+obj-$(CONFIG_PPC32)		+= setup_32.o
 obj-$(CONFIG_PPC64)		+= dma-iommu.o iommu.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
@@ -154,7 +154,7 @@ UBSAN_SANITIZE_vdso.o := n
 
 extra-$(CONFIG_PPC_FPU)		+= fpu.o
 extra-$(CONFIG_ALTIVEC)		+= vector.o
-extra-$(CONFIG_PPC64)		+= entry_64.o
+extra-y				+= entry_$(BITS).o
 extra-$(CONFIG_PPC_OF_BOOT_TRAMPOLINE)	+= prom_init.o
 
 extra-y				+= systbl_chk.i
-- 
2.12.0
