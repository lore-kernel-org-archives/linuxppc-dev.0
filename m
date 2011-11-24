Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 659471007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 07:16:41 +1100 (EST)
Date: Thu, 24 Nov 2011 22:17:23 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH-RFC 03/10] alpha: switch to GENERIC_PCI_IOMAP
Message-ID: <4245e7d8f484de6512fd4a9e4cba5b90cc111899.1322163031.git.mst@redhat.com>
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

alpha copied pci_iomap from generic code to avoid
pulling the rest of iomap.c in.  Since that's in
a separate file now, we can reuse the common implementation.

The only difference is handling of nocache flag,
that turns out to be done correctly by the
generic code since arch/alpha/include/asm/io.h
defines ioremap_nocache same as ioremap.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/alpha/Kconfig      |    1 +
 arch/alpha/kernel/pci.c |   26 +-------------------------
 2 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 3636b11..56a4df9 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -315,6 +315,7 @@ config ISA_DMA_API
 config PCI
 	bool
 	depends on !ALPHA_JENSEN
+	select GENERIC_PCI_IOMAP
 	default y
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index c9ab94e..f3cae27 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -508,30 +508,7 @@ sys_pciconfig_iobase(long which, unsigned long bus, unsigned long dfn)
 	return -EOPNOTSUPP;
 }
 
-/* Create an __iomem token from a PCI BAR.  Copied from lib/iomap.c with
-   no changes, since we don't want the other things in that object file.  */
-
-void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
-{
-	resource_size_t start = pci_resource_start(dev, bar);
-	resource_size_t len = pci_resource_len(dev, bar);
-	unsigned long flags = pci_resource_flags(dev, bar);
-
-	if (!len || !start)
-		return NULL;
-	if (maxlen && len > maxlen)
-		len = maxlen;
-	if (flags & IORESOURCE_IO)
-		return ioport_map(start, len);
-	if (flags & IORESOURCE_MEM) {
-		/* Not checking IORESOURCE_CACHEABLE because alpha does
-		   not distinguish between ioremap and ioremap_nocache.  */
-		return ioremap(start, len);
-	}
-	return NULL;
-}
-
-/* Destroy that token.  Not copied from lib/iomap.c.  */
+/* Destroy an __iomem token.  Not copied from lib/iomap.c.  */
 
 void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
 {
@@ -539,7 +516,6 @@ void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
 		iounmap(addr);
 }
 
-EXPORT_SYMBOL(pci_iomap);
 EXPORT_SYMBOL(pci_iounmap);
 
 /* FIXME: Some boxes have multiple ISA bridges! */
-- 
1.7.5.53.gc233e
