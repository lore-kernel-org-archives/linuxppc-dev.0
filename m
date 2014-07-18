Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 86B8C1A0025
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 18:14:09 +1000 (EST)
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8643A140116
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2014 18:14:08 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 18 Jul 2014 13:44:01 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id B3199125804F
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2014 13:43:46 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6I8Fc5f47316996
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2014 13:45:38 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6I8Dqda032520
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2014 13:43:54 +0530
Message-ID: <53C8D740.80406@linux.vnet.ibm.com>
Date: Fri, 18 Jul 2014 13:43:52 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH V3 0/3] Add new PowerPC specific ELF core notes
References: <1400858138-3939-1-git-send-email-khandual@linux.vnet.ibm.com>
 <53996E41.4070309@linux.vnet.ibm.com> <53C7A4FA.4030600@linux.vnet.ibm.com>
 <1405595380.25310.21.camel@pasglop>
 <CAEjGV6yK_9DS1cLQ2BH=HFi029N8rz-4Wyvwzdb_gy6PnJgbwg@mail.gmail.com>
 <53C85AE6.7080600@au1.ibm.com>
In-Reply-To: <53C85AE6.7080600@au1.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>,
 Pedro Alves <palves@redhat.com>, oleg@redhat.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dhowells@redhat.com,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, davej@redhat.com,
 akpm@linux-foundation.org, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/18/2014 04:53 AM, Sam Bobroff wrote:
> On 17/07/14 21:14, Michael Neuling wrote:
>>
>> On Jul 17, 2014 9:11 PM, "Benjamin Herrenschmidt"
>> <benh@kernel.crashing.org <mailto:benh@kernel.crashing.org>> wrote:
>>>
>>>>>
>>>>>> Outstanding Issues
>>>>>> ==================
>>>>>> (1) Running DSCR register value inside a transaction does not
>> seem to be saved
>>>>>>     at thread.dscr when the process stops for ptrace examination.
>>>>>
>>>>> Hey Ben,
>>>>>
>>>>> Any updates on this patch series ?
>>>>
>>>> Ben,
>>>>
>>>> Any updates on this patch series ?
>>>
>>> I haven't had a chance to review yet, I was hoping somebody else would..
>>>
>>> Have you made any progress vs. the DSCR outstanding issue mentioned
>>> above ?
>>
>> The DSCR issue should be resolved with Sam Bobroff's recent  DSCR
>> fixes.  I've not tested them though.
>>
>> Actually... Sam did you review this series?
>>
>> Mikey
>>
> 
> I did, and applying "powerpc: Correct DSCR during TM context switch"
> corrected the DSCR value in the test program (the one in the patch notes
> for this series).
> 
> (In fact, IIRC, the reason for my patch set was the bug exposed by this
> one ;-)

Yeah the test program worked correctly with the fix from Sam. The first patch
is a generic code change which Pedro had reviewed before. The second and third
patches are powerpc specific.
