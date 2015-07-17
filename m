Return-Path: <zumeng.chen@gmail.com>
Received: from mail-wg0-x243.google.com (mail-wg0-x243.google.com
 [IPv6:2a00:1450:400c:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BDE31A075D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 11:27:15 +1000 (AEST)
Received: by wgwk7 with SMTP id k7so6353557wgw.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 18:27:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1437037461.15828.2.camel@ellerman.id.au>
References: <CA+Y31wfLFe11nh9AVs2JgKrxpMc6qxxDyCfey52HT23S7RJ_zw@mail.gmail.com>
 <1437037461.15828.2.camel@ellerman.id.au>
Date: Fri, 17 Jul 2015 09:27:10 +0800
Message-ID: <CA+Y31wf16voXS6psDUDpNjMFTD8HTMwrdn=sDXC_B1=n7m=1FQ@mail.gmail.com>
Subject: Re: BUG: perf error on syscalls for powerpc64.
From: Zumeng Chen <zumeng.chen@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 romeo.cane.ext@coriant.com, imunsie@au1.ibm.com, paulus@samba.org,
 benh@kernel.crashing.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015=E5=B9=B407=E6=9C=8816=E6=97=A5 17:04, Michael Ellerman wrote:
> On Thu, 2015-07-16 at 13:57 +0800, Zumeng Chen wrote:
>> Hi All,
>>
>> 1028ccf5 did a change for sys_call_table from a pointer to an array of
>> unsigned long, I think it's not proper, here is my reason:
>>
>> sys_call_table defined as a label in assembler should be pointer array
>> rather than an array as described in 1028ccf5. If we defined it as an
>> array, then arch_syscall_addr will return the address of sys_call_table[=
],
>> actually the content of sys_call_table[] is demanded by arch_syscall_add=
r.
>> so 'perf list' will ignore all syscalls since find_syscall_meta will
>> return null
>> in init_ftrace_syscalls because of the wrong arch_syscall_addr.
>>
>> Did I miss something, or Gcc compiler has done something newer ?
> Hi Zumeng,
>
> It works for me with the code as it is in mainline.
>
> I don't quite follow your explanation, so if you're seeing a bug please s=
end
> some information about what you're actually seeing. And include the disas=
sembly
> of arch_syscall_addr() and your compiler version etc.

Hi Michael,

Yeah, it seems it was not a good explanation, I'll explain more this time:

1. Whatever we exclaim sys_call_table in C level, actually it is a pointer
     to sys_call_table rather than sys_call_table self in assemble level.

     arch/powerpc/kernel/systbl.S
     47 .globl sys_call_table   <--- see here
     48 sys_call_table:

     So if you want to exclaim sys_call_table as array, then I think
it's very
     clear what we'll get when we do sys_call_table[i].

2. Disassemble codes difference of arch_syscall_addr with or without
1028ccf5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

     *) With 1028ccf5
       ---------------------
Dump of assembler code for function arch_syscall_addr:
522    {
523        return (unsigned long)sys_call_table[nr];
    0xc000000000df53d4 <+0>:    addis   r10,r2,-13
    0xc000000000df53d8 <+4>:    addi    r9,r10,3488
    0xc000000000df53dc <+8>:    rldicr  r3,r3,3,60
524    }
    0xc000000000df53e0 <+12>:    ldx     r3,r9,r3
    0xc000000000df53e4 <+16>:    blr


     *) Without 1028ccf5
     ---------------------------
Dump of assembler code for function arch_syscall_addr:
522    {
523        return (unsigned long)sys_call_table[nr];
    0xc000000000df53d0 <+0>:    addis   r10,r2,-13
    0xc000000000df53d4 <+4>:    addi    r9,r10,3488
    0xc000000000df53d8 <+8>:    rldicr  r3,r3,3,60
    0xc000000000df53dc <+12>:    ld      r9,0(r9) <------only this is
different
524    }
    0xc000000000df53e0 <+16>:    ldx     r3,r9,r3
    0xc000000000df53e4 <+20>:    blr
End of assembler dump.

3. What I have seen in 3.14.x kernel,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
And so far, no more difference to 4.x kernel from me about this part if
I'm right.

*) With 1028ccf5

perf list|grep -i syscall got me nothing.


*) Without 1028ccf5
root@localhost:~# perf list|grep -i syscall
   syscalls:sys_enter_socket                          [Tracepoint event]
   syscalls:sys_exit_socket                           [Tracepoint event]
   syscalls:sys_enter_socketpair                      [Tracepoint event]
   syscalls:sys_exit_socketpair                       [Tracepoint event]
   syscalls:sys_enter_bind                            [Tracepoint event]
   syscalls:sys_exit_bind                             [Tracepoint event]
   syscalls:sys_enter_listen                          [Tracepoint event]
   syscalls:sys_exit_listen                           [Tracepoint event]
   ... ...

Cheers,
Zumeng

>
> cheers
>
>
