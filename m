Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 7D31E1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 07:19:56 +1100 (EST)
Date: Thu, 24 Nov 2011 22:20:37 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH-RFC 09/10] sh: switch to GENERIC_PCI_IOMAP
Message-ID: <28d52b292971f1bc6dab66ad6f27a0dbce35a9c0.1322163031.git.mst@redhat.com>
References: <cover.1322163031.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1322163031.git.mst@redhat.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org,
 linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux@openrisc.net,
 linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>,
 Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>,
 Jonas Bonn <jonas@southpole.se>, Jesper Nilsson <jesper.nilsson@axis.com>,
 Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org,
 linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-arch@vger.kernel.org,
 Arend van Spriel <arend@broadcom.com>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Lasse Collin <lasse.collin@tukaani.org>,
 Arnd Bergmann <arnd@arndb.de>, Lucas De Marchi <lucas.demarchi@profusion.mobi>,
 microblaze-uclinux@itee.uq.edu.au, Paul Bolle <pebolle@tiscali.nl>,
 Rob Herring <rob.herring@calxeda.com>, Mikael Starvik <starvik@axis.com>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Franky Lin <frankyl@broadcom.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Fabio Baltieri <fabio.baltieri@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Michael Ellerman <michael@ellerman.id.au>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, Paul Gortmaker <paul.gortmaker@windriver.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Richard Kuo <rkuo@codeaurora.org>, Kyle McMartin <kyle@mcmartin.ca>,
 Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

sh copied pci_iomap from generic code, probably to avoid
pulling the rest of iomap.c in.  Since that's in
a separate file now, we can reuse the common implementation.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/sh/Kconfig           |    1 +
 arch/sh/drivers/pci/pci.c |   23 -----------------------
 2 files changed, 1 insertions(+), 23 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5aeab58..ead1640 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -857,6 +857,7 @@ config PCI
 	bool "PCI support"
 	depends on SYS_SUPPORTS_PCI
 	select PCI_DOMAINS
+	select GENERIC_PCI_IOMAP
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index c2691af..11aaf2f 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -393,29 +393,6 @@ static void __iomem *ioport_map_pci(struct pci_dev *dev,
 	return (void __iomem *)(chan->io_map_base + port);
 }
 
-void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
-{
-	resource_size_t start = pci_resource_start(dev, bar);
-	resource_size_t len = pci_resource_len(dev, bar);
-	unsigned long flags = pci_resource_flags(dev, bar);
-
-	if (unlikely(!len || !start))
-		return NULL;
-	if (maxlen && len > maxlen)
-		len = maxlen;
-
-	if (flags & IORESOURCE_IO)
-		return ioport_map_pci(dev, start, len);
-	if (flags & IORESOURCE_MEM) {
-		if (flags & IORESOURCE_CACHEABLE)
-			return ioremap(start, len);
-		return ioremap_nocache(start, len);
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL(pci_iomap);
-
 void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
 	iounmap(addr);
-- 
1.7.5.53.gc233e
