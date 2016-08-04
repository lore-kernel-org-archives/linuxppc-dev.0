Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4dwG4YhczDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 15:36:30 +1000 (AEST)
Date: Thu, 4 Aug 2016 08:35:25 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexandre Bounine <alexandre.bounine@idt.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org
Subject: [patch] powerpc/fsl_rio: fix a missing error code
Message-ID: <20160804053525.GM775@mwanda>
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

We should set the error code here.  Otherwise static checkers complain.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 984e816..68e7c0d 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -491,6 +491,7 @@ int fsl_rio_setup(struct platform_device *dev)
 	rmu_node = of_parse_phandle(dev->dev.of_node, "fsl,srio-rmu-handle", 0);
 	if (!rmu_node) {
 		dev_err(&dev->dev, "No valid fsl,srio-rmu-handle property\n");
+		rc = -ENOENT;
 		goto err_rmu;
 	}
 	rc = of_address_to_resource(rmu_node, 0, &rmu_regs);
