Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXKsn6nmdzDvHh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 20:56:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC][PATCH] powerpc/oops: Provide disassembly on OOPS
In-Reply-To: <a04c2ba0-88f7-17af-8c2f-8fda8569ec13@gmail.com>
References: <a04c2ba0-88f7-17af-8c2f-8fda8569ec13@gmail.com>
Date: Mon, 05 Dec 2016 20:56:41 +1100
Message-ID: <877f7e66na.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> This patch is tied to xmon, it can be refactored out
> better later if required. The idea is to provide
> disassembly using xmon so that when we get an OOPS
> we see something like the following below
>
> ...
> NIP [c00000000063a230] lkdtm_WARNING+0x0/0x10
> LR [c00000000063986c] lkdtm_do_action+0x3c/0x80
> Call Trace:
> [c0000000ef1bbbc0] [c0000000009a5804] printk+0x50/0x64 (unreliable)
> [c0000000ef1bbbe0] [c000000000639cc0] direct_entry+0x100/0x1b0
> [c0000000ef1bbc70] [c00000000043eb4c] full_proxy_write+0x8c/0x100
> [c0000000ef1bbcd0] [c00000000028fe24] __vfs_write+0x54/0x1c0
> [c0000000ef1bbd80] [c000000000291138] vfs_write+0xc8/0x260
> [c0000000ef1bbdd0] [c000000000292c98] SyS_write+0x78/0x120
> [c0000000ef1bbe30] [c00000000000b220] system_call+0x38/0xfc
> Instruction dump:
> c00000000063a200  38630618      addi    r3,r3,1560
> c00000000063a204  f8010010      std     r0,16(r1)
> c00000000063a208  f821ffa1      stdu    r1,-96(r1)
> c00000000063a20c  4836b0f1      bl      c0000000009a52fc# panic+0x8/0x304
> c00000000063a210  60000000      nop
> c00000000063a214  60000000      nop
> c00000000063a218  60000000      nop
> c00000000063a21c  60420000      ori     r2,r2,0
> c00000000063a220  0fe00000      twi     31,r0,0
> c00000000063a224  60000000      nop
> c00000000063a228  60000000      nop
> c00000000063a22c  60420000      ori     r2,r2,0
> c00000000063a230  0fe00000      twi     31,r0,0
>                   ^^^^^^^^

> NOTE: That the <> around the instruction that caused the
> OOPS is now replaced with a ^^^^ following the disassembly
> in the output.

I think I'd prefer:
  c00000000063a22c  60420000      ori     r2,r2,0
  c00000000063a230  0fe00000      twi     31,r0,0	# <- nip
  c00000000063a234  4e800020      blr

Or maybe:
  c00000000063a22c  60420000      ori     r2,r2,0
  c00000000063a230  0fe00000      twi     31,r0,0	# Faulting instruction
  c00000000063a234  4e800020      blr

?

> An issue was raised if as to whether calling
> xmon during OOPS can cause further issues? xmon has been used
> robustly in the past to look at OOPS and disassemble them
> and moreover the OOPS output is at the end, so we've already
> captured the GPR's and stack trace already.

Once it's refactored properly you won't be calling xmon at all, you'll
just be calling the disassembly code.

The problem we have is that currently print_insn_powerpc() is built
using nonstdio.h, which means it is calling xmon_printf(), and that's
not what we want to do for an oops. An oops is printed using printk. So
that will need more work.

> NOTE2: If CONFIG_XMON_DISASSEMBLY is turned off, the disassembly
> will be printed as a list of .long(s). It is highly recommended
> to have both CONFIG_XMON_DISASSEMBLY and CONFIG_XMON for usable
> output.

So once it's refactored CONFIG_XMON_DISASSEMBLY would become
CONFIG_PPC_DISASSEMBLY (or something like that), and there'd be no
dependency on CONFIG_XMON.

And so there'd be no fallback to printing longs, you'd either print the
old compact format, or the disassembled format.

cheers
