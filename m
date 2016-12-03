Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVtpH53W5zDw40
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Dec 2016 12:33:42 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB31XdKL117294
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Dec 2016 20:33:39 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 273envpvma-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Dec 2016 20:33:38 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Fri, 2 Dec 2016 18:33:34 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 7169A3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 18:33:32 -0700 (MST)
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uB31XWpc7733510
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 3 Dec 2016 01:33:32 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC547AE03B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 20:33:31 -0500 (EST)
Received: from oc7015585048.ibm.com (unknown [9.48.102.228])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id A9A92AE034
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 20:33:31 -0500 (EST)
Subject: Re: [PATCH v2] powerpc/powernv: Initialise nest mmu
To: linuxppc-dev@lists.ozlabs.org
References: <1480656588-25504-1-git-send-email-alistair@popple.id.au>
 <871sxqznt2.fsf@concordia.ellerman.id.au>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Fri, 2 Dec 2016 17:33:30 -0800
MIME-Version: 1.0
In-Reply-To: <871sxqznt2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <305fa5b2-ca6b-c7d6-98d0-d1b04db6e02c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/02/2016 01:24 AM, Michael Ellerman wrote:
> Alistair Popple <alistair@popple.id.au> writes:
> 
>> diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
>> index da7c843..6fa9551 100644
>> --- a/arch/powerpc/platforms/powernv/powernv.h
>> +++ b/arch/powerpc/platforms/powernv/powernv.h
>> @@ -9,6 +9,12 @@ static inline void pnv_smp_init(void) { }
>>  
>>  struct pci_dev;
>>  
>> +#ifdef CONFIG_PPC_POWERNV
>> +extern void powernv_set_ptcr(unsigned long ptcr);
>> +#else
>> +static inline void powernv_set_ptcr(unisigned long ptcr) { }
>                                          ^
>                                          Your shout next time we're at the pub ;)
> 
> cheers
> 

Ah, the elusive unicorn of signed longs!

-Tyrel
