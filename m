From: benh@kernel.crashing.org
To: Michael Zucca <mzucca@ne.mediaone.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.18 and dmasound and rebooting
Date: Mon, 4 Mar 2002 01:03:25 +0100
Message-Id: <20020304000325.21818@mailhost.mipsys.com>
In-Reply-To: <3C827800.67CC4435@ne.mediaone.net>
References: <3C827800.67CC4435@ne.mediaone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Can you try this patch and tell me if it helps ?

===== drivers/sound/dmasound/dmasound_awacs.c 1.21 vs edited =====
--- 1.21/drivers/sound/dmasound/dmasound_awacs.c	Tue Feb  5 09:58:03 2002
+++ edited/drivers/sound/dmasound/dmasound_awacs.c	Mon Mar  4 11:32:36 2002
@@ -963,7 +963,9 @@
 			st_le16(&cp->res_count, 0);
 			st_le16(&cp->xfer_status, 0);
 			st_le32(&cp->phy_addr, phy);
-			st_le16(&cp->command, OUTPUT_MORE + INTR_ALWAYS);
+			st_le32(&cp->cmd_dep, virt_to_bus
(&awacs_tx_cmds[(i+1)%write_sq.max_count]));
+			st_le16(&cp->command, OUTPUT_MORE | BR_ALWAYS | INTR_ALWAYS);
+
 			/* point at our patched up command block */
 			out_le32(&awacs_txdma->cmdptr, virt_to_bus(cp));
 			/* we must re-start the controller */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
