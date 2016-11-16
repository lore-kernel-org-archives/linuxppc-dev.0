Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0062.outbound.protection.outlook.com [104.47.42.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJn4L3svZzDvmd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:40:50 +1100 (AEDT)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <oss@buserror.net>, <roy.pledge@nxp.com>
Subject: [PATCH 06/17] soc/qman: Fix direct access to fd's addr_lo,
 use proper accesor
Date: Wed, 16 Nov 2016 16:40:19 +0200
Message-ID: <1479307230-16650-7-git-send-email-claudiu.manoil@nxp.com>
In-Reply-To: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
References: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the proper accessor to get the FD address.
Accessing the internal field "addr_lo" directly is not portable
and error prone.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 80ff0b7..b4ef4a3 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1239,8 +1239,8 @@ static int qman_create_portal(struct qman_portal *portal,
 		/* special handling, drain just in case it's a few FQRNIs */
 		const union qm_mr_entry *e = qm_mr_current(p);
 
-		dev_err(c->dev, "MR dirty, VB 0x%x, rc 0x%x\n, addr 0x%x",
-			e->verb, e->ern.rc, e->ern.fd.addr_lo);
+		dev_err(c->dev, "MR dirty, VB 0x%x, rc 0x%x, addr 0x%llx\n",
+			e->verb, e->ern.rc, qm_fd_addr_get64(&e->ern.fd));
 		goto fail_dqrr_mr_empty;
 	}
 	/* Success */
-- 
1.7.11.7
