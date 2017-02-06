Return-Path: <rui.teng@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGsQm6zwpzDqDv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 13:50:24 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v162mYCB041668
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Feb 2017 21:50:21 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28dbu3rhaj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Feb 2017 21:50:21 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rui.teng@linux.vnet.ibm.com>;
 Sun, 5 Feb 2017 21:50:20 -0500
Subject: Re: [PATCH] powerpc/mm: fix a hardcode on memory boundary checking
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20170112090906.17864-1-rui.teng@linux.vnet.ibm.com>
 <877f5bvbjm.fsf@concordia.ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>, jia he <hejianet@linux.vnet.ibm.com>
From: Rui Teng <rui.teng@linux.vnet.ibm.com>
Date: Mon, 6 Feb 2017 10:50:21 +0800
MIME-Version: 1.0
In-Reply-To: <877f5bvbjm.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <a97db3cd-a756-390c-505e-819718b64904@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31/01/2017 5:11 PM, Michael Ellerman wrote:
> Rui Teng <rui.teng@linux.vnet.ibm.com> writes:
>
>> The offset of hugepage block will not be 16G, if the expected
>> page is more than one. Calculate the totol size instead of the
>> hardcode value.
>
> I assume you found this by code inspection and not by triggering an
> actual bug?

Yes, I found this problem only by code inspection. We were finding the
ways to enable 16G huge page besides changing the device tree. For 
example, provide a new interface to set these size and pages parameters.
So that I think it may cause problem here.

>
> cheers
>
>> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
>> index 8033493..b829f8e 100644
>> --- a/arch/powerpc/mm/hash_utils_64.c
>> +++ b/arch/powerpc/mm/hash_utils_64.c
>> @@ -506,7 +506,7 @@ static int __init htab_dt_scan_hugepage_blocks(unsigned long node,
>>  	printk(KERN_INFO "Huge page(16GB) memory: "
>>  			"addr = 0x%lX size = 0x%lX pages = %d\n",
>>  			phys_addr, block_size, expected_pages);
>> -	if (phys_addr + (16 * GB) <= memblock_end_of_DRAM()) {
>> +	if (phys_addr + block_size * expected_pages <= memblock_end_of_DRAM()) {
>>  		memblock_reserve(phys_addr, block_size * expected_pages);
>>  		add_gpage(phys_addr, block_size, expected_pages);
>>  	}
>> --
>> 2.9.0
>
