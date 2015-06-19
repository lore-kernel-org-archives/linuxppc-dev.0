Return-Path: <keescook@google.com>
Received: from mail-yh0-x22c.google.com (mail-yh0-x22c.google.com
 [IPv6:2607:f8b0:4002:c01::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 452951A0EF6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2015 02:58:48 +1000 (AEST)
Received: by yhak3 with SMTP id k3so82144276yha.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 09:58:46 -0700 (PDT)
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <5584234E.2040701@linaro.org>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
 <1434386579-6045-2-git-send-email-dave.long@linaro.org>
 <1434687583.23771.5.camel@ellerman.id.au>
 <5584234E.2040701@linaro.org>
Date: Fri, 19 Jun 2015 09:58:45 -0700
Message-ID: <CAGXu5jJFkv=ma0SJ-5N+GKQ3xoPw8193+kxO0F3M0c0_c=ZTtg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Move the pt_regs_offset struct definition from arch
 to common include file
From: Kees Cook <keescook@chromium.org>
To: David Long <dave.long@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@amacapital.net>, Anton Blanchard <anton@samba.org>,
 Behan Webster <behanw@converseincode.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Eric Paris <eparis@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Jan Willeke <willeke@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Nikolay Borisov <Nikolay.Borisov@arm.com>, Oleg Nesterov <oleg@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Richard Kuo <rkuo@codeaurora.org>,
 Robert Richter <rric@kernel.org>,
 Roland McGrath <roland@hack.frob.com>, Russell King <linux@arm.linux.org.uk>,
 Tejun Heo <tj@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-hexagon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 linux-sh <linux-sh@vger.kernel.org>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 19, 2015 at 7:12 AM, David Long <dave.long@linaro.org> wrote:
> On 06/19/15 00:19, Michael Ellerman wrote:
>>
>> On Mon, 2015-06-15 at 12:42 -0400, David Long wrote:
>>>
>>> From: "David A. Long" <dave.long@linaro.org>
>>>
>>> The pt_regs_offset structure is used for HAVE_REGS_AND_STACK_ACCESS_API
>>>   feature and has identical definitions in four different arch ptrace.h
>>> include files. It seems unlikely that definition would ever need to be
>>> changed regardless of architecture so lets move it into
>>> include/linux/ptrace.h.
>>>
>>> Signed-off-by: David A. Long <dave.long@linaro.org>
>>> ---
>>>   arch/powerpc/kernel/ptrace.c | 5 -----
>>
>>
>> Built and booted on powerpc, but is there an easy way to actually test the
>> code
>> paths in question?
>>
>
> There is an easy way to "smoke test" it on all archiectures that also
> implement kprobes (which powerpc does).  If I'm understanding the powerpc
> code correctly (WRT register naming conventions) just do the following:
>
> cd /sys/kernel/debug/tracing
> echo 'p do_fork %gpr0' > kprobe_events
> echo 1 > events/kprobes/enable
> ls
> cat trace
> echo 0 > events/kprobes/enable
>
> Every fork() call done on the system between those two echo commands (hence
> the "ls") should append a line to the trace file.  For a more exhaustive
> test one could repeat this sequence for every register in the architecture.
>
> This should work the same on all architectures supporting kprobes.  You just
> have to use the appropriate register names for your architecture after the
> "%".

Is this something we could codify into the selftests directory? It
seems like a great thing to capture in a single place somewhere (the
register lists, that is).

-Kees

>
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>>
>> cheers
>>
>>
>
> Thanks,
> -dl
>



-- 
Kees Cook
Chrome OS Security
