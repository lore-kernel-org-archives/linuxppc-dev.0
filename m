Return-Path: <walt.wimer@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id BE79267A7A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Mar 2005 10:09:22 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 24 Mar 2005 17:53:44 -0500
Message-ID: <1111705036.15834.29.camel@excalibur.timesys.com>
From: "Wimer, Walt" <walt.wimer@timesys.com>
To: "ML linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: PCI support under 2.6.11.4 on MPC8272ADS ???
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Using Vitaly's 2.4-based patch below as a starting point, I've been
adding PCI support to 2.6.11.4 for the MPC8272ADS board.

The good news is that I think I have PCI interrupts pretty well sorted
out, and I see *something* half-way reasonable from "lspci".

The bad news is that neither of the ethernet cards that I'm trying will
actually work, and I see some very weird behavior with PCI configuration
space:

  Card 1:  Some Realtek RTL8139D-based card
  Card 2:  NETGEAR FA311 (National Semi DP83815 chip)

With either card installed alone, both U-Boot and my kernel identify the
cards correctly in PCI configuration space.

With *both* cards installed, both U-Boot and my kernel see the Realtek-
based card correctly, but the NETGEAR card has a corrupted Vendor ID
(e.g. 0x1000 or 0x1003 instead of the correct 0x100b).  This happens
regardless of which PCI slots I use for the cards (I've tried virtually
every combination).  This smells of a power problem or something to me.

And again, even with either card alone, the drivers have serious
problems talking to the cards.  I get various error messages from
the drivers and I see badly mangled packets on the wire.  It's also
not uncommon for the whole system to freeze...

Has anyone else seen similar behavior?

Has anyone had success with PCI on this board (under any kernel
version)?


Any ideas / data points are appreciated.


Thanks!!!

Walt Wimer



> This patch adds PCI bridge support for MPC8272 and PQ2FADS to the
> current linuxppc-2.4 tree. Actually it has been tested with 8272, but
> PQ2 _should_ also work, though it will complain that host bridge ID is
> unrecognized.
>
> Signed-off-by: Vitaly Bordug <vbordug at ru.mvista.com>
>
> --
> Sincerely, Vitaly
>
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: pq2-pci.patch
> Type: text/x-patch
> Size: 20111 bytes
> Desc: not available
> Url : =
http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20050218/12060c=
e8/pq2-pci.bin


--=20
Walter L. Wimer III <walt.wimer@timesys.com>
TimeSys Corporation
