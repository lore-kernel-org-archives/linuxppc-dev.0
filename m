Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 67A2C1A0174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 23:02:03 +1100 (AEDT)
Received: from mail-yk0-x243.google.com (mail-yk0-x243.google.com
 [IPv6:2607:f8b0:4002:c07::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9D965140BF7
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2016 23:02:02 +1100 (AEDT)
Received: by mail-yk0-x243.google.com with SMTP id a85so422728ykb.2
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2016 04:02:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20160127105048.1fec7e07@camb691>
References: <1453337749-15506-1-git-send-email-cyrilbur@gmail.com>
 <1453337749-15506-5-git-send-email-cyrilbur@gmail.com>
 <20160125110423.3b0a5ae3@cotter.ozlabs.ibm.com>
 <20160127105048.1fec7e07@camb691>
Date: Wed, 27 Jan 2016 23:01:59 +1100
Message-ID: <CAKTCnzmzxSgckvr8SJVd7yeVWBexaHedzPVfoOn0yQafLYvcMw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] powerpc: Explicitly disable math features when
 copying thread
From: Balbir Singh <bsingharora@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
 Anton Blanchard <anton@samba.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 27, 2016 at 10:50 AM, Cyril Bur <cyrilbur@gmail.com> wrote:
> On Mon, 25 Jan 2016 11:04:23 +1100
> Balbir Singh <bsingharora@gmail.com> wrote:
>
>> On Thu, 21 Jan 2016 11:55:44 +1100
>> Cyril Bur <cyrilbur@gmail.com> wrote:
>>
>> > Currently when threads get scheduled off they always giveup the FPU,
>> > Altivec (VMX) and Vector (VSX) units if they were using them. When they are
>> > scheduled back on a fault is then taken to enable each facility and load
>> > registers. As a result explicitly disabling FPU/VMX/VSX has not been
>> > necessary.
>> >
>> > Future changes and optimisations remove this mandatory giveup and fault
>> > which could cause calls such as clone() and fork() to copy threads and run
>> > them later with FPU/VMX/VSX enabled but no registers loaded.
>> >
>> > This patch starts the process of having MSR_{FP,VEC,VSX} mean that a
>> > threads registers are hot while not having MSR_{FP,VEC,VSX} means that the
>> > registers must be loaded. This allows for a smarter return to userspace.
>> >
>> > Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
>> > ---
>> >  arch/powerpc/kernel/process.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>> > index dccc87e..e0c3d2d 100644
>> > --- a/arch/powerpc/kernel/process.c
>> > +++ b/arch/powerpc/kernel/process.c
>> > @@ -1307,6 +1307,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
>> >
>> >             f = ret_from_fork;
>> >     }
>> > +   childregs->msr &= ~(MSR_FP|MSR_VEC|MSR_VSX);
>>
>
> Hi Balbir,
>
> Perhaps I'm missing something, are you saying
>
>> Ideally you want to use __msr_check_and_clear()
>>
>
> instead of childregs->msr &= ~(MSR_FP|MSR_VEC|MSR_VSX); ? I don't see how that
> can work...
>
> __msr_check_and_clear() operates on the currently active MSR, that is, the msr
> for the current kernel context. childregs->msr is the value that will be used
> for that userspace context when the kernel returns. Here we must ensure that
> that children are created with the bit disabled.
>

Yes, my bad! I thought the routine took generic bits, hoping to reuse
the CONFIG_VSX bits. I don't think it helps much, what you have is
correct.

>> Basically we start with these bits off and then take an exception on use?
>>
>
> Currently yes, this is what I'm trying to change. This patch hasn't been
> necessary until now as any thread which saves its FPU/VMX/VSX data ALSO
> disables those bits in regs->msr and so theres no way a clone() or fork() can
> create a child with MSR_FP or MSR_VEC or MSR_VSX set. I add a meaning to
> 'having a regs->msr FP,VEC,VSX bit set' to mean that 'the regs are hot' in a
> subsequent patch which means this assumption no longer holds so now we must
> explicitly disable (so as to signal that the FPU/VMX/VSX regs are not hot) for
> children thread.
>
> Sounds like I still haven't got that commit message quite right yet.

I think the older series had more data to help understand the patch.
It would help to move some of them to the current series

Balbir
