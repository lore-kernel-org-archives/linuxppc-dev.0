Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 70113DDE0D
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 19:13:25 +1000 (EST)
Date: Sat, 22 Sep 2007 11:13:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH v2] pcmcia: Convert io_req_t to use kio_addr_t
Message-ID: <20070922091303.GA12525@lst.de>
References: <20070905142742.GA1760@lixom.net>
	<20070914034854.1658a9cf.akpm@linux-foundation.org>
	<20070921221516.GA7926@lixom.net>
	<20070921233936.2aeb2504@the-village.bc.nu>
	<20070922062551.GE10625@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070922062551.GE10625@parisc-linux.org>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>,
	Andrew Morton <akpm@linux-foundation.org>, hch@lst.de,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Sep 22, 2007 at 12:25:51AM -0600, Matthew Wilcox wrote:
> > What about the formatting and field widths ?
> > 
> > ulong would probably be a lot saner than kio_addr_t and yet more type
> > obfuscation.
> 
> I don't think anyone uses ioports > 32bit.  Certainly i386 takes an int
> port as parameter to {in,out}[bwl] (and it really only uses 16-bits).
> parisc uses 24 bits.  I don't know what the various ppcs do, but pci
> bars can only be 32-bit for ioports.  So my opinion is that ioports
> should be uint, not ulong.

The kernel seems to mostly use int, sometimes uint.  I never quite got
why pcmcia had to have it's own strange typedef for them.
