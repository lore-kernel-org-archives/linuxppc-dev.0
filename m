Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40909X36pzzF241
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 03:34:56 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2QGLdf8019411
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:34:54 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gy3nd2deu-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 12:34:53 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Mon, 26 Mar 2018 10:34:53 -0600
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH v3 33/41] cxlflash: Setup LISNs for master contexts
Date: Mon, 26 Mar 2018 11:34:48 -0500
In-Reply-To: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1522081759-57431-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1522082088-58675-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Similar to user contexts, master contexts also require that the per-context
LISN registers be programmed for certain AFUs. The mapped trigger page is
obtained from underlying transport and registered with AFU for each master
context.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 5d754d1..8c55fcd 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -1756,6 +1756,8 @@ static int init_global(struct cxlflash_cfg *cfg)
 	u64 wwpn[MAX_FC_PORTS];	/* wwpn of AFU ports */
 	int i = 0, num_ports = 0;
 	int rc = 0;
+	int j;
+	void *ctx;
 	u64 reg;
 
 	rc = read_vpd(cfg, &wwpn[0]);
@@ -1816,6 +1818,25 @@ static int init_global(struct cxlflash_cfg *cfg)
 		msleep(100);
 	}
 
+	if (afu_is_ocxl_lisn(afu)) {
+		/* Set up the LISN effective address for each master */
+		for (i = 0; i < afu->num_hwqs; i++) {
+			hwq = get_hwq(afu, i);
+			ctx = hwq->ctx_cookie;
+
+			for (j = 0; j < hwq->num_irqs; j++) {
+				reg = cfg->ops->get_irq_objhndl(ctx, j);
+				writeq_be(reg, &hwq->ctrl_map->lisn_ea[j]);
+			}
+
+			reg = hwq->ctx_hndl;
+			writeq_be(SISL_LISN_PASID(reg, reg),
+				  &hwq->ctrl_map->lisn_pasid[0]);
+			writeq_be(SISL_LISN_PASID(0UL, reg),
+				  &hwq->ctrl_map->lisn_pasid[1]);
+		}
+	}
+
 	/* Set up master's own CTX_CAP to allow real mode, host translation */
 	/* tables, afu cmds and read/write GSCSI cmds. */
 	/* First, unlock ctx_cap write by reading mbox */
-- 
2.1.0
