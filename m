Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AC0A02BDB0
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Oct 2004 21:54:33 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Harald Welte <laforge@gnumonks.org>
In-Reply-To: <20041001194630.GO27499@sunbeam.de.gnumonks.org>
References: <415D8768.8080808@nortelnetworks.com>
	<20041001193153.GN27499@sunbeam.de.gnumonks.org>
	<415DB334.4010809@nortelnetworks.com>
	<20041001194630.GO27499@sunbeam.de.gnumonks.org>
Content-Type: text/plain
Message-Id: <1096717811.3634.45.camel@gaston>
Mime-Version: 1.0
Date: Sat, 02 Oct 2004 21:50:11 +1000
Cc: netdev@oss.sgi.com, linuxppc-dev@ozlabs.org
Subject: Re: kernel crash with G5 Xserve and sungem driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2004-10-02 at 05:46, Harald Welte wrote:
> On Fri, Oct 01, 2004 at 01:42:44PM -0600, Chris Friesen wrote:
> > Harald Welte wrote:
> > 
> > >Just don't compile (or load) the sungem driver on those boxes.
> > 
> > Hmm.  That's a pain.  We've got G5 desktops too, and it would be nice to be 
> > able to run one kernel for both.  It'd be better (IMHO) to fix the driver 
> > so it doesn't crash.
> 
> I recommend talking to Bejamin Herrenschmidt, IIRC he already had
> something in mind in order to fix the issue.
> 
> I mean, you can always hardcode some exemption into the driver, that's
> two easy lines ;)

Or just have the driver test the return value of pci_device_to_OF_node()
for NULL :)

One thing is that I'm about to push a patch that will "hide" PCI devices
from the kernel that are absent from the OF tree since there are other
issues with newer machines, so that will fix the problem. Both 64 bits
and 32 bits patches are below:

===== arch/ppc64/kernel/pmac_pci.c 1.5 vs edited =====
--- 1.5/arch/ppc64/kernel/pmac_pci.c	2004-07-25 14:51:52 +10:00
+++ edited/arch/ppc64/kernel/pmac_pci.c	2004-08-04 10:26:07 +10:00
@@ -271,7 +271,7 @@
 				    int offset, int len, u32 *val)
 {
 	struct pci_controller *hose;
-	struct device_node *busdn;
+	struct device_node *busdn, *dn;
 	unsigned long addr;
 
 	if (bus->self)
@@ -282,6 +282,16 @@
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	hose = busdn->phb;
 	if (hose == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	/* We only allow config cycles to devices that are in OF device-tree
+	 * as we are apparently having some weird things going on with some
+	 * revs of K2 on recent G5s
+	 */
+	for (dn = busdn->child; dn; dn = dn->sibling)
+		if (dn->devfn == devfn)
+			break;
+	if (dn == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	addr = u3_ht_cfg_access(hose, bus->number, devfn, offset);

===== arch/ppc/platforms/pmac_pci.c 1.21 vs edited =====
--- 1.21/arch/ppc/platforms/pmac_pci.c	2004-07-29 14:58:35 +10:00
+++ edited/arch/ppc/platforms/pmac_pci.c	2004-08-17 14:18:09 +10:00
@@ -315,6 +315,10 @@
 	unsigned int addr;
 	int i;
 
+	struct device_node *np = pci_busdev_to_OF_node(bus, devfn);
+	if (np == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	/*
 	 * When a device in K2 is powered down, we die on config
 	 * cycle accesses. Fix that here.
@@ -362,6 +366,9 @@
 	unsigned int addr;
 	int i;
 
+	struct device_node *np = pci_busdev_to_OF_node(bus, devfn);
+	if (np == NULL)
+		return PCIBIOS_DEVICE_NOT_FOUND;
 	/*
 	 * When a device in K2 is powered down, we die on config
 	 * cycle accesses. Fix that here.
