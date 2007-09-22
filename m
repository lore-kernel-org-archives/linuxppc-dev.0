Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BC6DADDE00
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Sep 2007 01:09:18 +1000 (EST)
Date: Sat, 22 Sep 2007 10:11:48 -0500
From: Olof Johansson <olof@lixom.net>
To: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH v2] pcmcia: Convert io_req_t to use kio_addr_t
Message-ID: <20070922151148.GA19776@lixom.net>
References: <20070905142742.GA1760@lixom.net>
	<20070914034854.1658a9cf.akpm@linux-foundation.org>
	<20070921221516.GA7926@lixom.net>
	<20070921233936.2aeb2504@the-village.bc.nu>
	<20070922062551.GE10625@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070922062551.GE10625@parisc-linux.org>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
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
> On Fri, Sep 21, 2007 at 11:39:36PM +0100, Alan Cox wrote:
> > On Fri, 21 Sep 2007 17:15:16 -0500
> > Olof Johansson <olof@lixom.net> wrote:
> > 
> > > Convert the io_req_t members to kio_addr_t, to allow use on machines with
> > > more than 16 bits worth of IO ports (i.e. secondary busses on ppc64, etc).
> > 
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

PPC would do just fine with 32-bit as well, which is what I wanted in
the first place. I just went with the local coding standard of pcmcia
and switched to kio_addr_t.

I suppose it's a janitorial todo item but with the maintainer MIA I
don't want to mess around with it too much, since I can't really test
much besides the PPC stuff I have.

As for the formatting/padding widths: Some platforms had ioaddr_t's
that were 32 bit already, so it was already broken on those, and the
only drawback is missing 0-padding. It'd look a bit silly to pad to 16
0:s anyway at the moment, so I think I'd prefer to keep it the way it is.


-Olof
