Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3smPyK5dwwzDrWb
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Oct 2016 20:42:17 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mahesh@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
 hbathini@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries: Use H_CLEAR_HPT to clear MMU hash table
 during kexec
Date: Sat,  1 Oct 2016 20:41:56 +1000
Message-Id: <1475318516-8447-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

An hcall was recently added that does exactly what we need
during kexec - it clears the entire MMU hash table, ignoring any
VRMA mappings.

Try it and fall back to the old method if we get a failure.

On a POWER8 box with 5TB of memory, this reduces the time it takes to
kexec a new kernel from from 4 minutes to 1 minute.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/hvcall.h     |  3 ++-
 arch/powerpc/platforms/pseries/lpar.c | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 708edeb..489748e 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -275,7 +275,8 @@
 #define H_COP			0x304
 #define H_GET_MPP_X		0x314
 #define H_SET_MODE		0x31C
-#define MAX_HCALL_OPCODE	H_SET_MODE
+#define H_CLEAR_HPT		0x358
+#define MAX_HCALL_OPCODE	H_CLEAR_HPT
 
 /* H_VIOCTL functions */
 #define H_GET_VIOA_DUMP_SIZE	0x01
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 86707e6..03884a8 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -221,7 +221,7 @@ static long pSeries_lpar_hpte_remove(unsigned long hpte_group)
 	return -1;
 }
 
-static void pSeries_lpar_hptab_clear(void)
+static void __pSeries_lpar_clear_hpt(void)
 {
 	unsigned long size_bytes = 1UL << ppc64_pft_size;
 	unsigned long hpte_count = size_bytes >> 4;
@@ -249,6 +249,18 @@ static void pSeries_lpar_hptab_clear(void)
 					&(ptes[j].pteh), &(ptes[j].ptel));
 		}
 	}
+}
+
+static void pSeries_lpar_hptab_clear(void)
+{
+	int rc;
+
+	do {
+		rc = plpar_hcall_norets(H_CLEAR_HPT);
+	} while (rc == H_CONTINUE);
+
+	if (rc != H_SUCCESS)
+		__pSeries_lpar_clear_hpt();
 
 #ifdef __LITTLE_ENDIAN__
 	/*
-- 
2.7.4
