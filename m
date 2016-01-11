Return-Path: <tuliom@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E0D41A0D35
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 06:55:51 +1100 (AEDT)
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tuliom@linux.vnet.ibm.com>;
 Mon, 11 Jan 2016 17:55:46 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 12739352006E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 14:55:38 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0BJrE9a30212410
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 17:53:15 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0BJtgnh018113
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 14:55:42 -0500
From: "Tulio Magno Quites Machado Filho" <tuliom@linux.vnet.ibm.com>
To: "Carlos O'Donell" <carlos@redhat.com>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 libc-alpha@sourceware.org, linuxppc-dev@lists.ozlabs.org,
 Steve Munroe <munroesj@linux.vnet.ibm.com>
Cc: 
Subject: Re: [PATCH] Add hwcap2 bits for POWER9
References: <568C272D.6000705@linux.vnet.ibm.com>
 <87egdsi4om.fsf@totoro.br.ibm.com>
 <1452267366.5201.12.camel@vnet.ibm.com> <568FE3D0.7080008@linaro.org>
 <87wprgdu3u.fsf@totoro.br.ibm.com> <5693C861.9030308@redhat.com>
Date: Mon, 11 Jan 2016 17:55:37 -0200
In-Reply-To: <5693C861.9030308@redhat.com> (Carlos O'Donell's message of "Mon,
 11 Jan 2016 10:21:05 -0500")
Message-ID: <87bn8revra.fsf@totoro.br.ibm.com>
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

"Carlos O'Donell" <carlos@redhat.com> writes:

> On 01/11/2016 10:16 AM, Tulio Magno Quites Machado Filho wrote:
>> Adhemerval Zanella <adhemerval.zanella@linaro.org> writes:
>> 
>>> On 08-01-2016 13:36, Peter Bergner wrote:
>>>> On Fri, 2016-01-08 at 11:25 -0200, Tulio Magno Quites Machado Filho wrote:
>>>>> Peter, this solves the issue you reported previously [1].
>>>>>
>>>>> [1] https://sourceware.org/ml/libc-alpha/2015-12/msg00522.html
>>>>
>>>> Agreed, thanks.  I'll also add the POWER9 support to the GCC side
>>>> of the patch now that the glibc code is upstream.
>>>
>>> I do not see these bits being added in kernel side yet and GLIBC usual
>>> only sync these kind of bits *after* they are included in kernel side.
>>> So I would advise to either get these pieces (kernel support and hwcap
>>> advertise) in kernel before 2.23 release, otherwise revert the patches.
>> 
>> Ack.
>> It has just been sent to the correspondent Linux mailing list:
>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-January/137763.html
>
> Please revert the changes from glibc until you checkin support to linux
> kernel mainline.
>
> Leaving these bits in increases the risk that someone uses to deploy a glibc
> that then may have the wrong value.

Could you clarify this statement, please?
I fail to see how they could have the wrong value.

These bits are enabled if you're running a kernel on a processor that
supports ISA 3.0 and/or VSX IEEE Float 128-bit.  The kernel must also support
this processor.

I see 3 possible scenarios:
 - Processor that doesn't support these features: as these bits are 0 by
   default, they have the correct value.
 - Both processor and kernel support these features: both bits are set,
   which is the correct value.
 - Processor support these features, but an old kernel doesn't support: these
   bits would be 0.  But, that's a valid scenario.

Am I missing another scenario?

However, I do agree with the concerns raised by Peter and Adhemerval: glibc
should be in sync with the kernel by the time of the release in order to
guarantee both bits are reserved for the exact same goal and we should have
both AT_HWCAP and AT_PLATFORM supporting the new processor.
With that said, I was planning to revert both commits d2de9ef7 and b1f19b8e
if we don't get the kernel patch accepted into the powerpc tree in time for
the release 2.23.

-- 
Tulio Magno
