Return-Path: <paubert@iram.es>
Received: from cica-lavadora-l1mail2.puc.rediris.es
 (ci-l1mail2-out04a.puc.rediris.es [IPv6:2001:720:418:ca02::22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWdTV73jrzDqk3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 20:38:04 +1100 (AEDT)
Date: Wed, 31 Jan 2018 10:37:30 +0100
From: Gabriel Paubert <paubert@iram.es>
To: linuxppc-dev@lists.ozlabs.org, James Hogan <jhogan@kernel.org>
Subject: Wifi (B43) broken on G4 PowerBooks with kernel v4.15
Message-ID: <20180131093730.ikmoawgh3mh2pxoy@lt-gp.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

	Hi,

yesterday I recompiled the kernel on my late 2005 G4 PowerBook, and the
Wifi stopped working. After comparing the configuration is turns out
that a change to a Kconfig condition disabled SSB support which is
necessary for these chips.

The graph of configuration options is quite messy, and I'm not sure that
I fully understand it.

Nevertheless the following patch fixes the regression, but there might
be a better way to solve the problem.

If you pick up this trivial patch as is, you may add:

Signed-off-by: Gabriel Paubert <paubert@iram.es>

diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
index 71c7376..d189db6 100644
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -32,7 +32,7 @@ config SSB_BLOCKIO
 
 config SSB_PCIHOST_POSSIBLE
 	bool
-	depends on SSB && (PCI = y || PCI = SSB) && PCI_DRIVERS_LEGACY
+	depends on SSB && (PCI = y || PCI = SSB) && (PCI_DRIVERS_LEGACY || B43_SSB)
 	default y
 
 config SSB_PCIHOST
