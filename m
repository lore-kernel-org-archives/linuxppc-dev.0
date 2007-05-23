Return-Path: <pterry@micromemory.com>
Received: from mail.micromemory.com
	(ip67-95-226-82.z226-95-67.customer.algx.net [67.95.226.82])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 76581DDF11
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 02:13:50 +1000 (EST)
Received: from [192.168.0.90] by micromemory.com (MDaemon PRO v9.5.6)
	with ESMTP id md50000412587.msg
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 09:13:46 -0700
Subject: Re: Porting RapidIO from ppc arch to powerpc arch in support of
	MPC8641D
From: Phil Terry <pterry@micromemory.com>
To: segher@kernel.crashing.org
In-Reply-To: <0389b4398a09293e6b6e0e4304a81ebe@kernel.crashing.org>
References: <1179862732.25914.40.camel@pterry-fc6.micromemory.com>
	<46B96294322F7D458F9648B60E15112C234AE6@zch01exm26.fsl.freescale.net>
	<Pine.LNX.4.64.0705230916170.535@localhost.localdomain>
	<0389b4398a09293e6b6e0e4304a81ebe@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 23 May 2007 09:13:42 -0700
Message-Id: <1179936822.11247.37.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: pterry@micromemory.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-23 at 18:00 +0200, Segher Boessenkool wrote:
> >>>                 interrupts = <30 1 31 1 32 1 35 1 36 1 37 1 38 1>;
> >>>
> >> Do you really use all of this interrupts? In my test, three <32 2 35 2
> >> 36 2> are okay, and the sense is 2.
> >
> > I think we need to list all the interrupts possible from RIO, not just 
> > the
> > ones the driver happens to use.
> 
> Yes exactly; the device tree describes the hardware, not
> the way that Linux (or any other OS) happens to use it.
So a law is a bit like a BAR in PCI, its a configuration by software of
the memory map determining which accesses are directed at the hardware.

Unlike PCI its not something we can go around probing the hardware for
and then doling out memory space to them. Its purely up to software as a
whole to decide its system wide memory map. Its not that the device
"needs" x amount of memory to work, its a case of for your application
how much of your memory would you like this device to handle for you.

Is this something the dts as a central, early boottime thing should be
in charge of, ie telling the kernel how to organize its total memory
map?

Excuse the noobie questions but I haven't been able to work out the
provenance of the open firmware stuff, and the resolution between the
ppc32, ppc64, powerpc, apple, ibm, freescale, etc., camps on how this
stuff should be used from the archives, too much noise to signal.

Cheers
Phil

> 
> The same holds for the "law", "doorbells", and "mailboxes"
> properties -- I have no clue whether those are hardware
> properties or what else, you guys figure it out :-)
> 
> 
> Segher
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 
