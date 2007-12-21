Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 1196DDDEC9
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 07:26:46 +1100 (EST)
Date: Fri, 21 Dec 2007 21:00:18 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH -mm 18/43] powerpc compat_binfmt_elf
Message-ID: <20071221200018.GA17164@uranus.ravnborg.org>
References: <20071220115200.C767E26F98A@magilla.localdomain>
	<20071220115816.504CC26F98E@magilla.localdomain>
	<20071221071229.GC4345@infradead.org>
	<20071221085609.4D53B26F98A@magilla.localdomain>
	<20071221175106.GB17656@fattire.cabal.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221175106.GB17656@fattire.cabal.ca>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 21, 2007 at 12:51:06PM -0500, Kyle McMartin wrote:
> On Fri, Dec 21, 2007 at 12:56:09AM -0800, Roland McGrath wrote:
> > > On Thu, Dec 20, 2007 at 03:58:16AM -0800, Roland McGrath wrote:
> > > > +obj-$(CONFIG_PPC64)		+= ../../../fs/compat_binfmt_elf.o
> > > 
> > > Building files from another directory is nasty.  Please add a
> > > CONFIG_BINFMT_COMPAT_ELF so we can simply build it in fs/
> > 
> > If that's better, please post the precise Kconfig magic you have in mind to
> > have it set when it should be.
Kyle made a proposal but I like to get in to the party too...

> > 
> 
> Just taking a stab that hch means,
> 
> config BINFMT_COMPAT_ELF
> 	def_bool n
> 	depends on 64BIT
> 
> and then in arch/powerpc/Kconfig
> 
> config COMPAT
> 	bool
> 	default y if PPC64
> 	select BINFMT_COMPAT_ELF
> 
> or somesuch.

We recently discussed a common prefix for the selctable symbols
and consensus pointed out "HAVE_" so let us try to use it.
I did not quite understand the "depends on 64BIT" in Kyles example.
Does we really want to use compat_binfmt_elf for all archs that
define 64BIT? Anyway I added this in the example below.

fs/Makefile:
obj-$(COMPAT_BINFMT_ELF) += compat_binfmt_elf.o

fs/Kconfig:
config COMPAT_BINFMT_ELF
	depends on HAVE_COMPAT_BINFMT_ELF || 64BIT

# COMPAT_BINFMT_ELF must be selected when an
# architecture supoorts ...
config HAVE_COMPAT_BINFMT_ELF


arch/powerpc/Kconfig:

config COMPAT
	bool
	default PPC64
	select HAVE_COMPAT_BINFMT_ELF


In the example above the extra indirection:
HAVE_COMPAT_BINFMT_ELF => COMPAT_BNFMT_ELF is not really needed
but tomorrow when we add another "depends on" to COMPAT_INFMT_ELF
it is needed to avoid the misbehaving select that just ignore the
dependencies and select the symbol anyway.

	Sam
