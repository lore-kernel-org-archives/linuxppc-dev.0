Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 385631A08DD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 20:07:36 +1000 (AEST)
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A86041400CB
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2015 20:07:35 +1000 (AEST)
Received: by pacex6 with SMTP id ex6so103412842pac.0
 for <linuxppc-dev@ozlabs.org>; Fri, 02 Oct 2015 03:07:34 -0700 (PDT)
Subject: Re: [PATCH V4 0/6] Redesign SR-IOV on PowerNV
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org
References: <1439949704-8023-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <560E5761.4070803@ozlabs.ru>
Date: Fri, 2 Oct 2015 20:07:29 +1000
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

I have posted few comments but in general the patchset makes things simpler 
by removing a compound PE and does not seem to make things worse so:

Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>



-- 
Alexey
