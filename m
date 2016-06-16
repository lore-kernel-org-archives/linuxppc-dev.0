Return-Path: <adhemerval.zanella@linaro.org>
Received: from mail-yw0-x233.google.com (mail-yw0-x233.google.com
 [IPv6:2607:f8b0:4002:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVp0v6B42zDqpd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 01:57:03 +1000 (AEST)
Received: by mail-yw0-x233.google.com with SMTP id g20so46983678ywb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 08:57:03 -0700 (PDT)
Subject: Re: possible bug in powerpc LE compat syscalls with 64-bit args
To: Chris Metcalf <cmetcalf@mellanox.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Mike Frysinger <vapier@gentoo.org>
References: <28c367c1-0f60-cd1d-b443-d3876798a627@mellanox.com>
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Message-ID: <5762CC49.6090400@linaro.org>
Date: Thu, 16 Jun 2016 12:56:57 -0300
MIME-Version: 1.0
In-Reply-To: <28c367c1-0f60-cd1d-b443-d3876798a627@mellanox.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/06/2016 12:36, Chris Metcalf wrote:
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
> 
> Here's the email thread from libc-alpha:
> 
> https://sourceware.org/ml/libc-alpha/2016-06/msg00638.html
> 

I am not fully familiar with kernel policy regarding ABI so is this considered
an ABI breakage or a real defect?
