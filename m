Return-Path: <srs0=da+p=7g=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNwY32rtbzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 15:32:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xNwY32JBLz8sy1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 15:32:23 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xNwY25ffcz9s8P
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2017 15:32:22 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v745NhFd076970
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Aug 2017 01:32:20 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2c4jq6rhmx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 04 Aug 2017 01:32:20 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 4 Aug 2017 15:32:17 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v745WFGN28639300
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Aug 2017 15:32:15 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v745WEI7005797
 for <linuxppc-dev@ozlabs.org>; Fri, 4 Aug 2017 15:32:15 +1000
Subject: Re: [PATCH 1/4] powerpc/prom: avoid endian conversions for linux,
 memory-limit node
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, ben@codiert.org,
 sjitindarsingh@gmail.com
References: <150175227508.9806.17545018023658850483.stgit@hbathini.in.ibm.com>
 <8760e4q9bd.fsf@concordia.ellerman.id.au>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 4 Aug 2017 11:02:11 +0530
MIME-Version: 1.0
In-Reply-To: <8760e4q9bd.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7929ae2c-1b34-18b4-127a-ed0e438c751d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Friday 04 August 2017 09:21 AM, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>
>> As linux,memory-limit node is set and also later used by the kernel,
>> avoid endian conversions for this property.
>>
>> Fixes: 493adffcb43f ("powerpc: Make prom_init.c endian safe")
>> Cc: stable@vger.kernel.org # 3.12+
>> Cc: Anton Blanchard <anton@ozlabs.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/kernel/prom_init.c |    3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
> As Ben said, this is not OK. The flat device tree is a data
> structure with a specified format[1], we don't violate the spec just to
> avoid an endian swap.
>
> Is there an actual bug you're trying to solve?

Yep. While retrieving this property in prom.c, no endian conversion is 
being done.
It was broken for a while. Let me do the endian swap in prom.c while 
retrieving..

Thanks
Hari

> [1]: https://www.devicetree.org/
>
>> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
>> index 613f79f..723df83 100644
>> --- a/arch/powerpc/kernel/prom_init.c
>> +++ b/arch/powerpc/kernel/prom_init.c
>> @@ -3180,9 +3180,8 @@ unsigned long __init prom_init(unsigned long r3, unsigned long r4,
>>   	 * Fill in some infos for use by the kernel later on
>>   	 */
>>   	if (prom_memory_limit) {
>> -		__be64 val = cpu_to_be64(prom_memory_limit);
>>   		prom_setprop(prom.chosen, "/chosen", "linux,memory-limit",
>> -			     &val, sizeof(val));
>> +			     &prom_memory_limit, sizeof(prom_memory_limit));
>>   	}
>>   #ifdef CONFIG_PPC64
>>   	if (prom_iommu_off)
