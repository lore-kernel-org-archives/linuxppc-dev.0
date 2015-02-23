Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C0A781A1008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 02:14:45 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Mon, 23 Feb 2015 15:14:42 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1095917D805A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 15:14:56 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1NFEe9857344118
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 15:14:40 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1NFEdUK019493
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 08:14:40 -0700
Subject: [PATCH v3 4/5] powerpc/vphn: parsing code rewrite
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 23 Feb 2015 16:14:37 +0100
Message-ID: <20150223151437.21565.8231.stgit@bahia.local>
In-Reply-To: <20150223151412.21565.2251.stgit@bahia.local>
References: <20150223151412.21565.2251.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current VPHN parsing logic has some flaws that this patch aims to fix:

1) when the value 0xffff is read, the value 0xffffffff gets added to the
   the output list and its element count isn't incremented. This is wrong.
   According to PAPR+ the domain identifiers are packed into a sequence
   terminated by the "reserved value of all ones". This means that 0xffff
   is a stream terminator.

2) the combination of byteswaps and casts make the code hardly readable.
   Let's parse the stream one 16-bit field at a time instead.

3) it is assumed that the hypercall returns 12 32-bit values packed into
   6 64-bit registers. According to PAPR+, the domain identifiers may be
   streamed as 16-bit values. Let's increase the number of expected numbers
   to 24.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 arch/powerpc/mm/vphn.c |   54 +++++++++++++++++++++++++++++++++---------------
 arch/powerpc/mm/vphn.h |    6 +++--
 2 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/mm/vphn.c b/arch/powerpc/mm/vphn.c
index c49ed51..5f8ef50 100644
--- a/arch/powerpc/mm/vphn.c
+++ b/arch/powerpc/mm/vphn.c
@@ -2,44 +2,64 @@
 #include "vphn.h"
 
 /*
- * Convert the associativity domain numbers returned from the hypervisor
- * to the sequence they would appear in the ibm,associativity property.
+ * The associativity domain numbers are returned from the hypervisor as a
+ * stream of mixed 16-bit and 32-bit fields. The stream is terminated by the
+ * special value of "all ones" (aka. 0xffff) and its size may not exceed 48
+ * bytes.
+ *
+ *    --- 16-bit fields -->
+ *  _________________________
+ *  |  0  |  1  |  2  |  3  |   be_packed[0]
+ *  ------+-----+-----+------
+ *  _________________________
+ *  |  4  |  5  |  6  |  7  |   be_packed[1]
+ *  -------------------------
+ *            ...
+ *  _________________________
+ *  | 20  | 21  | 22  | 23  |   be_packed[5]
+ *  -------------------------
+ *
+ * Convert to the sequence they would appear in the ibm,associativity property.
  */
 int vphn_unpack_associativity(const long *packed, __be32 *unpacked)
 {
 	__be64 be_packed[VPHN_REGISTER_COUNT];
 	int i, nr_assoc_doms = 0;
 	const __be16 *field = (const __be16 *) be_packed;
+	u16 last = 0;
+	bool is_32bit = false;
 
 #define VPHN_FIELD_UNUSED	(0xffff)
 #define VPHN_FIELD_MSB		(0x8000)
 #define VPHN_FIELD_MASK		(~VPHN_FIELD_MSB)
 
-	/* Let's recreate the original stream. */
+	/* Let's fix the values returned by plpar_hcall9() */
 	for (i = 0; i < VPHN_REGISTER_COUNT; i++)
 		be_packed[i] = cpu_to_be64(packed[i]);
 
 	for (i = 1; i < VPHN_ASSOC_BUFSIZE; i++) {
-		if (be16_to_cpup(field) == VPHN_FIELD_UNUSED) {
-			/* All significant fields processed, and remaining
-			 * fields contain the reserved value of all 1's.
-			 * Just store them.
+		u16 new = be16_to_cpup(field++);
+
+		if (is_32bit) {
+			/* Let's concatenate the 16 bits of this field to the
+			 * 15 lower bits of the previous field
 			 */
-			unpacked[i] = *((__be32 *)field);
-			field += 2;
-		} else if (be16_to_cpup(field) & VPHN_FIELD_MSB) {
+			unpacked[++nr_assoc_doms] =
+				cpu_to_be32(last << 16 | new);
+			is_32bit = false;
+		} else if (new == VPHN_FIELD_UNUSED)
+			/* This is the list terminator */
+			break;
+		else if (new & VPHN_FIELD_MSB) {
 			/* Data is in the lower 15 bits of this field */
-			unpacked[i] = cpu_to_be32(
-				be16_to_cpup(field) & VPHN_FIELD_MASK);
-			field++;
-			nr_assoc_doms++;
+			unpacked[++nr_assoc_doms] =
+				cpu_to_be32(new & VPHN_FIELD_MASK);
 		} else {
 			/* Data is in the lower 15 bits of this field
 			 * concatenated with the next 16 bit field
 			 */
-			unpacked[i] = *((__be32 *)field);
-			field += 2;
-			nr_assoc_doms++;
+			last = new;
+			is_32bit = true;
 		}
 	}
 
diff --git a/arch/powerpc/mm/vphn.h b/arch/powerpc/mm/vphn.h
index 96af9a4..fe8b780 100644
--- a/arch/powerpc/mm/vphn.h
+++ b/arch/powerpc/mm/vphn.h
@@ -6,10 +6,10 @@
 #define VPHN_REGISTER_COUNT 6
 
 /*
- * 6 64-bit registers unpacked into 12 32-bit associativity values. To form
- * the complete property we have to add the length in the first cell.
+ * 6 64-bit registers unpacked into up to 24 be32 associativity values. To
+ * form the complete property we have to add the length in the first cell.
  */
-#define VPHN_ASSOC_BUFSIZE (VPHN_REGISTER_COUNT*sizeof(u64)/sizeof(u32) + 1)
+#define VPHN_ASSOC_BUFSIZE (VPHN_REGISTER_COUNT*sizeof(u64)/sizeof(u16) + 1)
 
 extern int vphn_unpack_associativity(const long *packed, __be32 *unpacked);
 
