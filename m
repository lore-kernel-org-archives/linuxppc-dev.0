Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id C59362BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Nov 2004 04:33:40 +1100 (EST)
Date: Mon, 15 Nov 2004 10:33:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Message-ID: <20041115173338.GB2105@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2.6.10-rc2] ppc32: Fix Motorola Sandpoint builds
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Motorola Sandpoint builds broke recently, as part of the pci_find_device
-> pci_get_device change.  The following is the trivial fix.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.28/arch/ppc/platforms/sandpoint.c	2004-11-15 09:19:42 -07:00
+++ edited/arch/ppc/platforms/sandpoint.c	2004-11-15 10:31:45 -07:00
@@ -584,7 +584,7 @@
 		sandpoint_ide_ctl_regbase[0]=pdev->resource[1].start;
 		sandpoint_ide_ctl_regbase[1]=pdev->resource[3].start;
 		sandpoint_idedma_regbase=pdev->resource[4].start;
-		pci_dev_put(dev);
+		pci_dev_put(pdev);
 	}
 
 	sandpoint_ide_ports_known = 1;

-- 
Tom Rini
http://gate.crashing.org/~trini/
