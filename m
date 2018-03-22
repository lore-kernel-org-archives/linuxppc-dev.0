Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dN8538qzF20M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:20:56 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id e194so18201627wmd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:20:56 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 09/19] powerpc/chrp/pci: Make some functions static
Date: Thu, 22 Mar 2018 21:19:55 +0100
Message-Id: <20180322202007.23088-10-malat@debian.org>
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These functions can all be static, make it so. Fix warnings treated as
errors with W=1:

  arch/powerpc/platforms/chrp/pci.c:34:5: error: no previous prototype for ‘gg2_read_config’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/pci.c:61:5: error: no previous prototype for ‘gg2_write_config’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/pci.c:97:5: error: no previous prototype for ‘rtas_read_config’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/pci.c:112:5: error: no previous prototype for ‘rtas_write_config’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/chrp/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/pci.c b/arch/powerpc/platforms/chrp/pci.c
index 0f512d35f7c5..84e1fedb3796 100644
--- a/arch/powerpc/platforms/chrp/pci.c
+++ b/arch/powerpc/platforms/chrp/pci.c
@@ -31,7 +31,7 @@ void __iomem *gg2_pci_config_base;
  * limit the bus number to 3 bits
  */
 
-int gg2_read_config(struct pci_bus *bus, unsigned int devfn, int off,
+static int gg2_read_config(struct pci_bus *bus, unsigned int devfn, int off,
 			   int len, u32 *val)
 {
 	volatile void __iomem *cfg_data;
@@ -58,7 +58,7 @@ int gg2_read_config(struct pci_bus *bus, unsigned int devfn, int off,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int gg2_write_config(struct pci_bus *bus, unsigned int devfn, int off,
+static int gg2_write_config(struct pci_bus *bus, unsigned int devfn, int off,
 			    int len, u32 val)
 {
 	volatile void __iomem *cfg_data;
@@ -94,7 +94,7 @@ static struct pci_ops gg2_pci_ops =
 /*
  * Access functions for PCI config space using RTAS calls.
  */
-int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
+static int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		     int len, u32 *val)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
@@ -109,7 +109,7 @@ int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 	return rval? PCIBIOS_DEVICE_NOT_FOUND: PCIBIOS_SUCCESSFUL;
 }
 
-int rtas_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
+static int rtas_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		      int len, u32 val)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
-- 
2.11.0
