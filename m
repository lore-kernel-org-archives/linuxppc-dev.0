Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 824511007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Sep 2011 19:40:26 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p8T9dGdh024801
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2011 19:39:16 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8T9eOSE1863798
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2011 19:40:24 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8T9eNgV028205
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2011 19:40:24 +1000
Message-ID: <4E843D05.3070401@in.ibm.com>
Date: Thu, 29 Sep 2011 15:10:21 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] CONFIG_RELOCATABLE : __va() & __pa() definitions
References: <20110927175433.0c300384@suzukikp.in.ibm.com>
	<1317250996.29415.125.camel@pasglop>
In-Reply-To: <1317250996.29415.125.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	linux ppc dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/29/11 04:33, Benjamin Herrenschmidt wrote:
> On Tue, 2011-09-27 at 17:54 +0530, Suzuki Poulose wrote:
>> Hi,
>>
>> I am working on enabling CONFIG_RELOCATABLE for PPC44x Embedded PowerPC
>> boards as a foundation to enable CONFIG_CRASH_DUMP. After a discussion
>> on the linux-ppcdev we decided that we will follow the 'processing
>> relocation entries' approach for running the kernel from a different
>> address.
>
> I think the best approach is to not touch KERNELBASE and PAGE_OFFSET,
> and just process relocations, that way __va() and __pa() are unoutched
> and plenty of other stuff won't break.

Ben,

I am processing the relocations in my approach.
But even in that case, __va(), __pa() needs modification since , on BookE,
we depend on PHYSICAL_START(kernstart_addr) to do the translations.

So depending on the kernstart_addr, the __va() keeps changing, even though
the mappings doesn't change. (Virtual to Physical mapping). Please note that,
since we use 256M mappings, any address within the 256M will result in the same
mapping.

>> 			| Phys. Addr	| Virt. Addr	|
>> PageBoundary (256M)	|-------------------------------|
>> 			|		|		|
>> 			|		|		|
>> 			|		|		|
>> (Phys. Start)%256M->	|_______________|_ _ _ _ _ _ _ _|<- Relocated. Kernel
>> 			|		|       ^	| Virtual Address
>> 			|		|	|	|
>> 			|		|	|	|
>> 			|		|  reloc_offset	|
>> 			|		|	|	|
>> 			|		|	|	|
>> 			|		|_______v_______|<-(KERNELBASE)%
>> 			|		|		|   256M
>> 			|		|		|
>> 			|		|		|
>> 			|		|		|
>> 			|		|		|
>> PageBoundary (256M)	|---------------|---------------|
>> 			|		|		|
>> 			|		|		|
>>


Thanks

Suzuki
