Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 03/63] powerpc: Wrap MSR macros with parentheses
Date: Wed,  7 Aug 2013 02:01:20 +1000
Message-Id: <1375804940-22050-4-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Not having parentheses around a macro is asking for trouble.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/reg.h       | 8 ++++----
 arch/powerpc/include/asm/reg_booke.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index a6840e4..a312e0c 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -115,10 +115,10 @@
 #define MSR_64BIT	MSR_SF
 
 /* Server variant */
-#define MSR_		MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_ISF |MSR_HV
-#define MSR_KERNEL	MSR_ | MSR_64BIT
-#define MSR_USER32	MSR_ | MSR_PR | MSR_EE
-#define MSR_USER64	MSR_USER32 | MSR_64BIT
+#define MSR_		(MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_ISF |MSR_HV)
+#define MSR_KERNEL	(MSR_ | MSR_64BIT)
+#define MSR_USER32	(MSR_ | MSR_PR | MSR_EE)
+#define MSR_USER64	(MSR_USER32 | MSR_64BIT)
 #elif defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_8xx)
 /* Default MSR for kernel mode. */
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR)
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index b417de3..ed8f836 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -29,10 +29,10 @@
 #if defined(CONFIG_PPC_BOOK3E_64)
 #define MSR_64BIT	MSR_CM
 
-#define MSR_		MSR_ME | MSR_CE
-#define MSR_KERNEL	MSR_ | MSR_64BIT
-#define MSR_USER32	MSR_ | MSR_PR | MSR_EE
-#define MSR_USER64	MSR_USER32 | MSR_64BIT
+#define MSR_		(MSR_ME | MSR_CE)
+#define MSR_KERNEL	(MSR_ | MSR_64BIT)
+#define MSR_USER32	(MSR_ | MSR_PR | MSR_EE)
+#define MSR_USER64	(MSR_USER32 | MSR_64BIT)
 #elif defined (CONFIG_40x)
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
-- 
1.8.1.2
