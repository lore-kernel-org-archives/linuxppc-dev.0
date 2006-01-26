Return-Path: <froese@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id E65AD68AC4
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2006 15:34:31 +1100 (EST)
Date: Thu, 26 Jan 2006 05:34:12 +0100
From: Edgar Toernig <froese@gmx.de>
To: Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-Id: <20060126053412.0da7f505.froese@gmx.de>
In-Reply-To: <20060126000618.GA5592@twiddle.net>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113206.GD18584@miraclelinux.com>
	<20060125200250.GA26443@flint.arm.linux.org.uk>
	<20060126000618.GA5592@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, Ian Molton <spyro@f2s.com>,
	Kleen <ak@suse.de>, David Howells <dhowells@redhat.com>,
	linuxppc-dev@ozlabs.org, Greg Ungerer <gerg@uclinux.org>,
	sparclinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>, Andi,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	Linus Torvalds <torvalds@osdl.org>,
	Kokshaysky <ink@jurassic.park.msu.ru>, Ivan,
	Akinobu Mita <mita@miraclelinux.com>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxsh-dev@lists.sourceforge.net, linux390@de.ibm.com,
	parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Richard Henderson wrote:
>
> On Wed, Jan 25, 2006 at 08:02:50PM +0000, Russell King wrote:
> > > +	s = 16; if (word << 16 != 0) s = 0; b += s; word >>= s;
> > > +	s =  8; if (word << 24 != 0) s = 0; b += s; word >>= s;
> > > +	s =  4; if (word << 28 != 0) s = 0; b += s; word >>= s;
> ...
> > Basically, shifts which depend on a variable are more expensive than
> > constant-based shifts.
> 
> Actually, they're all constant shifts.  Just written stupidly.

Why shift at all?

int ffs(u32 word)
{
    int bit = 0;

    word &= -word; // only keep the lsb.

    if (word & 0xffff0000) bit |= 16;
    if (word & 0xff00ff00) bit |=  8;
    if (word & 0xf0f0f0f0) bit |=  4;
    if (word & 0xcccccccc) bit |=  2;
    if (word & 0xaaaaaaaa) bit |=  1;

    return bit;
}

Ciao, ET.
