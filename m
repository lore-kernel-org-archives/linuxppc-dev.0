Return-Path: <dan.carpenter@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqtT91s39zDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 21:17:17 +1000 (AEST)
Date: Thu, 14 Jul 2016 14:16:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org, walter harms <wharms@bfs.de>
Subject: [patch v2 -next] wan/fsl_ucc_hdlc: info leak in uhdlc_ioctl()
Message-ID: <20160714111653.GA30452@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57876EE0.10603@bfs.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a 2 byte struct whole after line.loopback so we need to clear
that out to avoid disclosing stack information.

Fixes: c19b6d246a35 ('drivers/net: support hdlc function for QE-UCC')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: remove the other initialization to zero

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 19174ac..6edd48a 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -635,9 +635,8 @@ static int uhdlc_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 			ifr->ifr_settings.size = size; /* data size wanted */
 			return -ENOBUFS;
 		}
+		memset(&line, 0, sizeof(line));
 		line.clock_type = priv->clocking;
-		line.clock_rate = 0;
-		line.loopback = 0;
 
 		if (copy_to_user(ifr->ifr_settings.ifs_ifsu.sync, &line, size))
 			return -EFAULT;
