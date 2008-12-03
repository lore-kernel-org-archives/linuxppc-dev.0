Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6FC85DDDE7
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 15:31:34 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: herbert@gondor.apana.org.au
Subject: [PATCH] crypto: talitos - Fix modpost warning
Date: Tue,  2 Dec 2008 22:29:16 -0600
Message-Id: <1228278556-1056-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Removed __devexit from talitos_remove() since its also called from
talitos_probe().

WARNING: vmlinux.o(.text+0x28a008): Section mismatch in reference from the function talitos_probe() to the function .devexit.text:talitos_remove()
The function talitos_probe() references a function in an exit section.
Often the function talitos_remove() has valid usage outside the exit section
and the fix is to remove the __devexit annotation of talitos_remove.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/crypto/talitos.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index b6ad3ac..2479348 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1357,7 +1357,7 @@ static int hw_supports(struct device *dev, __be32 desc_hdr_template)
 	return ret;
 }
 
-static int __devexit talitos_remove(struct of_device *ofdev)
+static int talitos_remove(struct of_device *ofdev)
 {
 	struct device *dev = &ofdev->dev;
 	struct talitos_private *priv = dev_get_drvdata(dev);
-- 
1.5.6.5
