Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yY1wr0KqyzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 12:02:51 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAA11f6H082573
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Nov 2017 20:02:49 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e4wb8m40v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Nov 2017 20:02:48 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 10 Nov 2017 01:02:46 -0000
Subject: Re: [PATCH] powerpc/powernv: Fix IMC_MAX_PMU macro
To: Michael Ellerman <mpe@ellerman.id.au>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1510229426-5547-1-git-send-email-anju@linux.vnet.ibm.com>
 <877euzp3mo.fsf@concordia.ellerman.id.au>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 06:32:41 +0530
MIME-Version: 1.0
In-Reply-To: <877euzp3mo.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6429f614-ab35-3c7f-6bfd-1f9f59545bbb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 10 November 2017 02:32 AM, Michael Ellerman wrote:
> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
>
>> IMC_MAX_PMU is used for static storage (per_nest_pmu_arr) which holds
>> nest pmu information. Current value for the macro is 32 based on
>> the initial number of nest pmu units supported by the nest microcode.
>> Currently 29 nest units are enabled based on the system configuration.
>> But going forward, microcode could support more nest units (max of 64
>> nest units). Hence fix the value for the macro.
> There should be no reason to have a hard coded limit.
>
> We should just fix the code to dynamically size the array based on
> what's found in the device tree.

Yes. My bad. Device tree handling part is done in the
platform/powernv side and this data (total number of nest pmus)
can be extended from there. Will work on it.

Thanks for review comments.
Maddy

>
> cheers
>
>> Fixes:8f95faaac56c1 ('powerpc/powernv: Detect and create IMC device')
>> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/imc-pmu.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/imc-pmu.h b/arch/powerpc/include/asm/imc-pmu.h
>> index 7f74c28..f9f0f2e 100644
>> --- a/arch/powerpc/include/asm/imc-pmu.h
>> +++ b/arch/powerpc/include/asm/imc-pmu.h
>> @@ -23,7 +23,7 @@
>>   /*
>>    * For static allocation of some of the structures.
>>    */
>> -#define IMC_MAX_PMUS			32
>> +#define IMC_MAX_PMUS			64
>>   
>>   /*
>>    * Compatibility macros for IMC devices
>> -- 
>> 2.7.4
