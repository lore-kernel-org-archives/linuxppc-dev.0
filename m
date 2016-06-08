Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPm9Y1CcDzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 21:17:05 +1000 (AEST)
Subject: Re: [PATCH] powerpc/pseries: Add POWER8NVL support to
 ibm,client-architecture-support call
To: Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <1464673877-30659-1-git-send-email-thuth@redhat.com>
 <1464689047.23025.1.camel@ellerman.id.au> <574D6549.3050903@redhat.com>
 <1464690745.23025.2.camel@ellerman.id.au>
 <70305fb4-d345-bd89-e395-04c39b266fe4@gmail.com>
 <1465382664.13854.1.camel@ellerman.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5757FEAC.2050002@redhat.com>
Date: Wed, 8 Jun 2016 13:17:00 +0200
MIME-Version: 1.0
In-Reply-To: <1465382664.13854.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08.06.2016 12:44, Michael Ellerman wrote:
> On Wed, 2016-06-08 at 11:14 +1000, Balbir Singh wrote:
>> On 31/05/16 20:32, Michael Ellerman wrote:
>>> On Tue, 2016-05-31 at 12:19 +0200, Thomas Huth wrote:
>>>> On 31.05.2016 12:04, Michael Ellerman wrote:
>>>>> On Tue, 2016-05-31 at 07:51 +0200, Thomas Huth wrote:
>>>>>> If we do not provide the PVR for POWER8NVL, a guest on this
>>>>>> system currently ends up in PowerISA 2.06 compatibility mode on
>>>>>> KVM, since QEMU does not provide a generic PowerISA 2.07 mode yet.
>>>>>> So some new instructions from POWER8 (like "mtvsrd") get disabled
>>>>>> for the guest, resulting in crashes when using code compiled
>>>>>> explicitly for POWER8 (e.g. with the "-mcpu=power8" option of GCC).
>>>>>>
>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>
>>>>> So this should say:
>>>>>
>>>>>   Fixes: ddee09c099c3 ("powerpc: Add PVR for POWER8NVL processor")
>>>>>
>>>>> And therefore:
>>>>>
>>>>>   Cc: stable@vger.kernel.org # v4.0+
>>>>>
>>>>> Am I right?
>>>>
>>>> Right. (At least for virtualized systems ... for bare-metal systems,
>>>> that original patch was enough). So shall I resubmit my patch with these
>>>> two lines, or could you add them when you pick this patch up?
>>>
>>> Thanks, I'll add them here.
>>
>> Don't we need to update IBM_ARCH_VEC_NRCORES_OFFSET as well?
> 
> Yep, patch sent this morning.

Ok, looks like BenH already posted a patch ... anyway, what do you think
about aborting the boot process here in case cores != NR_CPUS, rather
than just printing out a small warning which can easily get lost in the
kernel log?

 Thomas
