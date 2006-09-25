Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 347BB67BAC
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 09:02:46 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8PN2hrV001073
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Sep 2006 19:02:43 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8PN2h0F254394
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Sep 2006 19:02:43 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8PN1gUB030710
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Sep 2006 19:01:42 -0400
Date: Mon, 25 Sep 2006 18:01:42 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH]: Powerpc: EEH failure to mark pci slot as frozen.
Message-ID: <20060925230142.GD4518@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul, 

Resending, this one seems to have fallen through the cracks,
its not yet in 2.6.18-git4 or 2.6.18-mm1 (the others I've
sent have made it in, thanks!).

This patch is needed to make the symbios scsi recovery work 
correctly.  Please apply and forward.  

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

Index: linux-2.6.18-mm1/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.18-mm1.orig/arch/powerpc/platforms/pseries/eeh.c	2006-09-25 17:22:51.000000000 -0500
+++ linux-2.6.18-mm1/arch/powerpc/platforms/pseries/eeh.c	2006-09-25 17:31:55.000000000 -0500
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
 
