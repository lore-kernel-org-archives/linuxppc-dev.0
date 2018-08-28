Return-Path: <David.Gounaris@infinera.com>
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 4205ld3bvVzDr5Y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 21:15:41 +1000 (AEST)
From: David Gounaris <david.gounaris@infinera.com>
To: qiang.zhao@nxp.com, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: David Gounaris <david.gounaris@infinera.com>
Subject: [PATCH 5/6] net/wan/fsl_ucc_hdlc: GUMR for non tsa mode
Date: Tue, 28 Aug 2018 13:09:20 +0200
Message-Id: <20180828110921.2542-6-david.gounaris@infinera.com>
In-Reply-To: <20180828110921.2542-1-david.gounaris@infinera.com>
References: <20180828110921.2542-1-david.gounaris@infinera.com>
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
 drivers/net/wan/fsl_ucc_hdlc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 54e2b2143e36..e6154a6547e6 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -97,6 +97,13 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 	if (priv->tsa) {
 		uf_info->tsa = 1;
 		uf_info->ctsp = 1;
+		uf_info->cds = 1;
+		uf_info->ctss = 1;
+	}
+	else {
+		uf_info->cds = 0;
+		uf_info->ctsp = 0;
+		uf_info->ctss = 0;
 	}
 
 	/* This sets HPM register in CMXUCR register which configures a
-- 
2.13.6
