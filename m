Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3FD01A0F8E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 16:40:21 +1000 (AEST)
Message-ID: <1437460821.30722.11.camel@ellerman.id.au>
Subject: Re: BUG: perf error on syscalls for powerpc64.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Zumeng Chen <zumeng.chen@windriver.com>
Cc: Zumeng Chen <zumeng.chen@gmail.com>, linux-kernel@vger.kernel.org,
 paulus@samba.org, imunsie@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 romeo.cane.ext@coriant.com, Anton Blanchard <anton@samba.org>
Date: Tue, 21 Jul 2015 16:40:21 +1000
In-Reply-To: <55A89280.8090705@windriver.com>
References: <CA+Y31wfLFe11nh9AVs2JgKrxpMc6qxxDyCfey52HT23S7RJ_zw@mail.gmail.com>
 <1437037461.15828.2.camel@ellerman.id.au>
 <CA+Y31wf16voXS6psDUDpNjMFTD8HTMwrdn=sDXC_B1=n7m=1FQ@mail.gmail.com>
 <1437106043.29389.5.camel@ellerman.id.au> <55A89280.8090705@windriver.com>
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

On Fri, 2015-07-17 at 13:28 +0800, Zumeng Chen wrote:
> On 2015年07月17日 12:07, Michael Ellerman wrote:
> > On Fri, 2015-07-17 at 09:27 +0800, Zumeng Chen wrote:
> >> On 2015年07月16日 17:04, Michael Ellerman wrote:
> >>> On Thu, 2015-07-16 at 13:57 +0800, Zumeng Chen wrote:
> >>>> Hi All,
> >>>>
> >>>> 1028ccf5 did a change for sys_call_table from a pointer to an array of
> >>>> unsigned long, I think it's not proper, here is my reason:
> >>>>
> >>>> sys_call_table defined as a label in assembler should be pointer array
> >>>> rather than an array as described in 1028ccf5. If we defined it as an
> >>>> array, then arch_syscall_addr will return the address of sys_call_table[],
> >>>> actually the content of sys_call_table[] is demanded by arch_syscall_addr.
> >>>> so 'perf list' will ignore all syscalls since find_syscall_meta will
> >>>> return null
> >>>> in init_ftrace_syscalls because of the wrong arch_syscall_addr.
> >>>>
> >>>> Did I miss something, or Gcc compiler has done something newer ?
> >>> Hi Zumeng,
> >>>
> >>> It works for me with the code as it is in mainline.
> >>>
> >>> I don't quite follow your explanation, so if you're seeing a bug please send
> >>> some information about what you're actually seeing. And include the disassembly
> >>> of arch_syscall_addr() and your compiler version etc.
> >> Hi Michael,
> > Hi Zumeng,
> >
> >> Yeah, it seems it was not a good explanation, I'll explain more this time:
> >>
> >> 1. Whatever we exclaim sys_call_table in C level, actually it is a pointer
> >>       to sys_call_table rather than sys_call_table self in assemble level.
> > No it's not a pointer.
> 
> Then what is the second one in the following:

It's a function descriptor.

> zchen@pek-yocto-build2:$ cat  System.map |grep sys_call_table
> c000000000009590 T .sys_call_table  <-----this is a real sys_call_table.
> c0000000014e1b48 D sys_call_table  <-----this should be referred by 
> arch_syscall_addr
> 
> The c0000000014e1b48[0] = c000000000009590

That is from 3.14 isn't it?

In 3.14 we had in systbl.S:

    46 _GLOBAL(sys_call_table)
    47 #include <asm/systbl.h>

And _GLOBAL was:

    46 #define _GLOBAL(name) \
    47         .type name,@function; \
    48         .globl name; \
    49 name:


Which means sys_call_table was being declared as a function, which is
completely wrong.

On big endian when you declare a function "foo" you get two symbols, ".foo" at
the address you declare the symbol and "foo" which is somewhere else and
contains three pointers, the first of which is to ".foo".

So at address "foo" you have a pointer to ".foo", which happens to be what
you'd expect if "foo" was a pointer to ".foo".

Anton fixed this in 3.16:

  https://git.kernel.org/torvalds/c/c857c43b34ec


But that had the side-effect of breaking the usage of sys_call_table in C.

cheers
