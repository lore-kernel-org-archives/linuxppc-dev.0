Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id F185167A75
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2005 05:19:24 +1100 (EST)
Message-ID: <422DECA6.1090408@mvista.com>
Date: Tue, 08 Mar 2005 11:19:18 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Sven Luther <sven.luther@wanadoo.fr>
References: <422C495B.8090805@katalix.com>	<20050307125808.6585A200008A@mwinf0308.wanadoo.fr>	<20050307225401.GA31041@xyzzy>
	<20050308064945.GC27722@pegasos>	<1110266832.13607.267.camel@gaston>
	<20050308122048.GA22866@xyzzy> <20050308121501.GC4556@pegasos>
In-Reply-To: <20050308121501.GC4556@pegasos>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Sven Luther wrote:

>Also going to add the explicit detection of the marvell bridge in the OF tree,
>

Do you really need to do that, though?  Just finding "Pegasos" or 
"Pegasos2" in the 'model' field of the device tree should be sufficient, 
shouldn't it? (if I'm reading the code correctly)

>but need to decide what to check for there.
>

The only way that I know of to tell if you're on a mv64x60 bridge is to 
do a pci cfg read of the vendor/device id fields of fcn 0 of the 
bridge's device on that pci hose.  By default, the bus number of both 
hoses are 0 (but OF probably sets the second one to be > 0 depending on 
how many pci buses there are hanging off hose 0), the bridge will be 
device 0 on both hoses, the vendor id will be PCI_VENDOR_ID_MARVELL 
(0x11ab) and the device id will be PCI_DEVICE_ID_MARVELL_MV64360 
(0x6460) for a mv64360.

Unfortunately, the bus number of each hose, the device # of the bridge's 
device on that hose (see "PCI P2P Configuration" register offsets 0x1d14 
& 0x1d94), and the vendor & device ids (by a pci cfg write to those 
fields) can all be changed by the fw .  I guess the device tree tells 
you the bus number of each hose so you can generate the proper cfg 
access and I doubt OF changes the bridge's device # and pci vendor/dev 
id but I wanted to make you aware of the potential.

Mark
