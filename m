Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 252B01A020A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 10:04:01 +1100 (AEDT)
Message-ID: <1426547040.31646.2.camel@ellerman.id.au>
Subject: Re: [PATCH v3 2/2] selftests/powerpc: Add a test of the
 switch_endian() syscall
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 17 Mar 2015 10:04:00 +1100
In-Reply-To: <5506B7DC.80702@linux.vnet.ibm.com>
References: <1426489030-26025-1-git-send-email-mpe@ellerman.id.au>
 <1426489030-26025-2-git-send-email-mpe@ellerman.id.au>
 <5506B7DC.80702@linux.vnet.ibm.com>
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

On Mon, 2015-03-16 at 16:30 +0530, Anshuman Khandual wrote:
> On 03/16/2015 12:27 PM, Michael Ellerman wrote:
> > This adds a test of the switch_endian() syscall we added in the previous
> > commit.
> > 
> > We test it by calling the endian switch syscall, and then executing some
> > code in the other endian to check everything went as expected. That code
> > checks registers we expect to be maintained are, and then writes to
> > stdout. If the endian switch failed to happen that code sequence will be
> > illegal and cause the test to abort.
> > 
> > We then switch back to the original endian, do the same checks and
> > finally write a success message and exit(0).
> > 
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Hey Michael,
> 
> Did a quick test, passes on LE but seems like failing on BE.
> 
> On LE:
> 
> Hello wrong-endian world
> Hello right-endian world
> success: switch_endian_test
> 
> on BE:
> 
> Hello wrong-endian world (returns 176)
> 
> The previous version of the test was passing both on LE
> and BE (after applying the compiler trick in the assembly)

Hmm, odd. Works for me:

$ uname -a
Linux bebuntu 4.0.0-rc3-00002-g9dd2601a490a #1 SMP Fri Mar 13 15:52:11 AEDT 2015 ppc64 ppc64 ppc64 GNU/Linux
$ make
cc -O2 -Wall -g -nostdlib -m64   -c -o check.o check.S
objcopy -j .text --reverse-bytes=4 -O binary check.o check-reversed.o
hexdump -v -e '/1 ".byte 0x%02X\n"' check-reversed.o > check-reversed.S
cc -O2 -Wall -g -nostdlib -m64    switch_endian_test.S check-reversed.S   -o switch_endian_test
$ ./switch_endian_test 
Hello wrong-endian world
Hello right-endian world
success: switch_endian_test


What are you seeing exactly?

cheers
