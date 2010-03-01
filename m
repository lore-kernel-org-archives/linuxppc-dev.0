Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Mon, 1 Mar 2010 12:14:25 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100301191425.20987.46086.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
Subject: [RFC: PATCH 13/13] powerpc/476: Add dci instruction to async
	interrupt handlers on DD1 core
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
 arch/powerpc/kernel/head_booke.h      |    3 +++
 2 files changed, 8 insertions(+), 0 deletions(-)


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
 
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index 6b1ad61..d247c1c 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -175,12 +175,14 @@ label:									     \
 
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
@@ -380,6 +382,7 @@ label:									     \
 
 #define DECREMENTER_EXCEPTION						      \
 	START_EXCEPTION(Decrementer)					      \
+	PPC476_ERR_DCI();						      \
 	NORMAL_EXCEPTION_PROLOG;					      \
 	lis     r0,TSR_DIS@h;           /* Setup the DEC interrupt mask */    \
 	mtspr   SPRN_TSR,r0;		/* Clear the DEC interrupt */	      \

-- 
Dave Kleikamp
IBM Linux Technology Center
