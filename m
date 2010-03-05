Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Fri, 5 Mar 2010 13:44:10 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100305204410.18424.8976.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
References: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
Subject: [PATCH 13/13] powerpc/476: Add dci instruction to async interrupt
	handlers on DD1 core
Cc: Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/476: Add dci instruction to async interrupt handlers on DD1 core

From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/asm-compat.h |    5 +++++
 arch/powerpc/include/asm/cputable.h   |    1 +
 arch/powerpc/kernel/cputable.c        |   14 ++++++++++++++
 arch/powerpc/kernel/head_booke.h      |    3 +++
 4 files changed, 23 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index fd16e3a..43e9d1b 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -71,6 +71,10 @@
 		lwsync;				\
 	END_FTR_SECTION_IFSET(CPU_FTR_476_DD1_1)
 #define PPC476_ERR_MTPID PPC476_ERR_DCBx
+#define PPC476_ERR_DCI()			\
+	BEGIN_FTR_SECTION;			\
+		dci;				\
+	END_FTR_SECTION_IFSET(CPU_FTR_476_DD1)
 #define PPC476_ERR_ISYNC()			\
 	BEGIN_FTR_SECTION;			\
 		isync;				\
@@ -78,6 +82,7 @@
 #else	/* ! CONFIG_PPC_47x */
 #define PPC476_ERR_DCBx()
 #define PPC476_ERR_MTPID()
+#define PPC476_ERR_DCI()
 #define PPC476_ERR_ISYNC()
 #endif /* CONFIG_PPC_47x */
 
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 7c5d490..1cf38fb 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -156,6 +156,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_476_DD1_1		ASM_CONST(0x0000000000010000)
 #define CPU_FTR_NEED_COHERENT		ASM_CONST(0x0000000000020000)
 #define CPU_FTR_NO_BTIC			ASM_CONST(0x0000000000040000)
+#define CPU_FTR_476_DD1			ASM_CONST(0x0000000000080000)
 #define CPU_FTR_NODSISRALIGN		ASM_CONST(0x0000000000100000)
 #define CPU_FTR_PPC_LE			ASM_CONST(0x0000000000200000)
 #define CPU_FTR_REAL_LE			ASM_CONST(0x0000000000400000)
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index cb9e6b7..e91bb2e 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1701,6 +1701,20 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
+	{ /* 476 DD1 core - needs DD1.1 feature as well */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x11a50000,
+		.cpu_name		= "476",
+		.cpu_features		= CPU_FTRS_47X | CPU_FTR_476_DD1 |
+			CPU_FTR_476_DD1_1 | CPU_FTR_FPU_UNAVAILABLE,
+		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_47x |
+			MMU_FTR_LOCK_BCAST_INVAL,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 128,
+		.machine_check		= machine_check_47x,
+		.platform		= "ppc470",
+	},
 	{ /* 476 DD1.1 core */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x11a52040,
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index c6f5dcd..c8e38c8 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -174,12 +174,14 @@ label:									     \
 
 #define EXCEPTION(n, label, hdlr, xfer)				\
 	START_EXCEPTION(label);					\
+	PPC476_ERR_DCI();					\
 	NORMAL_EXCEPTION_PROLOG;				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	xfer(n, hdlr)
 
 #define CRITICAL_EXCEPTION(n, label, hdlr)			\
 	START_EXCEPTION(label);					\
+	PPC476_ERR_DCI();					\
 	CRITICAL_EXCEPTION_PROLOG;				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	EXC_XFER_TEMPLATE(hdlr, n+2, (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
@@ -379,6 +381,7 @@ label:									     \
 
 #define DECREMENTER_EXCEPTION						      \
 	START_EXCEPTION(Decrementer)					      \
+	PPC476_ERR_DCI();						      \
 	NORMAL_EXCEPTION_PROLOG;					      \
 	lis     r0,TSR_DIS@h;           /* Setup the DEC interrupt mask */    \
 	mtspr   SPRN_TSR,r0;		/* Clear the DEC interrupt */	      \

-- 
Dave Kleikamp
IBM Linux Technology Center
