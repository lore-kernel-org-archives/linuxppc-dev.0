Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcgkS1D5rzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 03:36:00 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4UHYT7j098731
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 13:35:51 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2asc6jb5r2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 13:35:51 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 30 May 2017 11:35:50 -0600
Subject: Re: [PATCH] powerpc/hotplug-mem: Fix aa_index match bug for hotplug
To: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, paulus@samba.org,
 sahilmehta17@gmail.com, jallen@linux.vnet.ibm.com,
 alastair@d-silva.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <b284d6be-ff37-4e5c-7357-446b4e1ea8ad@linux.vnet.ibm.com>
 <87tw424lmh.fsf@concordia.ellerman.id.au>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 30 May 2017 12:35:46 -0500
MIME-Version: 1.0
In-Reply-To: <87tw424lmh.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <b50a28ec-ae33-82f8-eefd-0e20e15c2dfb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/30/2017 06:41 AM, Michael Ellerman wrote:
> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> 
>> When adding or removing memory, the aa_index (affinity value) for the
>> memblock must also be converted to match the endianness of the rest
>> of the 'ibm,dynamic-memory' property.  Otherwise, subsequent retrieval
>> of the attribute will likely lead to non-existent nodes, followed by
>> using the default node in the code inappropriately.
>>
>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>>
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> index e104c71..1fb162b 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>> @@ -124,6 +124,7 @@ static struct property *dlpar_clone_drconf_property(struct device_node *dn)
>>  	for (i = 0; i < num_lmbs; i++) {
>>  		lmbs[i].base_addr = be64_to_cpu(lmbs[i].base_addr);
>>  		lmbs[i].drc_index = be32_to_cpu(lmbs[i].drc_index);
>> +		lmbs[i].aa_index = be32_to_cpu(lmbs[i].aa_index);
>>  		lmbs[i].flags = be32_to_cpu(lmbs[i].flags);
>>  	}
>>  
> 
> AFAICS this code was added in commit 5f97b2a0d176 ("powerpc/pseries:
> Implement memory hotplug add in the kernel").
> 
> So this should probably be marked:
> 
>   Fixes: 5f97b2a0d176 ("powerpc/pseries: Implement memory hotplug add in the kernel")
> 
> And it seems like a bug we'd want fixed in stable, so:
> 
>   Cc: stable@vger.kernel.org # v4.1+
> 
> 
> Am I right?

Yes, that is correct.

-Nathan
