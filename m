Return-Path: <Brad.Giffel@hbm.com>
Received: from relay.medianet-world.de (relay.medianet-world.de
 [213.157.0.172]) by ozlabs.org (Postfix) with SMTP id 4E848B6F65
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2011 23:19:55 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Support for multiple MSI interrupts on MPC8377
Date: Thu, 3 Nov 2011 07:19:49 -0500
Message-ID: <FBC631D6B23BAB40AF19415483130F7A6FD48B@HBMURBX.hbm.com>
In-Reply-To: <1320292282.3852.33.camel@concordia>
References: <FBC631D6B23BAB40AF19415483130F7A6FD458@HBMURBX.hbm.com>
 <1320292282.3852.33.camel@concordia>
From: "Giffel, Brad" <Brad.Giffel@hbm.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A single MSI interrupt it is then.

	Thanks,
	- Brad


-----Original Message-----
From: Michael Ellerman [mailto:michael@ellerman.id.au]=20
Sent: Wednesday, November 02, 2011 10:51 PM
To: Giffel, Brad
Cc: linuxppc-dev@lists.ozlabs.org; Matthew Wilcox
Subject: Re: Support for multiple MSI interrupts on MPC8377

On Wed, 2011-11-02 at 16:02 -0500, Giffel, Brad wrote:
> I'm working a project using a Spartan 6 FPGA with a PCIe interface and
> MSI interrupts.  I want to use multiple MSI interrupts (MSI-X is not
> supported in the FPGA PCIe core) but the current Linux distribution
> (3.0.8) prevents that (lines 23 to 25 in arch/powerpc/kernel/msi.c).
>=20
> =20
>=20
> What's the story here?  Is the code in place but not tested?  I tried
> commenting out those lines but a request_irq() called failed for the
> second interrupt requested.  Am I wasting my time here?  Should I
> re-architect to use a single MSI interrupt?

The short and easy answer is you should use a single MSI interrupt.

There is some code in place to support multiple MSI, but only in the
generic code (drivers/pci/msi.c), and I'm not sure if it's complete.
There is no arch support, for any arch AFAIK, and certainly not for
powerpc.

cheers
