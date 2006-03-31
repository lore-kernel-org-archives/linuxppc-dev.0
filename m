Return-Path: <moilanen@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 594A1679E2
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Apr 2006 09:25:03 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2VMP0FE010549
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 17:25:00 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2VMLkku271596
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 15:21:46 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2VMP0Qh032681
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 15:25:00 -0700
Date: Fri, 31 Mar 2006 16:18:04 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH 1/2] Base pSeries PCIe support
Message-Id: <20060331161804.022e0299.moilanen@austin.ibm.com>
In-Reply-To: <1143843311.9731.111.camel@localhost.localdomain>
References: <20060331160203.f2bf8b53.moilanen@austin.ibm.com>
	<20060331160545.db3fa210.moilanen@austin.ibm.com>
	<1143843311.9731.111.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 31 Mar 2006 14:15:11 -0800
Dave Hansen <haveblue@us.ibm.com> wrote:

> On Fri, 2006-03-31 at 16:05 -0600, Jake Moilanen wrote:
> > --- 2.6.16.orig/arch/powerpc/kernel/rtas_pci.c  2006-03-31 15:11:20.000000000 -0600
> > +++ 2.6.16/arch/powerpc/kernel/rtas_pci.c       2006-03-31 15:15:35.000000000 -0600
> > @@ -315,7 +315,8 @@
> >         for (node = of_get_next_child(root, NULL);
> >              node != NULL;
> >              node = of_get_next_child(root, node)) {
> > -               if (node->type == NULL || strcmp(node->type, "pci") != 0)
> > +
> > +               if (node->type == NULL || ((strcmp(node->type, "pci") != 0) && (strcmp(node->type, "pciex") != 0)))
> >                         continue; 
> 
> That one looks to have gone a wee bit over 80 columns.

I need to stop developing on my widescreen.  :)

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---

Index: 2.6.16/arch/powerpc/Kconfig
===================================================================
--- 2.6.16.orig/arch/powerpc/Kconfig	2006-03-31 16:13:26.000000000 -0600
+++ 2.6.16/arch/powerpc/Kconfig	2006-03-31 16:13:36.000000000 -0600
@@ -808,6 +808,8 @@
 
 endchoice
 
+source "drivers/pci/pcie/Kconfig"
+
 source "drivers/pci/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
Index: 2.6.16/arch/powerpc/kernel/pci_64.c
===================================================================
--- 2.6.16.orig/arch/powerpc/kernel/pci_64.c	2006-03-31 16:13:26.000000000 -0600
+++ 2.6.16/arch/powerpc/kernel/pci_64.c	2006-03-31 16:13:36.000000000 -0600
@@ -395,7 +395,7 @@
 
 	dev->current_state = 4;		/* unknown power state */
 
-	if (!strcmp(type, "pci")) {
+	if (!strcmp(type, "pci") || !strcmp(type, "pciex")) {
 		/* a PCI-PCI bridge */
 		dev->hdr_type = PCI_HEADER_TYPE_BRIDGE;
 		dev->rom_base_reg = PCI_ROM_ADDRESS1;
Index: 2.6.16/arch/powerpc/kernel/rtas_pci.c
===================================================================
--- 2.6.16.orig/arch/powerpc/kernel/rtas_pci.c	2006-03-31 16:13:26.000000000 -0600
+++ 2.6.16/arch/powerpc/kernel/rtas_pci.c	2006-03-31 16:14:10.000000000 -0600
@@ -315,7 +315,9 @@
 	for (node = of_get_next_child(root, NULL);
 	     node != NULL;
 	     node = of_get_next_child(root, node)) {
-		if (node->type == NULL || strcmp(node->type, "pci") != 0)
+
+		if (node->type == NULL || ((strcmp(node->type, "pci") != 0) &&
+					   (strcmp(node->type, "pciex") != 0)))
 			continue;
 
 		phb = pcibios_alloc_controller(node);
