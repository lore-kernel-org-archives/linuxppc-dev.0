Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E1C0BDDEFF
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 03:04:39 +1000 (EST)
Date: Fri, 7 Sep 2007 19:04:02 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [GIT PULL] FireWire fix
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <tkrat.9f3ebd038aa685a2@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Cc: =?iso-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus, please pull from the for-linus branch at

    git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394-2.6.git for-linus

to receive a fix of the laptop-refuses-to-suspend kind. Or simply apply
the patch from this mail.


There is still an old underlying oddness though which I ask the PPC
folks to investigate and possibly fix post 2.6.23:  On iBook G3 and
older PowerBooks, the onboard FireWire controller's pci_dev
current_state remains PCI_UNKNOWN long after initialization. Sounds like
a bug in platform code to me.


Stat, log, diff:

 drivers/firewire/fw-ohci.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

commit 5511142870046a7bed947d51ec9b320856ee120a
Author: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date:   Thu Sep 6 09:50:30 2007 +0200

    firewire: fw-ohci: ignore failure of pci_set_power_state (fix suspend regression)
    
    Fixes (papers over) "Sleep problems with kernels >= 2.6.21 on powerpc",
    http://lkml.org/lkml/2007/8/25/155.  The issue is that the FireWire
    controller's pci_dev.current_state of iBook G3 and presumably older
    PowerBooks is still in PCI_UNKNOWN instead of PCI_D0 when the firewire
    driver's .suspend method is called.
    
    Like it was suggested earlier in http://lkml.org/lkml/2006/10/24/13, we
    do not fail .suspend anymore if pci_set_power_state failed.
    
    Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

diff --git a/drivers/firewire/fw-ohci.c b/drivers/firewire/fw-ohci.c
index 7e427b4..e14c1ca 100644
--- a/drivers/firewire/fw-ohci.c
+++ b/drivers/firewire/fw-ohci.c
@@ -1945,10 +1945,8 @@ static int pci_suspend(struct pci_dev *pdev, pm_message_t state)
 		return err;
 	}
 	err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
-	if (err) {
-		fw_error("pci_set_power_state failed\n");
-		return err;
-	}
+	if (err)
+		fw_error("pci_set_power_state failed with %d\n", err);
 
 	return 0;
 }

-- 
Stefan Richter
-=====-=-=== =--= --===
http://arcgraph.de/sr/
