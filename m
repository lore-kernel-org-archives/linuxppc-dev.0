Return-Path: <Zumeng.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D6E81A0727
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 15:28:52 +1000 (AEST)
Message-ID: <55A89280.8090705@windriver.com>
Date: Fri, 17 Jul 2015 13:28:32 +0800
From: Zumeng Chen <zumeng.chen@windriver.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, Zumeng Chen <zumeng.chen@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <paulus@samba.org>, <imunsie@au1.ibm.com>,
 <linuxppc-dev@lists.ozlabs.org>, <romeo.cane.ext@coriant.com>
Subject: Re: BUG: perf error on syscalls for powerpc64.
References: <CA+Y31wfLFe11nh9AVs2JgKrxpMc6qxxDyCfey52HT23S7RJ_zw@mail.gmail.com>
 <1437037461.15828.2.camel@ellerman.id.au>
 <CA+Y31wf16voXS6psDUDpNjMFTD8HTMwrdn=sDXC_B1=n7m=1FQ@mail.gmail.com>
 <1437106043.29389.5.camel@ellerman.id.au>
In-Reply-To: <1437106043.29389.5.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015年07月17日 12:07, Michael Ellerman wrote:
> On Fri, 2015-07-17 at 09:27 +0800, Zumeng Chen wrote:
>> On 2015年07月16日 17:04, Michael Ellerman wrote:
>>> On Thu, 2015-07-16 at 13:57 +0800, Zumeng Chen wrote:
>>>> Hi All,
>>>>
>>>> 1028ccf5 did a change for sys_call_table from a pointer to an array of
>>>> unsigned long, I think it's not proper, here is my reason:
>>>>
>>>> sys_call_table defined as a label in assembler should be pointer array
>>>> rather than an array as described in 1028ccf5. If we defined it as an
>>>> array, then arch_syscall_addr will return the address of sys_call_table[],
>>>> actually the content of sys_call_table[] is demanded by arch_syscall_addr.
>>>> so 'perf list' will ignore all syscalls since find_syscall_meta will
>>>> return null
>>>> in init_ftrace_syscalls because of the wrong arch_syscall_addr.
>>>>
>>>> Did I miss something, or Gcc compiler has done something newer ?
>>> Hi Zumeng,
>>>
>>> It works for me with the code as it is in mainline.
>>>
>>> I don't quite follow your explanation, so if you're seeing a bug please send
>>> some information about what you're actually seeing. And include the disassembly
>>> of arch_syscall_addr() and your compiler version etc.
>> Hi Michael,
> Hi Zumeng,
>
>> Yeah, it seems it was not a good explanation, I'll explain more this time:
>>
>> 1. Whatever we exclaim sys_call_table in C level, actually it is a pointer
>>       to sys_call_table rather than sys_call_table self in assemble level.
> No it's not a pointer.

Then what is the second one in the following:

zchen@pek-yocto-build2:$ cat  System.map |grep sys_call_table
c000000000009590 T .sys_call_table  <-----this is a real sys_call_table.
c0000000014e1b48 D sys_call_table  <-----this should be referred by 
arch_syscall_addr

The c0000000014e1b48[0] = c000000000009590

>
> A pointer is a location in memory that contains the address of another location
> in memory.

Yeah, this definition is right.

>
>>       arch/powerpc/kernel/systbl.S
>>       47 .globl sys_call_table   <--- see here
>>       48 sys_call_table:
> Which gives us a .o that looks like:
>
>    0000000000000000 <sys_call_table>:
>                     0: R_PPC64_ADDR64       sys_restart_syscall
>                     8: R_PPC64_ADDR64       sys_restart_syscall
>                     10: R_PPC64_ADDR64      sys_exit
>                     18: R_PPC64_ADDR64      sys_exit
>
> ie. at the location in memory called sys_call_table we have *the contents of
> the syscall table*.
>
> We do not have *the address* of the syscall table.
>
> You can also see in the System.map:
>
>    c000000000bb0798 R sys_call_table
>    c000000000bb1e58 r cache_type_info

