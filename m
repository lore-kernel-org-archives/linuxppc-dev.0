Return-Path: <bjorn.helgaas@hp.com>
Received: from g1t0029.austin.hp.com (g1t0029.austin.hp.com [15.216.28.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp1.hp.com",
	Issuer "VeriSign Class 3 Secure Server CA - G2" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6278BB7D9F
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 07:20:00 +1100 (EST)
Subject: [PATCH v4 2/5] PCI: read bridge windows before filling in subtractive
	decode resources
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date: Wed, 17 Feb 2010 13:19:58 -0700
Message-ID: <20100217201958.4013.87131.stgit@bob.kio>
In-Reply-To: <20100217201654.4013.70201.stgit@bob.kio>
References: <20100217201654.4013.70201.stgit@bob.kio>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Tony Luck <tony.luck@intel.com>,
	linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org,
	Peter Haight <peterh@sapros.com>,
	Gary Hade <garyhade@us.ibm.com>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-am33-list@redhat.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, Yinghai Lu <yinghai@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


No functional change; this fills in the bus subtractive decode resources
after reading the bridge window information rather than before.  Also,
print out the subtractive decode resources as we already do for the
positive decode windows.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---

 drivers/pci/probe.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)


diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b47b4b..70c4ed2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -403,14 +403,19 @@ void __devinit pci_read_bridge_bases(struct pci_bus *child)
 		 child->secondary, child->subordinate,
 		 dev->transparent ? " (subtractive decode)" : "");
 
-	if (dev->transparent) {
-		for (i = 3; i < PCI_BUS_NUM_RESOURCES; i++)
-			child->resource[i] = child->parent->resource[i - 3];
-	}
-
 	pci_read_bridge_io(child);
 	pci_read_bridge_mmio(child);
 	pci_read_bridge_mmio_pref(child);
+
+	if (dev->transparent) {
+		for (i = 3; i < PCI_BUS_NUM_RESOURCES; i++) {
+			child->resource[i] = child->parent->resource[i - 3];
+			if (child->resource[i])
+				dev_printk(KERN_DEBUG, &dev->dev,
+					   "  bridge window %pR (subtractive decode)\n",
+					   child->resource[i]);
+		}
+	}
 }
 
 static struct pci_bus * pci_alloc_bus(void)
