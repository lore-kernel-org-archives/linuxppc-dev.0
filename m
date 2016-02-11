Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D4D561A0019
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 12:32:41 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 18:32:39 -0700
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A65AC19D8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 18:20:35 -0700 (MST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1B1WaSS30605482
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 01:32:36 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1B1TJJx003614
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:29:20 -0500
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: james.bottomley@hansenpartnership.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
 jthumshirn@suse.de, manoj@linux.vnet.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH v2 1/7] ibmvscsi: Correct values for several viosrp_crq_format
 enums
Date: Wed, 10 Feb 2016 19:32:22 -0600
Message-Id: <1455154348-3226-2-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The enum values for VIOSRP_LINUX_FORMAT and VIOSRP_INLINE_FORMAT are
off by one. They are currently defined as 0x06 and 0x07 respetively.
These values are defined in PAPR correctly as 0x05 and 0x06. This
inconsistency has gone unnoticed as neither enum is currently used.
The possible future support of PING messages between the VIOS and
client adapter relies on VIOSRP_INLINE_FORMAT crq messages.
Corrected these enum values to match PAPR definitions.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/ibmvscsi/viosrp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/viosrp.h b/drivers/scsi/ibmvscsi/viosrp.h
index 1162430..d1044e9 100644
--- a/drivers/scsi/ibmvscsi/viosrp.h
+++ b/drivers/scsi/ibmvscsi/viosrp.h
@@ -56,8 +56,8 @@ enum viosrp_crq_formats {
 	VIOSRP_MAD_FORMAT = 0x02,
 	VIOSRP_OS400_FORMAT = 0x03,
 	VIOSRP_AIX_FORMAT = 0x04,
-	VIOSRP_LINUX_FORMAT = 0x06,
-	VIOSRP_INLINE_FORMAT = 0x07
+	VIOSRP_LINUX_FORMAT = 0x05,
+	VIOSRP_INLINE_FORMAT = 0x06
 };
 
 enum viosrp_crq_status {
-- 
2.5.0
