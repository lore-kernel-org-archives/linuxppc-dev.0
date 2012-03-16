Return-Path: <bhelgaas@google.com>
Received: from mail-yx0-f201.google.com (mail-yx0-f201.google.com
 [209.85.213.201])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B739B6FB9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 10:48:22 +1100 (EST)
Received: by yenm6 with SMTP id m6so752321yen.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 16:48:19 -0700 (PDT)
Subject: [PATCH v2 5/7] powerpc/PCI: allow reallocation on PA Semi
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 16 Mar 2012 17:48:19 -0600
Message-ID: <20120316234819.6649.55979.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
References: <20120316234653.6649.59492.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Olof Johansson <olof@lixom.net>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We believe there's no reason to prevent reallocation on PA Semi, so
revert to the default of "allow reallocation if necessary."

CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org
Tested-by: Olof Johansson <olof@lixom.net>
Acked-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/powerpc/platforms/pasemi/pci.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
index b27d886..aa86271 100644
--- a/arch/powerpc/platforms/pasemi/pci.c
+++ b/arch/powerpc/platforms/pasemi/pci.c
@@ -229,9 +229,6 @@ void __init pas_pci_init(void)
 
 	/* Setup the linkage between OF nodes and PHBs */
 	pci_devs_phb_init();
-
-	/* Use the common resource allocation mechanism */
-	pci_add_flags(PCI_PROBE_ONLY);
 }
 
 void __iomem *pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset)
