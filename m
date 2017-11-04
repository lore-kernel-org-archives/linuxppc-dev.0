Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yTWHn1xkXzDrCZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Nov 2017 18:52:04 +1100 (AEDT)
Date: Sat, 4 Nov 2017 10:51:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: powerpc/perf: Fix a sizeof() typo so we allocate less memory
Message-ID: <20171104075136.nujqcprikcevsfwv@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We're allocating the size of the struct which is 32 bytes when we should
be allocating sizeof(void *) which is 4 or 8 bytes depending on the
architecture.

Fixes: 885dcd709ba9 ("powerpc/perf: Add nest IMC PMU support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 88126245881b..91c90ddab807 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -210,7 +210,7 @@ static int update_events_in_group(struct device_node *node, struct imc_pmu *pmu)
 	of_property_read_u32(node, "reg", &base_reg);
 
 	/* Allocate memory for the events */
-	pmu->events = kcalloc(ct, sizeof(struct imc_events), GFP_KERNEL);
+	pmu->events = kcalloc(ct, sizeof(*pmu->events), GFP_KERNEL);
 	if (!pmu->events)
 		return -ENOMEM;
 
