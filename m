Return-Path: <mst@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 9A5B11007DA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 07:17:26 +1100 (EST)
Date: Thu, 24 Nov 2011 22:18:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH-RFC 05/10] microblaze: switch to GENERIC_PCI_IOMAP
Message-ID: <dd85307a3ebcd0ce5870ca31cbe7b286621ab091.1322163031.git.mst@redhat.com>
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

microblaze copied pci_iomap from generic code, probably to avoid
pulling the rest of iomap.c in.  Since that's in
a separate file now, we can reuse the common implementation.

The only difference is handling of nocache flag,
that turns out to be done correctly by the
generic code since arch/microblaze/include/asm/io.h
defines ioremap_nocache same as ioremap.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/microblaze/Kconfig     |    1 +
 arch/microblaze/pci/iomap.c |   19 -------------------
 2 files changed, 1 insertions(+), 19 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index e446bab..f0eead7 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -17,6 +17,7 @@ config MICROBLAZE
 	select HAVE_GENERIC_HARDIRQS
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
+	select GENERIC_PCI_IOMAP
 
 config SWAP
 	def_bool n
diff --git a/arch/microblaze/pci/iomap.c b/arch/microblaze/pci/iomap.c
index 57acda8..b07abba 100644
--- a/arch/microblaze/pci/iomap.c
+++ b/arch/microblaze/pci/iomap.c
@@ -10,25 +10,6 @@
 #include <asm/io.h>
 #include <asm/pci-bridge.h>
 
-void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max)
-{
-	resource_size_t start = pci_resource_start(dev, bar);
-	resource_size_t len = pci_resource_len(dev, bar);
-	unsigned long flags = pci_resource_flags(dev, bar);
-
-	if (!len)
-		return NULL;
-	if (max && len > max)
-		len = max;
-	if (flags & IORESOURCE_IO)
-		return ioport_map(start, len);
-	if (flags & IORESOURCE_MEM)
-		return ioremap(start, len);
-	/* What? */
-	return NULL;
-}
-EXPORT_SYMBOL(pci_iomap);
-
 void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
 	if (isa_vaddr_is_ioport(addr))
-- 
1.7.5.53.gc233e
