Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0945567BA2
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 08:34:30 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8KMYRt9003446
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 18:34:27 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8KMYR5O371076
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 16:34:27 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8KMYRDM013245
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 16:34:27 -0600
Date: Wed, 20 Sep 2006 17:34:26 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH]: Powerpc: EEH failure to mark pci slot as frozen.
Message-ID: <20060920223426.GT29167@austin.ibm.com>
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


Paul,
Please apply and submit upstream. Shouldn't be urgent, as
none of the existing dev drivers will be subject to this bug.

--linas

Bug fix: when marking a slot as frozen, we forgot to mark
pci device itself as frozen. (we did manage to mark the 
pci children, but forget the parent itself.)

This is needed so that some device drivers can check the 
pci status in critical sections (e.g. in spin loops with 
interrupts disabled). 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.18-rc7-git1.orig/arch/powerpc/platforms/pseries/eeh.c	2006-09-20 17:18:00.000000000 -0500
+++ linux-2.6.18-rc7-git1/arch/powerpc/platforms/pseries/eeh.c	2006-09-20 17:21:04.000000000 -0500
@@ -225,6 +225,7 @@ static void __eeh_mark_slot (struct devi
 
 void eeh_mark_slot (struct device_node *dn, int mode_flag)
 {
+	struct pci_dev *dev;
 	dn = find_device_pe (dn);
 
 	/* Back up one, since config addrs might be shared */
@@ -232,6 +233,12 @@ void eeh_mark_slot (struct device_node *
 		dn = dn->parent;
 
 	PCI_DN(dn)->eeh_mode |= mode_flag;
+
+	/* Mark the pci device too */
+	dev = PCI_DN(dn)->pcidev;
+	if (dev)
+		dev->error_state = pci_channel_io_frozen;
+
 	__eeh_mark_slot (dn->child, mode_flag);
 }
 
