Return-Path: <shriyak@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7nFQ4Z8nzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 22:18:34 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v96BEHw3065488
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 07:18:32 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2de48rn3u3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Oct 2017 07:18:31 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shriyak@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 07:18:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 06 Oct 2017 16:52:48 +0530
From: shriyak <shriyak@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org, ego@linux.vnet.ibm.com, mikey@neuling.org,
 aneesh.kumar@linux.vnet.ibm.com, Linuxppc-dev
 <linuxppc-dev-bounces+shriyak=linux.vnet.ibm.com@lists.ozlabs.org>
Subject: Re: [PATCH] cpufreq: powernv: Return the actual CPU frequency in
 /proc/cpuinfo
In-Reply-To: <87mv544lgz.fsf@concordia.ellerman.id.au>
References: <1507274648-14221-1-git-send-email-shriyak@linux.vnet.ibm.com>
 <87mv544lgz.fsf@concordia.ellerman.id.au>
Message-Id: <d88b1fb751964b14977a4281369de122@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017-10-06 16:00, Michael Ellerman wrote:
> Shriya <shriyak@linux.vnet.ibm.com> writes:
> 
>> Make /proc/cpuinfo read the frequency of the CPU it is running at
>> instead of reading the cached value of the last requested frequency.
>> In conditions like WOF/throttle CPU can be running at a different
>> frequency than the requested frequency.
> 
> Sounds like a bug fix to me ?
> 
> cheers
> 
>> diff --git a/arch/powerpc/platforms/powernv/setup.c 
>> b/arch/powerpc/platforms/powernv/setup.c
>> index 897aa14..55ea4bf 100644
>> --- a/arch/powerpc/platforms/powernv/setup.c
>> +++ b/arch/powerpc/platforms/powernv/setup.c
>> @@ -311,7 +311,7 @@ static unsigned long pnv_get_proc_freq(unsigned 
>> int cpu)
>>  {
>>  	unsigned long ret_freq;
>> 
>> -	ret_freq = cpufreq_quick_get(cpu) * 1000ul;
>> +	ret_freq = cpufreq_get(cpu) * 1000ul;
>> 
>>  	/*
>>  	 * If the backend cpufreq driver does not exist,
>> --
>> 1.9.1

Yes, its a bug fix.

Thanks.
