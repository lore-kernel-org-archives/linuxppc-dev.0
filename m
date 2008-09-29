Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809291404y1b5f14b6j3f9d29cda6ce4bd5@mail.gmail.com>
Date: Mon, 29 Sep 2008 17:04:22 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: USB support on mpc5200 broken
In-Reply-To: <20080929201829.GA16153@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com>
	<9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com>
	<1222307447.8277.147.camel@pasglop> <48E02FD0.8000809@genesi-usa.com>
	<20080929034329.GB8694@yookeroo.seuss>
	<9e4733910809290714td2dc6cclecf2e2b080a80ca1@mail.gmail.com>
	<20080929201829.GA16153@ld0162-tx32.am.freescale.net>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 29, 2008 at 4:18 PM, Scott Wood <scottwood@freescale.com> wrote:
> On Mon, Sep 29, 2008 at 10:14:18AM -0400, Jon Smirl wrote:
>> Shouldn't the driver already know it is being used on a BE machine?
>
> No.  Endianness of the CPU is not necessarily the same as the endianness
> of device registers.
>
> For example, PCI OHCI on a big-endian host.

Endianess is encoded in the specific compatible string.

compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci";
This is BE.

inside PCI bus section
compatible = "my-pci-ohci-card"
This would be LE

The specifically loaded driver knows it's endianess.

But now you're tell me I need
compatible = "fsl,mpc5200b-ohci","fsl,mpc5200-ohci",  "ohci-be"

But that doesn't work right on the mpc5200. If I remove the mpc5200
specific device driver from my system it will cause the generic
ohci-be one to load. And the generic one doesn't work.

The mpc5200 ohci device driver should be setting the endianess state
into the generic ohci code.


>
> -Scott
>



-- 
Jon Smirl
jonsmirl@gmail.com
