Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3496A1A0B35
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 04:30:33 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 04:30:31 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3ED33357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 04:30:28 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8TIU9XI53477488
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 04:30:17 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8TITsrK013684
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 04:29:55 +1000
Message-ID: <560AD8E5.1000001@linux.vnet.ibm.com>
Date: Wed, 30 Sep 2015 00:01:01 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
CC: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 anton@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, cl@linux.com, gkurz@linux.vnet.ibm.com,
 grant.likely@linaro.org, nikunj@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: [PATCH RFC  2/5] powerpc:numa Rename functions referring to nid
 as chipid
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1443378553-2146-3-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <20150928172702.GB48470@linux.vnet.ibm.com>
In-Reply-To: <20150928172702.GB48470@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/28/2015 10:57 PM, Nishanth Aravamudan wrote:
> On 27.09.2015 [23:59:10 +0530], Raghavendra K T wrote:
>> There is no change in the fuctionality
>>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/mm/numa.c | 42 +++++++++++++++++++++---------------------
>>   1 file changed, 21 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index d5e6eee..f84ed2f 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -235,47 +235,47 @@ static void initialize_distance_lookup_table(int nid,
>>   	}
>>   }
>>
>> -/* Returns nid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
>> +/* Returns chipid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
>>    * info is found.
>>    */
>> -static int associativity_to_nid(const __be32 *associativity)
>> +static int associativity_to_chipid(const __be32 *associativity)
>
> This is confusing to me. This function is also used by the DLPAR code
> under PowerVM to indicate what node the CPU is on -- not a chip (which I
> don't believe is exposed at all under PowerVM).
>

Good point.

should I retain the name nid?
or any suggestions? instead of chipid -> nid which fits both the cases.
or should I rename like nid->vnid  something?
[...]
>> @@ -1415,7 +1415,7 @@ int arch_update_cpu_topology(void)
>>
>>   		/* Use associativity from first thread for all siblings */
>>   		vphn_get_associativity(cpu, associativity);
>> -		new_nid = associativity_to_nid(associativity);
>> +		new_nid = associativity_to_chipid(associativity);
>
> If you are getting a chipid, shouldn't you be assigning it to a variable
> called 'new_chipid'?

yes perhaps.
my splitting idea was
1. change nid name in functions to chipid (without changing nid
variable calling that function)
2. rename variables to chipid and assign nid=chipid (1:1 mapping)
3. now let nid = mapped chipid

But I see that it isn't consistent in some places. do you think
merging step 1 and step 2 is okay?
