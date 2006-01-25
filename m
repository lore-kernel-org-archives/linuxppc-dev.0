Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[212.18.232.186])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C381168A8A
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2006 07:03:36 +1100 (EST)
Date: Wed, 25 Jan 2006 20:02:50 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [PATCH 3/6] C-language equivalents of include/asm-*/bitops.h
Message-ID: <20060125200250.GA26443@flint.arm.linux.org.uk>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113206.GD18584@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060125113206.GD18584@miraclelinux.com>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	Ian Molton <spyro@f2s.com>, Andi Kleen <ak@suse.de>,
	David Howells <dhowells@redhat.com>, linuxppc-dev@ozlabs.org,
	Greg Ungerer <gerg@uclinux.org>, sparclinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	Linus Torvalds <torvalds@osdl.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Richard Henderson <rth@twiddle.net>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org, linuxsh-dev@lists.sourceforge.net,
	linux390@de.ibm.com, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2006 at 08:32:06PM +0900, Akinobu Mita wrote:
> +#ifndef HAVE_ARCH___FFS_BITOPS
> +
> +/**
> + * __ffs - find first bit in word.
> + * @word: The word to search
> + *
> + * Returns 0..BITS_PER_LONG-1
> + * Undefined if no bit exists, so code should check against 0 first.
> + */
> +static inline unsigned long __ffs(unsigned long word)
>  {
> -	int	mask;
> +	int b = 0, s;
>  
> -	addr += nr >> 5;
> -	mask = 1 << (nr & 0x1f);
> -	return ((mask & *addr) != 0);
> +#if BITS_PER_LONG == 32
> +	s = 16; if (word << 16 != 0) s = 0; b += s; word >>= s;
> +	s =  8; if (word << 24 != 0) s = 0; b += s; word >>= s;
> +	s =  4; if (word << 28 != 0) s = 0; b += s; word >>= s;
> +	s =  2; if (word << 30 != 0) s = 0; b += s; word >>= s;
> +	s =  1; if (word << 31 != 0) s = 0; b += s;
> +
> +	return b;
> +#elif BITS_PER_LONG == 64
> +	s = 32; if (word << 32 != 0) s = 0; b += s; word >>= s;
> +	s = 16; if (word << 48 != 0) s = 0; b += s; word >>= s;
> +	s =  8; if (word << 56 != 0) s = 0; b += s; word >>= s;
> +	s =  4; if (word << 60 != 0) s = 0; b += s; word >>= s;
> +	s =  2; if (word << 62 != 0) s = 0; b += s; word >>= s;
> +	s =  1; if (word << 63 != 0) s = 0; b += s;
> +
> +	return b;
> +#else
> +#error BITS_PER_LONG not defined
> +#endif

This code generates more expensive shifts than our (ARMs) existing C
version.  This is a backward step.

Basically, shifts which depend on a variable are more expensive than
constant-based shifts.

I've not really looked at the rest because I haven't figured out which
bits will be used on ARM and which won't - which I think is another
problem with this patch set.  I'll look again later tonight.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