Please refer to `cat  System.map` above

>
> ie. sys_call_table occupies 5824 bytes. If it was a pointer it would only
> occupy 8 bytes.
>
> Compare to SYS_CALL_TABLE, which *is* a pointer.
>
>    c000000001172bf8 d SYS_CALL_TABLE
>    c000000001172c00 d exception_marker
>
> Note, 8 bytes.
>
>
> Finally if you look at a running system using xmon:
>
>    0:mon> d $sys_call_table
>    c0000000008f0798 c0000000000a85a0 c0000000000a85a0  |................|
>    c0000000008f07a8 c000000000099b40 c000000000099b40  |.......@.......@|

This is right sys_call_table. but not what I'm talking about. What I'm 
talking about
is that the definition of sys_call_table by that commit will incur the 
following result:

sys_call_table[0]= 0xc0000000014e1b48[0] = c000000000009590 <----Only 
this one is right the head address of sys_call_table
sys_call_table[1]= 0xc0000000014e1b48[1] = c0000000015b0da8
sys_call_table[2]= 0xc0000000014e1b48[2] = 0
sys_call_table[3]= 0xc0000000014e1b48[3] = c000000000de0984
sys_call_table[4]= 0xc0000000014e1b48[4] = c0000000015b0da8
sys_call_table[5]= 0xc0000000014e1b48[5] = 0

This is definitely not what we want, is that right?


>
>    0:mon> la c0000000000a85a0
>    c0000000000a85a0: .sys_restart_syscall+0x0/0x40
>    0:mon> la c000000000099b40
>    c000000000099b40: .SyS_exit+0x0/0x20
>
>    0:mon> d $SYS_CALL_TABLE
>    c000000000ec68f8 c0000000008f0798 7265677368657265  |........regshere|
>                     ^
>    		 this is the address of sys_call_table
>
>
> As another example, see hcall_real_table, which is basically identical, and is
> also declared as an array in C.
>
>
>> 3. What I have seen in 3.14.x kernel,
>> ======================
>> And so far, no more difference to 4.x kernel from me about this part if
>> I'm right.
>>
>> *) With 1028ccf5
>>
>> perf list|grep -i syscall got me nothing.
>>
>>
>> *) Without 1028ccf5
>> root@localhost:~# perf list|grep -i syscall
>>     syscalls:sys_enter_socket                          [Tracepoint event]
>>     syscalls:sys_exit_socket                           [Tracepoint event]
>>     syscalls:sys_enter_socketpair                      [Tracepoint event]
>>     syscalls:sys_exit_socketpair                       [Tracepoint event]
>>     syscalls:sys_enter_bind                            [Tracepoint event]
>>     syscalls:sys_exit_bind                             [Tracepoint event]
>>     syscalls:sys_enter_listen                          [Tracepoint event]
>>     syscalls:sys_exit_listen                           [Tracepoint event]
>>     ... ...
> I don't know why that's happening.
>
> Please just test 4.2-rc2 for now, so that there are not too many variables.

Yeah, maybe right.

>
> Assuming you have CONFIG_FTRACE_SYSCALLS=y, you can see the tracepoints in

Absolutely

Cheers,
Zumeng

> debugfs with:
>
>    $ ls -la /sys/kernel/debug/tracing/events/syscalls
>    total 0
>    drwxr-xr-x 596 root root 0 Jul 17 13:11 .
>    drwxr-xr-x  45 root root 0 Jul 17 13:11 ..
>    -rw-r--r--   1 root root 0 Jul 17 13:33 enable
>    -rw-r--r--   1 root root 0 Jul 17 13:11 filter
>    drwxr-xr-x   2 root root 0 Jul 17 13:11 sys_enter_accept
>    drwxr-xr-x   2 root root 0 Jul 17 13:11 sys_enter_accept4
>    drwxr-xr-x   2 root root 0 Jul 17 13:11 sys_enter_access
>    drwxr-xr-x   2 root root 0 Jul 17 13:11 sys_enter_add_key
>    ...
>
>
> cheers
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
