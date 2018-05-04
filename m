Return-Path: <clg@kaod.org>
Received: from 8.mo68.mail-out.ovh.net (8.mo68.mail-out.ovh.net
 [46.105.74.219])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40crZq2hxxzDqKX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 22:16:01 +1000 (AEST)
Received: from player714.ha.ovh.net (unknown [10.109.122.24])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id D865FE1AC4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 13:36:46 +0200 (CEST)
Subject: Re: [PATCH 1/4] powerpc/64/kexec: fix race in kexec when XIVE is
 shutdowned
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20180403071548.19829-1-clg@kaod.org>
 <20180403071548.19829-2-clg@kaod.org>
 <87fu378zz0.fsf@concordia.ellerman.id.au>
 <df63e1d5-0f08-5b20-d70b-b9feea7df537@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <eac5c56d-6d05-92ba-6dcb-57e5a5ee05af@kaod.org>
Date: Fri, 4 May 2018 13:36:44 +0200
MIME-Version: 1.0
In-Reply-To: <df63e1d5-0f08-5b20-d70b-b9feea7df537@kaod.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/04/2018 01:13 PM, Cédric Le Goater wrote:
> On 05/04/2018 12:41 PM, Michael Ellerman wrote:
>> Cédric Le Goater <clg@kaod.org> writes:
>>
>>> The kexec_state KEXEC_STATE_IRQS_OFF barrier is reached by all
>>> secondary CPUs before the kexec_cpu_down() operation is called on
>>> secondaries. This can raise conflicts and provoque errors in the XIVE
>>> hcalls when XIVE is shutdowned with H_INT_RESET on the primary CPU.
>>>
>>> To synchronize the kexec_cpu_down() operations and make sure the
>>> secondaries have completed their task before the primary starts doing
>>> the same, let's move the primary kexec_cpu_down() after the
>>> KEXEC_STATE_REAL_MODE barrier.
>>
>> This sounds reasonable, I'm sure you've tested it. I'm just a bit
>> worried that it could potentially break on other platforms because it
>> changes the sequence of operations.
> 
> yes. We are adding a last barrier to be exact making the full sequence 
> a little slower.
> 
>> Looking we only have kexec_cpu_down() implemented for pseries, powernv,
>> ps3 and 85xx.
>>
>> We can easily test the first two. > ps3 doesn't do much so hopefully that's safe.
>>
>> mpc85xx_smp_kexec_cpu_down() does very little on 32-bit, and on 64-bit
>> it seems to already wait for at least one other CPU to get into
>> KEXEC_STATE_REAL_MODE, so that's probably safe too.
>>
>> So I guess I'm OK to merge this, and we'll fix any fallout. It would be
>> good for the change log to call out the change though, and that we think
>> it's a sensible change for all platforms.
> 
> OK. 

Ah and can you please fix the 'shutdowned' spelling ? it has been bugging me
since I sent the patch :) thx

C.
