Return-Path: <anton@ozlabs.org>
Date: Sat, 10 Jun 2006 23:14:51 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix HV bit handling on non partitioned machines
Message-ID: <20060610131451.GS23891@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On non partitioned machines we currently set the HV bit in kernel space
only. It turns out we are supposed to maintain the HV bit in both user
and kernel space.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/include/asm-powerpc/reg.h
===================================================================
--- build.orig/include/asm-powerpc/reg.h	2006-05-27 10:02:39.000000000 +1000
+++ build/include/asm-powerpc/reg.h	2006-05-27 10:09:46.000000000 +1000
@@ -93,8 +93,8 @@
 #define MSR_LE		__MASK(MSR_LE_LG)	/* Little Endian */
 
 #ifdef CONFIG_PPC64
-#define MSR_		MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_ISF
-#define MSR_KERNEL      MSR_ | MSR_SF | MSR_HV
+#define MSR_		MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_ISF |MSR_HV
+#define MSR_KERNEL      MSR_ | MSR_SF
 
 #define MSR_USER32	MSR_ | MSR_PR | MSR_EE
 #define MSR_USER64	MSR_USER32 | MSR_SF
