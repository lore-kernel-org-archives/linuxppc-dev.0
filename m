Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A9E6767A40
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 06:48:23 +1000 (EST)
Subject: Re: 2.6.16 backtrace at boot (Ibook G4) (related to "PowerBook5,4
	-- no sound?")
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
In-Reply-To: <Pine.LNX.4.44.0604201548060.12273-100000@zirkon.biophys.uni-duesseldorf.de>
References: <Pine.LNX.4.44.0604201548060.12273-100000@zirkon.biophys.uni-duesseldorf.de>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 06:48:05 +1000
Message-Id: <1145566085.17087.70.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "\[ATR\]Dj-Death" <djdeath@gmx.fr>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-04-20 at 15:51 +0200, Michael Schmitz wrote:
> > >   arch/powerpc/platforms/powermac/setup.c:721: error: 'mach_powermac' undeclared here (not in a function)
> > >   arch/powerpc/platforms/powermac/setup.c:721: warning: type defaults to 'int' in declaration of 'mach_powermac'
> > >   make[2]: *** [arch/powerpc/platforms/powermac/setup.o] Error 1
> > >   make[1]: *** [arch/powerpc/platforms/powermac] Error 2
> > >   make: *** [arch/powerpc/platforms] Error 2
> 
> That's how far I got on my own (didn't try Bens patch yet but machine_id
> is in fact still OK in the module, so exporting the necessary bits should
> fix it.
> 
> Commenting out the -ENODEV return gives me working sound; didn't I mention
> that?

There is a proper patch in paulus tree.. it's basically the patch I
posted with an extern declaration at the beginning of the macro before
the EXPORT_SYMBOL.
 
> > > However, I tried adding "EXPORT_SYMBOL(mach_powermac);" after the
> > > define_machine(powermac) and now sound works for me with my original
> > > I2C_POWERMAC=y SND_POWERMAC=m configuration.
> >
> > Yup, Paul has a working patch already, will be in 2.6.17 soonish.
> 
> I'll pull the current tree as soon as I'm back at the lab.

Patch isn't in yet it seems.

Ben
