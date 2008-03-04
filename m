Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id DFBDADDE30
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 19:19:05 +1100 (EST)
Date: Tue, 4 Mar 2008 09:19:04 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ARCH=ppc -> ARCH=powerpc : help needed for dts file
Message-ID: <20080304081904.GB18829@netgate.macqel>
References: <20080303144727.GA27949@ingate.macqel>
	<20080303170719.GC28951@ld0162-tx32.am.freescale.net>
	<20080303210532.GA20382@netgate.macqel>
	<47CC696C.4090103@freescale.com>
	<20080303212622.GB20382@netgate.macqel>
	<1204580493.21545.27.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204580493.21545.27.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

On Tue, Mar 04, 2008 at 08:41:33AM +1100, Benjamin Herrenschmidt wrote:
> 
> > Thanks
> > 
> > The following seems important also :
> > 
> > /*
> >                 interrupts = <18 2>;
> > */
> >                 /* interrupts number are coded in hexa ! */
> >                 interrupts = <12 2 19 2 1a 2 1b 2 35 2 36 2 37 2>;
> > 
> > I have replaced the interrupts spec in comments by the longer interrupts spec
> > below, and it seems to have some positive effect, but I do not know
> > precisely what I have described there.
> > 
> > I know that 25, 26, 27, 53, 54 and 55 decimal i(hence 19, 1a etc...) are the
> > interrupts numbers that I had in the ARCH=ppc version.  I added 18 because
> > of the error message, but it did not help.
> 
> Where is this ? (What node ?) The above looks like the interrupt spec
> for a single device with 7 interrupts, is that what you are trying to
> do ?

Well, the yenta device is a multi-function PCI peripheral that has two
pcmcia/pccard/compactflash slots and one ohci1394 interface.

Here's what uboot shows :
	PCI Scan: Found Bus 0, Device 18, Function 0
		00  12  104c  ac46  0607  ff
	PCI Scan: Found Bus 0, Device 18, Function 1
		00  12  104c  ac46  0607  ff
	PCI Scan: Found Bus 0, Device 18, Function 2
		00  12  104c  802a  0c00  00

and here is what /proc/interrupts shows in my ARCH=ppc dts-less running linux :
	root:~# cat /proc/interrupts
		   CPU0
	 25:          0   OpenPIC   Level     gfar_interrupt
	 26:        245   OpenPIC   Level     serial
	 27:          0   OpenPIC   Level     i2c-mpc
	 55:      18797   OpenPIC   Level     yenta, ide0
	 54:          1   OpenPIC   Level     yenta
	 55:         79   OpenPIC   Level     ohci1394
	BAD:          0
> 
> If not, then it's incorrect, you have to figure the interrupt-map out
> (it's really not -that- hard).

If I knew where to look at, and what I must produce, I'd agree with you :)

Philippe
