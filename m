Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44B9FDDF13
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 03:11:20 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l47HBClt007684
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:11:12 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l47HBBUW170896
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 11:11:11 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l47HBBZJ019973
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 11:11:11 -0600
Date: Mon, 7 May 2007 12:11:11 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH]: ppc64/pseries build-break fix: export
	pcibios_remove_pci_devices
Message-ID: <20070507171111.GF4452@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul, please apply and push the following; its a build-break fix.

BTW, I have 5 more pseries EEH patches I've been planning to push for
weeks, I just haven't been able to get access to the right kind of machine 
to test on.  But they're coming real soon now, I'd like to have them for 2.6.22

--linas


The pseries PCI hotplug code cannot build as a module, unless
the pcibios_remove_pci_devices function is exported.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/pci_dlpar.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/pci_dlpar.c
===================================================================
--- linux-2.6.21-rc7-mm2.orig/arch/powerpc/platforms/pseries/pci_dlpar.c	2007-04-26 15:37:32.000000000 -0500
+++ linux-2.6.21-rc7-mm2/arch/powerpc/platforms/pseries/pci_dlpar.c	2007-05-07 11:54:25.000000000 -0500
@@ -79,6 +79,7 @@ pcibios_remove_pci_devices(struct pci_bu
 		pci_remove_bus_device(dev);
 	}
 }
+EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
 
 /* Must be called before pci_bus_add_devices */
 void
