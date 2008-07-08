Return-Path: <zippel@linux-m68k.org>
Received: from smtp-vbr13.xs4all.nl (smtp-vbr13.xs4all.nl [194.109.24.33])
	by ozlabs.org (Postfix) with ESMTP id 52360DDEE3
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 12:56:04 +1000 (EST)
Date: Tue, 8 Jul 2008 04:55:49 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: linux-next: kbuild tree build failure
In-Reply-To: <1215473798.8138.4.camel@localhost>
Message-ID: <Pine.LNX.4.64.0807080437550.6791@localhost.localdomain>
References: <20080707184038.aaeb8d40.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0807071424240.6791@localhost.localdomain>
	<1215473798.8138.4.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Sam Ravnborg <sam@ravnborg.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Tue, 8 Jul 2008, Michael Ellerman wrote:

> I don't really see why it "doesn't make sense" for users to input 64-bit
> values, they're configuring addresses for a 64-bit kernel, so some of
> the values are going to be 64 bit.

Do you really expect users to insert random 64bit addresses without making 
a mistake?
Please make a realistic case, where the user input of a full 64bit value 
is required (i.e. where it's not easier to just offer the user a few 
choices).
Currently there is simply no need for this, as even powerpc only used them 
as constants here.

> > Index: linux-2.6/arch/powerpc/Kconfig
> > ===================================================================
> > --- linux-2.6.orig/arch/powerpc/Kconfig
> > +++ linux-2.6/arch/powerpc/Kconfig
> > @@ -714,8 +714,8 @@ config PHYSICAL_START_BOOL
> >  
> >  config PHYSICAL_START
> >  	hex "Physical address where the kernel is loaded" if PHYSICAL_START_BOOL
> > -	default "0x02000000" if PPC_STD_MMU && CRASH_DUMP
> > -	default "0x00000000"
> > +	default "0x2000000" if PPC_STD_MMU && CRASH_DUMP
> > +	default "0"
> >  
> >  config PHYSICAL_ALIGN
> >  	hex
> > @@ -763,7 +763,7 @@ config CONSISTENT_SIZE_BOOL
> >  
> >  config CONSISTENT_SIZE
> >  	hex "Size of consistent memory pool" if CONSISTENT_SIZE_BOOL
> > -	default "0x00200000" if NOT_COHERENT_CACHE
> > +	default "0x200000" if NOT_COHERENT_CACHE
> >  
> >  config PIN_TLB
> >  	bool "Pinned Kernel TLBs (860 ONLY)"
> > @@ -773,15 +773,11 @@ endmenu
> >  if PPC64
> >  config PAGE_OFFSET
> >  	hex
> > -	default "0xc000000000000000"
> > -config KERNEL_START
> > -	hex
> > -	default "0xc000000002000000" if CRASH_DUMP
> > -	default "0xc000000000000000"
> > +	default "0xc0000000"
> 
> I don't see where you cope with the "if CRASH_DUMP" case, and in fact my
> config changes for the worse when I apply your patch and regenerate my
> config:
> 
> --- .config.orig	2008-07-08 09:30:00.000000000 +1000
> +++ .config	2008-07-08 09:30:43.000000000 +1000
> @@ -370,9 +370,8 @@
>  CONFIG_HOTPLUG_PCI_RPA=m
>  CONFIG_HOTPLUG_PCI_RPA_DLPAR=m
>  # CONFIG_HAS_RAPIDIO is not set
> -CONFIG_PAGE_OFFSET=0xc000000000000000
> -CONFIG_KERNEL_START=0xc000000002000000
> -CONFIG_PHYSICAL_START=0x02000000
> +CONFIG_PAGE_OFFSET=0xc0000000
> +CONFIG_PHYSICAL_START=0x2000000

Why is this worse? These are constants, you're not supposed to change them 
anyway.
The remaining values are generated in page.h and should be the same as 
before. If that isn't the case and this patch produces a nonworking 
kernel, I'd like to hear about it.

bye, Roman
