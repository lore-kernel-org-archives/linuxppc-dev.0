Return-Path: <David.Gounaris@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 423qWN1RG1zF37K
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2018 22:48:00 +1000 (AEST)
From: David Gounaris <david.gounaris@infinera.com>
To: qiang.zhao@nxp.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 joakim.tjernlund@infinera.com
Cc: David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH v3 5/6] net/wan/fsl_ucc_hdlc: GUMR for non tsa mode
Date: Mon,  3 Sep 2018 14:47:29 +0200
Message-Id: <20180903124730.1551-6-david.gounaris@infinera.com>
In-Reply-To: <20180903124730.1551-1-david.gounaris@infinera.com>
References: <20180828110921.2542-2-david.gounaris@infinera.com>
 <20180903124730.1551-1-david.gounaris@infinera.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following bits in the GUMR is changed for non
tsa mode: CDS, CTSP and CTSS are set to zero.

When set, there is no tx interrupts from the controller.

Signed-off-by: David Gounaris <david.gounaris@infinera.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 3dacafb219c6..999d93fa54f7 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -97,6 +97,12 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 	if (priv->tsa) {
 		uf_info->tsa = 1;
 		uf_info->ctsp = 1;
+		uf_info->cds = 1;
+		uf_info->ctss = 1;
+	} else {
+		uf_info->cds = 0;
+		uf_info->ctsp = 0;
+		uf_info->ctss = 0;
 	}
 
 	/* This sets HPM register in CMXUCR register which configures a
-- 
2.13.6
