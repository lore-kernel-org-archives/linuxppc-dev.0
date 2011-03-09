Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D5E09B6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 15:40:22 +1100 (EST)
Message-ID: <62749.94.211.195.167.1299645589.squirrel@gate.crashing.org>
In-Reply-To: <AANLkTikAnb39XhR0hdZAzTKGJ-P1rH+ZxtD+Dea7-364@mail.gmail.com>
References: <4D6E8932.1010405@zytor.com>
	<alpine.LFD.2.00.1103022152420.2701@localhost6.localdomain6>
	<4D6EB07C.5040004@zytor.com>
	<alpine.LFD.2.00.1103022216180.2701@localhost6.localdomain6>
	<4D6ECBDB.6090307@zytor.com> <20110303083035.GB14854@elte.hu>
	<AANLkTik4aTN8+Ob_GVwF17v6pDNGg2DEZJubBazs2e3L@mail.gmail.com>
	<1299619716.22236.32.camel@pasglop>
	<AANLkTikAnb39XhR0hdZAzTKGJ-P1rH+ZxtD+Dea7-364@mail.gmail.com>
Date: Wed, 9 Mar 2011 05:39:49 +0100 (CET)
Subject: Re: RFC: x86: kill binutils 2.16.x?
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Kyle Moffett" <kyle@moffetthome.net>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kbuild <linux-kbuild@vger.kernel.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kyle Moffett <kyle.d.moffett@boeing.com>,
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

> The problem is not with the kernel compile itself, but with the 2.12
> "dssall" binutils test.  Basically, recent binutils treats e500 as
> effectively a separate architecture that happens to share *most* of
> the opcodes with regular PowerPC.  Any opcode which is not understood
> by the e500 chip is either convert to an equivalent opcode which is
> understood (IE: lwsync => sync), or failed with an error.  This means
> that the kernel compile aborts early telling me to upgrade to a newer
> version of binutils.

$ echo dssall | powerpc-linux-as -many -me500
$ powerpc-linux-objdump -d a.out | grep 0:
   0:   7e 00 06 6c     dssall
$ powerpc-linux-as --version | head -1
GNU assembler (GNU Binutils) 2.21.51.20110309


What version of binutils does not work?  (I also checked with
-me500x2, -me500mc, -mspe, and various combinations.  lwsync
is indeed converted to a regular sync (well, "msync") for e500
and e500x2).


Segher
