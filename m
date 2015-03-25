Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DBD841A1778
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 22:33:13 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AACCF1400F1
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2015 22:33:13 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 25 Mar 2015 21:33:11 +1000
Message-ID: <55129CBA.4010402@linux.vnet.ibm.com>
Date: Wed, 25 Mar 2015 17:02:10 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 2/2] selftests/powerpc: Add a test of the
 switch_endian() syscall
References: <1426489030-26025-1-git-send-email-mpe@ellerman.id.au>
 <1426489030-26025-2-git-send-email-mpe@ellerman.id.au>
 <5506B7DC.80702@linux.vnet.ibm.com> <1426547040.31646.2.camel@ellerman.id.au>
 <5507C437.3020203@linux.vnet.ibm.com>
 <1426655059.6504.4.camel@ellerman.id.au>
 <1427261327.29319.5.camel@ellerman.id.au>
In-Reply-To: <1427261327.29319.5.camel@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, linuxram@us.ibm.com, Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/25/2015 10:58 AM, Michael Ellerman wrote:
> On Wed, 2015-03-18 at 16:04 +1100, Michael Ellerman wrote:
>> On Tue, 2015-03-17 at 11:35 +0530, Anshuman Khandual wrote:
>>> On 03/17/2015 04:34 AM, Michael Ellerman wrote:
>>>> What are you seeing exactly?
>>>
>>> I am running on a BE PKVM guest but compiling the test case on
>>> a different BE machine which has newer version of the compiler.
>>>
>>> cc (GCC) 4.8.3 20140624
>>>
>>> cc -O2 -Wall -g -nostdlib -m64   -c -o check.o check.S
>>> objcopy -j .text --reverse-bytes=4 -O binary check.o check-reversed.o
>>> hexdump -v -e '/1 ".byte 0x%02X\n"' check-reversed.o > check-reversed.S
>>> cc -O2 -Wall -g -nostdlib -m64    switch_endian_test.S check-reversed.S   -o switch_endian_test
>>>
>>> which looks very similar to the details you have provided above.
>>> Running on guest or host should not make any difference.
>>
>> No it shouldn't.
>>
>> Can you try strace, that should give you the full result code.
>>
>> Also can you try gdb. You can't breakpoint in the wrong-endian region, but it
>> looks like you're getting through that anyway.
>>
>> So try setting a breakpoint at line ~77, and you should be back in BE. Then you
>> can single step and see where it errors out.
> 
> Did you try these?

Yeah. The test program is showing some strange behavior.

(1) Without strace: It just fails with 176 return code as before
(2) With strace: It works with return code 0 and prints everything !!

strace ./switch_endian_test
execve("./switch_endian_test", ["./switch_endian_test"], [/* 50 vars */]) = 0
SYS_363(0x5555aaaa5555aaaa, 0x5555aaaa5555aaae, 0x5555aaaa5555aaaf,
0x5555aaaa5555aab0, 0x5555aaaa5555aab1) = 6149008514797120170
write(1, "Hello wrong-endian world\n", 25Hello wrong-endian world
) = 25
SYS_363(0x19, 0x10010638, 0x19, 0x5555aaaa5555aab0, 0x5555aaaa5555aab1) = 25
write(1, "Hello right-endian world\n", 25Hello right-endian world
) = 25
write(1, "success: switch_endian_test\n", 28success: switch_endian_test
) = 28
exit(0)                                 = ?

With GDB and breaking at line 77, it exits with a different exit code this time

30		cmpd    r3,r5
(gdb) 
31		bne     1f
(gdb) 
32		addi    r3,r15,6
(gdb) 
33		cmpd    r3,r6
(gdb) 
34		bne     1f
(gdb) 
98	1:	li	r0, __NR_exit
(gdb) 
99		sc
(gdb) 
[Inferior 1 (process 6456) exited with code 0260]

Also (this might sound bit strange), after multiple attempts of GDB, the program
did ran successfully with exit code of 0. Also it ran successfully without GDB
as well. But again after a fresh reboot, the problem was recreated again.

Will look into this further.
