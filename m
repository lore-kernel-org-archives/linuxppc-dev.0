Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AE2E6DF052
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 06:26:58 +1000 (EST)
Date: Tue, 28 Aug 2007 15:19:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 2/9] cpm2: Fix off-by-one error in setbrg().
Message-ID: <20070828201921.GB24329@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The hardware adds one to the BRG value to get the divider, so it must
be subtracted by software.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/cpm2_common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index dbef50c..99ad1ed 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -102,7 +102,7 @@ cpm_setbrg(uint brg, uint rate)
 		brg -= 4;
 	}
 	bp += brg;
-	out_be32(bp, ((BRG_UART_CLK / rate) << 1) | CPM_BRG_EN);
+	out_be32(bp, (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN);
 
 	cpm2_unmap(bp);
 }
-- 
1.5.0.3
