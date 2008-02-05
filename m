Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id 10AE6DDE23
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 01:39:29 +1100 (EST)
Date: Tue, 5 Feb 2008 15:39:26 +0100
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: compile quirk linux-2.6.24 (with workaround)
Message-ID: <20080205143926.GA9709@powerlinux.fr>
References: <200802031729.12069.bernhard@intevation.de>
	<20080204095121.GA18167@powerlinux.fr>
	<20080205070833.3a5b7c11@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080205070833.3a5b7c11@zod.rchland.ibm.com>
From: Sven Luther <sven@powerlinux.fr>
Cc: linuxppc-dev@ozlabs.org, Bernhard Reiter <bernhard@intevation.de>,
	debian-powerpc@lists.debian.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 05, 2008 at 07:08:33AM -0600, Josh Boyer wrote:
> On Mon, 4 Feb 2008 10:51:21 +0100
> Sven Luther <sven@powerlinux.fr> wrote:
> 
> > On Sun, Feb 03, 2008 at 05:29:05PM +0100, Bernhard Reiter wrote:
> > > Dear linux powerpc Maintainers and Users,
> > > 
> > > recently I have tried to compile a new kernel on a Debian sarge ppc
> > > system (PowerBook5,6 MacRISC3 Power Macintosh).
> > 
> > This is a G4 based system.
> > 
> > > The build system bailed out with
> > >        BOOTCC  arch/powerpc/boot/4xx.o
> > >         cc1: error: bad value (440) for -mcpu= switch
> > >         make[1]: *** [arch/powerpc/boot/4xx.o] Fehler 1
> > > 
> > > I have tracked this a few steps and the attached patch made the compile for me
> > > as my compiler gcc-Version 3.3.5 (Debian 1:3.3.5-13) 
> > > cannot produce code for 4xx it seems.
> > 
> > You should normally not need to build the 4xx bootloader part. Make sure
> > that, i don't know why this happens. Can you look into
> > arch/powerpc/boot/Makefile, to see what option enables the 4xx build,
> > and make sure it is disabled in the main config ?
> 
> That's not true.  All the wrapper bits are built for every board always.

Yes, which is why it fails. But Should they not be conditionally built
upon including support or not for the actual board ? 

I mean, if you have not included 4xx support in the kernel, as is the
case here, it does not make sense to add the 4xx bootwrapper code, no ? 

Friendly,

Sven Luther
