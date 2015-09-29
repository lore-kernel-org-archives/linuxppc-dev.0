Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 770AA1A0A20
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 05:20:05 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 05:20:03 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CCF422CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 05:20:00 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8TJJqDg31523002
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 05:20:00 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8TJJQwi021080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 05:19:28 +1000
Message-ID: <560AE486.2030500@linux.vnet.ibm.com>
Date: Wed, 30 Sep 2015 00:50:38 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
CC: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 anton@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, cl@linux.com, gkurz@linux.vnet.ibm.com,
 grant.likely@linaro.org, nikunj@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com
Subject: Re: [PATCH RFC 3/5] powerpc:numa create 1:1 mappaing between chipid
 and nid
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1443378553-2146-4-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <20150928173529.GF48470@linux.vnet.ibm.com>
In-Reply-To: <20150928173529.GF48470@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/28/2015 11:05 PM, Nishanth Aravamudan wrote:
> On 27.09.2015 [23:59:11 +0530], Raghavendra K T wrote:
>> Once we have made the distinction between nid and chipid
>> create a 1:1 mapping between them. This makes compacting the
>> nids easy later.
>>
>> No functionality change.
>>
>> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/mm/numa.c | 36 +++++++++++++++++++++++++++++-------
>>   1 file changed, 29 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index f84ed2f..dd2073b 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -264,6 +264,17 @@ out:
>>   	return chipid;
>>   }
>>
>> +
>> + /* Return the nid from associativity */
>> +static int associativity_to_nid(const __be32 *associativity)
>> +{
>> +	int nid;
>> +
>> +	nid = associativity_to_chipid(associativity);
>> +	return nid;
>> +}
>
> This is ultimately confusing. You are assigning the semantic return
> value of a chipid to a nid -- is it a nid or a chipid? Shouldn't the
> variable naming be consistent?
>

:( yes. will come up with some consistent naming.
