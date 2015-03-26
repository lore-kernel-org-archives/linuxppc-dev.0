Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8EF981A0671
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 17:25:36 +1100 (AEDT)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5F46E1400B7
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 17:25:36 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 16:25:35 +1000
Message-ID: <5513A622.2040706@linux.vnet.ibm.com>
Date: Thu, 26 Mar 2015 11:54:34 +0530
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
 <55129CBA.4010402@linux.vnet.ibm.com>
 <1427330209.16501.1.camel@ellerman.id.au>
In-Reply-To: <1427330209.16501.1.camel@ellerman.id.au>
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

On 03/26/2015 06:06 AM, Michael Ellerman wrote:
> On Wed, 2015-03-25 at 17:02 +0530, Anshuman Khandual wrote:
>> On 03/25/2015 10:58 AM, Michael Ellerman wrote:
>>> On Wed, 2015-03-18 at 16:04 +1100, Michael Ellerman wrote:
>>>> On Tue, 2015-03-17 at 11:35 +0530, Anshuman Khandual wrote:
>>>>> On 03/17/2015 04:34 AM, Michael Ellerman wrote:
>>>>>> What are you seeing exactly?
>>>>>
>>>>> I am running on a BE PKVM guest but compiling the test case on
>>>>> a different BE machine which has newer version of the compiler.
>>>>>
>>>>> cc (GCC) 4.8.3 20140624
>>>>>
>>>>> cc -O2 -Wall -g -nostdlib -m64   -c -o check.o check.S
>>>>> objcopy -j .text --reverse-bytes=4 -O binary check.o check-reversed.o
>>>>> hexdump -v -e '/1 ".byte 0x%02X\n"' check-reversed.o > check-reversed.S
>>>>> cc -O2 -Wall -g -nostdlib -m64    switch_endian_test.S check-reversed.S   -o switch_endian_test
>>>>>
>>>>> which looks very similar to the details you have provided above.
>>>>> Running on guest or host should not make any difference.
>>>>
>>>> No it shouldn't.
>>>>
>>>> Can you try strace, that should give you the full result code.
>>>>
>>>> Also can you try gdb. You can't breakpoint in the wrong-endian region, but it
>>>> looks like you're getting through that anyway.
>>>>
>>>> So try setting a breakpoint at line ~77, and you should be back in BE. Then you
>>>> can single step and see where it errors out.
>>>
>>> Did you try these?
>>
>> Yeah. The test program is showing some strange behavior.
>>
>> (1) Without strace: It just fails with 176 return code as before
>> (2) With strace: It works with return code 0 and prints everything !!
>>
>> strace ./switch_endian_test
>> execve("./switch_endian_test", ["./switch_endian_test"], [/* 50 vars */]) = 0
>> SYS_363(0x5555aaaa5555aaaa, 0x5555aaaa5555aaae, 0x5555aaaa5555aaaf,
>> 0x5555aaaa5555aab0, 0x5555aaaa5555aab1) = 6149008514797120170
>> write(1, "Hello wrong-endian world\n", 25Hello wrong-endian world
>> ) = 25
>> SYS_363(0x19, 0x10010638, 0x19, 0x5555aaaa5555aab0, 0x5555aaaa5555aab1) = 25
>> write(1, "Hello right-endian world\n", 25Hello right-endian world
>> ) = 25
>> write(1, "success: switch_endian_test\n", 28success: switch_endian_test
>> ) = 28
>> exit(0)                                 = ?
>>
>> With GDB and breaking at line 77, it exits with a different exit code this time
> 
> No that's the same code, 176 == 0260 (octal).
> 
>> 30		cmpd    r3,r5
>> (gdb) 
>> 31		bne     1f
>> (gdb) 
>> 32		addi    r3,r15,6
>> (gdb) 
>> 33		cmpd    r3,r6
>> (gdb) 
>> 34		bne     1f
>> (gdb) 
>> 98	1:	li	r0, __NR_exit
>> (gdb) 
>> 99		sc
>> (gdb) 
>> [Inferior 1 (process 6456) exited with code 0260]
> 
> And that makes sense, it's bailing because r6 doesn't match. In the setup we do:
> 
> 	addi	r6, r15, 6
> 
> Where r15 is 0x5555aaaa5555aaaa, so:
> 
> 	0x5555aaaa5555aaaa + 6 = 0x5555aaaa5555aab0
> 
> And when we exit the kernel masks the exit code in r3 with 0xff, so:
> 
> 	0x5555aaaa5555aab0 & 0xff = 0xb0 = 176
> 
> 
> So for some reason r6 does not contain our pattern.
> 
> Can you do an "info registers" and see what's in r6?

Sure, here are the details.

(gdb)
98	1:	li	r0, __NR_exit
(gdb)
99		sc
(gdb) info registers
r0             0x1	1
r1             0x3ffffffff360	70368744174432
r2             0x10018670	268535408
r3             0x5555aaaa5555aab0	6149008514797120176
r4             0x5555aaaa5555aaca	6149008514797120202
r5             0x5555aaaa5555aaaf	6149008514797120175

r6             0x4000	16384   <<=========================

r7             0x100002e4	268436196
r8             0x800000010000d033	9223372041149796403
r9             0x0	0
r10            0x0	0
r11            0x0	0
r12            0x0	0
r13            0x5555aaaa5555aab7	6149008514797120183
r14            0x1001061a	268502554
r15            0x5555aaaa5555aaaa	6149008514797120170
r16            0x5555aaaa5555aaba	6149008514797120186
r17            0x5555aaaa5555aabb	6149008514797120187
r18            0x5555aaaa5555aabc	6149008514797120188
r19            0x5555aaaa5555aabd	6149008514797120189
r20            0x5555aaaa5555aabe	6149008514797120190
r21            0x5555aaaa5555aabf	6149008514797120191
r22            0x5555aaaa5555aac0	6149008514797120192
r23            0x5555aaaa5555aac1	6149008514797120193
r24            0x5555aaaa5555aac2	6149008514797120194
r25            0x5555aaaa5555aac3	6149008514797120195
r26            0x5555aaaa5555aac4	6149008514797120196
r27            0x5555aaaa5555aac5	6149008514797120197
r28            0x5555aaaa5555aac6	6149008514797120198
r29            0x5555aaaa5555aac7	6149008514797120199
r30            0x5555aaaa5555aac8	6149008514797120200
r31            0x5555aaaa5555aac9	6149008514797120201
pc             0x10000468	0x10000468 <._start+856>
msr            0x800000014000d032	9223372042223538226
cr             0x40fff000	1090514944
lr             0x5555aaaa5555aaca	0x5555aaaa5555aaca
ctr            0x0	0
xer            0x0	0
orig_r3        0xc000000000009974	-4611686018427348620
trap           0xd00	3328
(gdb) s
[Inferior 1 (process 8377) exited with code 0260]
