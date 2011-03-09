Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A355D1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 18:55:26 +1100 (EST)
Date: Wed, 9 Mar 2011 08:27:48 +0100
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: powerpc/e500: binutils tests [Was: RFC: x86: kill binutils
	2.16.x?]
Message-ID: <20110309072748.GA4773@Chamillionaire.breakpoint.cc>
References: <AANLkTi=PXwh7ZCT1hW=OgBSH_U5CXaDt7yj+dSjfstJU@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <AANLkTi=PXwh7ZCT1hW=OgBSH_U5CXaDt7yj+dSjfstJU@mail.gmail.com>
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

* Kyle Moffett | 2011-03-09 00:22:11 [-0500]:

>On Tue, Mar 8, 2011 at 23:39, Segher Boessenkool
><segher@kernel.crashing.org> wrote:
>>> The problem is not with the kernel compile itself, but with the 2.12
>>> "dssall" binutils test. ??Basically, recent binutils treats e500 as
>>> effectively a separate architecture that happens to share *most* of
>>> the opcodes with regular PowerPC. ??Any opcode which is not understood
>>> by the e500 chip is either convert to an equivalent opcode which is
>>> understood (IE: lwsync => sync), or failed with an error. ??This means
>>> that the kernel compile aborts early telling me to upgrade to a newer
>>> version of binutils.
>>
>> $ echo dssall | powerpc-linux-as -many -me500
>> $ powerpc-linux-objdump -d a.out | grep 0:
>> ?? 0: ?? 7e 00 06 6c ?? ?? dssall
>> $ powerpc-linux-as --version | head -1
>> GNU assembler (GNU Binutils) 2.21.51.20110309
>>
>> What version of binutils does not work? ??(I also checked with
>> -me500x2, -me500mc, -mspe, and various combinations. ??lwsync
>> is indeed converted to a regular sync (well, "msync") for e500
>> and e500x2).
>
>Hmm, something's fishy here.

Did I break anything?
Not sure if mc and x2 are the same thing. One of those e500 thingy has a
the "classic FPU" if I remember correctly.
Anyway, -me500 enables a certain range of opcodes -many enables all of
them (or the remaining few). So without -many this test will fail. The
auto conversion of lwsync => sync or msync should be performed due to
-me500.

>Just going based on this changeset, the floating point and AltiVec
>opcodes are *supposed* to generate hard errors:
>  http://sourceware.org/ml/binutils-cvs/2010-06/msg00070.html
>
>Oh... that patch only disables the opcodes if "-many" is not specified.

To some degree yes. If you specify -me500 -maltivec you can still use
AltiVec opcodes because you enabled them. So for that reason there are
scripts on buildds to prevent passing mcpu to gcc among other things :)

>Cheers,
>Kyle Moffett

Sebastian
