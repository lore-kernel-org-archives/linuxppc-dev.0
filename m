Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y62Vr2FGszDqks
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 02:09:08 +1100 (AEDT)
Subject: Re: [PATCH v9 01/12] x86/mm: setting fields in deferred pages
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, mark.rutland@arm.com, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org, mgorman@techsingularity.net,
 steven.sistare@oracle.com, daniel.m.jordan@oracle.com, bob.picco@oracle.com
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-2-pasha.tatashin@oracle.com>
 <20171003122658.cv64pxnuavopjid6@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <00978c7c-8d05-fbc3-eaba-9455b66ff02e@oracle.com>
Date: Tue, 3 Oct 2017 11:07:54 -0400
MIME-Version: 1.0
In-Reply-To: <20171003122658.cv64pxnuavopjid6@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michal,

> 
> I hope I haven't missed anything but it looks good to me.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you for your review.

> 
> one nit below
>> ---
>>   arch/x86/mm/init_64.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>> index 5ea1c3c2636e..30fe22558720 100644
>> --- a/arch/x86/mm/init_64.c
>> +++ b/arch/x86/mm/init_64.c
>> @@ -1182,12 +1182,17 @@ void __init mem_init(void)
>>   
>>   	/* clear_bss() already clear the empty_zero_page */
>>   
>> -	register_page_bootmem_info();
>> -
>>   	/* this will put all memory onto the freelists */
>>   	free_all_bootmem();
>>   	after_bootmem = 1;
>>   
>> +	/* Must be done after boot memory is put on freelist, because here we
> 
> standard code style is to do
> 	/*
> 	 * text starts here

OK, will change for both patch 1 and 2.

Pasha
