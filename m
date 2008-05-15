Return-Path: <mcarlson@broadcom.com>
Received: from mms2.broadcom.com (mms2.broadcom.com [216.31.210.18])
	by ozlabs.org (Postfix) with ESMTP id 3DF32DDF6B
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 03:18:21 +1000 (EST)
Date: Thu, 15 May 2008 10:15:20 -0700
From: "Matt Carlson" <mcarlson@broadcom.com>
To: "Olaf Hering" <olaf@aepfle.de>
Subject: Re: dead network on JS21 with tg3 driver after flowcontrol
 changes
Message-ID: <20080515171520.GA20953@localdomain>
References: <20080515121340.GA23033@aepfle.de>
MIME-Version: 1.0
In-Reply-To: <20080515121340.GA23033@aepfle.de>
Content-Type: text/plain;
 charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Matt Carlson <mcarlson@broadcom.com>, Michael Chan <mchan@broadcom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If you were to start with the original file, does the following patch
fix the problem?


diff --git a/drivers/net/tg3.c b/drivers/net/tg3.c
index 07b3f77..4c248d7 100644
--- a/drivers/net/tg3.c
+++ b/drivers/net/tg3.c
@@ -3168,8 +3168,7 @@ static int tg3_setup_fiber_mii_phy(struct tg3 *tp, int force_reset)
 	err |= tg3_readphy(tp, MII_BMCR, &bmcr);
 
 	if ((tp->link_config.autoneg == AUTONEG_ENABLE) && !force_reset &&
-	    (tp->tg3_flags2 & TG3_FLG2_PARALLEL_DETECT) &&
-	     tp->link_config.flowctrl == tp->link_config.active_flowctrl) {
+	    (tp->tg3_flags2 & TG3_FLG2_PARALLEL_DETECT)) {
 		/* do nothing, just check for link up at the end */
 	} else if (tp->link_config.autoneg == AUTONEG_ENABLE) {
 		u32 adv, new_adv;
