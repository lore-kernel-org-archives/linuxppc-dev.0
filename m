Return-Path: <arnd@arndb.de>
To: Kumar Gala <kumar.gala@freescale.com>
Date: Sat, 17 Sep 2005 02:36:35 +0200
References: <200509160511.39277.arnd@arndb.de>
	<17FA692D-4643-4390-AE8A-AEF6F716C5EE@freescale.com>
In-Reply-To: <17FA692D-4643-4390-AE8A-AEF6F716C5EE@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200509170236.35963.>
From: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, pantelis.antoniou@gmail.com,
	linuxppc64-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] powerpc: merge include/asm/cputable.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Freedag 16 September 2005 23:40, Kumar Gala wrote:
> However, I do have some questions, why introduce new Kconfig options  
> for ppc64.  It seems overkill to have specific build options for each  
> "class" of ppc64.  One could make the argument we should go do the  
> same thing for classic ppc32.  From an embedded point of view I could  
> reduce down to the specific cpu I'm using.  I really dont think we  
> want to start doing this.

Note that the configuration options that my patch introduced are
all autodetected from the existing platform CONFIG_PPC_ symbols, so
they don't give you extra settings that might be messed up.

Having the options makes the enum in cpufeatures.h more readable
imho, but if you want to do a patch without them, I wont complain.

> If we did I would have to say we would have to add Kconfig for 601,  
> 603, 604, 750 (740, 750, 755), 7400 (7400/7410), 7450 (744x/745x).   
> That's six more Kconfig options

I actually like the idea more flexibility to which CPU optimizations
you get in the kernel. These could be combined with the gcc -mcpu=
argument, if there is a way for Kconfig to deduce the most generic
cpu type that still supports all selected models.
The easiest way to do something like this should be to add more
choices to the existing "Processor Type" submenu instead of having
each one selectable separately.

Something tells me that the platform and CPU type selection will
keep us busy for some time, because they are currently treated very
differently in ppc and ppc64. Please tell me if I understand this
correctly:

In ppc, the user can select one out of 27 platforms and one out of
seven separate sets of CPUs. All platforms except CHRP/PowerMac/PReP
can only ever work with a specific CPU selection, while that one
platform has the choice between 6xx/7xx/74xx/52xx/82xx/83xx, POWER3
and POWER4/970. These connections are currently not documented.

In ppc64, the user has to choose between the legacy iSeries and 
the generic platform. Generic means any combination of pSeries, 
PowerMac, Cell or Maple. The only CPU selection possibility is
'any cpu' or 'Power4 or better'. In future, we will have at least
a third option 'Book E' (or e700), which is incompatible with the
others. With my patch applied, the kernel would automatically disable
support for CPUs that are not possible with the selected platform
setting.

	Arnd <><
