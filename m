Return-Path: <mike@mikebwilliams.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 72F7FB6F85
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 05:31:10 +1000 (EST)
Received: by vxb40 with SMTP id 40so933918vxb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 12:31:07 -0700 (PDT)
From: Mike Williams <mike@mikebwilliams.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc,
	460gt: Add 460gt as compatible in the check for 460ex-compatible
	crypto
Date: Wed, 22 Jun 2011 15:30:51 -0400
Message-Id: <1308771051-30861-1-git-send-email-mike@mikebwilliams.com>
Cc: Mike Williams <mike@mikebwilliams.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Mike Williams <mike@mikebwilliams.com>
---
 drivers/crypto/amcc/crypto4xx_core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index 1891252..4895be5 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -1161,7 +1161,8 @@ static int __init crypto4xx_probe(struct platform_device *ofdev)
 	if (rc)
 		return -ENODEV;
 
-	if (of_find_compatible_node(NULL, NULL, "amcc,ppc460ex-crypto")) {
+	if (of_find_compatible_node(NULL, NULL, "amcc,ppc460ex-crypto") ||
+	    of_find_compatible_node(NULL, NULL, "amcc,ppc460gt-crypto")) {
 		mtdcri(SDR0, PPC460EX_SDR0_SRST,
 		       mfdcri(SDR0, PPC460EX_SDR0_SRST) | PPC460EX_CE_RESET);
 		mtdcri(SDR0, PPC460EX_SDR0_SRST,
-- 
1.7.3.4
