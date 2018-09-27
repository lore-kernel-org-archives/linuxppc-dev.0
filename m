Return-Path: <breno.debian@gmail.com>
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LmFy6t2dzF37q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 06:13:10 +1000 (AEST)
Received: by mail-qk1-f193.google.com with SMTP id g184-v6so2425792qkc.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 13:13:10 -0700 (PDT)
Subject: Re: [RFC PATCH 00/11] New TM Model
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Cc: paulus@ozlabs.org, gromero@linux.vnet.ibm.com, mpe@ellerman.id.au,
 ldufour@linux.vnet.ibm.com, Cyril Bur <cyrilbur@gmail.com>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
 <b1ed898835f2e0805088d215e8afb193a7c4768c.camel@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <a48a3713-f473-a770-5721-d9b10700a3af@debian.org>
Date: Thu, 27 Sep 2018 17:13:03 -0300
MIME-Version: 1.0
In-Reply-To: <b1ed898835f2e0805088d215e8afb193a7c4768c.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mikey,

First of all, thanks for you detailed review. I really appreciate your
comments here.

On 09/17/2018 02:25 AM, Michael Neuling wrote:
> On Wed, 2018-09-12 at 16:40 -0300, Breno Leitao wrote:
>> This patchset for the hardware transactional memory (TM) subsystem aims to
>> avoid spending a lot of time on TM suspended mode in kernel space. It
>> basically
>> changes where the reclaim/recheckpoint will be executed.
>>
>> Once a CPU enters in transactional state it uses a footprint area to track
>> down the load/stores performed in transaction so it can be verified later
>> to decide if a conflict happened due to some change done in that state. If
>> a transaction is active in userspace and there is an exception that takes
>> the CPU to the kernel space the CPU moves the transaction to suspended
>> state but does not discard the footprint area.
> 
> In this description, you should differente between memory and register
> (GPR/VSX/SPR) footprints.

Right, reading the ISA, I understand that footprint is a term for memory only
and it represents the modified memory that was stored during a transactional
state (that after tbegin). For registers, the ISA talks about checkpointed
registers, which is the register state *before* a transaction starts.

I.e, for register it is the previous state, and for memory, it is the
current/live state.

That said, if the transactional is aborted, the memory footprint is discarded
and the checkpointed registers replaces the live registers.

> In suspend, the CPU can disregard the memory footprint at any point, but it has> to keep the register footprint.
Yes!

Anyway, I was just trying to describe how the hardware works, it is not
related to the kernel at the paragraph above, but I will make sure I will
re-write it better.

>> This patchset aims to reclaim the checkpointed footprint as soon as the
>> kernel is invoked, in the beginning of the exception handlers, thus freeing
>> room to other CPUs enter in suspended mode, avoiding too many CPUs in
>> suspended
>> state that can cause the CPUs to stall. The same mechanism is done on kernel
>> exit, doing a recheckpoint as late as possible (which will reload the
>> checkpointed state into CPU's room) at the exception return.
> 
> OK, but we are still potentially in suspend in userspace, so that doesn't help
> us on the lockup issue.
> 
> We need fake suspend in userspace to prevent lockups.

Correct. I will make sure I document it. This patchset is the very first step
to start creating a work around for the hardware limitations.

>> The way to achieve this goal is creating a macro (TM_KERNEL_ENTRY) which
>> will check if userspace was in an active transaction just after getting
>> into kernel and reclaiming if that's the case. Thus all exception handlers
>> will call this macro as soon as possible.
>>
>> All exceptions should reclaim (if necessary) at this stage and only
>> recheckpoint if the task is tagged as TIF_RESTORE_TM (i.e. was in
>> transactional state before being interrupted), which will be done at
>> ret_from_except_lite().
>>
>> Ideally all reclaims will happen at the exception entrance, however during
>> the recheckpoint process another exception can hit the CPU which might
>> cause the current thread to be rescheduled, thus there is another reclaim
>> point to be considered at __switch_to().
> 
> Can we do the recheckpoint() later so that it's when we have interrupts off and
> can't be rescheduled?

Yes!  After thinking on it for a long time, this is definitely what should be
done. I will send a v2 with this change (and others being discussed here)

Thank you,
Breno
