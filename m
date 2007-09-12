Return-Path: <ed.swarthout@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0BA4DDE2C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 16:35:52 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l8C6Zj2n008766
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 23:35:46 -0700 (MST)
Received: from az33exm20.fsl.freescale.net (az33exm20.am.freescale.net
	[10.64.32.6])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l8C6ZjLa023101
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 01:35:45 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] Fix interrupt routing and setup of ULI M1575
	onFSL boards
Date: Tue, 11 Sep 2007 23:33:11 -0700
Message-ID: <B52955765C54604CB1A62A9967F22C73026651A8@az33exm20.fsl.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0708170003210.21006@blarg.am.freescale.net>
From: "Swarthout Edward L-SWARTHOU" <ed.swarthout@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Kumar Gala:
...
> Fixed RTC support that requires a dummy memory read on the P2P
> bridge to unlock the RTC and setup the default of the RTC alarm
> registers to match with a basic x86 style CMOS RTC.
...
> diff --git a/arch/powerpc/platforms/fsl_uli1575.c
...
> +/* We have to do a dummy read on the P2P for the RTC to work, WTF
> +static void __devinit quirk_final_uli5249(struct pci_dev *dev)
...
> +	for (i =3D 0; i < PCI_BUS_NUM_RESOURCES; i++) {
> +		if ((bus->resource[i]) &&
> +			(bus->resource[i]->flags & IORESOURCE_MEM)) {
> +			dummy =3D ioremap(bus->resource[i]->start, 0x4);
> +			if (dummy) {
> +				in_8(dummy);

This read (to resource->start) can cause a hang on 8572ds when there
is a PCI card plugged into the uli slot and the card is configured
(but not enabled) in the memory space.

The read is going to the slot, 2.11, which has 0x8000_0000 assigned.
=20
To be safe, the read needs to go to a device internal to the uli.

-ELS
