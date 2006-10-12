Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 14AB1679E9
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 07:28:15 +1000 (EST)
Received: from [10.50.1.108] (rvinson@linuxbox.az.mvista.com [10.50.1.108])
	by zipcode.az.mvista.com (8.9.3/8.9.3) with ESMTP id NAA29958
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Oct 2006 13:42:45 -0700
Message-ID: <452EA747.5080601@mvista.com>
Date: Thu, 12 Oct 2006 13:36:23 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix IO Window Updates on P2P bridges.
Content-Type: multipart/mixed; boundary="------------080506060302050605010307"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080506060302050605010307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greetings,
  When update_bridge_base() updates the IO window on a PCI-to-PCI bridge, it fails to zero the upper 16 bits of the base and limit registers if the window size is less than 64K. The attached patch corrects this.

	Randy Vinson

--------------080506060302050605010307
Content-Type: text/plain;
 name="pci_update_IO.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pci_update_IO.patch"

Fix IO Window Updates on P2P bridges.

When updating the I/O window of a PCI-to-PCI bridge, update_bridge_base()
fails to zero the upper 16 bits of the IO base and limit registers if the
new I/O window is under 64k in size.

Signed-off-by: Randy Vinson <rvinson@mvista.com>

---
commit 46be7a52bb42e3323644f4d15bd1e93f14632a60
tree 3e5b1c12c04255d59647f6660cd6b0e3f39d1cc5
parent 10270613fb4d5a44c335cfa13e9626bf5743c01d
author Randy Vinson <rvinson@linuxbox.(none)> Thu, 12 Oct 2006 13:25:46 -0700
committer Randy Vinson <rvinson@linuxbox.(none)> Thu, 12 Oct 2006 13:25:46 -0700

 arch/powerpc/kernel/pci_32.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 9b49f86..0d9ff72 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -441,14 +441,14 @@ update_bridge_base(struct pci_bus *bus, 
 		end = res->end - off;
 		io_base_lo = (start >> 8) & PCI_IO_RANGE_MASK;
 		io_limit_lo = (end >> 8) & PCI_IO_RANGE_MASK;
-		if (end > 0xffff) {
-			pci_write_config_word(dev, PCI_IO_BASE_UPPER16,
-					      start >> 16);
-			pci_write_config_word(dev, PCI_IO_LIMIT_UPPER16,
-					      end >> 16);
+		if (end > 0xffff)
 			io_base_lo |= PCI_IO_RANGE_TYPE_32;
-		} else
+		else
 			io_base_lo |= PCI_IO_RANGE_TYPE_16;
+		pci_write_config_word(dev, PCI_IO_BASE_UPPER16,
+				start >> 16);
+		pci_write_config_word(dev, PCI_IO_LIMIT_UPPER16,
+				end >> 16);
 		pci_write_config_byte(dev, PCI_IO_BASE, io_base_lo);
 		pci_write_config_byte(dev, PCI_IO_LIMIT, io_limit_lo);
 

--------------080506060302050605010307--
