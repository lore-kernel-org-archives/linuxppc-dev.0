Return-Path: <cmetcalf@mellanox.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0040.outbound.protection.outlook.com [104.47.2.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVqf10HHDzDqpZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 03:10:47 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>, Adhemerval Zanella
 <adhemerval.zanella@linaro.org>, Mike Frysinger <vapier@gentoo.org>
From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: possible bug in powerpc LE compat syscalls with 64-bit args
Message-ID: <28c367c1-0f60-cd1d-b443-d3876798a627@mellanox.com>
Date: Thu, 16 Jun 2016 11:36:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adhemerval Zanella is cleaning up the preadv/pwritev implementation in glibc
and came across an issue with the tilepro/tilegx32 implementation of argument
passing for 64-bit arguments in split register pairs.

The glibc code base uses __LONG_LONG_PAIR to split 64-bit arguments,
passing "hi, lo" for BE systems and "lo, hi" for LE systems.  Tile is almost uniformly
LE, but we do support BE for specific customers.  The 32-bit compat mode on
tilegx was getting passed "hi, lo" arguments by glibc but looking for them to
be "lo, hi" arguments on the kernel side.  I fixed this here:

https://lkml.kernel.org/g/1466019219-10462-1-git-send-email-cmetcalf@mellanox.com

Reviewing what other platforms do, it seems like powerpc compat mode may
have the opposite problem in little-endian mode, since arguments are passed
in "hi, lo" order unconditionally in arch/powerpc/kernel/sys_ppc32.c.  You may
want to adopt the solution in the patch cited above, or similar solutions
elsewhere, eg regs_to_64 in arch/arm64/include/asm/assembler.h, or
merge_64 in arch/mips/kernel/linux32.c.

Here's the email thread from libc-alpha:

https://sourceware.org/ml/libc-alpha/2016-06/msg00638.html

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
