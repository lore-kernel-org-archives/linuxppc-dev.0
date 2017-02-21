Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSMFz3PXDzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 00:45:43 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1LDjeRG113013
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 08:45:41 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r3prkr8t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 08:45:40 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 06:45:03 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D82B33E40030
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 06:45:01 -0700 (MST)
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1LDj1qm13500910
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 06:45:01 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B75E06E050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 06:45:01 -0700 (MST)
Received: from oc5780617838.ibm.com (unknown [9.10.86.34])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP id 978DD6E038
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 06:45:01 -0700 (MST)
Subject: Re: [PATCH 1/1] powerpc/xmon: Dump memory in native endian format.
To: linuxppc-dev@lists.ozlabs.org
References: <1486474844-9872-1-git-send-email-dougmill@linux.vnet.ibm.com>
 <87shn8m925.fsf@concordia.ellerman.id.au>
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 07:45:01 -0600
MIME-Version: 1.0
In-Reply-To: <87shn8m925.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <69f48978-207c-cf01-58ad-117d1fe8ae59@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/20/2017 11:01 PM, Michael Ellerman wrote:
> Douglas Miller <dougmill@linux.vnet.ibm.com> writes:
>
>> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>> index 9c0e17c..6249975 100644
>> --- a/arch/powerpc/xmon/xmon.c
>> +++ b/arch/powerpc/xmon/xmon.c
>> @@ -2334,9 +2338,49 @@ static void dump_pacas(void)
>>   }
>>   #endif
>>   
>> +static void dump_by_size(unsigned long addr, long count, int size)
>> +{
>> +	unsigned char temp[16];
>> +	int i, j;
>> +	u64 val;
>> +
>> +	/*
>> +	 * 'count' was aligned 16. If that changes, the following
>> +	 * must also change to accommodate other values for 'count'.
>> +	 */
>> +	for (i = 0; i < count; i += 16, addr += 16) {
>> +		printf(REG, addr);
>> +
>> +		if (mread(addr, temp, 16) != 16) {
>> +			printf("Faulted reading %d bytes from 0x"REG"\n", 16, addr);
>> +			return;
>> +		}
>> +
>> +		for (j = 0; j < 16; j += size) {
>> +			putchar(' ');
>> +			switch (size) {
>> +			case 1: val = temp[j]; break;
>> +			case 2: val = *(u16 *)&temp[j]; break;
>> +			case 4: val = *(u32 *)&temp[j]; break;
>> +			case 8: val = *(u64 *)&temp[j]; break;
>> +			default: val = 0;
>> +			}
>> +
>> +			printf("%0*lx", size * 2, val);
>> +		}
>> +		printf("  |");
>> +		for (j = 0; j < 16; ++j) {
>> +			val = temp[j];
>> +			putchar(' ' <= val && val <= '~' ? val : '.');
>> +		}
>> +		printf("|\n");
> I know the ascii dump looks nice, but I think it's misleading. Which is
> why I omitted it from my version.
>
> eg.
>
> 0:mon> d $__kstrtab_init_task
> c000000000c03ebe 696e69745f746173 6b006d6d755f6665  |init_task.mmu_fe|
> c000000000c03ece 61747572655f6b65 7973006370755f66  |ature_keys.cpu_f|
> c000000000c03ede 6561747572655f6b 657973006375725f  |eature_keys.cur_|
> c000000000c03eee 6370755f73706563 00766972715f746f  |cpu_spec.virq_to|
>
> 0:mon> d8 $__kstrtab_init_task
> c000000000c03ebe 7361745f74696e69 65665f756d6d006b  |init_task.mmu_fe|
> c000000000c03ece 656b5f6572757461 665f757063007379  |ature_keys.cpu_f|
> c000000000c03ede 6b5f657275746165 5f72756300737965  |eature_keys.cur_|
> c000000000c03eee 636570735f757063 6f745f7172697600  |cpu_spec.virq_to|
>
>
> That second dump says at c000000000c03ebe there is a byte with the value
> 0x73, which prints as 'i' - but that's false.
>
>
> So I've dropped the ascii printing for now because I want to sneak this
> in to v4.11.
>
> If you want to send a follow-up patch to do the ascii byte reversed that
> would be nice.
>
> cheers
>
I would disagree, anything printed as bytes should be in only one order 
- the order it exists in memory. I maintain that the ascii dump is 
correctly printed. The purpose of an ascii dump like this is to show 
what is in memory. ASCII in memory has only one order.

Thanks,
Doug
