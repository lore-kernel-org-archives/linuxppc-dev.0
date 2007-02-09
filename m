Return-Path: <dgibson@ozlabs.org>
Date: Sat, 10 Feb 2007 09:40:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: Okay to change default zImage link/load address?
Message-ID: <20070209224010.GB7339@localhost.localdomain>
References: <20070209184345.GA28127@mag.az.mvista.com>
	<20070209185107.GA12703@aepfle.de>
	<20070209185528.GB28127@mag.az.mvista.com>
	<45CCCCAD.2040507@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45CCCCAD.2040507@am.sony.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Olaf Hering <olaf@aepfle.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 09, 2007 at 11:34:05AM -0800, Geoff Levand wrote:
> Mark A. Greer wrote:
> > On Fri, Feb 09, 2007 at 07:51:07PM +0100, Olaf Hering wrote:
> >> On Fri, Feb 09, Mark A. Greer wrote:
> >> 
> >> > Does anyone know of a problem downloading to 8MB instead of 4MB in
> >> > arch/powerpc?  If not, would you object if it changed to 8MB?
> >> 
> >> IBM chrp 32 and 64bit has a free and usable memory range from 64k to
> >> 12M.
> >> Changing the link address from 4 to 8 MB will reduce the max zImage size
> >> to 3MB on these systems.
> > 
> > Hmm, not good.
> > 
> > Paul, may we may this configurable (i.e., a CONFIG option)?
>  
> To have zImage.lds.S use a config option you'll need to run it through
> the preprocessor, which in general seems like a good thing.  Now we just
> have this:
> 
> $(obj)/zImage.lds $(obj)/zImage.coff.lds: $(obj)/%: $(srctree)/$(src)/%.S
> 	@cp $< $@

No.  Well, at that, running zImage.lds.S through the preprocessor
might not be a bad idea, but we definitely want to avoid using the
config anywhere in the bootwrapper, except in the Makefile for
choosing the platform passed to the wrapper script.  The idea is that
it should always be possible to wrap a given vmlinux using the wrapper
script and wrapper library, outside the context of the kernel source
tree that built that vmlinux.

Note that the zImage is already build -fPIC and capable of relocating
itself if loaded at an address other than 4MB...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
