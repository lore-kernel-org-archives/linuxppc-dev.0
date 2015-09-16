Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415161A1957
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 07:28:21 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 16 Sep 2015 17:28:18 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 057FFC90045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 17:19:21 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8GLSHFB54722784
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 21:28:17 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8GLSGXw027156
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 17:28:16 -0400
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Subject: [PATCH v2 07/30] cxlflash: Fix context encode mask width
Date: Wed, 16 Sep 2015 16:27:54 -0500
Message-Id: <1442438874-49431-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The context encode mask covers more than 32-bits, making it
a long integer. This should be noted by appending the ULL
width suffix to the mask.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/superpipe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/cxlflash/superpipe.h b/drivers/scsi/cxlflash/superpipe.h
index 72d53cf..7947091 100644
--- a/drivers/scsi/cxlflash/superpipe.h
+++ b/drivers/scsi/cxlflash/superpipe.h
@@ -87,7 +87,7 @@ enum ctx_ctrl {
 	CTX_CTRL_FILE		= (1 << 5)
 };
 
-#define ENCODE_CTXID(_ctx, _id)	(((((u64)_ctx) & 0xFFFFFFFF0) << 28) | _id)
+#define ENCODE_CTXID(_ctx, _id)	(((((u64)_ctx) & 0xFFFFFFFF0ULL) << 28) | _id)
 #define DECODE_CTXID(_val)	(_val & 0xFFFFFFFF)
 
 struct ctx_info {
-- 
2.1.0
