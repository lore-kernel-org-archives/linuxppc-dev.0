Return-Path: <dave.long@linaro.org>
Received: from mail-qg0-f43.google.com (mail-qg0-f43.google.com
 [209.85.192.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C6311A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 06:58:50 +1000 (AEST)
Received: by qged89 with SMTP id d89so11456245qge.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 13:58:48 -0700 (PDT)
Message-ID: <557F3C7F.5040809@linaro.org>
Date: Mon, 15 Jun 2015 16:58:39 -0400
From: David Long <dave.long@linaro.org>
MIME-Version: 1.0
To: Kees Cook <keescook@chromium.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>,
 Anton Blanchard <anton@samba.org>,
 Behan Webster <behanw@converseincode.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Eric Paris <eparis@redhat.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Ingo Molnar <mingo@redhat.com>, Jan Willeke <willeke@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nikolay Borisov <Nikolay.Borisov@arm.com>,
 Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Richard Kuo <rkuo@codeaurora.org>,
 Robert Richter <rric@kernel.org>, Roland McGrath <roland@hack.frob.com>,
 Russell King <linux@arm.linux.org.uk>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linux-hexagon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 linux-sh <linux-sh@vger.kernel.org>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/2] Consolidate redundant register/stack access code
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
 <CAGXu5jJ7i6qgUOXuaNJ8vT7+D+6_C_hrOwWHZA+6f9zFJQ+Vbw@mail.gmail.com>
In-Reply-To: <CAGXu5jJ7i6qgUOXuaNJ8vT7+D+6_C_hrOwWHZA+6f9zFJQ+Vbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/15/15 16:44, Kees Cook wrote:
> On Mon, Jun 15, 2015 at 9:42 AM, David Long <dave.long@linaro.org> wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> Move duplicate and functionally equivalent code for accessing registers
>> and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
>> common kernel files.
>>
>> Note: Help regression testing s390, hexagon, and sh would be appreciated.
>>        Powerpc builds but I have not verified the functionality.
>>
>> David A. Long (2):
>>    Move the pt_regs_offset struct definition from arch to common include
>>      file
>>    Consolidate redundant register/stack access code
>>
>>   arch/arm/include/asm/ptrace.h          |  6 ---
>>   arch/arm/kernel/ptrace.c               | 72 +---------------------------------
>>   arch/hexagon/include/uapi/asm/ptrace.h |  3 --
>>   arch/powerpc/include/asm/ptrace.h      | 38 ------------------
>>   arch/powerpc/kernel/ptrace.c           | 39 +-----------------
>>   arch/s390/include/asm/ptrace.h         |  3 --
>>   arch/s390/kernel/ptrace.c              | 70 ++++++++++-----------------------
>>   arch/sh/include/asm/ptrace.h           | 44 ---------------------
>>   arch/sh/kernel/Makefile                |  2 +-
>>   arch/sh/kernel/ptrace.c                | 33 ----------------
>>   arch/sh/kernel/ptrace_32.c             |  2 +-
>>   arch/sh/kernel/ptrace_64.c             |  2 +-
>>   arch/x86/include/asm/ptrace.h          | 37 -----------------
>>   arch/x86/kernel/ptrace.c               | 39 +-----------------
>>   include/linux/ptrace.h                 | 51 ++++++++++++++++++++++++
>>   kernel/ptrace.c                        | 38 ++++++++++++++++++
>>   16 files changed, 116 insertions(+), 363 deletions(-)
>>   delete mode 100644 arch/sh/kernel/ptrace.c
>
> I love the deletions:insertions ratio! :)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> I wonder why arm64 doesn't define CONFIG_HAVE_REGS_AND_STACK_ACCESS_API?
>

That support is added in the patch I sent out after this one (to a 
different set of recipients).

Thanks.

> Thanks!
>
> -Kees
>
