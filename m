Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EAF43DDE21
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 16:54:49 +1000 (EST)
Date: Sat, 22 Sep 2007 00:25:51 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] pcmcia: Convert io_req_t to use kio_addr_t
Message-ID: <20070922062551.GE10625@parisc-linux.org>
References: <20070905142742.GA1760@lixom.net>
	<20070914034854.1658a9cf.akpm@linux-foundation.org>
	<20070921221516.GA7926@lixom.net>
	<20070921233936.2aeb2504@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070921233936.2aeb2504@the-village.bc.nu>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>,
	Andrew Morton <akpm@linux-foundation.org>, hch@lst.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2007 at 11:39:36PM +0100, Alan Cox wrote:
> On Fri, 21 Sep 2007 17:15:16 -0500
> Olof Johansson <olof@lixom.net> wrote:
> 
> > Convert the io_req_t members to kio_addr_t, to allow use on machines with
> > more than 16 bits worth of IO ports (i.e. secondary busses on ppc64, etc).
> 
> What about the formatting and field widths ?
> 
> ulong would probably be a lot saner than kio_addr_t and yet more type
> obfuscation.

I don't think anyone uses ioports > 32bit.  Certainly i386 takes an int
port as parameter to {in,out}[bwl] (and it really only uses 16-bits).
parisc uses 24 bits.  I don't know what the various ppcs do, but pci
bars can only be 32-bit for ioports.  So my opinion is that ioports
should be uint, not ulong.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
