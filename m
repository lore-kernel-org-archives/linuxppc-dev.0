Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EB901A0179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 18:06:41 +1000 (AEST)
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F04051401DA
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2015 18:06:40 +1000 (AEST)
Received: by pacti10 with SMTP id ti10so80190608pac.0
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2015 01:06:38 -0700 (PDT)
Subject: Re: [PATCH V4 0/6] Redesign SR-IOV on PowerNV
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org
References: <1439949704-8023-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <55DD4A80.8030102@ozlabs.ru>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55DD7388.4080802@ozlabs.ru>
Date: Wed, 26 Aug 2015 18:06:32 +1000
MIME-Version: 1.0
In-Reply-To: <55DD4A80.8030102@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/26/2015 03:11 PM, Alexey Kardashevskiy wrote:
> On 08/19/2015 12:01 PM, Wei Yang wrote:
>> In original design, it tries to group VFs to enable more number of VFs in
>> the
>> system, when VF BAR is bigger than 64MB. This design has a flaw in which one
>> error on a VF will interfere other VFs in the same group.
>>
>> This patch series change this design by using M64 BAR in Single PE mode to
>> cover only one VF BAR. By doing so, it gives absolute isolation between VFs.
>
> With or without this patchset, this fails with a horrible loop of EEHs:
> rmmod mlx4_en mlx4_ib mlx4_core
> modprobe mlx4_core num_vfs=4 probe_vf=4 port_type_array=2,2 debug_level=1
>
> No guest is needed, just boot and do these commands. The EEH error is
> pointing to a broken DMA address. iommu=nobypass fixed it for 4 VFs case
> but when I try 16 VFs, none is created.
>
> What is the correct base tree and what hardware did you use for the testing
> _exactly_?
>
> Mine is "Ethernet controller: Mellanox Technologies MT27520 Family
> [ConnectX-3 Pro]" with 128MB BARs and that works (just double checked - can
> create all 16 VFs) with PowerKVM 3.1 so it is not a hardware issue.


This turned out to be the powerpc/next tree problem, not this patch or 
anything related to SRIOV. Debugging now...



-- 
Alexey
