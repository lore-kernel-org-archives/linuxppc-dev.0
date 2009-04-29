Return-Path: <why@r54964-12.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 62F53DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 04:14:25 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3TIELd0006678
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 11:14:21 -0700 (MST)
Received: from r54964-12.am.freescale.net (R54964-12.am.freescale.net
	[10.29.201.229])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n3TIEJ7x018904
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 13:14:20 -0500 (CDT)
From: Haiying Wang <Haiying.Wang@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH 5/6] net/ucc_geth: Assign six threads to Rx for UEC
Date: Wed, 29 Apr 2009 14:14:37 -0400
Message-Id: <1241028884406-git-send-email-Haiying.Wang@freescale.com>
In-Reply-To: <1241028883630-git-send-email-Haiying.Wang@freescale.com>
References: <1241028878175-git-send-email-Haiying.Wang@freescale.com>
	<12410288792524-git-send-email-Haiying.Wang@freescale.com>
	<12410288811793-git-send-email-Haiying.Wang@freescale.com>
	<1241028883630-git-send-email-Haiying.Wang@freescale.com>
Cc: Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

when there are 46 snums defined in device tree.

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
---
 drivers/net/ucc_geth.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 3e003fe..1f6529f 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -3709,7 +3709,10 @@ static int ucc_geth_probe(struct of_device* ofdev, const struct of_device_id *ma
 		ug_info->uf_info.utfet = UCC_GETH_UTFET_GIGA_INIT;
 		ug_info->uf_info.utftt = UCC_GETH_UTFTT_GIGA_INIT;
 		ug_info->numThreadsTx = UCC_GETH_NUM_OF_THREADS_4;
-		ug_info->numThreadsRx = UCC_GETH_NUM_OF_THREADS_4;
+		if (qe_get_num_of_snums() == 46)
+			ug_info->numThreadsRx = UCC_GETH_NUM_OF_THREADS_6;
+		else
+			ug_info->numThreadsRx = UCC_GETH_NUM_OF_THREADS_4;
 	}
 
 	if (netif_msg_probe(&debug))
-- 
1.6.0.2
