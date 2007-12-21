Return-Path: <kyle@fattire.cabal.ca>
Received: from fattire.cabal.ca (there.is.no.cabal.ca [134.117.69.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 996D7DDE3C
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 04:51:11 +1100 (EST)
Date: Fri, 21 Dec 2007 12:51:06 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH -mm 18/43] powerpc compat_binfmt_elf
Message-ID: <20071221175106.GB17656@fattire.cabal.ca>
References: <20071220115200.C767E26F98A@magilla.localdomain>
	<20071220115816.504CC26F98E@magilla.localdomain>
	<20071221071229.GC4345@infradead.org>
	<20071221085609.4D53B26F98A@magilla.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221085609.4D53B26F98A@magilla.localdomain>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 21, 2007 at 12:56:09AM -0800, Roland McGrath wrote:
> > On Thu, Dec 20, 2007 at 03:58:16AM -0800, Roland McGrath wrote:
> > > +obj-$(CONFIG_PPC64)		+= ../../../fs/compat_binfmt_elf.o
> > 
> > Building files from another directory is nasty.  Please add a
> > CONFIG_BINFMT_COMPAT_ELF so we can simply build it in fs/
> 
> If that's better, please post the precise Kconfig magic you have in mind to
> have it set when it should be.
> 

Just taking a stab that hch means,

config BINFMT_COMPAT_ELF
	def_bool n
	depends on 64BIT

and then in arch/powerpc/Kconfig

config COMPAT
	bool
	default y if PPC64
	select BINFMT_COMPAT_ELF

or somesuch.

Regards, Kyle
