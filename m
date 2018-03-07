Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxQS82YqWzF1kx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 07:37:28 +1100 (AEDT)
Received: by mail-oi0-x244.google.com with SMTP id c12so2703197oic.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 12:37:28 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <87muzoglga.fsf@concordia.ellerman.id.au>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-18-malat@debian.org>
 <87muzoglga.fsf@concordia.ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 7 Mar 2018 21:37:05 +0100
Message-ID: <CA+7wUsyMQcvEOOAuthFg4Sc783x4KBqtjkgB81KzJqPxQnwdYA@mail.gmail.com>
Subject: Re: [PATCH 17/21] powerpc: Add missing prototype for
 sys_debug_setcontext
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Jiri Slaby <jslaby@suse.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 4, 2018 at 11:54 AM, Michael Ellerman <mpe@ellerman.id.au> wrot=
e:
> Mathieu Malaterre <malat@debian.org> writes:
>
>> In commit 81e7009ea46c ("powerpc: merge ppc signal.c and ppc64 signal32.=
c")
>> the function sys_debug_setcontext was added without a prototype.
>>
>> Fix compilation warning (treated as error in W=3D1):
>>
>>   CC      arch/powerpc/kernel/signal_32.o
>> arch/powerpc/kernel/signal_32.c:1227:5: error: no previous prototype for=
 =E2=80=98sys_debug_setcontext=E2=80=99 [-Werror=3Dmissing-prototypes]
>>  int sys_debug_setcontext(struct ucontext __user *ctx,
>>      ^~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>
> This one should actually be using the SYSCALL_DEFINE syntax, so that it
> can be used with CONFIG_FTRACE_SYSCALLS.
>
> See eg. our mmap:
>
>   SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
>                 unsigned long, prot, unsigned long, flags,
>                 unsigned long, fd, off_t, offset)
>   {
>         return do_mmap2(addr, len, prot, flags, fd, offset, PAGE_SHIFT);
>   }
>
>
> We probably still need this patch, but I'm not entirely sure because the
> SYSCALL_DEFINE macro does all sorts of shenanigans.

I see. Could you please drop this patch then. The patch does not look
that trivial anymore. I'll need to dig a bit more on how to do the
syscall stuff with a 7 params function.

Thanks
