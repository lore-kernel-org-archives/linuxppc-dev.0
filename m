Return-Path: <carlos@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 146FE1A0D35
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 07:48:53 +1100 (AEDT)
Subject: Re: [PATCH] Add hwcap2 bits for POWER9
To: Tulio Magno Quites Machado Filho <tuliom@linux.vnet.ibm.com>
References: <568C272D.6000705@linux.vnet.ibm.com>
 <87egdsi4om.fsf@totoro.br.ibm.com> <1452267366.5201.12.camel@vnet.ibm.com>
 <568FE3D0.7080008@linaro.org> <87wprgdu3u.fsf@totoro.br.ibm.com>
 <5693C861.9030308@redhat.com> <87bn8revra.fsf@totoro.br.ibm.com>
Cc: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 libc-alpha@sourceware.org, linuxppc-dev@lists.ozlabs.org,
 Steve Munroe <munroesj@linux.vnet.ibm.com>
From: "Carlos O'Donell" <carlos@redhat.com>
Message-ID: <56941532.9030800@redhat.com>
Date: Mon, 11 Jan 2016 15:48:50 -0500
MIME-Version: 1.0
In-Reply-To: <87bn8revra.fsf@totoro.br.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/11/2016 02:55 PM, Tulio Magno Quites Machado Filho wrote:
> "Carlos O'Donell" <carlos@redhat.com> writes:
> 
>> On 01/11/2016 10:16 AM, Tulio Magno Quites Machado Filho wrote:
>>> Adhemerval Zanella <adhemerval.zanella@linaro.org> writes:
>>>
>>>> On 08-01-2016 13:36, Peter Bergner wrote:
>>>>> On Fri, 2016-01-08 at 11:25 -0200, Tulio Magno Quites Machado Filho wrote:
>>>>>> Peter, this solves the issue you reported previously [1].
>>>>>>
>>>>>> [1] https://sourceware.org/ml/libc-alpha/2015-12/msg00522.html
>>>>>
>>>>> Agreed, thanks.  I'll also add the POWER9 support to the GCC side
>>>>> of the patch now that the glibc code is upstream.
>>>>
>>>> I do not see these bits being added in kernel side yet and GLIBC usual
>>>> only sync these kind of bits *after* they are included in kernel side.
>>>> So I would advise to either get these pieces (kernel support and hwcap
>>>> advertise) in kernel before 2.23 release, otherwise revert the patches.
>>>
>>> Ack.
>>> It has just been sent to the correspondent Linux mailing list:
>>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-January/137763.html
>>
>> Please revert the changes from glibc until you checkin support to linux
>> kernel mainline.
>>
>> Leaving these bits in increases the risk that someone uses to deploy a glibc
>> that then may have the wrong value.
> 
> Could you clarify this statement, please?
> I fail to see how they could have the wrong value.

Until it is checked into the mainline kernel it is not canonical.

That's the rule. There are no other discussions to be had.

The single rule avoids discussions like "it can never be wrong because that's
what our ABI says it is."
 
> However, I do agree with the concerns raised by Peter and Adhemerval: glibc
> should be in sync with the kernel by the time of the release in order to
> guarantee both bits are reserved for the exact same goal and we should have
> both AT_HWCAP and AT_PLATFORM supporting the new processor.
> With that said, I was planning to revert both commits d2de9ef7 and b1f19b8e
> if we don't get the kernel patch accepted into the powerpc tree in time for
> the release 2.23.

Exactly. That's perfect. We can backport them to 2.23.1 if you get in later.

Cheers,
Carlos.
 
