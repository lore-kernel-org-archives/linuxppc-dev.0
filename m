Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by ozlabs.org (Postfix) with ESMTP id 380FCB70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 Aug 2010 04:27:59 +1000 (EST)
Received: by pzk5 with SMTP id 5so436661pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 Aug 2010 11:27:58 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH] powerpc/pci: fix checking for child bridges in PCI code.
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 18 Aug 2010 12:27:55 -0600
Message-ID: <20100818182727.29483.53699.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Julia Lawall <julia@diku.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pci_device_to_OF_node() can return null, and list_for_each_entry will
never enter the loop when dev is NULL, so it looks like this test is
a typo.

Reported-by: Julia Lawall <julia@diku.dk>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/kernel/pci_of_scan.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 6ddb795..e751506 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -336,7 +336,7 @@ static void __devinit __of_scan_bus(struct device_node *node,
 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE ||
 		    dev->hdr_type == PCI_HEADER_TYPE_CARDBUS) {
 			struct device_node *child = pci_device_to_OF_node(dev);
-			if (dev)
+			if (child)
 				of_scan_pci_bridge(child, dev);
 		}
 	}
