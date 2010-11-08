Return-Path: <nacc@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DD56DB710A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Nov 2010 06:43:04 +1100 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oA8JQTew016875
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Nov 2010 14:26:29 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oA8JgxvX324272
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Nov 2010 14:42:59 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	oA8Jgw4U002108
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Nov 2010 14:42:59 -0500
Date: Mon, 8 Nov 2010 11:42:55 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: sonnyrao@us.ibm.com, miltonm@bga.com,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 0/7 v2] ppc: enable dynamic dma window support
Message-ID: <20101108194255.GA3113@us.ibm.com>
References: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

On 26.10.2010 [20:35:10 -0700], Nishanth Aravamudan wrote:
> The following series, which builds upon the series of cleanups I posted
> on 9/15 and 10/18 as "ppc iommu cleanups", enables the pseries firmware
> feature dynamic dma windows. This feature will allow future devices to
> have a 64-bit DMA mapping covering all memory, coexisting with a smaller
> IOMMU window in 32-bit PCI space

Was ping'ing on this changeset. If there are no objections, I will
repost it without the RFC tag asking Ben to merge it.

Thanks,
Nish

> Changes from v1 to v2:
> 
> Fixed numerous bugs/issues found in testing.
> Reworked to be based off platform hook dma_set_mask().
> 
> Nishanth Aravamudan (7):
>   macio: ensure all dma routines get copied over
>   ppc: add memory_hotplug_max
>   ppc: do not search for dma-window property on dlpar remove
>   ppc: checking for pdn->parent is redundant
>   ppc/iommu: do not need to check for dma_window == NULL
>   ppc/iommu: pass phb only to iommu_table_setparms_lpar
>   ppc: add dynamic dma window support
> 
>  arch/powerpc/include/asm/device.h      |    6 +
>  arch/powerpc/include/asm/mmzone.h      |    5 +
>  arch/powerpc/mm/numa.c                 |   26 ++
>  arch/powerpc/platforms/pseries/iommu.c |  600 ++++++++++++++++++++++++++++++--
>  drivers/macintosh/macio_asic.c         |    7 +-
>  5 files changed, 619 insertions(+), 25 deletions(-)
> 
> 

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
