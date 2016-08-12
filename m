Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9nNZ3x11zDr1m
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Aug 2016 00:30:22 +1000 (AEST)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s9nNY6wMlz9sxR
 for <linuxppc-dev@ozlabs.org>; Sat, 13 Aug 2016 00:30:21 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id i6so1637772pfe.0
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Aug 2016 07:30:21 -0700 (PDT)
Date: Sat, 13 Aug 2016 00:30:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org, Alan Modra <amodra@gmail.com>
Subject: Re: [RFC PATCH] powerpc/Makefile: Add option to build with gold
Message-ID: <20160813003009.6ff8eea5@roar.ozlabs.ibm.com>
In-Reply-To: <1471001421-9845-1-git-send-email-mpe@ellerman.id.au>
References: <1471001421-9845-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 12 Aug 2016 21:30:21 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> This adds a Kconfig option which can be turned on to enable use of the
> gold linker. It depends on DEBUG_KERNEL to hopefully hide it from users
> who don't really care about it, and also !COMPILE_TEST so that it will
> be turned off for allyes/modconfig builds.
> 
> In the wrapper script we currently always use ${CROSS}ld, so instead
> make that the default if ${LD} isn't already set. When we're called as
> part of a normal build ${LD} will be set, but if the wrapper is called
> separately we will fall back to ${CROSS}ld as before.
> 
> With this enabled I have successfully built a ppc64[le]_defconfig using
> a toolchain which only has ld.gold.

Nice. Out of curiosity, I ran some testing.

On allyesconfig with sfr's thin archives patch and --gc-sections,
ld.gold is about 10% faster than ld.bfd. About 11 seconds vs 12. A lot
of that is in utf8 conversions from "fnmatch" it's using to match
section names though. Setting LANG=C brings it down to 8 seconds and
helps ld.bfd a tiny bit but not much. So that's a pretty good win.
Threading still has some crashes.

ld.gold creates a larger executable though. It seems to be creating a
lot more branch stubs (19000 vs 6500 for ld.bfd). 

I should keep in mind we link the kernel about 4 times every build
before complain too much about linker performance to the binutils guys.
I wonder if we couldn't objcopy the kallsyms onto the end of the image
to avoid that relinking.
