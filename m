Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYt4n3M2YzDqNL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 14:12:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matt Brown <matthew.brown.dev@gmail.com>, pc@us.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/lib: Split xor_vmx file to guarantee instruction
 ordering
In-Reply-To: <CAPoR37YQ-9Q=HacFVrWDg_aS=rPhWhB_SuuevdZDCA2Vu=AVyg@mail.gmail.com>
References: <20170523234559.28080-1-matthew.brown.dev@gmail.com>
 <0a79517a-c9eb-6eca-4048-de20d4543114@us.ibm.com>
 <CAPoR37YQ-9Q=HacFVrWDg_aS=rPhWhB_SuuevdZDCA2Vu=AVyg@mail.gmail.com>
Date: Fri, 26 May 2017 14:12:09 +1000
Message-ID: <87wp948deu.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matt Brown <matthew.brown.dev@gmail.com> writes:

> On Wed, May 24, 2017 at 11:36 PM, Paul Clarke <pc@us.ibm.com> wrote:
>> On 05/23/2017 06:45 PM, Matt Brown wrote:
>>> The xor_vmx.c file is used for the RAID5 xor operations. In these functions
>>> altivec is enabled to run the operation and then disabled. However due to
>>> compiler instruction reordering, altivec instructions are being run before
>>> enable_altivec() and after disable_altivec().
>>
>> If altivec instructions can be reordered after disable_altivec(), then disable_altivec() is broken, I'd think.
>>
>> Could it be because the isync in mtmsr_isync() is after the mtmsr?
>>
>> disable_kernel_altivec
>> - msr_check_and_clear
>>   - __msr_check_and_clear
>>     - mtmsr_isync
>
> So it turns out the enable / disable functions don't actually enable
> or disable the use of vector instructions.
> If we have marked the file to be compiled with altivec the compiler
> has free reign to reorder the vector instructions wherever it likes.
> Including reordering it before or after the enable/disable_altivec
> commands.

That's true. Though it's not that the compiler is reordering vector
instructions, it's that it's generating them directly to save/restore
vector arguments.

In enable_kernel_altivec() we have a mtmsr() which is implemented with
inline asm, with a "memory" clobber, so that is effectively a full
compiler barrier. ie. the compiler will not reorder code across that.

> The enable_kernel_altivec and disable_kernel_altivec functions are
> mainly there to empty and restore the vector registers which could
> have been used in user-space. So those functions work as intended,
> although not particularly intuitive.

Yeah, perhaps "allow" would be better. In fact the whole API is a bit
crap and we need to rework it.

cheers
