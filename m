Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41MvYw4V4gzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2018 11:45:40 +1000 (AEST)
Message-ID: <a3c9b9ee9ec116390c47dca65fcf14f138eccd3f.camel@kernel.crashing.org>
Subject: Re: powerpc: 32BIT vs. 64BIT (PPC32 vs. PPC64)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kbuild
 <linux-kbuild@vger.kernel.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org
Date: Sat, 07 Jul 2018 11:45:03 +1000
In-Reply-To: <3f906b03-98ff-c081-4e19-b490f0b35c51@infradead.org>
References: <3f906b03-98ff-c081-4e19-b490f0b35c51@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-07-05 at 14:30 -0700, Randy Dunlap wrote:
> Hi,
> 
> Is there a good way (or a shortcut) to do something like:
> 
> $ make ARCH=powerpc O=PPC32 [other_options] allmodconfig
>   to get a PPC32/32BIT allmodconfig
> 
> and also be able to do:
> 
> $make ARCH=powerpc O=PPC64 [other_options] allmodconfig
>   to get a PPC64/64BIT allmodconfig?

Hrm... O= is for the separate build dir, so there much be something
else.

You mean having ARCH= aliases like ppc/ppc32 and ppc64 ?

That would be a matter of overriding some .config defaults I suppose, I
don't know how this is done on other archs.

I see the aliasing trick in the Makefile but that's about it.

> Note that arch/x86, arch/sh, and arch/sparc have ways to do
> some flavor(s) of this (from Documentation/kbuild/kbuild.txt;
> sh and sparc based on a recent "fix" patch from me):

I fail to see what you are actually talking about here ... sorry. Do
you have concrete examples on x86 or sparc ? From what I can tell the
"i386" or "sparc32/sparc64" aliases just change SRCARCH in Makefile and
32 vs 64-bit is just a Kconfig option...

> x86: i386 for 32 bit, x86_64 for 64 bit
> sh: sh for 32 bit, sh64 for 64 bit
> sparc: sparc32 for 32 bit, sparc64 for 64 bit
