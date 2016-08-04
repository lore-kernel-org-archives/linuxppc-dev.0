Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4zc44Zf0zDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 04:53:40 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s4zc3587xz9sXR
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Aug 2016 04:53:39 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u74InAE3090602
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 14:53:37 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24kkajufm2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 04 Aug 2016 14:53:37 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 5 Aug 2016 04:53:34 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 909492BB0054
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Aug 2016 04:53:31 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u74IrV5926804276
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Aug 2016 04:53:31 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u74IrUqR022071
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Aug 2016 04:53:31 +1000
Subject: Re: [RESEND][PATCH v2 2/2] powerpc/fadump: parse fadump reserve
 memory size based on memory range
To: Michael Ellerman <mpe@ellerman.id.au>, rusty@rustcorp.com.au,
 ebiederm@xmission.com, vgoyal@redhat.com,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <147025270324.29229.8322429758761407397.stgit@hbathini.in.ibm.com>
 <147025281599.29229.9962999599360876220.stgit@hbathini.in.ibm.com>
 <87h9b0g953.fsf@concordia.ellerman.id.au>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org,
 lkml <linux-kernel@vger.kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 5 Aug 2016 00:23:26 +0530
MIME-Version: 1.0
In-Reply-To: <87h9b0g953.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <ef95923f-56b6-b4f1-94a2-555f7df32629@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Thursday 04 August 2016 03:15 PM, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
> ...
>>   /**
>>    * fadump_calculate_reserve_size(): reserve variable boot area 5% of System RAM
>>    *
>> @@ -212,12 +262,17 @@ static inline unsigned long fadump_calculate_reserve_size(void)
>>   {
>>   	unsigned long size;
>>   
>> +	/* sets fw_dump.reserve_bootvar */
>> +	parse_fadump_reserve_mem();
>> +
>>   	/*
>>   	 * Check if the size is specified through fadump_reserve_mem= cmdline
>>   	 * option. If yes, then use that.
>>   	 */
>>   	if (fw_dump.reserve_bootvar)
>>   		return fw_dump.reserve_bootvar;
>> +	else
>> +		printk(KERN_INFO "fadump: calculating default boot size\n");
>>   
>>   	/* divide by 20 to get 5% of value */
>>   	size = memblock_end_of_DRAM() / 20;
> The code already knows how to reserve 5% based on the size of the machine's
> memory, as long as no commandline parameter is passed. So why can't we
> just use that logic?

Hi Michael,

That is the default value reserved but not a good enough value for
every case. It is a bit difficult to come up with a robust formula
that works for every case as new kernel changes could make the
values obsolete. But it won't be all that difficult to find values that
work for different memory ranges for a given kernel version.
Passing that as range based input with "fadump_reserve_mem"
parameter would work for every memory configuration on a
given system, which is what this patch is trying to provide..

Thanks
Hari


> cheers
>
