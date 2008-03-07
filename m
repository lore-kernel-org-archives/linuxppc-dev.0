Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC65EDE006
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 03:21:46 +1100 (EST)
Date: Fri, 7 Mar 2008 10:21:35 -0600
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: Trouble with SCC UART ports when moving from ppc to powerpc
Message-ID: <20080307162135.GC10545@ld0162-tx32.am.freescale.net>
References: <200803071521.00383.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200803071521.00383.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 07, 2008 at 03:20:55PM +0100, Laurent Pinchart wrote:
> The CPM dual port ram was defined in the device tree as follows (copied from 
> the MPC8272ADS board device tree).
> 
>         muram@0 {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>                 ranges = <0 0 10000>;
> 
>                 data@0 {
>                         compatible = "fsl,cpm-muram-data";
>                         reg = <0 2000 9800 800>;
>                 };
>         };
> 
> Changing the reg property to
> 
> reg = <80 1f80 9800 800>;
> 
> fixed my problem.

Perhaps there's an SMC1 running with its parameter RAM at offset zero? 

> Does anyone have any clue regarding what could write to the dpram ? I thought 
> about some CPM peripheral set up by the boot loader, but my board 
> initialization code calls cpm2_reset() long before initializing SCC1.

cpm2_reset() doesn't currently actually reset the CPM, for some reason
(unlike cpm1).  This should probably be fixed, though then we'd have to
deal with assigning SMC parameter RAM addresses ourselves.

For now, the above fix should be done on any board with an active SMC
device (assuming SMC parameter RAM at zero, as u-boot sets it; other
bootloaders may need to exempt a different region).

-Scott
