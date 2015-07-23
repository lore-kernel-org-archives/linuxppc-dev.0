Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EA8B1A0066
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 19:24:22 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 23 Jul 2015 14:54:17 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id EFEDBE0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 14:58:11 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6N9O6Up48037974
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 14:54:07 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6N82pMd032150
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 13:32:52 +0530
Message-ID: <55B0B2A0.30404@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2015 14:53:44 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v5 4/7] powerpc/powernv: detect supported nest pmus and
 its events
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-5-git-send-email-maddy@linux.vnet.ibm.com>
 <1437538064.30906.20.camel@axtens.net> <55B083A2.4030404@linux.vnet.ibm.com>
 <1437642672.29271.2.camel@ellerman.id.au>
In-Reply-To: <1437642672.29271.2.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 23 July 2015 02:41 PM, Michael Ellerman wrote:
> On Thu, 2015-07-23 at 11:33 +0530, Madhavan Srinivasan wrote:
>> On Wednesday 22 July 2015 09:37 AM, Daniel Axtens wrote:
>>>  
>>>>  static struct perchip_nest_info p8_nest_perchip_info[P8_NEST_MAX_CHIPS];
>>>> +static struct nest_pmu *per_nest_pmu_arr[P8_NEST_MAX_PMUS];
>>>> +
>>>> +static int nest_event_info(struct property *pp, char *name,
>>>> +			struct nest_ima_events *p8_events, int string, u32 val)
>>> 'int string' is a bit confusing. 'bool is_string' might be clearer, but
>>> I think it would be even better still to have different functions for
>>> string and non-string cases, especially because you only need val in the
>>> non-string case.
>> I would perfer to be a single function, since most of the code is same
>> just of the sting or val part. yes. We can make is as is_string and will
>> add comment explaining what is done here? 
> I think Daniel's right, it would be better as two functions.
>
> The only part that is common after the if (string) check is the
> p8_events->ev_value = buf assignment.
>
> So you should be able to keep all the code up to the if (string) check in a
> shared function and just have two wrappers that use it.
>
> cheers

Sure. Will do.

Maddy

>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
