Return-Path: <johnrose@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2676DDDE0C
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 06:51:32 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l49KpTEE000808
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 16:51:29 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l49KpT6w552812
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 16:51:29 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l49KpT6W007754
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 16:51:29 -0400
Subject: [PATCH] powerpc: export pcibios_remove_pci_devices()
From: John Rose <johnrose@austin.ibm.com>
To: External List <linuxppc-dev@ozlabs.org>, Paul Mackerras <pmac@au1.ibm.com>,
	Nathan Fontenot <nfont@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 09 May 2007 15:50:53 -0500
Message-Id: <1178743853.22467.13.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The rpadlpar_io module depends on this.

Signed-off-by: John Rose <johnrose@austin.ibm.com>

--

Thanks-
John

diff -puN arch/powerpc/platforms/pseries/pci_dlpar.c~export_pci_remove arch/powerpc/platforms/pseries/pci_dlpar.c
--- 2_6_linus/arch/powerpc/platforms/pseries/pci_dlpar.c~export_pci_remove	2007-05-09 15:52:50.000000000 -0500
+++ 2_6_linus-johnrose/arch/powerpc/platforms/pseries/pci_dlpar.c	2007-05-09 15:53:12.000000000 -0500
@@ -79,6 +79,7 @@ pcibios_remove_pci_devices(struct pci_bu
 		pci_remove_bus_device(dev);
 	}
 }
+EXPORT_SYMBOL(pcibios_remove_pci_devices);
 
 /* Must be called before pci_bus_add_devices */
 void

_
