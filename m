Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409Ppq6xzqzF28v
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 19:50:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 17/21] powerpc: Add missing prototype for
 sys_debug_setcontext
In-Reply-To: <CA+7wUszeX3vdctpddcEvx+j-evwSBbX=Q7Mh1-mx+GNFbFh0=A@mail.gmail.com>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-18-malat@debian.org>
 <87muzoglga.fsf@concordia.ellerman.id.au>
 <CA+7wUsyMQcvEOOAuthFg4Sc783x4KBqtjkgB81KzJqPxQnwdYA@mail.gmail.com>
 <878tb2etva.fsf@concordia.ellerman.id.au>
 <CA+7wUszeX3vdctpddcEvx+j-evwSBbX=Q7Mh1-mx+GNFbFh0=A@mail.gmail.com>
Date: Tue, 27 Mar 2018 19:50:09 +1100
Message-ID: <87h8p1kim6.fsf@concordia.ellerman.id.au>
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

Hi Mathieu,

Mathieu Malaterre <malat@debian.org> writes:
> On Thu, Mar 8, 2018 at 11:36 AM, Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>> Mathieu Malaterre <malat@debian.org> writes:
>>> On Sun, Mar 4, 2018 at 11:54 AM, Michael Ellerman <mpe@ellerman.id.au> =
wrote:
>>>> Mathieu Malaterre <malat@debian.org> writes:
>>>>> In commit 81e7009ea46c ("powerpc: merge ppc signal.c and ppc64 signal=
32.c")
>>>>> the function sys_debug_setcontext was added without a prototype.
>>>>>
>>>>> Fix compilation warning (treated as error in W=3D1):
>>>>>
>>>>>   CC      arch/powerpc/kernel/signal_32.o
>>>>> arch/powerpc/kernel/signal_32.c:1227:5: error: no previous prototype =
for =E2=80=98sys_debug_setcontext=E2=80=99 [-Werror=3Dmissing-prototypes]
>>>>>  int sys_debug_setcontext(struct ucontext __user *ctx,
>>>>>      ^~~~~~~~~~~~~~~~~~~~
>>>>> cc1: all warnings being treated as errors
>>>>
>>>> This one should actually be using the SYSCALL_DEFINE syntax, so that it
>>>> can be used with CONFIG_FTRACE_SYSCALLS.
>>>>
>>>> See eg. our mmap:
>>>>
>>>>   SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
>>>>                 unsigned long, prot, unsigned long, flags,
>>>>                 unsigned long, fd, off_t, offset)
>>>>   {
>>>>         return do_mmap2(addr, len, prot, flags, fd, offset, PAGE_SHIFT=
);
>>>>   }
>>>>
>>>>
>>>> We probably still need this patch, but I'm not entirely sure because t=
he
>>>> SYSCALL_DEFINE macro does all sorts of shenanigans.
>>>
>>> I see. Could you please drop this patch then. The patch does not look
>>> that trivial anymore. I'll need to dig a bit more on how to do the
>>> syscall stuff with a 7 params function.
>>
>> Ergh, yuck, seems we're the first suckers to need do that.
>>
>> I think I'll take this patch for now, it's still good for now at least,
>> and then the SYSCALL_DEFINE stuff can be an addition.
>
> Just to close the loop (for later reference). Here is what Al Viro
> told me about this function
>
> [begin quote]
> int sys_debug_setcontext(struct ucontext __user *ctx,
>                          int ndbg, struct sig_dbg_op __user *dbg,
>                          int r6, int r7, int r8,
>                          struct pt_regs *regs)
>
> can't be converted to SYSCALL_DEFINE... not because it's a 7-argument
> syscall (it isn't); the problem is that the last argument here does
> *not* come from userland.  What it really is trying to be is
> 3-argument syscall:
> SYSCALL_DEFINE3(debug_setcontext, struct ucontext __user *, ctx,
>                                   int, ndbg,
>                                   struct sig_dbg_op __user *, dbg)
> with no dummy r6/r7/r8.  The thing is, ppc dispatcher combines the
> "pass 6 arguments" and "pass pt_regs *" by passing both.
>
> debug_setcontext(), swapcontext(), sigreturn() and rt_sigreturn() are,
> AFAICS, the only ppc syscalls that make use of that argument.  All of
> those are relying upon regs =3D=3D current_pt_regs() =3D=3D current->thre=
ad.regs,
> [...]
> But in any case, these are not 7-argument syscalls - debug_setcontext(2)
> and swapcontext(2) are 3-argument and sigreturn()/rt_sigreturn() have
> no arguments at all.
> [end quote]

Awesome follow-up thanks.

I should have realised that's what the code was doing, but I didn't look
closely enough. Apologies to Al for having to stare at our horrible
signal code again :)

We should really clean all that up, I can't see any reason those
syscalls aren't using current_pt_regs().

That would then mean we could use SYSCALL_DEFINE.

I wrote that down so we don't (might not) forget:

  https://github.com/linuxppc/linux/issues/131

> Sorry about the wrong analysis in the number of arguments count. I
> believe commit 0d60619e1c0ca (powerpc/next) should be just fine for
> now.

No worries.

cheers
