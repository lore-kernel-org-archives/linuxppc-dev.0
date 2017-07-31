Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLV3K4b1zzDrJh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 16:31:41 +1000 (AEST)
In-Reply-To: <1501075144-20582-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/boot: Fix 64-bit boot wrapper build with non-biarch
 compiler
Message-Id: <3xLV3K04sNz9tWH@ozlabs.org>
Date: Mon, 31 Jul 2017 16:31:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-26 at 13:19:04 UTC, Michael Ellerman wrote:
> Historically the boot wrapper was always built 32-bit big endian, even
> for 64-bit kernels. That was because old firmwares didn't necessarily
> support booting a 64-bit image. Because of that arch/powerpc/boot/Makefile
> uses CROSS32CC for compilation.
> 
> However when we added 64-bit little endian support, we also added
> support for building the boot wrapper 64-bit. However we kept using
> CROSS32CC, because in most cases it is just CC and everything works.
> 
> However if the user doesn't specify CROSS32_COMPILE (which no one ever
> does AFAIK), and CC is *not* biarch (32/64-bit capable), then CROSS32CC
> becomes just "gcc". On native systems that is probably OK, but if we're
> cross building it definitely isn't, leading to eg:
> 
>   gcc ... -m64 -mlittle-endian -mabi=elfv2 ... arch/powerpc/boot/cpm-serial.c
>   gcc: error: unrecognized argument in option ‘-mabi=elfv2’
>   gcc: error: unrecognized command line option ‘-mlittle-endian’
>   make: *** [zImage] Error 2
> 
> To fix it, stop using CROSS32CC, because we may or may not be building
> 32-bit. Instead setup a BOOTCC, which defaults to CC, and only use
> CROSS32_COMPILE if it's set and we're building for 32-bit.
> 
> Fixes: 147c05168fc8 ("powerpc/boot: Add support for 64bit little endian wrapper")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/65c5ec11c25eff6ba6e9b1cbfff014

cheers
