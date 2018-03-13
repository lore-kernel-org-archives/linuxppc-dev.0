Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 400kKf0QXnzDrLF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 16:43:14 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2D5dpfh095776
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 01:43:11 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gp1b1cu61-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 01:43:11 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 13 Mar 2018 01:43:10 -0400
Subject: Re: [PATCH v3] powerpc/kernel/sysfs: Export ldbar spr to sysfs
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com
References: <1510232445-10869-1-git-send-email-anju@linux.vnet.ibm.com>
 <878tb5foqk.fsf@concordia.ellerman.id.au>
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Tue, 13 Mar 2018 11:13:05 +0530
MIME-Version: 1.0
In-Reply-To: <878tb5foqk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <dba1f760-2073-f7e0-148f-370f5ead4e76@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,


On Tuesday 06 March 2018 04:35 PM, Michael Ellerman wrote:
> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
>
>> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
>> index 4437c70..caefb64 100644
>> --- a/arch/powerpc/kernel/sysfs.c
>> +++ b/arch/powerpc/kernel/sysfs.c
>> @@ -757,6 +759,9 @@ static int register_cpu_online(unsigned int cpu)
>>   			device_create_file(s, &pmc_attrs[i]);
>>   
>>   #ifdef CONFIG_PPC64
>> +	if (cpu_has_feature(CPU_FTR_ARCH_300))
>> +		device_create_file(s, &dev_attr_ldbar);
> Is this register readable in supervisor state?

This is a nice catch, thanks. :)
The guest kernel can not access the register, it is only readable in the 
hypervisor state.
I will resend the patch with a condition check so that this spr will not 
get registered for guest kernel.


Regards,
Anju
>
> cheers
>
