Return-Path: <mporter@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A9FC067BE5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 23:11:41 +1000 (EST)
Date: Thu, 24 Aug 2006 08:23:38 -0500
From: Matt Porter <mporter@embeddedalley.com>
To: Benjamin Delagoutte <BDE@teamlog.com>
Subject: Re: ARCH=ppc or ARCH=powerpc
Message-ID: <20060824132338.GA27468@gate.crashing.org>
References: <20060824123841.4756.qmail@web36601.mail.mud.yahoo.com>
	<1156423796.5640.23.camel@zod.rchland.ibm.com>
	<1156424295.19482.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1156424295.19482.11.camel@localhost>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 24, 2006 at 02:58:15PM +0200, Benjamin Delagoutte wrote:
> Le jeudi 24 août 2006 à 07:49 -0500, Josh Boyer a écrit :
> > On Thu, 2006-08-24 at 05:38 -0700, Parav Pandit wrote:
> > > ppc = 32bit.
> > > powerpc= 64bit.
> > > Correct me if I am wrong.
> > 
> > Yes, you're wrong.  Some 32 bit boards are also under arch/powerpc now.
> > 
> > >  
> > > I am not sure why community didn't adopt the name ppc and ppc64 just
> > > like ia-32 and ia64.
> > 
> > They did originally.
> > 
> > The new direction is to have everything under arch/powerpc, both 32 and
> > 64 bit.  The reason arch/ppc still exists is because some 32 bit
> > platforms have not been fully migrated to the requirements to be merged
> > into arch/powerpc.  Namely, the code has to boot from an OpenFirmware
> > like flattened device tree.  The PPC 4xx family of processors, as an
> > example, does not do this yet though there is work going on to adapt it.
> 
> I'm currently working on a PPC 405 based developement card. Does it mean
> I have to work using the arch/ppc tree ? 

PPC405 is only supported in the arch/ppc tree currenty. Unless you
want to contribute to the effort to move to arch/powerpc, you'll
have to work with arch/ppc/

> What about the includes ? Do I have to use only include/asm-ppc or are
> include/asm-powerpc necessary as well ?

When you do an arch/ppc build it automagically includes shared
includes from asm-powerpc as necessary. There's nothing to worry
about there.

The goal is to have the new 4xx arch/powerpc support not break 4xx
arch/ppc support. So as boards are merged and verified working,
we'll remove the equivalent support from arch/ppc...

Some boards/chips may just die if no maintainer step up to port
them over...but all the important stuff should get an interested
party once we get the initial 4xx support in arch/powerpc working.

-Matt
