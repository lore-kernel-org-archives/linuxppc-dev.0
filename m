Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B94A4DDF73
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Jul 2008 09:38:18 +1000 (EST)
Date: Wed, 30 Jul 2008 16:10:46 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Stephen Horton <SHorton@kodiaknetworks.com>
Message-ID: <20080730231046.GA26011@farnsworth.org>
References: <295C5089A56CE143B316E5F67CA99CB001C9E4BD@cowboy.inovate.inovate.com>
	<20080728165108.GA22621@mag.az.mvista.com>
	<295C5089A56CE143B316E5F67CA99CB001D06956@cowboy.inovate.inovate.com>
MIME-Version: 1.0
In-Reply-To: <295C5089A56CE143B316E5F67CA99CB001D06956@cowboy.inovate.inovate.com>
Subject: Re: mpc744x, Marvell mv6446x kernel guidance please
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jul 30, 2008 at 08:56:18AM -0500, Stephen Horton wrote:
> Thanks for your kind encouragement. I now have a mostly booting kernel.
> I have just a few remaining issues to resolve; perhaps you (or others)
> can give me some tips regarding these:
> 
> 1. In your prpmc2800 .dts configuration, in the PCI bus configuration
> section, you lay-out the IRQ mappings like this:
> 	interrupt-map = <
>                 /* IDSEL 0x0a */
>                 5000 0 0 1 &/mv64x60/pic 50
>                 5000 0 0 2 &/mv64x60/pic 51
> I've read the Open Firmware document on Interrupt Mapping, but I still
> don't really understand the first 3 columns (5000 0 0), especially where
> the first column comes from. Is this just some arbitrarily selected
> offset address for that device on the pci bus?

An address on the PCI bus is represented by 3 cells (96 bits).

Take a look at page 4 of http://www.openbios.org/data/docs/bus.pci.pdf

You'll see that the PCI device is contained in bits 15-11, selected by
the 0xf800 in interrupt-map-mask.  The 0x5000 corresponds to device 0xa.

-Dale
