Return-Path: <tie-fei.zang@freescale.com>
Message-ID: <9FCDBA58F226D911B202000BDBAD4673062C0A9D@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Mark A. Greer"
	<mgreer@mvista.com>
Subject: RE: [HACK] add sandpoint + flattened dt support to arch/powerpc/b oot
Date: Thu, 18 May 2006 18:24:28 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 6729c98..de09eac 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -323,7 +323,10 @@ config PPC_ISERIES
> >  
> >  config EMBEDDED6xx
> >  	bool "Embedded 6xx/7xx/7xxx-based board"
> > -	depends on PPC32 && BROKEN
> > +	depends on PPC32
> > +	select PPC_UDBG_16550
> > +	select MPIC
> > +	select MPIC_SERIAL
> 
> Not totally related to your patch but I'm tempted to turn that into a
> "Generic 6xx/7xx/7xxx" rather than "embedded" if we manage to always
> avoid board specific code most of the time, but instead add necessary
> bits in the device-tree. We still need a per-board Kconfig option I
> think that will just select the necessary bits and pieces 
> (and more than
> one can be selected at one time). Also, I think right now, 
> the embedded
> stuff is +/- exclusive from the MULTIPLATFORM stuff, that 
> must be fixed
> asap. We are all living in the same kernel now :)

config Embedded6xx is not accurate. It can not cover all the 
board with 7xx/7xxx based processor.
