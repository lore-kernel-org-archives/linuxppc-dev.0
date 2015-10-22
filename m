Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 597B01A06A9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 22:14:52 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2B18A14131C
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 22:14:52 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 22 Oct 2015 21:14:50 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 81920357804F
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 22:14:47 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9MBEcwr65470526
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 22:14:47 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9MBEEYg010429
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 22:14:14 +1100
Date: Thu, 22 Oct 2015 22:13:57 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, benh@kernel.crashing.org,
 linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH V7 0/6] Redesign SR-IOV on PowerNV
Message-ID: <20151022111356.GA22500@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1445476939-2995-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445476939-2995-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 22, 2015 at 09:22:13AM +0800, Wei Yang wrote:
>In original design, it tries to group VFs to enable more number of VFs in the
>system, when VF BAR is bigger than 64MB. This design has a flaw in which one
>error on a VF will interfere other VFs in the same group.
>
>This patch series change this design by using M64 BAR in Single PE mode to
>cover only one VF BAR. By doing so, it gives absolute isolation between VFs.
>

This series looks good to me, no obvious problems found. By the way, The
VF EEH patchset has been there for some time, could you respin it on top
of this series and resend that after retesting?

In case Michael need the ack as mentioned last time in IRC:

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>v7:
>   * clear res->flags when truncating the IOV BAR
>v6:
>   * add the minimum size check when M64 BAR is in Single PE mode
>   * truncate IOV BAR when powernv can't handle it
>v5:
>   * rebase on top of v4.2, with commit 68230242cdb "net/mlx4_core: Add port
>     attribute when tracking counters" reverted
>   * add some reason in change log of Patch 1
>   * make the pnv_pci_iov_resource_alignment() more easy to read
>   * initialize pe_num_map[] just after it is allocated
>   * test ssh from guest to host via VF passed and then shutdown the guest
>   * no code change
>v4:
>   * rebase the code on top of v4.2-rc7
>   * switch back to use the dynamic version of pe_num_map and m64_map
>   * split the memory allocation and PE assignment of pe_num_map to make it
>     more easy to read
>   * check pe_num_map value before free PE.
>   * add the rename reason for pe_num_map and m64_map in change log
>v3:
>   * return -ENOSPC when a VF has non-64bit prefetchable BAR
>   * rename offset to pe_num_map and define it staticly
>   * change commit log based on comments
>   * define m64_map staticly
>v2:
>   * clean up iov bar alignment calculation
>   * change m64s to m64_bars
>   * add a field to represent M64 Single PE mode will be used
>   * change m64_wins to m64_map
>   * calculate the gate instead of hard coded
>   * dynamically allocate m64_map
>   * dynamically allocate PE#
>   * add a case to calculate iov bar alignment when M64 Single PE is used
>   * when M64 Single PE is used, compare num_vfs with M64 BAR available number 
>     in system at first
>
>
>Wei Yang (6):
>  powerpc/powernv: don't enable SRIOV when VF BAR has non
>    64bit-prefetchable BAR
>  powerpc/powernv: simplify the calculation of iov resource alignment
>  powerpc/powernv: use one M64 BAR in Single PE mode for one VF BAR
>  powerpc/powernv: replace the hard coded boundary with gate
>  powerpc/powernv: boundary the total VF BAR size instead of the
>    individual one
>  powerpc/powernv: allocate sparse PE# when using M64 BAR in Single PE
>    mode
>
> arch/powerpc/include/asm/pci-bridge.h     |   7 +-
> arch/powerpc/platforms/powernv/pci-ioda.c | 347 ++++++++++++++++--------------
> 2 files changed, 192 insertions(+), 162 deletions(-)
>
>-- 
>2.5.0
>
