Return-Path: <kyle@moffetthome.net>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A3F35B6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 06:57:54 +1100 (EST)
Received: by eyg5 with SMTP id 5so1996933eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 08 Mar 2011 11:57:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110303083035.GB14854@elte.hu>
References: <4D6E8932.1010405@zytor.com>
	<alpine.LFD.2.00.1103022152420.2701@localhost6.localdomain6>
	<4D6EB07C.5040004@zytor.com>
	<alpine.LFD.2.00.1103022216180.2701@localhost6.localdomain6>
	<4D6ECBDB.6090307@zytor.com> <20110303083035.GB14854@elte.hu>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Tue, 8 Mar 2011 14:57:29 -0500
Message-ID: <AANLkTik4aTN8+Ob_GVwF17v6pDNGg2DEZJubBazs2e3L@mail.gmail.com>
Subject: Re: RFC: x86: kill binutils 2.16.x?
To: Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain; charset=UTF-8
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kyle Moffett <Kyle.D.Moffett@boeing.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 3, 2011 at 03:30, Ingo Molnar <mingo@elte.hu> wrote:
> This is how specific GAS functionality is tested in arch/powerpc:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0@if ! /bin/echo dssall | $(AS) -many -o $(TOUT=
) >/dev/null 2>&1 ; then \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo -n '*** ${VER=
SION}.${PATCHLEVEL} kernels no longer build ' ; \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo 'correctly wi=
th old versions of binutils.' ; \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo '*** Please u=
pgrade your binutils to 2.12.1 or newer' ; \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0false ; \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> This would also be a 'constructive' (and safest) way of blacklisting binu=
tils: we'd
> really only exclude binutils that is truly buggy.

Hrm... well... actually...

It's funny that you brought up this particular case.  While I agree
that it's good in general, it's causing problems for me building a
kernel using a recent e500 gcc/binutils (triplet
"powerpc-linux-gnuspe").

Specifically the e500 doesn't have a normal PowerPC FPU, it has a
custom FPU built using extended integer registers instead, and it
happens to borrow the AltiVec opcode range to do it.

When trying to port Debian to the platform we were getting SIGILL's
all over the place until binutils got updated to reject all of the
unsupported opcodes on this particular platform.  Now of course we get
build errors, but that's a lot easier to debug and fix. :-D

Basically, binutils no longer supports "-many" (because too many
opcodes conflict), and the test itself would fail anyways (because
"dssall" is not valid on "any" PowerPC).

So while I think that it is entirely reasonable to add a similar test
for buggy x86 binutils, I'm actually about to send a patch to remove
that particular check from the powerpc Makefile.  Since the "required"
binutils 2.12.1 was released in May 2002 (almost 9 years ago) it's
probably not even worth testing for anymore.

Cheers,
Kyle Moffett
