Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 01E1D1A1FB2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 04:42:46 +1100 (AEDT)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Mon, 17 Nov 2014 17:42:42 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 316A617D8045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 17:42:52 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAHHgehO9961814
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 17:42:40 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAHHgeO1015972
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Nov 2014 10:42:40 -0700
Subject: [PATCH REPOST 2/3] powerpc/vphn: simplify the parsing code
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Nov 2014 18:42:38 +0100
Message-ID: <20141117174230.7717.25270.stgit@bahia.local>
In-Reply-To: <20141117174216.7717.10926.stgit@bahia.local>
References: <20141117174216.7717.10926.stgit@bahia.local>
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

According to PAPR+ 14.11.6.1 H_HOME_NODE_ASSOCIATIVITY, the hypervisor is
supposed to pack significant fields first and fill the remaining unused
fields with "all ones". It means that the first unused field can be viewed
as an end-of-list marker.
The "ibm,associativity" property in the DT isn't padded with ones and no
code in arch/powerpc/mm/numa.c seems to expect the associativity array
to be padded either.

This patch simply ends the parsing when we reach the first unused field.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 1425517..e30c469 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1417,7 +1417,7 @@ static int update_cpu_associativity_changes_mask(void)
  */
 static int vphn_unpack_associativity(const long *packed, __be32 *unpacked)
 {
-	int i, nr_assoc_doms = 0;
+	int i;
 	const __be16 *field = (const __be16 *) packed;
 
 #define VPHN_FIELD_UNUSED	(0xffff)
@@ -1425,33 +1425,29 @@ static int vphn_unpack_associativity(const long *packed, __be32 *unpacked)
 #define VPHN_FIELD_MASK		(~VPHN_FIELD_MSB)
 
 	for (i = 1; i < VPHN_ASSOC_BUFSIZE; i++) {
-		if (be16_to_cpup(field) == VPHN_FIELD_UNUSED) {
-			/* All significant fields processed, and remaining
-			 * fields contain the reserved value of all 1's.
-			 * Just store them.
+		if (be16_to_cpup(field) == VPHN_FIELD_UNUSED)
+			/* All significant fields processed.
 			 */
-			unpacked[i] = *((__be32 *)field);
-			field += 2;
-		} else if (be16_to_cpup(field) & VPHN_FIELD_MSB) {
+			break;
+
+		if (be16_to_cpup(field) & VPHN_FIELD_MSB) {
 			/* Data is in the lower 15 bits of this field */
 			unpacked[i] = cpu_to_be32(
 				be16_to_cpup(field) & VPHN_FIELD_MASK);
 			field++;
-			nr_assoc_doms++;
 		} else {
 			/* Data is in the lower 15 bits of this field
 			 * concatenated with the next 16 bit field
 			 */
 			unpacked[i] = *((__be32 *)field);
 			field += 2;
-			nr_assoc_doms++;
 		}
 	}
 
 	/* The first cell contains the length of the property */
-	unpacked[0] = cpu_to_be32(nr_assoc_doms);
+	unpacked[0] = cpu_to_be32(i - 1);
 
-	return nr_assoc_doms;
+	return i - 1;
 }
 
 /*
