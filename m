Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 7859B67B7C
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 05:25:44 +1000 (EST)
Date: Thu, 21 Sep 2006 14:25:34 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] maple u3 ht - reject inappropriate config space access
Message-ID: <20060921192534.GE630@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When there is a PCI-X mode 2 capable device behind the HT<->PCI-X
bridge, the pci core decides that the device has the extended 4K
config space, even though the bus is not operating in mode 2.  This is
because the u3_ht pci ops silently accept offsets greater than 255 but
use only the 8 least significant bits, which means reading at offset
0x100 gets the data at offset 0x0, and causes confusion for lspci.

Reject accesses to configuration space offsets greater than 255.

Signed-off-by: Nathan Lynch <ntl@pobox.com>

--- linux-2.6.git.orig/arch/powerpc/platforms/maple/pci.c
+++ linux-2.6.git/arch/powerpc/platforms/maple/pci.c
@@ -211,6 +211,9 @@ static int u3_ht_read_config(struct pci_
 	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	if (offset > 0xff)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
 	addr = u3_ht_cfg_access(hose, bus->number, devfn, offset);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -243,6 +246,9 @@ static int u3_ht_write_config(struct pci
 	if (hose == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	if (offset > 0xff)
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
 	addr = u3_ht_cfg_access(hose, bus->number, devfn, offset);
 	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
