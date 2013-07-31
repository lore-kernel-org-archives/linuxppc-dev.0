Return-Path: <anton@samba.org>
Date: Wed, 31 Jul 2013 16:05:19 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Wrap MSR macros with parentheses
Message-ID: <20130731160519.3f01a89c@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Index: b/arch/powerpc/include/asm/reg.h
===================================================================
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
