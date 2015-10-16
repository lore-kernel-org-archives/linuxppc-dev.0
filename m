Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D1D71A0B37
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 16:56:12 +1100 (AEDT)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42B951402DD
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 16:56:11 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 16 Oct 2015 11:26:09 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 37B84E0056
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 11:26:03 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9G5tpRu56361174
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 11:25:51 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9G5to6A004924
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 11:25:50 +0530
Message-ID: <56209166.50602@linux.vnet.ibm.com>
Date: Fri, 16 Oct 2015 11:25:50 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, nacc@linux.vnet.ibm.com
Subject: Re: [RFC] powerpc/numa: Use VPHN based node ID information on shared
 processor LPARs
References: <1444813335-4009-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1444962421.28419.3.camel@ellerman.id.au>
In-Reply-To: <1444962421.28419.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/16/2015 07:57 AM, Michael Ellerman wrote:
> On Wed, 2015-10-14 at 14:32 +0530, Anshuman Khandual wrote:
>> On shared processor LPARs, H_HOME_NODE_ASSOCIATIVITY hcall provides the
>> dynamic virtual-physical mapping for any given processor. Currently we
>> use VPHN node ID information only after getting either a PRRN or a VPHN
>> event. But during boot time inside the function numa_setup_cpu, we still
>> query the OF device tree for the node ID value which might be different
>> than what can be fetched from the H_HOME_NODE_ASSOCIATIVITY hcall. In a
>> scenario where there are no PRRN or VPHN event after boot, all node-cpu
>> mapping will remain incorrect there after.
>>
>> With this proposed change, numa_setup_cpu will try to override the OF
>> device tree fetched node ID information with H_HOME_NODE_ASSOCIATIVITY
>> hcall fetched node ID value. Right now shared processor property of the
>> LPAR cannot be queried as VPA inializaion happens after numa_setup_cpu
>> during boot time. So initmem_init function has been moved after ppc_md.
>> setup_arch inside setup_arch during boot.
>>
>> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
>> index 8b9502a..e404d05 100644
>> --- a/arch/powerpc/mm/numa.c
>> +++ b/arch/powerpc/mm/numa.c
>> @@ -553,6 +557,17 @@ static int numa_setup_cpu(unsigned long lcpu)
>>  
>>  	nid = of_node_to_nid_single(cpu);
>>  
>> +	/*
>> +	 * Override the OF device tree fetched node number
>> +	 * with VPHN based node number in case of a shared
>> +	 * processor LPAR on PHYP platform.
>> +	 */
>> +#ifdef CONFIG_PPC_SPLPAR
>> +	if (lppaca_shared_proc(get_lppaca())) {
>> +		nid = vphn_get_node(lcpu);
>> +	}
>> +#endif
> 
> 
> That logic exposes a potential problem which you don't seem to have addressed.

You are right.

> 
> You're not updating the logic in of_node_to_nid[_single](), instead you're
> overriding it in *this one location*. But what about other code that uses
> of_node_to_nid()? It will still get the old device-tree value and so will have
> the wrong nid, won't it?

Yeah it will. of_node_to_nid() calls of_node_to_nid_single(). So we
can move in this VPHN override logic inside of_node_to_nid_single to
make it available across the board. But the original problem of timing
of vpa_init() still remains to make lppaca_shared_proc() check available
during boot time inside numa_setup_cpu() function.
