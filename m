Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 42CC72C00CC
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Oct 2013 15:33:33 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 11 Oct 2013 10:03:30 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 97891394003F
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Oct 2013 10:03:08 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9B4a2gh46661808
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Oct 2013 10:06:02 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9B4XPEQ012513
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Oct 2013 10:03:26 +0530
Message-ID: <52577F5C.6000704@linux.vnet.ibm.com>
Date: Fri, 11 Oct 2013 10:02:28 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc, perf: Configure BHRB filter before enabling
 PMU interrupts
References: <1381120226-14838-1-git-send-email-khandual@linux.vnet.ibm.com>
 <20131008042137.GE31666@concordia> <5253B26E.3020800@linux.vnet.ibm.com>
 <20131009012130.GA23780@concordia> <5254DFA8.2050100@linux.vnet.ibm.com>
 <20131009060321.GB28160@concordia> <52566A4E.2000409@linux.vnet.ibm.com>
 <20131011021131.GA26561@concordia>
In-Reply-To: <20131011021131.GA26561@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/11/2013 07:41 AM, Michael Ellerman wrote:
> On Thu, Oct 10, 2013 at 02:20:22PM +0530, Anshuman Khandual wrote:
>> On 10/09/2013 11:33 AM, Michael Ellerman wrote:
>>> On Wed, Oct 09, 2013 at 10:16:32AM +0530, Anshuman Khandual wrote:
>>>> On 10/09/2013 06:51 AM, Michael Ellerman wrote:
>>>>> On Tue, Oct 08, 2013 at 12:51:18PM +0530, Anshuman Khandual wrote:
>>>>>> On 10/08/2013 09:51 AM, Michael Ellerman wrote:
>>>>>>> On Mon, Oct 07, 2013 at 10:00:26AM +0530, Anshuman Khandual wrote:
>>>>>>>> Right now the `config_bhrb` PMU specific call happens after write_mmcr0
>>>>>>>> which actually enables the PMU for event counting and interrupt. So
>>>>>>>> there is a small window of time where the PMU and BHRB runs without the
>>>>>>>> required HW branch filter (if any) enabled in BHRB. This can cause some
>>>>>>>> of the branch samples to be collected through BHRB without any filter
>>>>>>>> being applied and hence affecting the correctness of the results. This
>>>>>>>> patch moves the BHRB config function call before enabling the interrupts.
>>>>>>>
>>>>>>> Patch looks good.
>>>>>>>
>>>>>>> But it reminds me I have an item in my TODO list:
>>>>>>>  - "Why can't config_bhrb() be done in compute_mmcr()" ?
>>>>>>>
>>>>>>
>>>>>> compute_mmcr() function deals with generic MMCR* configs for normal PMU
>>>>>> events. Even if BHRB config touches MMCRA register, it's configuration
>>>>>> does not interfere with the PMU config for general events. So its best
>>>>>> to keep them separate. 
>>>>>
>>>>> I'm unconvinced. If they'd been together to begin with this bug never
>>>>> would have happened.
>>>>
>>>> This is an ordering of configuration problem. Putting them together in the
>>>> same function does not rule out the chances of this ordering problem. Could
>>>> you please kindly explain how this could have been avoided ?
>>>
>>> The existing code already makes sure to write MMCRA before MMCR0.
>>
>> Thats not true. One example being here at power_pmu_enable function.
>>
>>         write_mmcr0(cpuhw, mmcr0);
>>
>>         /*
>>          * Enable instruction sampling if necessary
>>          */
>>         if (cpuhw->mmcr[2] & MMCRA_SAMPLE_ENABLE) {
>>                 mb();
>>                 mtspr(SPRN_MMCRA, cpuhw->mmcr[2]);
>>         }
> 
> The only example.
> 
> The BHRB config would have been applied prior to that:
> 
> 	mtspr(SPRN_MMCRA, cpuhw->mmcr[2] & ~MMCRA_SAMPLE_ENABLE);
> 	mtspr(SPRN_MMCR1, cpuhw->mmcr[1]);
> 	mtspr(SPRN_MMCR0, (cpuhw->mmcr[0] & ~(MMCR0_PMC1CE | MMCR0_PMCjCE))
> 				| MMCR0_FC);
> 
> 
> So as I said, if the BHRB config was in cpuhw->mmcr[2] then the ordering would
> have been correct.

I got your point. But ...

> 
>> Even I think this is not right. Instruction sampling should have been
>> enabled before we enable PMU interrupts. Else there is a small window
>> of time where we could have the PMU enabled with events (which requires
>> sampling) without the sampling itself being enabled in MMCRA.
> 
> Yes I agree. That's a separate bug, which we'll need to test on all the book3s
> platforms we have perf support for.

Okay, I guess any platform which supports sampling will definitely want to have
it enabled before we can set the events to count on PMU. Can you think of any
problem which can arise if we move it before the enabling the PMU back ? Else
we can fix this easily.
