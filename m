Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSmdt65HjzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 16:49:22 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1M5msBR019841
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 00:49:20 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28rv2s9qbc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 00:49:20 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 22:49:19 -0700
Subject: Re: [PATCH] powerpc/mm: Add translation mode information in
 /proc/cpuinfo
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
 paulus@samba.org
References: <1487499469-15284-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <874lzmn5h1.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 22 Feb 2017 11:19:10 +0530
MIME-Version: 1.0
In-Reply-To: <874lzmn5h1.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <8ec533a5-daf6-4644-ffea-e940fe3e77f9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 22 February 2017 11:15 AM, Michael Ellerman wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>
>> With this we have on powernv and pseries /proc/cpuinfo reporting
>>
>> timebase        : 512000000
>> platform        : PowerNV
>> model           : 8247-22L
>> machine         : PowerNV 8247-22L
>> firmware        : OPAL
>> translation     : Hash
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/platforms/powernv/setup.c | 4 ++++
>>   arch/powerpc/platforms/pseries/setup.c | 4 ++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
>> index d50c7d99baaf..d38571e289bb 100644
>> --- a/arch/powerpc/platforms/powernv/setup.c
>> +++ b/arch/powerpc/platforms/powernv/setup.c
>> @@ -95,6 +95,10 @@ static void pnv_show_cpuinfo(struct seq_file *m)
>>   	else
>>   		seq_printf(m, "firmware\t: BML\n");
>>   	of_node_put(root);
>> +	if (radix_enabled())
>> +		seq_printf(m, "translation\t: Radix\n");
>> +	else
>> +		seq_printf(m, "translation\t: Hash\n");
>>   }
> Can we just call it "MMU" ?
>
> I don't think it's entirely clear what "translation" means here if you
> don't already know.
>
> cheers
>
I avoided using MMU, because it will confuse hardware guys. Radix is not 
clearly the full definition of
Memory management unit, but rather the translation mode used by memory 
management unit. But
i don't have strong opinion on this.

Do you want me to send an updated patch ? or you can update it when you 
apply it to your tree ?

-aneesh
