Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vST9s6FJdzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 05:12:33 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vST9s0vgvz9s7M
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Feb 2017 05:12:32 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1LI8dXI050756
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 13:12:31 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28rt2chkg2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 13:12:30 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 22 Feb 2017 04:12:28 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C67202CE8046
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Feb 2017 05:12:25 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1LICHYa46923808
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Feb 2017 05:12:25 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1LIBrYH008156
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Feb 2017 05:11:53 +1100
Subject: Re: [PATCH] powerpc/fadump: set an upper limit for boot memory size
To: Michael Ellerman <mpe@ellerman.id.au>
References: <148717255648.1711.9357297790070400059.stgit@hbathini.in.ibm.com>
 <87efyxjpx0.fsf@concordia.ellerman.id.au>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 23:41:34 +0530
MIME-Version: 1.0
In-Reply-To: <87efyxjpx0.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <88b69843-0c26-6821-eb8f-1dffb40ecd09@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,


On Friday 17 February 2017 11:54 AM, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index de7d39a..d5107f4 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -222,6 +222,18 @@ static inline unsigned long fadump_calculate_reserve_size(void)
>>   				&size, &base);
>>   	if (ret == 0 && size > 0) {
>>   		fw_dump.reserve_bootvar = (unsigned long)size;
>> +		/*
>> +		 * Adjust if the boot memory size specified is above
>> +		 * the upper limit.
>> +		 */
>> +		if (fw_dump.reserve_bootvar >
>> +		    (memblock_end_of_DRAM() / MAX_BOOT_MEM_RATIO)) {
> Using memblock_end_of_DRAM() doesn't take into account the fact that you
> might have holes in your memory layout.
>
> Possibly on PowerVM that never happens, but I don't think we should
> write the code to assume that, if possible.
>

I think memblock_phys_mem_size() can fill in..

In the same file, memblock_end_of_DRAM() is also used when nothing
is specified through cmdline. Let me also change that and respin..

Thanks
Hari
