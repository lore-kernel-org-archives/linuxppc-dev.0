Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 70279DDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:40:01 +1000 (EST)
Date: Mon, 20 Aug 2007 12:39:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 07/20] bootwrapper: Add TARGET_HAS_ETHn tests to ppcboot.h.
Message-ID: <20070820173952.GF30562@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

U-boots more recent than when ppcboot.h was forked allow the board config
file to enable additional ethernet ports explicitly, rather than
using a hardcoded list of targets.  This allows bootwrapper platform
files to do the same.

Fortunately, nothing after the ethernet addresses is of interest to
cuboot platforms, so the inevitable mismatches won't be too catastrophic.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/ppcboot.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/ppcboot.h b/arch/powerpc/boot/ppcboot.h
index 5290ff2..6ae6f90 100644
--- a/arch/powerpc/boot/ppcboot.h
+++ b/arch/powerpc/boot/ppcboot.h
@@ -78,17 +78,18 @@ typedef struct bd_info {
 	hymod_conf_t	bi_hymod_conf;	/* hymod configuration information */
 #endif
 #if defined(TARGET_EVB64260) || defined(TARGET_405EP) || defined(TARGET_44x) || \
-	defined(TARGET_85xx) ||	defined(TARGET_83xx)
+	defined(TARGET_85xx) ||	defined(TARGET_83xx) || defined(TARGET_HAS_ETH1)
 	/* second onboard ethernet port */
 	unsigned char	bi_enet1addr[6];
 #define HAVE_ENET1ADDR
 #endif
-#if defined(TARGET_EVB64260) || defined(TARGET_440GX) || defined(TARGET_85xx)
+#if defined(TARGET_EVB64260) || defined(TARGET_440GX) || \
+    defined(TARGET_85xx) || defined(TARGET_HAS_ETH2)
 	/* third onboard ethernet ports */
 	unsigned char	bi_enet2addr[6];
 #define HAVE_ENET2ADDR
 #endif
-#if defined(TARGET_440GX)
+#if defined(TARGET_440GX) || defined(TARGET_HAS_ETH3)
 	/* fourth onboard ethernet ports */
 	unsigned char	bi_enet3addr[6];
 #define HAVE_ENET3ADDR
-- 
1.5.0.3
