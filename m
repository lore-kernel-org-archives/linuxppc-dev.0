Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9650DDDDF8
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 07:13:08 +1100 (EST)
Subject: Re: pmac_zilog debugging ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <492145BB.7080904@hypersurf.com>
References: <4914B549.9010805@hypersurf.com>
	<1226096603.13603.74.camel@pasglop> <491C11B2.1060909@hypersurf.com>
	<1226612654.7178.84.camel@pasglop> <491CAA32.20307@hypersurf.com>
	<1226624429.7178.105.camel@pasglop> <49212D61.3080305@hypersurf.com>
	<1226912422.7178.228.camel@pasglop>  <492145BB.7080904@hypersurf.com>
Content-Type: text/plain
Date: Mon, 17 Nov 2008 22:40:18 +1100
Message-Id: <1226922018.7178.237.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-11-17 at 02:21 -0800, Kevin Diggs wrote:
> Benjamin Herrenschmidt wrote:
> >  
> > 
> > That's definitely strange. I would expect the kernel to be able to get
> > interrupts fast enough to service a 1200 bauds serial port. Maybe
> > there's something else wrong, or an other driver causing undue interrupt
> > latencies.... 
> > 
> As far as I can see the system is NOT busy. I see no evidence of excessive
> interrupt loading. It does have an Adaptec 2940 u2w SCSI card, an ATI video card,
> and a USB/firewire card. The SCSI card has some disks on it. The other two cards
> are unused. I guess, in theory, something in my 2.6.27 kernel could be causing one
> of the two unused cards to throw spurious interrupts?
> 
> I still think the hardware is mis-behaving.

That's strange. Maybe one of the drivers is occasionally hogging
interrutps. Well, there may also be a bug in the code :-)

One thing you can try is to disable DMA in macserial (shouldn't be hard
to hack) and see if it degrades the same way.

> > Out of curiosity, check that IDE properly unmasks interrupts (hdparm
> > -u1 /dev/hda).
> > 
> This is an 8600. It is SCSI only (the onboard controller is the MESH).

Ah yes.
 
> >> So, I'm on board with this approach. Since I don't really know what I am
> >>doing, how do you recommend I proceed?
> > 
> > 
> > Google for a document called MacTech.pdf which contains various
> > documentations for bits of the ancestor of the IO chip in your machine,
> > along with a description of the DBDMA engine :-) Something else you can
> > do is to look at how it's properly used by other drivers such as bmac
> > and look at some of the darwin source code for reference on how the HW
> > works.
> > 
> where might one find older Darwin source?

Apple still has most of them back to 10.0 and even the recent ones still
have an SCC serial driver afaik.

Ben.

> > Cheers,
> > Ben.
> > 
> > _______________________________________________
> > 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
