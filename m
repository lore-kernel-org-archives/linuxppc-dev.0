Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxn4q1zwpzF1q0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 21:36:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/21] powerpc: Add missing prototype for
 sys_debug_setcontext
In-Reply-To: <CA+7wUsyMQcvEOOAuthFg4Sc783x4KBqtjkgB81KzJqPxQnwdYA@mail.gmail.com>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-18-malat@debian.org>
 <87muzoglga.fsf@concordia.ellerman.id.au>
 <CA+7wUsyMQcvEOOAuthFg4Sc783x4KBqtjkgB81KzJqPxQnwdYA@mail.gmail.com>
Date: Thu, 08 Mar 2018 21:36:57 +1100
Message-ID: <878tb2etva.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mathieu Malaterre <malat@debian.org> writes:

> On Sun, Mar 4, 2018 at 11:54 AM, Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>> Mathieu Malaterre <malat@debian.org> writes:
>>
>>> In commit 81e7009ea46c ("powerpc: merge ppc signal.c and ppc64 signal32=
.c")
>>> the function sys_debug_setcontext was added without a prototype.
>>>
>>> Fix compilation warning (treated as error in W=3D1):
>>>
>>>   CC      arch/powerpc/kernel/signal_32.o
>>> arch/powerpc/kernel/signal_32.c:1227:5: error: no previous prototype fo=
r =E2=80=98sys_debug_setcontext=E2=80=99 [-Werror=3Dmissing-prototypes]
>>>  int sys_debug_setcontext(struct ucontext __user *ctx,
>>>      ^~~~~~~~~~~~~~~~~~~~
>>> cc1: all warnings being treated as errors
>>
>> This one should actually be using the SYSCALL_DEFINE syntax, so that it
>> can be used with CONFIG_FTRACE_SYSCALLS.
>>
>> See eg. our mmap:
>>
>>   SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
>>                 unsigned long, prot, unsigned long, flags,
>>                 unsigned long, fd, off_t, offset)
>>   {
>>         return do_mmap2(addr, len, prot, flags, fd, offset, PAGE_SHIFT);
>>   }
>>
>>
>> We probably still need this patch, but I'm not entirely sure because the
>> SYSCALL_DEFINE macro does all sorts of shenanigans.
>
> I see. Could you please drop this patch then. The patch does not look
> that trivial anymore. I'll need to dig a bit more on how to do the
> syscall stuff with a 7 params function.

Ergh, yuck, seems we're the first suckers to need do that.

I think I'll take this patch for now, it's still good for now at least,
and then the SYSCALL_DEFINE stuff can be an addition.

cheers
