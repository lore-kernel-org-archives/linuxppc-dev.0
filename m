Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5GdS5CKgzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 16:10:52 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7564IoD066044
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Aug 2016 02:10:50 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkam710q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Aug 2016 02:10:49 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 5 Aug 2016 00:10:49 -0600
Date: Thu, 4 Aug 2016 23:10:41 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/pseries: Use a helper to fixup nr_cores
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20160805061041.GA31857@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>From d49b597623ac58fa1ab61ce0157470b6390e9a67 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Fri, 5 Aug 2016 00:01:54 -0400
Subject: [PATCH 1/2] powerpc/pseries: Use a helper to fixup nr_cores.

We have to fixup RMA size also, so using helpers will make it cleaner
and consistent.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c | 70 ++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 6ee4b72..f612a99 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -863,47 +863,53 @@ static int __init prom_count_smt_threads(void)
 
 }
 
+static void fixup_nr_cores(void)
+{
+	u32 cores;
+	unsigned char *ptcores;
+
+	/* We need to tell the FW about the number of cores we support.
+	 *
+	 * To do that, we count the number of threads on the first core
+	 * (we assume this is the same for all cores) and use it to
+	 * divide NR_CPUS.
+	 */
+
+	/* The core value may start at an odd address. If such a word
+	 * access is made at a cache line boundary, this leads to an
+	 * exception which may not be handled at this time.
+	 * Forcing a per byte access to avoid exception.
+	 */
+	ptcores = &ibm_architecture_vec[IBM_ARCH_VEC_NRCORES_OFFSET];
+	cores = 0;
+	cores |= ptcores[0] << 24;
+	cores |= ptcores[1] << 16;
+	cores |= ptcores[2] << 8;
+	cores |= ptcores[3];
+	if (cores != NR_CPUS) {
+		prom_printf("WARNING ! "
+			    "ibm_architecture_vec structure inconsistent: %lu!\n",
+			    cores);
+	} else {
+		cores = DIV_ROUND_UP(NR_CPUS, prom_count_smt_threads());
+		prom_printf("Max number of cores passed to firmware: %lu (NR_CPUS = %lu)\n",
+			    cores, NR_CPUS);
+		ptcores[0] = (cores >> 24) & 0xff;
+		ptcores[1] = (cores >> 16) & 0xff;
+		ptcores[2] = (cores >> 8) & 0xff;
+		ptcores[3] = cores & 0xff;
+	}
+}
 
 static void __init prom_send_capabilities(void)
 {
 	ihandle root;
 	prom_arg_t ret;
-	u32 cores;
-	unsigned char *ptcores;
 
 	root = call_prom("open", 1, 1, ADDR("/"));
 	if (root != 0) {
-		/* We need to tell the FW about the number of cores we support.
-		 *
-		 * To do that, we count the number of threads on the first core
-		 * (we assume this is the same for all cores) and use it to
-		 * divide NR_CPUS.
-		 */
 
-		/* The core value may start at an odd address. If such a word
-		 * access is made at a cache line boundary, this leads to an
-		 * exception which may not be handled at this time.
-		 * Forcing a per byte access to avoid exception.
-		 */
-		ptcores = &ibm_architecture_vec[IBM_ARCH_VEC_NRCORES_OFFSET];
-		cores = 0;
-		cores |= ptcores[0] << 24;
-		cores |= ptcores[1] << 16;
-		cores |= ptcores[2] << 8;
-		cores |= ptcores[3];
-		if (cores != NR_CPUS) {
-			prom_printf("WARNING ! "
-				    "ibm_architecture_vec structure inconsistent: %lu!\n",
-				    cores);
-		} else {
-			cores = DIV_ROUND_UP(NR_CPUS, prom_count_smt_threads());
-			prom_printf("Max number of cores passed to firmware: %lu (NR_CPUS = %lu)\n",
-				    cores, NR_CPUS);
-			ptcores[0] = (cores >> 24) & 0xff;
-			ptcores[1] = (cores >> 16) & 0xff;
-			ptcores[2] = (cores >> 8) & 0xff;
-			ptcores[3] = cores & 0xff;
-		}
+		fixup_nr_cores();
 
 		/* try calling the ibm,client-architecture-support method */
 		prom_printf("Calling ibm,client-architecture-support...");
-- 
1.8.3.1
