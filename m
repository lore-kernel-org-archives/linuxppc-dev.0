Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C7361A1000
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 15:11:36 +1000 (AEST)
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6B1901401EF
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2015 15:11:35 +1000 (AEST)
Received: by pacti10 with SMTP id ti10so75194357pac.0
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Aug 2015 22:11:34 -0700 (PDT)
Subject: Re: [PATCH V4 0/6] Redesign SR-IOV on PowerNV
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org
References: <1439949704-8023-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55DD4A80.8030102@ozlabs.ru>
Date: Wed, 26 Aug 2015 15:11:28 +1000
MIME-Version: 1.0
In-Reply-To: <1439949704-8023-1-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/19/2015 12:01 PM, Wei Yang wrote:
> In original design, it tries to group VFs to enable more number of VFs in the
> system, when VF BAR is bigger than 64MB. This design has a flaw in which one
> error on a VF will interfere other VFs in the same group.
>
> This patch series change this design by using M64 BAR in Single PE mode to
> cover only one VF BAR. By doing so, it gives absolute isolation between VFs.

With or without this patchset, this fails with a horrible loop of EEHs:
rmmod mlx4_en mlx4_ib mlx4_core
modprobe mlx4_core num_vfs=4 probe_vf=4 port_type_array=2,2 debug_level=1

No guest is needed, just boot and do these commands. The EEH error is 
pointing to a broken DMA address. iommu=nobypass fixed it for 4 VFs case 
but when I try 16 VFs, none is created.

What is the correct base tree and what hardware did you use for the testing 
_exactly_?

Mine is "Ethernet controller: Mellanox Technologies MT27520 Family 
[ConnectX-3 Pro]" with 128MB BARs and that works (just double checked - can 
create all 16 VFs) with PowerKVM 3.1 so it is not a hardware issue.



>
> v4:
>     * rebase the code on top of v4.2-rc7
>     * switch back to use the dynamic version of pe_num_map and m64_map
>     * split the memory allocation and PE assignment of pe_num_map to make it
>       more easy to read
>     * check pe_num_map value before free PE.
>     * add the rename reason for pe_num_map and m64_map in change log
> v3:
>     * return -ENOSPC when a VF has non-64bit prefetchable BAR
>     * rename offset to pe_num_map and define it staticly
>     * change commit log based on comments
>     * define m64_map staticly
> v2:
>     * clean up iov bar alignment calculation
>     * change m64s to m64_bars
>     * add a field to represent M64 Single PE mode will be used
>     * change m64_wins to m64_map
>     * calculate the gate instead of hard coded
>     * dynamically allocate m64_map
>     * dynamically allocate PE#
>     * add a case to calculate iov bar alignment when M64 Single PE is used
>     * when M64 Single PE is used, compare num_vfs with M64 BAR available number
>       in system at first
>
>
>
> Wei Yang (6):
>    powerpc/powernv: don't enable SRIOV when VF BAR has non
>      64bit-prefetchable BAR
>    powerpc/powernv: simplify the calculation of iov resource alignment
>    powerpc/powernv: use one M64 BAR in Single PE mode for one VF BAR
>    powerpc/powernv: replace the hard coded boundary with gate
>    powerpc/powernv: boundary the total VF BAR size instead of the
>      individual one
>    powerpc/powernv: allocate sparse PE# when using M64 BAR in Single PE
>      mode
>
>   arch/powerpc/include/asm/pci-bridge.h     |    7 +-
>   arch/powerpc/platforms/powernv/pci-ioda.c |  328 +++++++++++++++--------------
>   2 files changed, 175 insertions(+), 160 deletions(-)
>


-- 
Alexey
