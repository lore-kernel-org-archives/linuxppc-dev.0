Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 522341A1E1D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 13:21:44 +1000 (AEST)
Received: by pacwi10 with SMTP id wi10so31507486pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2015 20:21:42 -0700 (PDT)
Subject: Re: [PATCH V5 0/6] Redesign SR-IOV on PowerNV
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 mpe@ellerman.id.au, benh@kernel.crashing.org
References: <1441243792-2074-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55E7BCC0.7010501@ozlabs.ru>
Date: Thu, 3 Sep 2015 13:21:36 +1000
MIME-Version: 1.0
In-Reply-To: <1441243792-2074-1-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/03/2015 11:29 AM, Wei Yang wrote:
> In original design, it tries to group VFs to enable more number of VFs in the
> system, when VF BAR is bigger than 64MB. This design has a flaw in which one
> error on a VF will interfere other VFs in the same group.
>
> This patch series change this design by using M64 BAR in Single PE mode to
> cover only one VF BAR. By doing so, it gives absolute isolation between VFs.
>
> v5:
>     * rebase on top of v4.2, with commit 68230242cdb "net/mlx4_core: Add port
>       attribute when tracking counters" reverted
>     * test ssh from guest to host via VF passed and then shutdown the guest
>     * no code change


This is weak test actually. When I try to load it more (described in 
another mail thread with the "mlx4" subject, please respond there), the 
host is crashing quite soon.



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
>   arch/powerpc/include/asm/pci-bridge.h     |   7 +-
>   arch/powerpc/platforms/powernv/pci-ioda.c | 328 ++++++++++++++++--------------
>   2 files changed, 175 insertions(+), 160 deletions(-)
>


-- 
Alexey
