Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Fri, 5 Mar 2010 17:43:53 -0300
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100305204353.18424.78936.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
References: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
Subject: [PATCH 10/13] powerpc/476: Add isync to the top of all exception
	handlers for DD1.1 core
Cc: Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/476: Add isync to the top of all exception handlers for DD1.1 core

From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/asm-compat.h |    7 ++++++-
 arch/powerpc/kernel/head_booke.h      |    3 ++-
 2 files changed, 8 insertions(+), 2 deletions(-)


diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index bee05ec..1890fbf 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -70,8 +70,13 @@
 	BEGIN_FTR_SECTION;			\
 		lwsync;				\
 	END_FTR_SECTION_IFSET(CPU_FTR_476_DD1_1)
-#else
+#define PPC476_ERR_ISYNC()			\
+	BEGIN_FTR_SECTION;			\
+		isync;				\
+	END_FTR_SECTION_IFSET(CPU_FTR_476_DD1_1)
+#else	/* ! CONFIG_PPC_47x */
 #define PPC476_ERR_DCBx()
+#define PPC476_ERR_ISYNC()
 #endif /* CONFIG_PPC_47x */
 
 #endif
diff --git a/arch/powerpc/kernel/head_booke.h b/arch/powerpc/kernel/head_booke.h
index a0bf158..c6f5dcd 100644
--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -164,7 +164,8 @@
  */
 #define	START_EXCEPTION(label)						     \
         .align 5;              						     \
-label:
+label:									     \
+	PPC476_ERR_ISYNC()
 
 #define FINISH_EXCEPTION(func)					\
 	bl	transfer_to_handler_full;			\

-- 
Dave Kleikamp
IBM Linux Technology Center
