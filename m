Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp11.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F0C252C00DD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 19:52:59 +1000 (EST)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 17 Sep 2013 10:52:52 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 14B34219005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 10:52:50 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8H9qbNe66846782
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 09:52:37 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8H9qnN7002605
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 03:52:49 -0600
Subject: [PATCH] powerpc: prom_init exception when updating core value
To: linuxppc-dev@lists.ozlabs.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 17 Sep 2013 11:52:48 +0200
Message-ID: <20130917095248.17584.60243.stgit@nimbus>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: tbreeds@au1.ibm.com, benh@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the CPU is generating an exception when accessing unaligned word, and
as this exception is not yet handled when running prom_init, data should be
copied from the architecture vector byte per byte.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c |   28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index edcb6be..50065ee 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -855,7 +855,8 @@ static void __init prom_send_capabilities(void)
 {
 	ihandle root;
 	prom_arg_t ret;
-	__be32 *cores;
+	u32 cores;
+	unsigned char *ptcores;
 
 	root = call_prom("open", 1, 1, ADDR("/"));
 	if (root != 0) {
@@ -865,15 +866,30 @@ static void __init prom_send_capabilities(void)
 		 * (we assume this is the same for all cores) and use it to
 		 * divide NR_CPUS.
 		 */
-		cores = (__be32 *)&ibm_architecture_vec[IBM_ARCH_VEC_NRCORES_OFFSET];
-		if (be32_to_cpup(cores) != NR_CPUS) {
+
+		/* The core value may start at an odd address. If such a word
+		 * access is made at a cache line boundary, this leads to an
+		 * exception which may not be handled at this time.
+		 * Forcing a per byte access to avoid exception.
+		 */
+		ptcores = &ibm_architecture_vec[IBM_ARCH_VEC_NRCORES_OFFSET];
+		cores = 0;
+		cores |= ptcores[0] << 24;
+		cores |= ptcores[1] << 16;
+		cores |= ptcores[2] << 8;
+		cores |= ptcores[3];
+		if (cores != NR_CPUS) {
 			prom_printf("WARNING ! "
 				    "ibm_architecture_vec structure inconsistent: %lu!\n",
-				    be32_to_cpup(cores));
+				    cores);
 		} else {
-			*cores = cpu_to_be32(DIV_ROUND_UP(NR_CPUS, prom_count_smt_threads()));
+			cores = DIV_ROUND_UP(NR_CPUS, prom_count_smt_threads());
 			prom_printf("Max number of cores passed to firmware: %lu (NR_CPUS = %lu)\n",
-				    be32_to_cpup(cores), NR_CPUS);
+				    cores, NR_CPUS);
+			ptcores[0] = (cores >> 24) & 0xff;
+			ptcores[1] = (cores >> 16) & 0xff;
+			ptcores[2] = (cores >> 8) & 0xff;
+			ptcores[3] = cores & 0xff;
 		}
 
 		/* try calling the ibm,client-architecture-support method */
