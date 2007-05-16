Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 741BDDDF16
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 04:06:35 +1000 (EST)
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02 hardware
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1179333883.7018.20.camel@ld0161-tx32>
References: <1179245829.8132.100.camel@rhino> <1179247809.8132.138.camel@rhino>
	<1179333883.7018.20.camel@ld0161-tx32>
Content-Type: text/plain
Date: Wed, 16 May 2007 11:06:34 -0700
Message-Id: <1179338794.8132.209.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-16 at 11:44 -0500, Jon Loeliger wrote:
> On Tue, 2007-05-15 at 11:50, Wade Farnsworth wrote:
> > +static void __devinit early_mpc86xx_pcie(struct pci_dev *dev)
> > +{
> > +	   dev->class = PCI_CLASS_BRIDGE_PCI << 8 | 0x1;
> > +}
> 
> What'd we decide on that 0x1 in there?
> 
> Thanks,
> jdl
> 
> 

I originally thought that it the 0x1 was necessary, but it was pointed
out to me that it should not be.

If I remove the 0x1 I get some I/O resource allocation failures on the
P2P bridge and its child devices.  I'm currently investigating what the
cause of this is.

--Wade
