Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp1.wanadoo.fr (smtp1.wanadoo.fr [193.252.22.30])
	by ozlabs.org (Postfix) with ESMTP id 5BA1667A81
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2005 05:31:23 +1100 (EST)
Date: Tue, 8 Mar 2005 19:19:08 +0100
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20050308181908.GB12496@pegasos>
References: <422C495B.8090805@katalix.com>
	<20050307125808.6585A200008A@mwinf0308.wanadoo.fr>
	<20050307225401.GA31041@xyzzy> <20050308064945.GC27722@pegasos>
	<1110266832.13607.267.camel@gaston>
	<20050308122048.GA22866@xyzzy> <20050308121501.GC4556@pegasos>
	<422DECA6.1090408@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <422DECA6.1090408@mvista.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Nicolas DET <det.nicolas@free.fr>, Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: mv643xx_eth SA_SHIRQ support patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 08, 2005 at 11:19:18AM -0700, Mark A. Greer wrote:
> Sven Luther wrote:
> 
> >Also going to add the explicit detection of the marvell bridge in the OF 
> >tree,
> >
> 
> Do you really need to do that, though?  Just finding "Pegasos" or 
> "Pegasos2" in the 'model' field of the device tree should be sufficient, 
> shouldn't it? (if I'm reading the code correctly)

Well, benh suggested it, so ... Basically i look for a host named node which
is a marvel discovery 2 pci id.

> >but need to decide what to check for there.
> 
> The only way that I know of to tell if you're on a mv64x60 bridge is to 
> do a pci cfg read of the vendor/device id fields of fcn 0 of the 

Yep, this is what i chose. Well in the of device tree not the pci-config
thingy.

> bridge's device on that pci hose.  By default, the bus number of both 
> hoses are 0 (but OF probably sets the second one to be > 0 depending on 
> how many pci buses there are hanging off hose 0), the bridge will be 
> device 0 on both hoses, the vendor id will be PCI_VENDOR_ID_MARVELL 
> (0x11ab) and the device id will be PCI_DEVICE_ID_MARVELL_MV64360 
> (0x6460) for a mv64360.

Nice, didn't think about using the #defines, will modify this.

> Unfortunately, the bus number of each hose, the device # of the bridge's 
> device on that hose (see "PCI P2P Configuration" register offsets 0x1d14 
> & 0x1d94), and the vendor & device ids (by a pci cfg write to those 
> fields) can all be changed by the fw .  I guess the device tree tells 
> you the bus number of each hose so you can generate the proper cfg 
> access and I doubt OF changes the bridge's device # and pci vendor/dev 
> id but I wanted to make you aware of the potential.

The only problem would be if there is more than one 'host' node in the OF
device-tree, but i guess chances are good that even if there are more than
one, the first one would be the marvell one. Well, there are at least two,
one per bus, but i mean beyond that.

The driver seems to work, i was able to launch a dhclient on top of it, but
didn't do more testing. I will do some additional cleanup, and then i think
the patch will be ready.

Thanks for your help, you and Dale and Ben and the others who gave hints on
how to make this happen.

Friendly,

Sven Luther
