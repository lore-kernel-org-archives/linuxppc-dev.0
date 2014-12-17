Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E73F1A058D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Dec 2014 03:38:06 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Wed, 17 Dec 2014 16:38:02 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id B198917E9A2E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 15:31:19 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBHFUsHA59113682
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 15:30:54 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBHFUrSJ011808
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 10:30:54 -0500
Subject: [PATCH v2 3/4] powerpc/vphn: move VPHN parsing logic to a separate
 file
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 17 Dec 2014 10:42:58 +0100
Message-ID: <20141217094246.16957.59244.stgit@bahia.local>
In-Reply-To: <20141217094007.16957.70423.stgit@bahia.local>
References: <20141217094007.16957.70423.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The goal behind this patch is to be able to write userland tests for the
VPHN parsing code.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 arch/powerpc/mm/Makefile |    1 +
 arch/powerpc/mm/numa.c   |   61 ++--------------------------------------------
 arch/powerpc/mm/vphn.c   |   50 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/vphn.h   |   16 ++++++++++++
 4 files changed, 70 insertions(+), 58 deletions(-)
 create mode 100644 arch/powerpc/mm/vphn.c
 create mode 100644 arch/powerpc/mm/vphn.h

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 438dcd3..9c8770b 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_40x)		+= 40x_mmu.o
 obj-$(CONFIG_44x)		+= 44x_mmu.o
 obj-$(CONFIG_PPC_FSL_BOOK3E)	+= fsl_booke_mmu.o
 obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
+obj-$(CONFIG_PPC_SPLPAR)	+= vphn.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-y				+= hugetlbpage.o
 ifeq ($(CONFIG_HUGETLB_PAGE),y)
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 2e36a6f..008af17 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1177,6 +1177,9 @@ u64 memory_hotplug_max(void)
 
 /* Virtual Processor Home Node (VPHN) support */
 #ifdef CONFIG_PPC_SPLPAR
+
+#include "vphn.h"
+
 struct topology_update_data {
 	struct topology_update_data *next;
 	unsigned int cpu;
@@ -1247,64 +1250,6 @@ static int update_cpu_associativity_changes_mask(void)
 	return cpumask_weight(changes);
 }
 
