Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DF999DDFC3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 03:35:42 +1000 (EST)
Subject: Re: How do external irq's get mapped?
From: Jon Loeliger <jdl@freescale.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <46322CE4.1060004@ru.mvista.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1EE@MERCURY.inside.istor.com>
	<46322CE4.1060004@ru.mvista.com>
Content-Type: text/plain
Message-Id: <1177695334.8797.30.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 27 Apr 2007 12:35:34 -0500
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2007-04-27 at 12:03, Sergei Shtylyov wrote:
> Hello.
> 
> Charles Krinke wrote:
> 
> > Let me try a more simplified IRQ question a different way by only
> > referring to the 8541.
> 
> > There are 12 external interrupt sources, irq[0..11] and as I understand
> > it, they all go through one vector, ExternalInput set in
> > head_fsl_booke.S and this vector resolves to "do_IRQ()", which I believe
> > is in arch/powerpc/kernel/irq.c (not arch/ppc/kernel/...).
> 
> > I am striving to understand how mapping of these external pins
> > irq[0..11] gets to IRQ numbers as shown with "cat /proc/interrupts".
> 
>     IIUC, the external IRQ #'s should follow those occupied by 32 internal IRQs.
>     But those shown in that file are "virtual" numbers, i.e. they got re-mapped by the kernel as it sees fit (basically, it tries to assign the same # to IRQs above 15 and remaps those below)

And remember, Ben distorted the IRQ World right about
somewhere in that time frame too.

Kumar, can you remind us?

> > Could someone point me at some references I can read to understand this
> > nuance of the 8541 in a linux-2.6.17.11 kernel, please.
> 
>    I'm not sure arch/powerpc/ in 2.6.17 had the complete MPC8541 support...

Which might be a different way of saying "You should try the
current top of git or 2.6.21." :-)

jdl
