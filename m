Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DAE61A0465
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 19:13:31 +1000 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Fri, 3 Oct 2014 10:13:27 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id D80201B08049
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 10:14:37 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s939DO4G59179070
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Oct 2014 09:13:24 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s939DOTO029463
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Oct 2014 05:13:24 -0400
Subject: [PATCH v2] powerpc/vphn: fix endian issue in NUMA device node code
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 03 Oct 2014 11:13:17 +0200
Message-ID: <20141003091250.28354.13766.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The associativity domain numbers are obtained from the hypervisor through
registers and written into memory by the guest: the packed array passed to
vphn_unpack_associativity() is then native-endian, unlike what was assumed
in the following commit:

commit b08a2a12e44eaec5024b2b969f4fcb98169d1ca3
Author: Alistair Popple <alistair@popple.id.au>
Date:   Wed Aug 7 02:01:44 2013 +1000

    powerpc: Make NUMA device node code endian safe

If a CPU home node changes, the topology gets filled with
bogus values. This leads to severe performance breakdowns.

This patch does two things:
- extract values from the packed array with shifts, in order to be endian
  neutral
- convert the resulting values to be32 as expected

Suggested-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---

Changes in v2:
- removed the left out __be16 *field declaration
- removed the left out be16_to_cpup() call
- updated the comment of the magic formula

Thanks again Nish... the two left outs probably explain why PowerVM wasn't
happy that patch. :P

--
Greg

 arch/powerpc/mm/numa.c |   64 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index b835bf0..4547f91 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1369,38 +1369,78 @@ static int update_cpu_associativity_changes_mask(void)
 #define VPHN_ASSOC_BUFSIZE (6*sizeof(u64)/sizeof(u32) + 1)
 
 /*
+ * The associativity values are either 16-bit (VPHN_FIELD_MSB) or 32-bit (data
+ * or VPHN_FIELD_UNUSED). We hence need to parse the packed array into 16-bit
+ * chunks. Let's do that with bit shifts to be endian neutral.
+ *
+ *    --- 16-bit chunks -->
+ *  _________________________
+ *  |  0  |  1  |  2  |  3  |   packed[0]
+ *  -------------------------
+ *  _________________________
+ *  |  4  |  5  |  6  |  7  |   packed[1]
+ *  -------------------------
+ *            ...
+ *  _________________________
+ *  | 20  | 21  | 22  | 23  |   packed[5]
+ *  -------------------------
+ *       48    32    16     0
+ *    <------ bits -------- 
+ *
+ * We need 48-bit shift for chunks 0,4,8,16,20
+ *         32-bit shift for chunks 1,5,9,17,21
+ *         16-bit shift for chunks 2,6,10,18,22
+ *             no shift for chunks 3,7,11,19,23
+ *
+ * The 2 lo bits of the chunk index multiplied by 16 give the shift.
+ * The remaining hi bits divided by 4 give the index in packed[].
+ *
+ * For example:
+ * chunk  0 = packed[0/4]  >> (~0b00000 & 0b11) * 16 = bits 48..63 in packed[0]
+ * chunk  5 = packed[5/4]  >> (~0b00101 & 0b11) * 16 = bits 32..47 in packed[1]
+ * chunk 22 = packed[22/4] >> (~0b10110 & 0b11) * 16 = bits 16..31 in packed[5]
+ */
+static inline u16 read_vphn_chunk(const long *packed, unsigned int i)
+{
+	return packed[i >> 2] >> ((~i & 3) << 4);
+}
+
+/*
  * Convert the associativity domain numbers returned from the hypervisor
  * to the sequence they would appear in the ibm,associativity property.
  */
 static int vphn_unpack_associativity(const long *packed, __be32 *unpacked)
 {
-	int i, nr_assoc_doms = 0;
-	const __be16 *field = (const __be16 *) packed;
+	unsigned int i, j, nr_assoc_doms = 0;
 
 #define VPHN_FIELD_UNUSED	(0xffff)
 #define VPHN_FIELD_MSB		(0x8000)
 #define VPHN_FIELD_MASK		(~VPHN_FIELD_MSB)
 
-	for (i = 1; i < VPHN_ASSOC_BUFSIZE; i++) {
-		if (be16_to_cpup(field) == VPHN_FIELD_UNUSED) {
+	for (i = 1, j = 0; i < VPHN_ASSOC_BUFSIZE; i++) {
+		u16 field = read_vphn_chunk(packed, j);
+
+		if (field == VPHN_FIELD_UNUSED) {
 			/* All significant fields processed, and remaining
 			 * fields contain the reserved value of all 1's.
 			 * Just store them.
 			 */
-			unpacked[i] = *((__be32 *)field);
-			field += 2;
-		} else if (be16_to_cpup(field) & VPHN_FIELD_MSB) {
+			unpacked[i] = (VPHN_FIELD_UNUSED << 16 |
+				       VPHN_FIELD_UNUSED);
+			j += 2;
+		} else if (field & VPHN_FIELD_MSB) {
 			/* Data is in the lower 15 bits of this field */
-			unpacked[i] = cpu_to_be32(
-				be16_to_cpup(field) & VPHN_FIELD_MASK);
-			field++;
+			unpacked[i] = cpu_to_be32(field & VPHN_FIELD_MASK);
+			j++;
 			nr_assoc_doms++;
 		} else {
 			/* Data is in the lower 15 bits of this field
 			 * concatenated with the next 16 bit field
 			 */
-			unpacked[i] = *((__be32 *)field);
-			field += 2;
+			unpacked[i] =
+				cpu_to_be32((u32) field << 16 |
+					    read_vphn_chunk(packed, j + 1));
+			j += 2;
 			nr_assoc_doms++;
 		}
 	}
