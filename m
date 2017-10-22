Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yKZkN4dGCzDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Oct 2017 20:59:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Tulio Magno Quites Machado Filho <tuliom@linux.vnet.ibm.com>,
 Florian Weimer <fweimer@redhat.com>, linuxppc-dev@ozlabs.org
Cc: stewart@linux.vnet.ibm.com, mikey@neuling.org, cyrilbur@gmail.com
Subject: Re: [PATCH 3/4] powerpc/powernv: Enable TM without suspend if possible
In-Reply-To: <238022cd-ee1a-54a7-2da8-8327030ea593@linaro.org>
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
 <1507803439-12862-3-git-send-email-mpe@ellerman.id.au>
 <920a68e7-1bb5-3ace-2aaf-1594d8845721@redhat.com>
 <8760bbb6su.fsf@linux.vnet.ibm.com>
 <238022cd-ee1a-54a7-2da8-8327030ea593@linaro.org>
Date: Sun, 22 Oct 2017 20:59:01 +1100
Message-ID: <87vaj7mrkq.fsf@concordia.ellerman.id.au>
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

Adhemerval Zanella <adhemerval.zanella@linaro.org> writes:

> On 19/10/2017 11:34, Tulio Magno Quites Machado Filho wrote:
>> Forwarding some comments from Adhemerval sent to libc-alpha [1]...
>> 
>> Adhemerval Zanella <adhemerval.zanella@linaro.org> writes:
>>> Florian Weimer <fweimer@redhat.com> writes:
>>>
>>>> On 10/12/2017 12:17 PM, Michael Ellerman wrote:
>>>>> +	pr_info("Enabling TM (Transactional Memory) with Suspend Disabled\n");
>>>>> +	cur_cpu_spec->cpu_features |= CPU_FTR_TM;
>>>>> +	cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_HTM_NO_SUSPEND;
>>>>> +	tm_suspend_disabled = true;
>>>>
>>>> This doesn't look right because if suspend is not available, you need to 
>>>> clear the original PPC_FEATURE2_HTM flag because the semantics are not 
>>>> right, so that applications can use fallback code.  Otherwise, 
>>>> applications may incorrectly select the HTM code and break if running on 
>>>> a system which supports HTM, but without the suspend state.
>>>>
>>>> The new flag should say that HTM is supported, but without the suspend 
>>>> state, and it should be always set if PPC_FEATURE2_HTM is set.
>>>
>>> Will it also change TEXARS with the abort information?
>> 
>> It should, with a permanent error cause so that old applications entering
>> suspended state can adopt another technique.
>> Michael, could you clarify if this is indeed happening, please?
>> 
>>> I completely agree with Florian here, this is as *ABI* change
>>> and the kernel need to advertise a different TM ABI instead
>>> of as an extension.
>> 
>> Adhemerval, could you elaborate which problems you're foreseeing, please?
>> 
>
> Pretty much the same Florian already stated: an application can not any
> more assume for instance:
>
>         tsr. 	0
>         mfcr	r9,128
>         andis. 	r10,r9,0x4000
>         be 	cr0,L(suspend)
> 	andis.	r10,r9,0x2000
> 	be	cr0,L(transactional)
>
> However thinking more about it I am not sure if this should be really a
> problem: on default HTM mode the program must handle self-induced failures
> as the tbegin. failure path and I assume trying to suspend/resume in this
> case will trigger this.

You're right, it *probably* shouldn't be a problem for most code that is
written well and doesn't use suspend mode for anything except
trace/debug etc.

But that's not a strong enough guarantee to just make the two modes
equivalent and punt the problems to userspace.

Disabling suspend changes the programming model in ways that are not
clearly documented, and which have not been widely tested, so it has to
be controlled by a new feature bit.

cheers
