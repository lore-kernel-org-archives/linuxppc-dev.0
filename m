Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A4A02C00B3
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Oct 2013 15:47:37 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 9 Oct 2013 10:17:34 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id AA83A125803F
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Oct 2013 10:17:52 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r994o3ng31064164
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Oct 2013 10:20:04 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r994lS2n008439
 for <linuxppc-dev@ozlabs.org>; Wed, 9 Oct 2013 10:17:29 +0530
Message-ID: <5254DFA8.2050100@linux.vnet.ibm.com>
Date: Wed, 09 Oct 2013 10:16:32 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc, perf: Configure BHRB filter before enabling
 PMU interrupts
References: <1381120226-14838-1-git-send-email-khandual@linux.vnet.ibm.com>
 <20131008042137.GE31666@concordia> <5253B26E.3020800@linux.vnet.ibm.com>
 <20131009012130.GA23780@concordia>
In-Reply-To: <20131009012130.GA23780@concordia>
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

On 10/09/2013 06:51 AM, Michael Ellerman wrote:
> On Tue, Oct 08, 2013 at 12:51:18PM +0530, Anshuman Khandual wrote:
>> On 10/08/2013 09:51 AM, Michael Ellerman wrote:
>>> On Mon, Oct 07, 2013 at 10:00:26AM +0530, Anshuman Khandual wrote:
>>>> Right now the `config_bhrb` PMU specific call happens after write_mmcr0
>>>> which actually enables the PMU for event counting and interrupt. So
>>>> there is a small window of time where the PMU and BHRB runs without the
>>>> required HW branch filter (if any) enabled in BHRB. This can cause some
>>>> of the branch samples to be collected through BHRB without any filter
>>>> being applied and hence affecting the correctness of the results. This
>>>> patch moves the BHRB config function call before enabling the interrupts.
>>>
>>> Patch looks good.
>>>
>>> But it reminds me I have an item in my TODO list:
>>>  - "Why can't config_bhrb() be done in compute_mmcr()" ?
>>>
>>
>> compute_mmcr() function deals with generic MMCR* configs for normal PMU
>> events. Even if BHRB config touches MMCRA register, it's configuration
>> does not interfere with the PMU config for general events. So its best
>> to keep them separate. 
> 
> I'm unconvinced. If they'd been together to begin with this bug never
> would have happened.

This is an ordering of configuration problem. Putting them together in the
same function does not rule out the chances of this ordering problem. Could
you please kindly explain how this could have been avoided ?

> 
> And there's the added overhead of another indirect function call.
>

This overhead should be minimal given the fact that we already call so
many PMU specific indirect calls. BHRB is a different part of the PMU
hardware, so a separate call for this purpose is not a bad idea. AFAIK,
X86 does that too for LBR. But yes it is debatable.

>> Besides, we can always look at these code consolidation
>> issues in future. 
> 
> The future is now.

What I meant was functional correctness has always more priority than
code consolidation efforts. Yes I will look into this after book3s
software branch filtering code has been merged.

> 
>> But this patch solves a problem which is happening right now.
> 
> Sure, I'm not saying we shouldn't merge it as a fix. But I think we
> should do the cleanup to move it into compute_mmcr() for 3.13.

yeah that sounds reasonable.

Regards
Anshuman
