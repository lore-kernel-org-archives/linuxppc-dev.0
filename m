Return-Path: <robherring2@gmail.com>
Sender: Rob Herring <robherring2@gmail.com>
From: Rob Herring <robh@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 04/16] powerpc: add struct pci_ops member names to
 initialization
Date: Fri,  9 Jan 2015 20:34:38 -0600
Message-Id: <1420857290-8373-5-git-send-email-robh@kernel.org>
In-Reply-To: <1420857290-8373-1-git-send-email-robh@kernel.org>
References: <1420857290-8373-1-git-send-email-robh@kernel.org>
Cc: cbe-oss-dev@lists.ozlabs.org, Rob Herring <robh@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some instances of pci_ops initialization rely on the read/write members'
location in the struct. This is fragile and may break when adding new
members to the beginning of the struct.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: cbe-oss-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/cell/celleb_scc_pciex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/celleb_scc_pciex.c b/arch/powerpc/platforms/cell/celleb_scc_pciex.c
index f223875..94170e4 100644
--- a/arch/powerpc/platforms/cell/celleb_scc_pciex.c
+++ b/arch/powerpc/platforms/cell/celleb_scc_pciex.c
@@ -399,8 +399,8 @@ static int scc_pciex_write_config(struct pci_bus *bus, unsigned int devfn,
 }
 
 static struct pci_ops scc_pciex_pci_ops = {
-	scc_pciex_read_config,
-	scc_pciex_write_config,
+	.read = scc_pciex_read_config,
+	.write = scc_pciex_write_config,
 };
 
 static void pciex_clear_intr_all(unsigned int __iomem *base)
-- 
2.1.0
