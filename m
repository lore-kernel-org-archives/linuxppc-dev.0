Return-Path: <mort@bork.org>
Received: from darwin.bork.org (darwin.bork.org [IPv6:2001:470:1f05:998::1])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFD6B1A0D7A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 07:05:53 +1100 (AEDT)
Date: Thu, 19 Feb 2015 15:05:47 -0500
From: Martin Hicks <mort@bork.org>
To: Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] sata-fsl: Apply link speed limits
Message-ID: <20150219200547.GA25730@darwin.bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



The driver was ignoring limits requested by libata.force.  The output
would look like:

fsl-sata ffe18000.sata: Sata FSL Platform/CSB Driver init
ata1: FORCE: PHY spd limit set to 1.5Gbps
ata1: SATA max UDMA/133 irq 74
ata1: Signature Update detected @ 0 msecs
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 310)

Signed-off-by: Martin Hicks <mort@bork.org>
---
 drivers/ata/sata_fsl.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index f9054cd..a9b5508 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -868,6 +868,8 @@ try_offline_again:
 	 * PHY reset should remain asserted for atleast 1ms
 	 */
 	ata_msleep(ap, 1);
+	
+	sata_set_spd(link);
 
 	/*
 	 * Now, bring the host controller online again, this can take time
-- 
1.7.10.4


-- 
Martin Hicks P.Eng.    |      mort@bork.org
Bork Consulting Inc.   |  +1 (613) 266-2296
