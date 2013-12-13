Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 394552C009C
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Dec 2013 17:48:12 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 13 Dec 2013 12:18:07 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2C5BDE0056
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Dec 2013 12:20:24 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBD6lwU153412088
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Dec 2013 12:17:58 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBD6m1JB030896
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Dec 2013 12:18:01 +0530
Message-ID: <52AAAD5E.9070705@linux.vnet.ibm.com>
Date: Fri, 13 Dec 2013 12:16:54 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc, perf: Configure BHRB filter before enabling
 PMU interrupts
References: <1381120226-14838-1-git-send-email-khandual@linux.vnet.ibm.com>
 <20131008042137.GE31666@concordia> <5253B26E.3020800@linux.vnet.ibm.com>
 <20131009012130.GA23780@concordia> <5254DFA8.2050100@linux.vnet.ibm.com>
 <20131009060321.GB28160@concordia> <52566A4E.2000409@linux.vnet.ibm.com>
 <20131011021131.GA26561@concordia> <52577F5C.6000704@linux.vnet.ibm.com>
 <20131014061958.GA8300@concordia> <525E166C.5070407@linux.vnet.ibm.com>
In-Reply-To: <525E166C.5070407@linux.vnet.ibm.com>
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

On 10/16/2013 10:00 AM, Anshuman Khandual wrote:
> On 10/14/2013 11:49 AM, Michael Ellerman wrote:
>> On Fri, Oct 11, 2013 at 10:02:28AM +0530, Anshuman Khandual wrote:
>>> On 10/11/2013 07:41 AM, Michael Ellerman wrote:
>>>> On Thu, Oct 10, 2013 at 02:20:22PM +0530, Anshuman Khandual wrote:
>>>>
>>>>> Even I think this is not right. Instruction sampling should have been
>>>>> enabled before we enable PMU interrupts. Else there is a small window
>>>>> of time where we could have the PMU enabled with events (which requires
>>>>> sampling) without the sampling itself being enabled in MMCRA.
>>>>
>>>> Yes I agree. That's a separate bug, which we'll need to test on all the book3s
>>>> platforms we have perf support for.
>>>
>>> Okay, I guess any platform which supports sampling will definitely want to have
>>> it enabled before we can set the events to count on PMU. Can you think of any
>>> problem which can arise if we move it before the enabling the PMU back ? Else
>>> we can fix this easily.
>>
>> In theory it should be a trivial change. But hardware can behave in
>> strange ways, it's possible on some old chip we need to do it the
>> current way for some reason.
>>
>> So although I don't think it will be a problem, it could be, so we
>> will need to test it thoroughly.
> 
> So which are the HW chips, you would like to test this fix for possible problems ? 
> 

Michael,
	Any updates on this patch ?
