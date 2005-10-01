Return-Path: <sfr@canb.auug.org.au>
Date: Sat, 1 Oct 2005 21:40:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20051001214029.5d66fdb4.sfr@canb.auug.org.au>
In-Reply-To: <20051001000516.1d444d51.sfr@canb.auug.org.au>
References: <20050930233602.138b6e27.sfr@canb.auug.org.au>
	<20051001000516.1d444d51.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 7/9] ppc64: simplify the build a little
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

New version to because of changes in 6/9

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

---

 arch/powerpc/Makefile        |    1 -
 arch/powerpc/kernel/Makefile |   11 +++++++++--
 arch/ppc64/Makefile          |    2 +-
 arch/ppc64/kernel/Makefile   |   11 ++---------
 4 files changed, 12 insertions(+), 13 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

bd142b70a6bd5522f7d95f0cec06091b93bb0715
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -121,7 +121,6 @@ head-$(CONFIG_FSL_BOOKE)	:= arch/powerpc
 
 ifeq ($(CONFIG_PPC32),y)
 head-$(CONFIG_6xx)		+= arch/powerpc/kernel/idle_6xx.o
-head-$(CONFIG_POWER4)		+= arch/powerpc/kernel/idle_power4.o
 head-$(CONFIG_PPC_FPU)		+= arch/powerpc/kernel/fpu.o
 endif
 
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -2,6 +2,10 @@
 # Makefile for the linux kernel.
 #
 
+ifeq ($(CONFIG_PPC64),y)
+EXTRA_CFLAGS	+= -mno-minimal-toc
+endif
+
 extra-$(CONFIG_PPC_STD_MMU)	:= head.o
 extra_$(CONFIG_PPC64)		:= head_64.o
 extra-$(CONFIG_40x)		:= head_4xx.o
@@ -9,10 +13,13 @@ extra-$(CONFIG_44x)		:= head_44x.o
 extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
 extra-$(CONFIG_8xx)		:= head_8xx.o
 extra-$(CONFIG_6xx)		+= idle_6xx.o
-extra-$(CONFIG_POWER4)		+= idle_power4.o
 extra-$(CONFIG_PPC_FPU)		+= fpu.o
 extra-y				+= vmlinux.lds
 
-obj-y				:= semaphore.o traps.o process.o
+obj-y				:= traps.o
+obj-$(CONFIG_PPC32)		+= semaphore.o process.o
+obj-$(CONFIG_PPC64)		+= idle_power4.o
+ifeq ($(CONFIG_PPC32),y)
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
+endif
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
diff --git a/arch/ppc64/Makefile b/arch/ppc64/Makefile
--- a/arch/ppc64/Makefile
+++ b/arch/ppc64/Makefile
@@ -82,7 +82,7 @@ CFLAGS += $(call cc-option,-funit-at-a-t
 head-y := arch/ppc64/kernel/head.o
 
 libs-y				+= arch/ppc64/lib/
-core-y				+= arch/ppc64/kernel/
+core-y				+= arch/ppc64/kernel/ arch/powerpc/kernel/
 core-y				+= arch/ppc64/mm/
 core-y				+= arch/powerpc/platforms/
 core-$(CONFIG_XMON)		+= arch/ppc64/xmon/
diff --git a/arch/ppc64/kernel/Makefile b/arch/ppc64/kernel/Makefile
--- a/arch/ppc64/kernel/Makefile
+++ b/arch/ppc64/kernel/Makefile
@@ -7,12 +7,12 @@ ifneq ($(CONFIG_PPC_MERGE),y)
 EXTRA_CFLAGS	+= -mno-minimal-toc
 extra-y		:= head.o vmlinux.lds
 
-obj-y               :=	setup.o entry.o traps.o irq.o idle.o dma.o \
+obj-y               :=	setup.o entry.o irq.o idle.o dma.o \
 			time.o process.o signal.o syscalls.o misc.o ptrace.o \
 			align.o semaphore.o bitops.o pacaData.o \
 			udbg.o binfmt_elf32.o sys_ppc32.o ioctl32.o \
 			ptrace32.o signal32.o rtc.o init_task.o \
-			lmb.o cputable.o cpu_setup_power4.o idle_power4.o \
+			lmb.o cputable.o cpu_setup_power4.o \
 			iommu.o sysfs.o vdso.o pmc.o firmware.o prom.o
 obj-y += vdso32/ vdso64/
 
@@ -66,7 +66,6 @@ obj-$(CONFIG_PPC_BPA)		+= pSeries_smp.o
 obj-$(CONFIG_PPC_MAPLE)		+= smp-tbsync.o
 endif
 
-obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 
 CFLAGS_ioctl32.o += -Ifs/
@@ -76,12 +75,6 @@ arch/ppc64/kernel/head.o: arch/powerpc/p
 AFLAGS_head.o += -Iarch/powerpc/platforms/iseries
 endif
 
-# These are here while we do the architecture merge
-vecemu-y			+= ../../powerpc/kernel/vecemu.o
-vector-y			+= ../../powerpc/kernel/vector.o
-idle_power4-y			+= ../../powerpc/kernel/idle_power4.o
-traps-y				+= ../../powerpc/kernel/traps.o
-
 else
 
 endif
