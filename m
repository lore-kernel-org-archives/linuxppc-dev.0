Return-Path: <srs0=n81q=bs=redhat.com=fweimer@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHpZ12SSCzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 23:45:45 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yHpZ11fknz8tBH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 23:45:45 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yHpZ06VCKz9t48
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2017 23:45:44 +1100 (AEDT)
Subject: Re: [PATCH 3/4] powerpc/powernv: Enable TM without suspend if possible
To: Tulio Magno Quites Machado Filho <tuliom@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: stewart@linux.vnet.ibm.com, mikey@neuling.org, cyrilbur@gmail.com
References: <1507803439-12862-1-git-send-email-mpe@ellerman.id.au>
 <1507803439-12862-3-git-send-email-mpe@ellerman.id.au>
 <920a68e7-1bb5-3ace-2aaf-1594d8845721@redhat.com>
 <87efpzbay3.fsf@linux.vnet.ibm.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <65150714-f3ac-22c8-9b85-c9dc9c225cd8@redhat.com>
Date: Thu, 19 Oct 2017 14:45:40 +0200
MIME-Version: 1.0
In-Reply-To: <87efpzbay3.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/19/2017 02:04 PM, Tulio Magno Quites Machado Filho wrote:
> Florian Weimer <fweimer@redhat.com> writes:
> 
>> On 10/12/2017 12:17 PM, Michael Ellerman wrote:
>>> +	pr_info("Enabling TM (Transactional Memory) with Suspend Disabled\n");
>>> +	cur_cpu_spec->cpu_features |= CPU_FTR_TM;
>>> +	cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_HTM_NO_SUSPEND;
>>> +	tm_suspend_disabled = true;
>>
>> This doesn't look right because if suspend is not available, you need to
>> clear the original PPC_FEATURE2_HTM flag because the semantics are not
>> right, so that applications can use fallback code.  Otherwise,
>> applications may incorrectly select the HTM code and break if running on
>> a system which supports HTM, but without the suspend state.
> 
> Just clarifying: it won't break an application, but abort the transaction,
> which can cause a performance hit.

And in this case, it is better not HTM at all.

>> The new flag should say that HTM is supported, but without the suspend
>> state, and it should be always set if PPC_FEATURE2_HTM is set.
> 
> If we change the semantics of this bit, old applications that don't suspend
> transactions won't run on these processors, even if they're safe to run.
> 
> If we adopt the current semantics, only applications that enter in suspend
> state will have to be modified in order to not get a performance regression.

In this light, the trade-off implied by the posted patch seems to be the 
right one.  But the other discussion of an ABI change still makes me a 
bit nervous.

Thanks,
Florian
