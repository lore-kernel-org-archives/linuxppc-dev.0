Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0101DE4E3
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 07:55:02 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: netdev@vger.kernel.org
Subject: [PATCH] gianfar: ensure ECNTRL[R100] is cleared on link state change
Date: Tue,  6 Jan 2009 14:52:51 -0600
Message-Id: <1231275171-21388-1-git-send-email-galak@kernel.crashing.org>
Cc: Leo Li <leo@rock.ap.freescale.net>, linuxppc-dev@ozlabs.org,
	afleming@freescale.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Leo Li <leo@rock.ap.freescale.net>

When changing the link between 100Mbps and 1Gbps in SGMII mode it was
found out that the link would stop working.  The issue is that ECNTRL[R100]
needs to be cleared when in 1Gbps mode.  Older reference manuals didn't
require the explicitly clearing but has since been found it that it is
needed.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Dave,

Please apply for 2.6.29 as it addresses a "HW" bug in real systems.

thanks

- k

 drivers/net/gianfar.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index c672ecf..7fcc3af 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -1973,6 +1973,8 @@ static void adjust_link(struct net_device *dev)
 			case 1000:
 				tempval =
 				    ((tempval & ~(MACCFG2_IF)) | MACCFG2_GMII);
+
+				ecntrl &= ~(ECNTRL_R100);
 				break;
 			case 100:
 			case 10:
-- 
1.5.6.5
