Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61C401A0E55
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Dec 2014 03:48:50 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Wed, 17 Dec 2014 16:48:46 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id D6C1417E7D98
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 15:31:29 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBHFUsmx39190558
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 15:30:54 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBHARXIp014038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Dec 2014 05:27:33 -0500
Subject: [PATCH v2 2/4] powerpc/vphn: move endianness fixing to
 vphn_unpack_associativity()
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Wed, 17 Dec 2014 10:42:40 +0100
Message-ID: <20141217094126.16957.20713.stgit@bahia.local>
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

The first argument to vphn_unpack_associativity() is a const long *, but the
parsing code expects __be64 values actually. Let's move the endian fixing
down for consistency.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---

 v2: only move the endian fixing. The logic is reworked in another patch.

 arch/powerpc/mm/numa.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 2a83e48..2e36a6f 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1263,13 +1263,18 @@ static int update_cpu_associativity_changes_mask(void)
  */
 static int vphn_unpack_associativity(const long *packed, __be32 *unpacked)
 {
+	__be64 be_packed[VPHN_REGISTER_COUNT];
 	int i, nr_assoc_doms = 0;
-	const __be16 *field = (const __be16 *) packed;
+	const __be16 *field = (const __be16 *) be_packed;
 
 #define VPHN_FIELD_UNUSED	(0xffff)
 #define VPHN_FIELD_MSB		(0x8000)
 #define VPHN_FIELD_MASK		(~VPHN_FIELD_MSB)
 
+	/* Let's recreate the original stream. */
+	for (i = 0; i < VPHN_REGISTER_COUNT; i++)
+		be_packed[i] = cpu_to_be64(packed[i]);
+
 	for (i = 1; i < VPHN_ASSOC_BUFSIZE; i++) {
 		if (be16_to_cpup(field) == VPHN_FIELD_UNUSED) {
 			/* All significant fields processed, and remaining
@@ -1310,11 +1315,8 @@ static long hcall_vphn(unsigned long cpu, __be32 *associativity)
 	long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
 	u64 flags = 1;
 	int hwcpu = get_hard_smp_processor_id(cpu);
-	int i;
 
 	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, hwcpu);
-	for (i = 0; i < VPHN_REGISTER_COUNT; i++)
-		retbuf[i] = cpu_to_be64(retbuf[i]);
 	vphn_unpack_associativity(retbuf, associativity);
 
 	return rc;
