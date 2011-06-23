Return-Path: <ralf@linux-mips.org>
Received: from duck.linux-mips.net
	(6.7.e.0.d.c.8.f.6.4.1.0.1.b.1.2.0.0.0.0.a.e.3.0.0.b.8.0.1.0.0.2.ip6.arpa
	[IPv6:2001:8b0:3ea:0:21b1:146:f8cd:e76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E629B6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jun 2011 22:23:11 +1000 (EST)
Date: Thu, 23 Jun 2011 13:02:35 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Martyn Welch <martyn.welch@ge.com>
Subject: Re: [PATCH] STAGING: Comedi: Build only on arches providing
	PAGE_KERNEL_NOCACHE
Message-ID: <20110623120234.GA22524@linux-mips.org>
References: <20110623114536.GA14011@linux-mips.org> <4E032940.5010205@ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4E032940.5010205@ge.com>
Cc: devel@driverdev.osuosl.org, linux-m32r-ja@ml.linux-m32r.org,
	linux-m32r@ml.linux-m32r.org, Paul Mundt <lethal@linux-sh.org>,
	linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
	David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com,
	Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 23, 2011 at 12:53:36PM +0100, Martyn Welch wrote:

> On 23/06/11 12:45, Ralf Baechle wrote:
> > On architectures that don't define PAGE_KERNEL_NOCACHE, the Comedi driver turns
> > into tragedy:
> > 
> >   CC [M]  drivers/staging/comedi/drivers.o
> > drivers/staging/comedi/drivers.c: In function ‘comedi_buf_alloc’:
> > drivers/staging/comedi/drivers.c:505:41: error: ‘PAGE_KERNEL_NOCACHE’ undeclared (first use in this function)
> > drivers/staging/comedi/drivers.c:505:41: note: each undeclared identifier is rep orted only once for each function it appears in
> > make[3]: *** [drivers/staging/comedi/drivers.o] Error 1
> > 
> > Restrict the driver to only those architectures that define PAGE_KERNEL_NOCACHE.
> > 
> > PAGE_KERNEL_NOCACHE is a kludge - some system architectures such as SGI IP27
> > are even uable to offer uncached operation - at least in the way an unwitting
> > driver might assume.  I haven't looked in details how the driver is using
> > the area vmaped with PAGE_KERNEL_NOCACHE but maybe doing it XFS-style using
> > cached memory and the flush_kernel_vmap_range / invalidate_kernel_vmap_range
> > APIs in conjunction with the DMA API is a practical alternative.
> > 
> > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> > 
> >  drivers/staging/comedi/Kconfig |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/staging/comedi/Kconfig b/drivers/staging/comedi/Kconfig
> > index 1502d80..bccdc12 100644
> > --- a/drivers/staging/comedi/Kconfig
> > +++ b/drivers/staging/comedi/Kconfig
> > @@ -2,6 +2,7 @@ config COMEDI
> >  	tristate "Data acquisition support (comedi)"
> >  	default N
> >  	depends on m
> > +	depends on BROKEN || FRV || M32R || MN10300 || SUPERH || TILE || X86
> 
> I'm sure I got comedi to compile on a 32-bit PPC board not that long ago. Has
> something changed, or is this just not an exhaustive list?

(Adding the PPC folks to cc.)

A "git grep -w PAGE_KERNEL_NOCACHE arch/powerpc/" doesn't find anything so
I don't think the driver will build there.  I don't have a PPC toolchain
to verify that.

  Ralf
