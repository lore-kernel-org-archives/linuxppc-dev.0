Return-Path: <rdunlap@xenotime.net>
Received: from xenotime.net (xenotime.net [66.160.160.81])
	by ozlabs.org (Postfix) with SMTP id 8DDB267B83
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 02:08:42 +1000 (EST)
Received: from midway.site ([71.117.236.95]) by xenotime.net for
	<linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 09:08:36 -0700
Date: Tue, 10 Oct 2006 09:10:04 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] Add Kconfig dependency !VT for VIOCONS
Message-Id: <20061010091004.d6d91f8d.rdunlap@xenotime.net>
In-Reply-To: <20061010045534.GA3650@stusta.de>
References: <20061006180549.GB3684@shell0.pdx.osdl.net>
	<20061006200007.GD3684@shell0.pdx.osdl.net>
	<20061006143437.f7338860.rdunlap@xenotime.net>
	<20061010045534.GA3650@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 10 Oct 2006 06:55:34 +0200 Adrian Bunk wrote:

> On Fri, Oct 06, 2006 at 02:34:37PM -0700, Randy Dunlap wrote:
> > On Fri, 6 Oct 2006 13:00:07 -0700 Judith Lebzelter wrote:
> > 
> > > Actually, this gets rid of the CONFIG_VIOCONS from my .config, but 
> > > then I get another warning when I build:
> > > 
> > > Warning! Found recursive dependency: VT VIOCONS VT
> > > 
> > > Can anyone suggest something?
> > 
> > I think that your patch is mostly good/correct, but one more line
> > is needed on the VT side:  a deletion.
> > 
> > This works for me:
> > 
> > From: Randy Dunlap <rdunlap@xenotime.net>
> > 
> > Make allmodconfig .config build successfully by making VIOCONS
> > available only if VT=n.  VT need not check VIOCONS.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> > ---
> >  arch/powerpc/platforms/iseries/Kconfig |    2 +-
> >  drivers/char/Kconfig                   |    1 -
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> > 
> > --- linux-2619-rc1g2.orig/arch/powerpc/platforms/iseries/Kconfig
> > +++ linux-2619-rc1g2/arch/powerpc/platforms/iseries/Kconfig
> > @@ -3,7 +3,7 @@ menu "iSeries device drivers"
> >  	depends on PPC_ISERIES
> >  
> >  config VIOCONS
> > -	tristate "iSeries Virtual Console Support (Obsolete)"
> > +	tristate "iSeries Virtual Console Support (Obsolete)" if !VT
> >  	help
> >...
> >  config VT
> >  	bool "Virtual terminal" if EMBEDDED
> 
> With this dependency on EMBEDDED, you could as well simply remove 
> VIOCONS...
> 
> >  	select INPUT
> > -	default y if !VIOCONS
> 
> Removing the "default y" is wrong.

Oops, yes, agreed.

I don't see a way (using: make ARCH=powerpc iseries_defconfig,
which wants to enable VIOCONS) to prevent VT from being enabled
so that VIOCONS can be enabled.
However, since VIOCONS is marked (Obsolete) and since the powerpc
people don't comment on this patch & problem, maybe Judith is the
only person who cares.


> >  	---help---
> >  	  If you say Y here, you will get support for terminal devices with
> >  	  display and keyboard devices. These are called "virtual" because you
> >...

---
~Randy
