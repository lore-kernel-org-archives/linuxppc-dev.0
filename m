Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Fri, 5 Mar 2010 13:44:05 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100305204404.18424.27384.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
References: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
Subject: [PATCH 12/13] powerpc/476: Workaround for DD1.1: Issue lwsync after
	mtpid
Cc: Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/476: Workaround for DD1.1: Issue lwsync after mtpid

From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/asm-compat.h |    2 ++
 arch/powerpc/kernel/head_44x.S        |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index 1890fbf..fd16e3a 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -70,12 +70,14 @@
 	BEGIN_FTR_SECTION;			\
 		lwsync;				\
 	END_FTR_SECTION_IFSET(CPU_FTR_476_DD1_1)
+#define PPC476_ERR_MTPID PPC476_ERR_DCBx
 #define PPC476_ERR_ISYNC()			\
 	BEGIN_FTR_SECTION;			\
 		isync;				\
 	END_FTR_SECTION_IFSET(CPU_FTR_476_DD1_1)
 #else	/* ! CONFIG_PPC_47x */
 #define PPC476_ERR_DCBx()
+#define PPC476_ERR_MTPID()
 #define PPC476_ERR_ISYNC()
 #endif /* CONFIG_PPC_47x */
 
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index a96796d..c27b0cd 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -705,6 +705,7 @@ _GLOBAL(set_context)
 	stw	r4, 0x4(r5)
 #endif
 	mtspr	SPRN_PID,r3
+	PPC476_ERR_MTPID()
 	isync			/* Force context change */
 	blr
 

-- 
Dave Kleikamp
IBM Linux Technology Center
