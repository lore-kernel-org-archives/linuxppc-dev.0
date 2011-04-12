Return-Path: <R1AAHA@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 52F0DB6F05
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Apr 2011 10:15:29 +1000 (EST)
Date: Mon, 11 Apr 2011 19:15:21 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: <linux-crypto@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/4] crypto: caam - fix queue interface detection
Message-ID: <20110411191521.52d6ccc6.kim.phillips@freescale.com>
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

The presence of a h/w Queue Interface would fail due to this
cut-n-paste snafu.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 drivers/crypto/caam/regs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h
index d063a26..aee394e 100644
--- a/drivers/crypto/caam/regs.h
+++ b/drivers/crypto/caam/regs.h
@@ -131,7 +131,7 @@ struct caam_perfmon {
 	/* CAAM Hardware Instantiation Parameters		fa0-fbf */
 	u64 cha_rev;		/* CRNR - CHA Revision Number		*/
 #define CTPR_QI_SHIFT		57
-#define CTPR_QI_MASK		(0x1ull << CHA_NUM_DECONUM_SHIFT)
+#define CTPR_QI_MASK		(0x1ull << CTPR_QI_SHIFT)
 	u64 comp_parms;	/* CTPR - Compile Parameters Register	*/
 	u64 rsvd1[2];
 
-- 
1.7.4.3.dirty
