Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 229B467C1A
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 14:23:35 +1100 (EST)
Date: Mon, 27 Nov 2006 21:21:29 -0600
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: fix OF pci flags parsing
Message-ID: <20061127212129.2484d68d@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For PCI devices with only io ports, of_bus_pci_get_flags() will fall
through and still mark the resource as IORESOURCE_MEM.


Signed-off-by: Olof Johansson <olof@lixom.net>

---

This should be fine to hold until 2.6.20, since noone (as far as I
know) has hit it in the wild.


diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 346fb7b..0dfbe1c 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -160,9 +160,11 @@ static unsigned int of_bus_pci_get_flags
 	switch((w >> 24) & 0x03) {
 	case 0x01:
 		flags |= IORESOURCE_IO;
+		break;
 	case 0x02: /* 32 bits */
 	case 0x03: /* 64 bits */
 		flags |= IORESOURCE_MEM;
+		break;
 	}
 	if (w & 0x40000000)
 		flags |= IORESOURCE_PREFETCH;
