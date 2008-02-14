Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 8FB8DDDF55
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 04:11:22 +1100 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org> Kim Phillips
	<kim.phillips@freescale.com> Li Yang <LeoLi@freescale.com>
Subject: [PATCH] Fix ucc_geth MII master selection
Date: Thu, 14 Feb 2008 18:11:21 +0100
Message-Id: <1203009081-10966-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove bogus UCC regs range test and correct
off by one error in call to ucc_set_qe_mux_mii_mng()

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---

I am not 100% sure this is the correct fix, please ACK or NACK

 drivers/net/ucc_geth_mii.c |   26 +++++++++++---------------
 1 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ucc_geth_mii.c b/drivers/net/ucc_geth_mii.c
index 6c257b8..472d5a1 100644
--- a/drivers/net/ucc_geth_mii.c
+++ b/drivers/net/ucc_geth_mii.c
@@ -200,21 +200,17 @@ static int uec_mdio_probe(struct of_device *ofdev, const struct of_device_id *ma
 		if (err)
 			goto bus_register_fail;
 
-		/* if our mdio regs fall within this UCC regs range */
-		if ((res.start >= tempres.start) &&
-		    (res.end <= tempres.end)) {
-			/* set this UCC to be the MII master */
-			const u32 *id = of_get_property(tempnp, "device-id", NULL);
-			if (id == NULL)
-				goto bus_register_fail;
-
-			ucc_set_qe_mux_mii_mng(*id - 1);
-
-			/* assign the TBI an address which won't
-			 * conflict with the PHYs */
-			out_be32(&regs->utbipar, UTBIPAR_INIT_TBIPA);
-			break;
-		}
+		/* set this UCC to be the MII master */
+		const u32 *id = of_get_property(tempnp, "device-id", NULL);
+		if (id == NULL)
+			goto bus_register_fail;
+
+		ucc_set_qe_mux_mii_mng(*id);
+
+		/* assign the TBI an address which won't
+		 * conflict with the PHYs */
+		out_be32(&regs->utbipar, UTBIPAR_INIT_TBIPA);
+		break;
 	}
 
 	err = mdiobus_register(new_bus);
-- 
1.5.3.8
