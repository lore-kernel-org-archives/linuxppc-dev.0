Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2BF63679A6
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 08:39:42 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3SMdcJY017169
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 18:39:38 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3SMddxt241004
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 18:39:39 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3SMddT0004640
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 18:39:39 -0400
Date: Fri, 28 Apr 2006 17:39:38 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH]: powerpc/pseries: Increment fail counter in PCI recovery
Message-ID: <20060428223938.GD22621@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

A small medium-priority patch; please send upstream as appropriate.

--linas

[PATCH]: powerpc/pseries: Increment fail counter in PCI recovery

When a PCI device driver does not support PCI error recovery,
the powerpc/pseries code takes a walk through a branch of code 
that resets the failure counter. Because of this, if a broken
PCI card is present, the kernel will attempt to reset it an
infinite number of times. (This is annoying but mostly harmless:
each reset takes about 10-20 seconds, and uses almost no CPU time).

This patch preserves the failure count across resets.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-04-28 17:30:21.000000000 -0500
+++ linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_driver.c	2006-04-28 17:31:31.000000000 -0500
@@ -201,7 +201,11 @@ static void eeh_report_failure(struct pc
 
 static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
 {
-	int rc;
+	int cnt, rc;
+
+	/* pcibios will clear the counter; save the value */
+	cnt = pe_dn->eeh_freeze_count;
+
 	if (bus)
 		pcibios_remove_pci_devices(bus);
 
@@ -240,6 +244,7 @@ static int eeh_reset_device (struct pci_
 		ssleep (5);
 		pcibios_add_pci_devices(bus);
 	}
+	pe_dn->eeh_freeze_count = cnt;
 
 	return 0;
 }
