Return-Path: <srs0=ib65=kz=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41n1dy5MG9zDrtm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 20:32:22 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41n1dy3nZ3z8tBY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 20:32:22 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41n1dx1XpMz9s7Q
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2018 20:32:20 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7AAOO2N114085
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2018 06:32:19 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ks6h7wryr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2018 06:32:18 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 10 Aug 2018 11:32:16 +0100
Subject: Re: [PATCH v7 7/9] powerpc/pseries: Dump the SLB contents on SLB MCE
 errors.
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, Ananth Narayan <ananth@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365145460.14256.11932687379471923123.stgit@jupiter.in.ibm.com>
 <87lg9g9wnd.fsf@concordia.ellerman.id.au>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 10 Aug 2018 16:02:12 +0530
MIME-Version: 1.0
In-Reply-To: <87lg9g9wnd.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <39ebc2b1-0139-2946-2d9b-1b7998bd4560@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2018 06:35 AM, Michael Ellerman wrote:
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> 
>> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
>> index 7f22929ce915..233d25ff6f64 100644
>> --- a/arch/powerpc/include/asm/paca.h
>> +++ b/arch/powerpc/include/asm/paca.h
>> @@ -254,6 +254,10 @@ struct paca_struct {
>>  #endif
>>  #ifdef CONFIG_PPC_PSERIES
>>  	u8 *mce_data_buf;		/* buffer to hold per cpu rtas errlog */
>> +
>> +	/* Capture SLB related old contents in MCE handler. */
>> +	struct slb_entry *mce_faulty_slbs;
>> +	u16 slb_save_cache_ptr;
>>  #endif /* CONFIG_PPC_PSERIES */
> 
>              ^^^^^^^^^^^^^^^^^

I will pull that out of CONFIG_PPC_PSERIES.

> 
>> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
>> index e89f675f1b5e..16a53689ffd4 100644
>> --- a/arch/powerpc/mm/slb.c
>> +++ b/arch/powerpc/mm/slb.c
>> @@ -151,6 +151,79 @@ void slb_flush_and_rebolt_realmode(void)
>>  	get_paca()->slb_cache_ptr = 0;
>>  }
>>  
>> +void slb_save_contents(struct slb_entry *slb_ptr)
>> +{
>> +	int i;
>> +	unsigned long e, v;
>> +
>> +	/* Save slb_cache_ptr value. */
>> +	get_paca()->slb_save_cache_ptr = get_paca()->slb_cache_ptr;
> 
> This isn't inside CONFIG_PPC_PSERIES which breaks lots of configs, eg
> powernv.
> 
>   arch/powerpc/mm/slb.c:160:12: error: 'struct paca_struct' has no member named 'slb_save_cache_ptr'
>   arch/powerpc/mm/slb.c:218:27: error: 'struct paca_struct' has no member named 'slb_save_cache_ptr'
>   arch/powerpc/mm/slb.c:216:49: error: 'struct paca_struct' has no member named 'slb_save_cache_ptr'
> 
> http://kisskb.ozlabs.ibm.com/kisskb/head/219f20e490add009194d94fdeb480da2e385f1c6/
> 
> cheers
> 

Ouch.. my bad. Will fix it.

Thanks,
-Mahesh.
