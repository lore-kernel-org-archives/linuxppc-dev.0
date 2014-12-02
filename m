Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5ED21A0C7A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 17:51:40 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 2 Dec 2014 12:21:34 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6ECB9E0053
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 12:22:01 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB26q9S942860628
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Dec 2014 12:22:09 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB26pWTB002547
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Dec 2014 12:21:32 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/mm: don't do tlbie for updatepp request with
 NO HPTE fault
In-Reply-To: <1417478377.7182.17.camel@kernel.crashing.org>
References: <1415026295-25965-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1415026295-25965-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1417478377.7182.17.camel@kernel.crashing.org>
Date: Tue, 02 Dec 2014 12:21:24 +0530
Message-ID: <87ppc2h7df.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2014-11-03 at 20:21 +0530, Aneesh Kumar K.V wrote:
>> --- a/arch/powerpc/mm/hash_native_64.c
>> +++ b/arch/powerpc/mm/hash_native_64.c
>> @@ -283,11 +283,11 @@ static long native_hpte_remove(unsigned long hpte_group)
>>  
>>  static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
>>                                  unsigned long vpn, int bpsize,
>> -                                int apsize, int ssize, int local)
>> +                                int apsize, int ssize, unsigned long flags)
>>  {
>>         struct hash_pte *hptep = htab_address + slot;
>>         unsigned long hpte_v, want_v;
>> -       int ret = 0;
>> +       int ret = 0, local = 0;
>>  
>>         want_v = hpte_encode_avpn(vpn, bpsize, ssize);
>>  
>> @@ -322,8 +322,15 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
>>                 }
>>                 native_unlock_hpte(hptep);
>>         }
>> -       /* Ensure it is out of the tlb too. */
>> -       tlbie(vpn, bpsize, apsize, ssize, local);
>> +
>> +       if (flags & HPTE_LOCAL_UPDATE)
>> +               local = 1;
>> +       /*
>> +        * Ensure it is out of the tlb too if it is not a nohpte fault
>> +        */
>> +       if (!(flags & HPTE_NOHPTE_UPDATE))
>> +               tlbie(vpn, bpsize, apsize, ssize, local);
>> +
>>         return ret;
>>  }
>
> An additional refinement we discussed that I'd like you to test/measure
> is to basically always be local for updatepp unless we have a flag that
> forces us not to.
>
> That flag would be set by copro faults only.
>
> Can you do something on top of this series ?

Yes. Will try that out.

-aneesh
