Return-Path: <kyle@moffetthome.net>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 28C2BB70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 16:28:00 +1100 (EST)
Received: by ewy28 with SMTP id 28so44047ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 08 Mar 2011 21:27:55 -0800 (PST)
MIME-Version: 1.0
From: Kyle Moffett <kyle@moffetthome.net>
Date: Wed, 9 Mar 2011 00:22:11 -0500
Message-ID: <AANLkTi=PXwh7ZCT1hW=OgBSH_U5CXaDt7yj+dSjfstJU@mail.gmail.com>
Subject: powerpc/e500: binutils tests [Was: RFC: x86: kill binutils 2.16.x?]
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kbuild <linux-kbuild@vger.kernel.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	sebastian@breakpoint.cc, Kyle Moffett <kyle.d.moffett@boeing.com>,
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

On Tue, Mar 8, 2011 at 23:39, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>> The problem is not with the kernel compile itself, but with the 2.12
>> "dssall" binutils test. =C2=A0Basically, recent binutils treats e500 as
>> effectively a separate architecture that happens to share *most* of
>> the opcodes with regular PowerPC. =C2=A0Any opcode which is not understo=
od
>> by the e500 chip is either convert to an equivalent opcode which is
>> understood (IE: lwsync =3D> sync), or failed with an error. =C2=A0This m=
eans
>> that the kernel compile aborts early telling me to upgrade to a newer
>> version of binutils.
>
> $ echo dssall | powerpc-linux-as -many -me500
> $ powerpc-linux-objdump -d a.out | grep 0:
> =C2=A0 0: =C2=A0 7e 00 06 6c =C2=A0 =C2=A0 dssall
> $ powerpc-linux-as --version | head -1
> GNU assembler (GNU Binutils) 2.21.51.20110309
>
> What version of binutils does not work? =C2=A0(I also checked with
> -me500x2, -me500mc, -mspe, and various combinations. =C2=A0lwsync
> is indeed converted to a regular sync (well, "msync") for e500
> and e500x2).

Hmm, something's fishy here.

Just going based on this changeset, the floating point and AltiVec
opcodes are *supposed* to generate hard errors:
  http://sourceware.org/ml/binutils-cvs/2010-06/msg00070.html

Oh... that patch only disables the opcodes if "-many" is not specified.

Aha! The native compiler on my Debian e500 boxes right now is hidden
behind a small wrapper script which removes "-many" and "-Wa,-many"
and generates errors for anything else that isn't "-me500".  My GCC
also excludes the "-many" option when calling the linker directly.

So I think this is only a "local" problem right now, actually, sorry
for the noise and confusion.  If I log into that system and run "echo
dssall | as", I get the expected hard error, and due to the wrapper
scripts in place I get the same error from "echo dssall | as -me500x2
-many"

Unfortunately I still need to have the assembler generate hard errors
when someone tries to natively compile code with AltiVec or
classic-FPU instructions, otherwise I have no way of detecting
unported software at build-time.

Would a patch to make the Altivec "dssall" test conditional on
CONFIG_ALTIVEC be acceptable?  That really is the only test that
causes the kernel compile to fail with the strict wrappers.

Cheers,
Kyle Moffett
