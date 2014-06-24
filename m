Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 337CE1A023A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 18:22:24 +1000 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <B07421@freescale.com>
Subject: [PATCH] powerpc/ucc_geth: deal with an compile warning
Date: Tue, 24 Jun 2014 16:18:55 +0800
Message-ID: <1403597935-39952-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

deal with a compile warning: comparison between
'enum qe_fltr_largest_external_tbl_lookup_key_size'
and 'enum qe_fltr_tbl_lookup_key_size'

the code:
	"if (ug_info->largestexternallookupkeysize ==
	     QE_FLTR_TABLE_LOOKUP_KEY_SIZE_8_BYTES)"
is warned because different enum, so modify it.

	"enum qe_fltr_largest_external_tbl_lookup_key_size
	             largestexternallookupkeysize;

	enum qe_fltr_tbl_lookup_key_size {
		 QE_FLTR_TABLE_LOOKUP_KEY_SIZE_8_BYTES
			 = 0x3f,         /* LookupKey parsed by the Generate LookupKey
					    CMD is truncated to 8 bytes */
		 QE_FLTR_TABLE_LOOKUP_KEY_SIZE_16_BYTES
			 = 0x5f,         /* LookupKey parsed by the Generate LookupKey
					    CMD is truncated to 16 bytes */
	 };

	 /* QE FLTR extended filtering Largest External Table Lookup Key Size */
	 enum qe_fltr_largest_external_tbl_lookup_key_size {
		 QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_NONE
			 = 0x0,/* not used */
		 QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_8_BYTES
			 = QE_FLTR_TABLE_LOOKUP_KEY_SIZE_8_BYTES,        /* 8 bytes */
		 QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_16_BYTES
			 = QE_FLTR_TABLE_LOOKUP_KEY_SIZE_16_BYTES,       /* 16 bytes */
	 };"

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index ee2f1ff..0b0de89 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -2993,11 +2993,11 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	if (ug_info->rxExtendedFiltering) {
 		size += THREAD_RX_PRAM_ADDITIONAL_FOR_EXTENDED_FILTERING;
 		if (ug_info->largestexternallookupkeysize ==
-		    QE_FLTR_TABLE_LOOKUP_KEY_SIZE_8_BYTES)
+		    QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_8_BYTES)
 			size +=
 			    THREAD_RX_PRAM_ADDITIONAL_FOR_EXTENDED_FILTERING_8;
 		if (ug_info->largestexternallookupkeysize ==
-		    QE_FLTR_TABLE_LOOKUP_KEY_SIZE_16_BYTES)
+		    QE_FLTR_LARGEST_EXTERNAL_TABLE_LOOKUP_KEY_SIZE_16_BYTES)
 			size +=
 			    THREAD_RX_PRAM_ADDITIONAL_FOR_EXTENDED_FILTERING_16;
 	}
-- 
1.8.5
