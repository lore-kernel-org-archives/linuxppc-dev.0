Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 562ECB70EA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 10:14:14 +1100 (EST)
Subject: Re: RFC: x86: kill binutils 2.16.x?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <kyle@moffetthome.net>
In-Reply-To: <AANLkTikAnb39XhR0hdZAzTKGJ-P1rH+ZxtD+Dea7-364@mail.gmail.com>
References: <4D6E8932.1010405@zytor.com>
	<alpine.LFD.2.00.1103022152420.2701@localhost6.localdomain6>
	<4D6EB07C.5040004@zytor.com>
	<alpine.LFD.2.00.1103022216180.2701@localhost6.localdomain6>
	<4D6ECBDB.6090307@zytor.com> <20110303083035.GB14854@elte.hu>
	<AANLkTik4aTN8+Ob_GVwF17v6pDNGg2DEZJubBazs2e3L@mail.gmail.com>
	<1299619716.22236.32.camel@pasglop>
	<AANLkTikAnb39XhR0hdZAzTKGJ-P1rH+ZxtD+Dea7-364@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Mar 2011 10:13:28 +1100
Message-ID: <1299626008.22236.47.camel@pasglop>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kbuild <linux-kbuild@vger.kernel.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kyle Moffett <Kyle.D.Moffett@boeing.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-03-08 at 16:59 -0500, Kyle Moffett wrote:
> 
> The problem is not with the kernel compile itself, but with the 2.12
> "dssall" binutils test.  Basically, recent binutils treats e500 as
> effectively a separate architecture that happens to share *most* of
> the opcodes with regular PowerPC. 

This is bogus. Newer e500 don't have that SPE crap afaik and BookI and
II of the architecture have been converged. In fact, Scott, don't newer
FSL chips also support real lwsync ?

>  Any opcode which is not understood
> by the e500 chip is either convert to an equivalent opcode which is
> understood (IE: lwsync => sync), or failed with an error.  This means
> that the kernel compile aborts early telling me to upgrade to a newer
> version of binutils.

This is more bogosity in binutils. lwsync is designed to fallback as
sync if not supported in -HW-, binutils shouldn't silently swallow it.

Or is it that FSL failed on the original e500 and make lwsync actually
trap ?

> This was *critical* for getting an actual Debian distribution
> bootstrapped on the e500 cores, because so much software assumes
> PowerPC == altivec (ffmpeg), hardcodes 'asm("lwsync")' for memory
> barriers (80+ packages in Debian), or includes hand-coded
> floating-point ASM instructions (libffi).  Noisy build errors are
> better than silent runtime failures any day of the week.
> 
> At the very least that test needs to be turned off if
> CONFIG_ALTIVEC=n, because the kernel builds and runs fine otherwise.

I think the right thing is to keep that as e500-legacy or something,
because afaik, newer e500's don't have most of these issues and could be
treated as "normal" powerpc again.

Cheers,
Ben.