-/* The H_HOME_NODE_ASSOCIATIVITY h_call returns 6 64-bit registers.
- */
-#define VPHN_REGISTER_COUNT 6
-
-/*
- * 6 64-bit registers unpacked into 12 32-bit associativity values. To form
- * the complete property we have to add the length in the first cell.
- */
-#define VPHN_ASSOC_BUFSIZE (VPHN_REGISTER_COUNT*sizeof(u64)/sizeof(u32) + 1)
-
-/*
- * Convert the associativity domain numbers returned from the hypervisor
- * to the sequence they would appear in the ibm,associativity property.
- */
-static int vphn_unpack_associativity(const long *packed, __be32 *unpacked)
-{
-	__be64 be_packed[VPHN_REGISTER_COUNT];
-	int i, nr_assoc_doms = 0;
-	const __be16 *field = (const __be16 *) be_packed;
-
-#define VPHN_FIELD_UNUSED	(0xffff)
-#define VPHN_FIELD_MSB		(0x8000)
-#define VPHN_FIELD_MASK		(~VPHN_FIELD_MSB)
-
-	/* Let's recreate the original stream. */
-	for (i = 0; i < VPHN_REGISTER_COUNT; i++)
-		be_packed[i] = cpu_to_be64(packed[i]);
-
-	for (i = 1; i < VPHN_ASSOC_BUFSIZE; i++) {
-		if (be16_to_cpup(field) == VPHN_FIELD_UNUSED) {
-			/* All significant fields processed, and remaining
-			 * fields contain the reserved value of all 1's.
-			 * Just store them.
-			 */
-			unpacked[i] = *((__be32 *)field);
-			field += 2;
-		} else if (be16_to_cpup(field) & VPHN_FIELD_MSB) {
-			/* Data is in the lower 15 bits of this field */
-			unpacked[i] = cpu_to_be32(
-				be16_to_cpup(field) & VPHN_FIELD_MASK);
-			field++;
-			nr_assoc_doms++;
-		} else {
-			/* Data is in the lower 15 bits of this field
-			 * concatenated with the next 16 bit field
-			 */
-			unpacked[i] = *((__be32 *)field);
-			field += 2;
-			nr_assoc_doms++;
-		}
-	}
-
-	/* The first cell contains the length of the property */
-	unpacked[0] = cpu_to_be32(nr_assoc_doms);
-
-	return nr_assoc_doms;
-}
-
 /*
  * Retrieve the new associativity information for a virtual processor's
  * home node.
diff --git a/arch/powerpc/mm/vphn.c b/arch/powerpc/mm/vphn.c
new file mode 100644
index 0000000..c49ed51
--- /dev/null
+++ b/arch/powerpc/mm/vphn.c
@@ -0,0 +1,50 @@
+#include <asm/byteorder.h>
+#include "vphn.h"
+
+/*
+ * Convert the associativity domain numbers returned from the hypervisor
+ * to the sequence they would appear in the ibm,associativity property.
+ */
+int vphn_unpack_associativity(const long *packed, __be32 *unpacked)
+{
+	__be64 be_packed[VPHN_REGISTER_COUNT];
+	int i, nr_assoc_doms = 0;
+	const __be16 *field = (const __be16 *) be_packed;
+
+#define VPHN_FIELD_UNUSED	(0xffff)
+#define VPHN_FIELD_MSB		(0x8000)
+#define VPHN_FIELD_MASK		(~VPHN_FIELD_MSB)
+
+	/* Let's recreate the original stream. */
+	for (i = 0; i < VPHN_REGISTER_COUNT; i++)
+		be_packed[i] = cpu_to_be64(packed[i]);
+
+	for (i = 1; i < VPHN_ASSOC_BUFSIZE; i++) {
+		if (be16_to_cpup(field) == VPHN_FIELD_UNUSED) {
+			/* All significant fields processed, and remaining
+			 * fields contain the reserved value of all 1's.
+			 * Just store them.
+			 */
+			unpacked[i] = *((__be32 *)field);
+			field += 2;
+		} else if (be16_to_cpup(field) & VPHN_FIELD_MSB) {
+			/* Data is in the lower 15 bits of this field */
+			unpacked[i] = cpu_to_be32(
+				be16_to_cpup(field) & VPHN_FIELD_MASK);
+			field++;
+			nr_assoc_doms++;
+		} else {
+			/* Data is in the lower 15 bits of this field
+			 * concatenated with the next 16 bit field
+			 */
+			unpacked[i] = *((__be32 *)field);
+			field += 2;
+			nr_assoc_doms++;
+		}
+	}
+
+	/* The first cell contains the length of the property */
+	unpacked[0] = cpu_to_be32(nr_assoc_doms);
+
+	return nr_assoc_doms;
+}
diff --git a/arch/powerpc/mm/vphn.h b/arch/powerpc/mm/vphn.h
new file mode 100644
index 0000000..96af9a4
--- /dev/null
+++ b/arch/powerpc/mm/vphn.h
@@ -0,0 +1,16 @@
+#ifndef _ARCH_POWERPC_MM_VPHN_H_
+#define _ARCH_POWERPC_MM_VPHN_H_
+
+/* The H_HOME_NODE_ASSOCIATIVITY h_call returns 6 64-bit registers.
+ */
+#define VPHN_REGISTER_COUNT 6
+
+/*
+ * 6 64-bit registers unpacked into 12 32-bit associativity values. To form
+ * the complete property we have to add the length in the first cell.
+ */
+#define VPHN_ASSOC_BUFSIZE (VPHN_REGISTER_COUNT*sizeof(u64)/sizeof(u32) + 1)
+
+extern int vphn_unpack_associativity(const long *packed, __be32 *unpacked);
+
+#endif
