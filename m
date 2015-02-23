Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 019BD1A0EFC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 02:14:32 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Mon, 23 Feb 2015 15:14:29 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 783C117D805F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 15:14:42 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1NFEQ7B55902258
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 15:14:26 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1NFEQcP018902
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 08:14:26 -0700
Subject: [PATCH v3 2/5] powerpc/vphn: move endianness fixing to
 vphn_unpack_associativity()
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 23 Feb 2015 16:14:25 +0100
Message-ID: <20150223151425.21565.49048.stgit@bahia.local>
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

The first argument to vphn_unpack_associativity() is a const long *, but the
parsing code expects __be64 values actually. Let's move the endian fixing
down for consistency.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 7a5bc21..59196c5 100644
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
