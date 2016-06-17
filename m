Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW3DF7598zDql7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 11:52:45 +1000 (AEST)
Message-ID: <1466128365.12899.9.camel@ellerman.id.au>
Subject: Re: possible bug in powerpc LE compat syscalls with 64-bit args
From: Michael Ellerman <mpe@ellerman.id.au>
To: Chris Metcalf <cmetcalf@mellanox.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Adhemerval Zanella
 <adhemerval.zanella@linaro.org>,  Mike Frysinger <vapier@gentoo.org>
Date: Fri, 17 Jun 2016 11:52:45 +1000
In-Reply-To: <28c367c1-0f60-cd1d-b443-d3876798a627@mellanox.com>
References: <28c367c1-0f60-cd1d-b443-d3876798a627@mellanox.com>
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

On Thu, 2016-06-16 at 11:36 -0400, Chris Metcalf wrote:

> Adhemerval Zanella is cleaning up the preadv/pwritev implementation in glibc
> and came across an issue with the tilepro/tilegx32 implementation of argument
> passing for 64-bit arguments in split register pairs.
> 
> The glibc code base uses __LONG_LONG_PAIR to split 64-bit arguments,
> passing "hi, lo" for BE systems and "lo, hi" for LE systems.  Tile is almost uniformly
> LE, but we do support BE for specific customers.  The 32-bit compat mode on
> tilegx was getting passed "hi, lo" arguments by glibc but looking for them to
> be "lo, hi" arguments on the kernel side.  I fixed this here:
> 
> https://lkml.kernel.org/g/1466019219-10462-1-git-send-email-cmetcalf@mellanox.com
> 
> Reviewing what other platforms do, it seems like powerpc compat mode may
> have the opposite problem in little-endian mode, since arguments are passed
> in "hi, lo" order unconditionally in arch/powerpc/kernel/sys_ppc32.c.  You may
> want to adopt the solution in the patch cited above, or similar solutions
> elsewhere, eg regs_to_64 in arch/arm64/include/asm/assembler.h, or
> merge_64 in arch/mips/kernel/linux32.c.

We don't support compat mode on ppc64le. So I think we're OK?

Thanks for letting us know.

cheers
