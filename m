Return-Path: <aik@ozlabs.ru>
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xR351hbQzDr3g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 13:04:47 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id c6-v6so455395pls.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 20:04:47 -0700 (PDT)
Subject: Re: [PATCH kernel RFC 0/3] powerpc/pseries/iommu: GPU coherent memory
 pass through
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 Russell Currey <ruscur@russell.cc>
References: <20180725095032.2196-1-aik@ozlabs.ru>
 <f5bb1df3-1b15-9c2b-8bb1-7733bb743926@ozlabs.ru>
Message-ID: <a28c139e-deb6-cdb3-1eb5-b8d6e7378ce1@ozlabs.ru>
Date: Fri, 24 Aug 2018 13:04:38 +1000
MIME-Version: 1.0
In-Reply-To: <f5bb1df3-1b15-9c2b-8bb1-7733bb743926@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/08/2018 14:41, Alexey Kardashevskiy wrote:
> 
> 
> On 25/07/2018 19:50, Alexey Kardashevskiy wrote:
>> I am trying to pass through a 3D controller:
>> [0302]: NVIDIA Corporation GV100GL [Tesla V100 SXM2] [10de:1db1] (rev a1)
>>
>> which has a quite unique feature as coherent memory directly accessible
>> from a POWER9 CPU via an NVLink2 transport.
>>
>> So in addition to passing a PCI device + accompanying NPU devices,
>> we will also be passing the host physical address range as it is done
>> on the bare metal system.
>>
>> The memory on the host is presented as:
>>
>> ===
>> [aik@yc02goos ~]$ lsprop /proc/device-tree/memory@42000000000
>> ibm,chip-id      000000fe (254)
>> device_type      "memory"
>> compatible       "ibm,coherent-device-memory"
>> reg              00000420 00000000 00000020 00000000
>> linux,usable-memory
>>                  00000420 00000000 00000000 00000000
>> phandle          00000726 (1830)
>> name             "memory"
>> ibm,associativity
>>                  00000004 000000fe 000000fe 000000fe 000000fe
>> ===
>>
>> and the host does not touch it as the second 64bit value of
>> "linux,usable-memory" - the size - is null. Later on the NVIDIA driver
>> trains the NVLink2 and probes this memory and this is how it becomes
>> onlined.
>>
>> In the virtual environment I am planning on doing the same thing,
>> however there is a difference in 64bit DMA handling. The powernv
>> platform uses a PHB3 bypass mode and that just works but
>> the pseries platform uses DDW RTAS API to achieve the same
>> result and the problem with this is that we need a huge DMA
>> window to start from zero (because this GPU supports less than
>> 50bits for DMA address space) and cover not just present memory
>> but also this new coherent memory.
>>
>>
>> This is based on sha1
>> d72e90f3 Linus Torvalds "Linux 4.18-rc6".
>>
>> Please comment. Thanks.
> 
> 
> Ping?


Ping?

> 
> 
>>
>>
>>
>> Alexey Kardashevskiy (3):
>>   powerpc/pseries/iommu: Allow dynamic window to start from zero
>>   powerpc/pseries/iommu: Force default DMA window removal
>>   powerpc/pseries/iommu: Use memory@ nodes in max RAM address
>>     calculation
>>
>>  arch/powerpc/platforms/pseries/iommu.c | 77 ++++++++++++++++++++++++++++++----
>>  1 file changed, 70 insertions(+), 7 deletions(-)
>>
> 

-- 
Alexey
