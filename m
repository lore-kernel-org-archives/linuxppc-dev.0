Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3EB0E1A1EE5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 19:39:01 +1100 (AEDT)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Wed, 12 Nov 2014 08:38:58 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 708942190043
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 08:38:29 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAC8ctNQ66977986
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 08:38:55 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAC8cslI019889
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 01:38:55 -0700
Subject: [PATCH 3/3] powerpc/vphn: move endianness fixing to
 vphn_unpack_associativity()
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Nov 2014 09:38:53 +0100
Message-ID: <20141112083853.6896.45789.stgit@bahia.local>
In-Reply-To: <20141112083123.6492.22889.stgit@bahia.local>
References: <20141112083123.6492.22889.stgit@bahia.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The first argument to vphn_unpack_associativity() is a const long *, but the
parsing code expects __be64 values actually. This is inconsistent. We should
either pass a const __be64 * or change vphn_unpack_associativity() so that
it fixes endianness by itself.

This patch does the latter, since the caller doesn't need to know about
endianness and this allows to fix significant 64-bit values only. Please
note that the previous code was able to cope with 32-bit fields being split
accross two consecutives 64-bit values. Since PAPR+ doesn't say this cannot
happen, the behaviour was kept. It requires extra checking to know when fixing
is needed though.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index e30c469..903ef27 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1417,30 +1417,49 @@ static int update_cpu_associativity_changes_mask(void)
  */
 static int vphn_unpack_associativity(const long *packed, __be32 *unpacked)
 {
-	int i;
-	const __be16 *field = (const __be16 *) packed;
+	int i, j, k;
+	union {
+		__be64 packed[VPHN_REGISTER_COUNT];
+		__be16 field[VPHN_REGISTER_COUNT * 4];
+	} fixed;
 
 #define VPHN_FIELD_UNUSED	(0xffff)
 #define VPHN_FIELD_MSB		(0x8000)
 #define VPHN_FIELD_MASK		(~VPHN_FIELD_MSB)
 
-	for (i = 1; i < VPHN_ASSOC_BUFSIZE; i++) {
-		if (be16_to_cpup(field) == VPHN_FIELD_UNUSED)
+	for (i = 1, j = 0, k = 0; i < VPHN_ASSOC_BUFSIZE;) {
+		u16 field;
+
+		if (j % 4 == 0) {
+			fixed.packed[k] = cpu_to_be64(packed[k]);
+			k++;
+		}
+
+		field = be16_to_cpu(fixed.field[j]);
+
+		if (field == VPHN_FIELD_UNUSED)
 			/* All significant fields processed.
 			 */
 			break;
 
-		if (be16_to_cpup(field) & VPHN_FIELD_MSB) {
+		if (field & VPHN_FIELD_MSB) {
 			/* Data is in the lower 15 bits of this field */
-			unpacked[i] = cpu_to_be32(
-				be16_to_cpup(field) & VPHN_FIELD_MASK);
-			field++;
+			unpacked[i++] = cpu_to_be32(field & VPHN_FIELD_MASK);
+			j++;
 		} else {
 			/* Data is in the lower 15 bits of this field
 			 * concatenated with the next 16 bit field
 			 */
-			unpacked[i] = *((__be32 *)field);
-			field += 2;
+			if (unlikely(j % 4 == 3)) {
+				/* The next field is to be copied from the next
+				 * 64-bit input value. We must fix it now.
+				 */
+				fixed.packed[k] = cpu_to_be64(packed[k]);
+				k++;
+			}
+
+			unpacked[i++] = *((__be32 *)&fixed.field[j]);
+			j += 2;
 		}
 	}
 
@@ -1460,11 +1479,8 @@ static long hcall_vphn(unsigned long cpu, __be32 *associativity)
 	long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
 	u64 flags = 1;
 	int hwcpu = get_hard_smp_processor_id(cpu);
-	int i;
 
 	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, hwcpu);
-	for (i = 0; i < VPHN_REGISTER_COUNT; i++)
-		retbuf[i] = cpu_to_be64(retbuf[i]);
 	vphn_unpack_associativity(retbuf, associativity);
 
 	return rc;
