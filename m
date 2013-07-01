Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6B12D2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 23:01:20 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 1 Jul 2013 22:51:29 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CA1943578050
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 23:01:13 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r61D14pv2294130
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Jul 2013 23:01:04 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r61D1CUq017173
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Jul 2013 23:01:13 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michal Nazarewicz <mina86@mina86.com>, benh@kernel.crashing.org,
 paulus@samba.org, linux-mm@kvack.org, m.szyprowski@samsung.com
Subject: Re: [PATCH -V2 1/4] mm/cma: Move dma contiguous changes into a
 seperate config
In-Reply-To: <xa1tzju6sdjx.fsf@mina86.com>
References: <1372410662-3748-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <xa1tzju6sdjx.fsf@mina86.com>
Date: Mon, 01 Jul 2013 18:31:10 +0530
Message-ID: <8738rytox5.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michal Nazarewicz <mina86@mina86.com> writes:

> On Fri, Jun 28 2013, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>
>> We want to use CMA for allocating hash page table and real mode area for
>> PPC64. Hence move DMA contiguous related changes into a seperate config
>> so that ppc64 can enable CMA without requiring DMA contiguous.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> Acked-by: Michal Nazarewicz <mina86@mina86.com>
>
>> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
>> index 07abd9d..74b7c98 100644
>> --- a/drivers/base/Kconfig
>> +++ b/drivers/base/Kconfig
>> @@ -202,11 +202,10 @@ config DMA_SHARED_BUFFER
>>  	  APIs extension; the file's descriptor can then be passed on to other
>>  	  driver.
>>  
>> -config CMA
>> -	bool "Contiguous Memory Allocator"
>> -	depends on HAVE_DMA_CONTIGUOUS && HAVE_MEMBLOCK
>> -	select MIGRATION
>> -	select MEMORY_ISOLATION
>> +config DMA_CMA
>> +	bool "DMA Contiguous Memory Allocator"
>> +	depends on HAVE_DMA_CONTIGUOUS
>> +	select CMA
>
> Just to be on the safe side, I'd add
>
> 	depends on HAVE_MEMBLOCK
>
> or change this so that it does not select CMA but depends on CMA.


updated this to 

+config DMA_CMA
+	bool "DMA Contiguous Memory Allocator"
+	depends on HAVE_DMA_CONTIGUOUS && CMA


>
>>  	help
>>  	  This enables the Contiguous Memory Allocator which allows drivers
>>  	  to allocate big physically-contiguous blocks of memory for use with
>> @@ -215,17 +214,7 @@ config CMA
>>  	  For more information see <include/linux/dma-contiguous.h>.
>>  	  If unsure, say "n".
>>  
>> -if CMA
>> -
>> -config CMA_DEBUG
>> -	bool "CMA debug messages (DEVELOPMENT)"
>> -	depends on DEBUG_KERNEL
>> -	help
>> -	  Turns on debug messages in CMA.  This produces KERN_DEBUG
>> -	  messages for every CMA call as well as various messages while
>> -	  processing calls such as dma_alloc_from_contiguous().
>> -	  This option does not affect warning and error messages.
>> -

Thanks
-aneesh
