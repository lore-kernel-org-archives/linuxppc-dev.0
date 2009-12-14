Return-Path: <vishnus@lc1105.zin33.ap.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9170B7BBE
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Dec 2009 00:33:43 +1100 (EST)
From: Vishnu Suresh <Vishnu@freescale.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org, dan.j.williams@intel.com,
	linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v0] Crypto: Talitos: re-initialize async_tx descriptors
Date: Mon, 14 Dec 2009 19:03:22 +0530
Message-Id: <1260797602-7476-1-git-send-email-Vishnu@freescale.com>
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

 drivers/crypto/talitos.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 87f06be..9e261c6 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -952,6 +952,9 @@ static struct dma_async_tx_descriptor * talitos_prep_dma_xor(
 		return NULL;
 	}
 	dma_async_tx_descriptor_init(&new->async_tx, &xor_chan->common);
+	new->async_tx.parent = NULL;
+	new->async_tx.next = NULL;
+
 
 	desc = &new->hwdesc;
 	/* Set destination: Last pointer pair */
-- 
1.6.4.2
