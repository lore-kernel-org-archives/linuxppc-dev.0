Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF1F81A0D2B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:28:48 +1100 (AEDT)
Message-ID: <1427261327.29319.5.camel@ellerman.id.au>
Subject: Re: [PATCH v3 2/2] selftests/powerpc: Add a test of the
 switch_endian() syscall
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 25 Mar 2015 16:28:47 +1100
In-Reply-To: <1426655059.6504.4.camel@ellerman.id.au>
References: <1426489030-26025-1-git-send-email-mpe@ellerman.id.au>
 <1426489030-26025-2-git-send-email-mpe@ellerman.id.au>
 <5506B7DC.80702@linux.vnet.ibm.com>
 <1426547040.31646.2.camel@ellerman.id.au>
 <5507C437.3020203@linux.vnet.ibm.com>
 <1426655059.6504.4.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxram@us.ibm.com, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-03-18 at 16:04 +1100, Michael Ellerman wrote:
> On Tue, 2015-03-17 at 11:35 +0530, Anshuman Khandual wrote:
> > On 03/17/2015 04:34 AM, Michael Ellerman wrote:
> > > What are you seeing exactly?
> > 
> > I am running on a BE PKVM guest but compiling the test case on
> > a different BE machine which has newer version of the compiler.
> > 
> > cc (GCC) 4.8.3 20140624
> > 
> > cc -O2 -Wall -g -nostdlib -m64   -c -o check.o check.S
> > objcopy -j .text --reverse-bytes=4 -O binary check.o check-reversed.o
> > hexdump -v -e '/1 ".byte 0x%02X\n"' check-reversed.o > check-reversed.S
> > cc -O2 -Wall -g -nostdlib -m64    switch_endian_test.S check-reversed.S   -o switch_endian_test
> > 
> > which looks very similar to the details you have provided above.
> > Running on guest or host should not make any difference.
> 
> No it shouldn't.
> 
> Can you try strace, that should give you the full result code.
> 
> Also can you try gdb. You can't breakpoint in the wrong-endian region, but it
> looks like you're getting through that anyway.
> 
> So try setting a breakpoint at line ~77, and you should be back in BE. Then you
> can single step and see where it errors out.

Did you try these?

I want to merge this, and it works for me, but I'd be interested if you can
track down why it's failing for you.

cheers
