Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2pLt1mY9zDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 15:49:42 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u715mZb8047298
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 01:49:40 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24grr94jtc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 01:49:39 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 1 Aug 2016 15:49:37 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1372E2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 15:49:34 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u715nYa029818984
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 15:49:34 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u715nXAN010893
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Aug 2016 15:49:33 +1000
Subject: Re: [RFC PATCH v2 08/11] powerpc: Add "mask_lvl" paramater to
 MASKABLE_* macros
To: Nicholas Piggin <npiggin@gmail.com>
References: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469991989-28409-9-git-send-email-maddy@linux.vnet.ibm.com>
 <20160801152100.55b6c5f1@roar.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 1 Aug 2016 11:19:30 +0530
MIME-Version: 1.0
In-Reply-To: <20160801152100.55b6c5f1@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3886eb7a-c16e-e53e-1c13-244cc0fd7299@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 01 August 2016 10:51 AM, Nicholas Piggin wrote:
> On Mon,  1 Aug 2016 00:36:26 +0530
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:
>
>> Make it explicit the interrupt masking level supported
>> by a gievn interrupt handler. Patch correspondingly
>> extends the MASKABLE_* macros with an addition's parameter.
>> "mask_lvl" parameter is passed to SOFTEN_TEST macro to decide
>> on masking the interrupt.
> Hey Madhavan,
>
> It looks like this has worked quite nicely. I think you've
> managed to avoid any additional instructions in fastpaths
> if I'm reading correctly.

Yes. This avoids condition checking for many cases.

>
> I will do a more comprehensive review, but I wanted to ask:
>
>
>> @@ -426,79 +426,81 @@ label##_relon_hv:						\
>>   #define SOFTEN_VALUE_0xe60	PACA_IRQ_HMI
>>   #define SOFTEN_VALUE_0xe62	PACA_IRQ_HMI
>>   
>> -#define __SOFTEN_TEST(h, vec)						\
>> +#define __SOFTEN_TEST(h, vec, mask_lvl)					\
>>   	lbz	r10,PACASOFTIRQEN(r13);					\
>> -	cmpwi	r10,IRQ_DISABLE_LEVEL_LINUX;				\
>> +	andi.	r10,r10,mask_lvl;					\
>>   	li	r10,SOFTEN_VALUE_##vec;					\
>> -	bge	masked_##h##interrupt
>> -#define _SOFTEN_TEST(h, vec)	__SOFTEN_TEST(h, vec)
>> +	bne	masked_##h##interrupt
>> +#define _SOFTEN_TEST(h, vec, mask_lvl)	__SOFTEN_TEST(h, vec, mask_lvl)
> We're talking about IRQ masking levels, but here it looks
> like you're actually treating it as a mask.

Yes. That is true. I started with "level", but then realized
that I am adding more branch condition checks to
retain the PMI as NMI incase.

> I don't have a strong preference. Mask is more flexible, but
> potentially constrained in how many interrupt types it can
> cope with. That said, I doubt we'll need more than 8 mask bits
> considering we've lived with one for years. So perhaps a mask
> is a better choice. Ben, others, any preferences?
>
> We should just use either "mask" or "level" everywhere, depending
> on what we go with.

Yep. will change it.

Maddy

>
> Thanks,
> Nick
>
