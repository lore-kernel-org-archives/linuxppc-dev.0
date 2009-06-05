Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5BC5BB709F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 09:32:22 +1000 (EST)
Subject: Re: [BUILD FAILURE 01/04] Next June 04:PPC64 randconfig
	[drivers/staging/comedi/drivers.o]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20090605182618.GA11853@kroah.com>
References: <20090605182625.24093.7808.sendpatchset@elm3a191.beaverton.ibm.com>
	<20090605182618.GA11853@kroah.com>
Content-Type: text/plain
Date: Sat, 06 Jun 2009 09:31:40 +1000
Message-Id: <1244244700.31984.15.camel@pasglop>
Mime-Version: 1.0
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Linux-Next <linux-next@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Subrata Modak <subrata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-06-05 at 11:26 -0700, Greg KH wrote:
> Should the comedi layer just not be using PAGE_KERNEL_NOCACHE here?  I
> can't believe that we need to do something like this in a driver.  What
> should the proper fix for this be?

Actualy, I think powerpc -had- PAGE_KERNEL_NOCACHE and I removed it ...
Oh well... My understanding was that the exposed interface isn't that
but instead pgprot_noncached().

Nowadays we provide these on ppc:

#define pgprot_noncached(prot)    (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
                                            _PAGE_NO_CACHE | _PAGE_GUARDED))

#define pgprot_noncached_wc(prot) (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
                                            _PAGE_NO_CACHE))

#define pgprot_cached(prot)       (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
                                            _PAGE_COHERENT))

#define pgprot_cached_wthru(prot) (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
                                            _PAGE_COHERENT | _PAGE_WRITETHRU))


Now, of course, expect interesting problems if you use it in vmap, since
you are mapping struct pages, you are effectively mapping memory.

On some platforms, it's absolutely illegal to map memory non-cacheable while
this memory is mapped cacheable elsewhere and can be fatal. But the pages you
are mapping here, I suppose, are also part of the linear mapping which is ...
cacheable.

Why would you need that non-cacheable mapping in the first place ? If it's
for DMA, it's the wrong interface I believe....

Cheers,
Ben.
