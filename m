Return-Path: <vishnus@lc1105.zin33.ap.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18BFDB7088
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 00:31:13 +1100 (EST)
From: Vishnu Suresh <Vishnu@freescale.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org, dan.j.williams@intel.com
Subject: [PATCH v0] fsldma: re-initialize async_tx descriptors
Date: Mon, 14 Dec 2009 19:00:55 +0530
Message-Id: <1260797455-7390-1-git-send-email-Vishnu@freescale.com>
Cc: Vishnu Suresh <Vishnu@freescale.com>, B04825@freescale.com,
	R58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The async_tx descriptors contains dangling pointers.
Hence, re-initialize them to NULL before use.

Signed-off-by: Vishnu Suresh <Vishnu@freescale.com>
---
o. Rebased to linux-next as of 20091214

 drivers/dma/fsldma.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 272097a..779c2b6 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -384,6 +384,8 @@ static struct fsl_desc_sw *fsl_dma_alloc_descriptor(
 		dma_async_tx_descriptor_init(&desc_sw->async_tx,
 						&fsl_chan->common);
 		desc_sw->async_tx.tx_submit = fsl_dma_tx_submit;
+		desc_sw->async_tx.parent = NULL;
+		desc_sw->async_tx.next = NULL;
 		desc_sw->async_tx.phys = pdesc;
 	}
 
-- 
1.6.4.2
