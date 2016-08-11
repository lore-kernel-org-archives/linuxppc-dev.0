Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s957k2H2GzDr0m
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 21:16:50 +1000 (AEST)
In-Reply-To: <1470746626-1989-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>, Nick Piggin <npiggin@gmail.com>,
 imunsie@au.ibm.com
Subject: Re: powerpc/Makefile: Use cflags-y/aflags-y for setting endian options
Message-Id: <3s957k04rBz9sDf@ozlabs.org>
Date: Thu, 11 Aug 2016 21:16:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-08 at 12:43:46 UTC, Michael Ellerman wrote:
> When we introduced the little endian support, we added the endian flags
> to CC directly using override. I don't know the history of why we did
> that, I suspect no one does.
> 
> Although this mostly works, it has one bug, which is that CROSS32CC
> doesn't get -mbig-endian. That means when the compiler is little endian
> by default and the user is building big endian, vdso32 is incorrectly
> compiled as little endian and the kernel fails to build.
> 
> Instead we can add the endian flags to cflags-y/aflags-y, and then
> append those to KBUILD_CFLAGS/KBUILD_AFLAGS.
> 
> This has the advantage of being 1) less ugly, 2) the documented way of
> adding flags in the arch Makefile and 3) it fixes building vdso32 with a
> LE toolchain.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/164af597ce945751e2dcd53d0a

cheers
