Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add of_platform support for	OHCI/Bigendian HC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <454D0E58.4010100@246tNt.com>
References: <45490407.1010700@bplan-gmbh.de>
	<1162419799.25682.466.camel@localhost.localdomain>
	<1162423628.25682.489.camel@localhost.localdomain>
	<454A59CC.6070902@bplan-gmbh.de>  <454D0E58.4010100@246tNt.com>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 09:15:16 +1100
Message-Id: <1162678516.28571.60.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-11-04 at 23:04 +0100, Sylvain Munaut wrote:

> Isn't it possible to specify "options" in the device tree rather than
> different names ?
> (just a though ...)
> It's just duplicating all that code doesn't look nice.

Well, he certainly doesn't need to different match lists.

He can just have both LE and BE in a single list and have probe()
routine go look at the property instead.

Ben.

> > +config USB_OHCI_HCD_PPC_OF
> > +	bool "OHCI support for PPC USB controller for OpenFirmware platform"
> > +	depends on USB_OHCI_HCD && PPC_OF
> > +	default y
> > +	select USB_OHCI_BIG_ENDIAN
> > +	select USB_OHCI_LITTLE_ENDIAN
> > +	---help---
> > +	  Enables support for the USB controller PowerPC OpenFirmware platform
> > +
> >   
> I know what benh said but do we really want to select both all the
> times. That adds
> quite an overhead to the accesses ...

What I said ws that I wanted them to be user-selectable options.

Ben.
