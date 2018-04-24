Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Vp7y41BLzF244
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 02:05:18 +1000 (AEST)
Subject: Re: [PATCH] powerpc/signal32: Use fault_in_pages_readable() to
 prefault user context
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20180424141759.F02AF6C59D@po15720vm.idsi0.si.c-s.fr>
 <CA+7wUsz6NNG=sVUYL1n+ntAJUWNvjtpjCHzJmPuQ4Zb7TuFrZA@mail.gmail.com>
 <CA+7wUsxXwRVHDrE_bzog2+m+kdyDsC4MnjB4_BMc2owDUe7d8A@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7d61f98e-8cbb-91cf-97d4-f861758ed11d@c-s.fr>
Date: Tue, 24 Apr 2018 18:05:12 +0200
MIME-Version: 1.0
In-Reply-To: <CA+7wUsxXwRVHDrE_bzog2+m+kdyDsC4MnjB4_BMc2owDUe7d8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 24/04/2018 à 16:50, Mathieu Malaterre a écrit :
> On Tue, Apr 24, 2018 at 4:45 PM, Mathieu Malaterre <malat@debian.org> wrote:
>> On Tue, Apr 24, 2018 at 4:17 PM, Christophe Leroy
>> <christophe.leroy@c-s.fr> wrote:
>>> Use fault_in_pages_readable() to prefault user context
>>> instead of open coding
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   arch/powerpc/kernel/signal_32.c | 13 +++++--------
>>>   1 file changed, 5 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
>>> index 492f03451877..cfacb2726152 100644
>>> --- a/arch/powerpc/kernel/signal_32.c
>>> +++ b/arch/powerpc/kernel/signal_32.c
>>> @@ -25,6 +25,7 @@
>>>   #include <linux/errno.h>
>>>   #include <linux/elf.h>
>>>   #include <linux/ptrace.h>
>>> +#include <linux/pagemap.h>
>>>   #include <linux/ratelimit.h>
>>>   #ifdef CONFIG_PPC64
>>>   #include <linux/syscalls.h>
>>> @@ -1045,7 +1046,6 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
>>>                       struct ucontext __user *new_ctx,
>>>                       int ctx_size, int r6, int r7, int r8, struct pt_regs *regs)
>>>   {
>>> -       unsigned char tmp __maybe_unused;
>>>          int ctx_has_vsx_region = 0;
>>>
>>>   #ifdef CONFIG_PPC64
>>> @@ -1109,9 +1109,8 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
>>>          }
>>>          if (new_ctx == NULL)
>>>                  return 0;
>>> -       if (!access_ok(VERIFY_READ, new_ctx, ctx_size)
>>> -           || __get_user(tmp, (u8 __user *) new_ctx)
>>> -           || __get_user(tmp, (u8 __user *) new_ctx + ctx_size - 1))
>>> +       if (!access_ok(VERIFY_READ, new_ctx, ctx_size) ||
>>> +           fault_in_pages_readable((u8 __user *)new_ctx, ctx_size))
>>>                  return -EFAULT;
>>>
>>>          /*
>>> @@ -1231,7 +1230,6 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
>>>   {
>>>          struct sig_dbg_op op;
>>>          int i;
>>> -       unsigned char tmp __maybe_unused;
>>>          unsigned long new_msr = regs->msr;
>>>   #ifdef CONFIG_PPC_ADV_DEBUG_REGS
>>>          unsigned long new_dbcr0 = current->thread.debug.dbcr0;
>>> @@ -1287,9 +1285,8 @@ int sys_debug_setcontext(struct ucontext __user *ctx,
>>>          current->thread.debug.dbcr0 = new_dbcr0;
>>>   #endif
>>>
>>> -       if (!access_ok(VERIFY_READ, ctx, sizeof(*ctx))
>>> -           || __get_user(tmp, (u8 __user *) ctx)
>>> -           || __get_user(tmp, (u8 __user *) (ctx + 1) - 1))
>>> +       if (!access_ok(VERIFY_READ, ctx, sizeof(*ctx)) ||
>>> +           fault_in_pages_readable((u8 __user *)ctx, 1))
>>
>> I believe you meant:
>>
>> fault_in_pages_readable((u8 __user *)new_ctx, ctx_size)
>>
>> Since (u8 __user *) (ctx + 1) - 1 really is (u8 __user *) new_ctx + ctx_size - 1
> 
> Without the copy/paste errors:
> 
> [...]
> fault_in_pages_readable((u8 __user *)ctx, sizeof(*ctx))
> 
> Since (u8 __user *) (ctx + 1) - 1 really is (u8 __user *) ctx + sizeof(*ctx) - 1
> [...]

Oops you're right thanks.
v2 submitted

Christophe


>>>                  return -EFAULT;
>>>
>>>          /*
>>> --
>>> 2.13.3
>>>
