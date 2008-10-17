Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A9A08DDEFE
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 08:19:06 +1100 (EST)
Subject: RE: Problems with PCI-E devices not being detected with switch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <AymanE@tanisys.com>
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F829@tanisys-ex2.Tanisys.Local>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F81E@tanisys-ex2.Tanisys.Local>
	<1224134422.8157.549.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F822@tanisys-ex2.Tanisys.Local>
	<1224202209.7654.36.camel@pasglop>
	<16691A8B34B5D9458EA3A1C37A11555A0137F829@tanisys-ex2.Tanisys.Local>
Content-Type: text/plain
Date: Sat, 18 Oct 2008 08:19:00 +1100
Message-Id: <1224278340.7654.103.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-17 at 09:54 -0500, Ayman El-Khashab wrote:
> Benjamin Herrenschmidt wrote:
> > On Thu, 2008-10-16 at 10:01 -0500, Ayman El-Khashab wrote:
> >> Benjamin Herrenschmidt wrote:
> >>> On Wed, 2008-10-15 at 10:47 -0500, Ayman El-Khashab wrote:
> >>> 
> >>> Note for people on CC: This is a problem on 460EX on a canyonland
> >>> using the 4x port. 
> >>> 
> > 
> > Ok, can you send me a full dmesg log with "debug" on the kernel
> > command line after adding a #define DEBUG 1 to the top of
> > drivers/pci/probe.c please ? (before the batch of #include).  
> > 
> 
> Yes, it is below.  I saw the #define DEBUG 1 turned on these messages
> below, but I am not sure how to verify that I correctly added the 
> "debug" to the kernel arguments.  (In u-boot I added them to the end
> of the ramargs variable)

Can you try this (untested) patch and send me the resulting dmesg log
(along with whether it helps).

I think I know what the problem is. This isn't the "proper" solution
that should be implemented but it might help with the generic code
detecting that something is wrong and fixing it up.

I'll look at doing something better next week.

The problem I -think- is the bus numbers in the switch don't get reset
by the PCI-E reset below the root complex. Thus when the kernel probes,
it finds non sensical numbers in there that don't fit the range assigned
to the parent bus.

We can force the kernel to renumber everything with a flag but that will
cause problems with the root complex on 4xx due to other considerations
(that we need to fix too, mainly the way we limit config space to a
subset of bus numbers, we need to switch to dynamic fixmap for config
space to solve that).

If my theory is correct, this patch should help the kernel detect that
something is wrong on the switch and reconfigure it.

Cheers,
Ben.

Index: linux-work/drivers/pci/probe.c
===================================================================
--- linux-work.orig/drivers/pci/probe.c	2008-10-18 08:10:25.000000000 +1100
+++ linux-work/drivers/pci/probe.c	2008-10-18 08:14:14.000000000 +1100
@@ -536,19 +536,27 @@
 	int is_cardbus = (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS);
 	u32 buses, i, j = 0;
 	u16 bctl;
+	int broken = 0;
 
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
 
 	dev_dbg(&dev->dev, "scanning behind bridge, config %06x, pass %d\n",
 		buses & 0xffffff, pass);
 
+	/* Check if setup is sensible at all */
+	if ((buses & 0xff) != bus->number ||
+	    ((buses >> 8) & 0xff) != <= bus->number) {
+		dev_dbg(&dev->dev, "bus configuration doesn't match, reconfiguring\n");
+		broken = 1;
+	}
+
 	/* Disable MasterAbortMode during probing to avoid reporting
 	   of bus errors (in some architectures) */ 
 	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &bctl);
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
-	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus) {
+	if ((buses & 0xffff00) && !pcibios_assign_all_busses() && !is_cardbus && !broken) {
 		unsigned int cmax, busnr;
 		/*
 		 * Bus already configured by firmware, process it in the first
@@ -586,7 +594,7 @@
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses())
+			if (pcibios_assign_all_busses() || broken)
 				/* Temporarily disable forwarding of the
 				   configuration cycles on all bridges in
 				   this bus segment to avoid possible
