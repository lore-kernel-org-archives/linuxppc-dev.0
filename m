Return-Path: <kyle@moffetthome.net>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57AEEB70D0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 08:59:30 +1100 (EST)
Received: by eyg5 with SMTP id 5so2049015eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 08 Mar 2011 13:59:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1299619716.22236.32.camel@pasglop>
References: <4D6E8932.1010405@zytor.com>
	<alpine.LFD.2.00.1103022152420.2701@localhost6.localdomain6>
	<4D6EB07C.5040004@zytor.com>
	<alpine.LFD.2.00.1103022216180.2701@localhost6.localdomain6>
	<4D6ECBDB.6090307@zytor.com> <20110303083035.GB14854@elte.hu>
	<AANLkTik4aTN8+Ob_GVwF17v6pDNGg2DEZJubBazs2e3L@mail.gmail.com>
	<1299619716.22236.32.camel@pasglop>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Tue, 8 Mar 2011 16:59:05 -0500
Message-ID: <AANLkTikAnb39XhR0hdZAzTKGJ-P1rH+ZxtD+Dea7-364@mail.gmail.com>
Subject: Re: RFC: x86: kill binutils 2.16.x?
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
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

On Tue, Mar 8, 2011 at 16:28, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2011-03-08 at 14:57 -0500, Kyle Moffett wrote:
>> Specifically the e500 doesn't have a normal PowerPC FPU, it has a
>> custom FPU built using extended integer registers instead, and it
>> happens to borrow the AltiVec opcode range to do it.
>>
>> When trying to port Debian to the platform we were getting SIGILL's
>> all over the place until binutils got updated to reject all of the
>> unsupported opcodes on this particular platform. =C2=A0Now of course we =
get
>> build errors, but that's a lot easier to debug and fix. :-D
>>
>> Basically, binutils no longer supports "-many" (because too many
>> opcodes conflict), and the test itself would fail anyways (because
>> "dssall" is not valid on "any" PowerPC).
>
> Note that this freescale "SPE" fiasco is just that ... a fiasco :-) I
> don't think there's that many cases of opcode overlap outside of it.

I absolutely agree on the "fiasco" part, although I'm pretty sure that
there's a large number of incompatible ARM variants (even 16-bit vs.
32-bit opcodes).  Unfortunately there's a lot of shipped hardware to
be supported and maintained...


> Now regarding the kernel, the best is probably for nasty cases like that
> to use hand coded opcodes (see ppc-opcodes.h) and stick to a more
> "generic" setting for binutils, since it should be possible to build
> kernels that support multiple types of BookE CPUs with different
> floating point units.

The problem is not with the kernel compile itself, but with the 2.12
"dssall" binutils test.  Basically, recent binutils treats e500 as
effectively a separate architecture that happens to share *most* of
the opcodes with regular PowerPC.  Any opcode which is not understood
by the e500 chip is either convert to an equivalent opcode which is
understood (IE: lwsync =3D> sync), or failed with an error.  This means
that the kernel compile aborts early telling me to upgrade to a newer
version of binutils.

This was *critical* for getting an actual Debian distribution
bootstrapped on the e500 cores, because so much software assumes
PowerPC =3D=3D altivec (ffmpeg), hardcodes 'asm("lwsync")' for memory
barriers (80+ packages in Debian), or includes hand-coded
floating-point ASM instructions (libffi).  Noisy build errors are
better than silent runtime failures any day of the week.

At the very least that test needs to be turned off if
CONFIG_ALTIVEC=3Dn, because the kernel builds and runs fine otherwise.

Cheers,
Kyle Moffett
