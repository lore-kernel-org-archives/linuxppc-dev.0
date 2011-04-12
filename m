Return-Path: <R1AAHA@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F3ED2B7103
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Apr 2011 10:15:55 +1000 (EST)
Date: Mon, 11 Apr 2011 19:15:28 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: <linux-crypto@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/4] crypto: caam - remove duplicate dev_err
Message-ID: <20110411191528.36e41831.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Steve Cornelius <sec@pobox.com>, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

keep the hex error value reporting version (a) to be consistent
with decrypt_done(), and (b) to keep our hardware guys happy.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 drivers/crypto/caam/caamalg.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/crypto/caam/caamalg.c b/drivers/crypto/caam/caamalg.c
index 8eb84d3..245cfe4 100644
--- a/drivers/crypto/caam/caamalg.c
+++ b/drivers/crypto/caam/caamalg.c
@@ -418,7 +418,6 @@ static void ipsec_esp_encrypt_done(struct device *jrdev, u32 *desc, u32 err,
 	if (err) {
 		char tmp[256];
 
-		dev_err(jrdev, "%s\n", caam_jr_strstatus(tmp, err));
 		dev_err(jrdev, "%08x: %s\n", err, caam_jr_strstatus(tmp, err));
 	}
 
-- 
1.7.4.3.dirty
