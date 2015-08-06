Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D4491A2CB4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 19:36:25 +1000 (AEST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7D7D81402B8
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 19:36:24 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 15:06:22 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 182891258064
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2015 15:09:30 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t769a5Ee34472036
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 15:06:05 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t769a4MD026943
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2015 15:06:04 +0530
Date: Thu, 6 Aug 2015 17:36:02 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, aik@ozlabs.ru,
 benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V2 3/6] powerpc/powernv: use one M64 BAR in Single PE
 mode for one VF BAR
Message-ID: <20150806093602.GA13055@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <20150731020148.GA6151@richard>
 <1438737903-10399-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1438737903-10399-4-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150806052025.GC28524@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150806052025.GC28524@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 06, 2015 at 03:20:25PM +1000, Gavin Shan wrote:
>On Wed, Aug 05, 2015 at 09:25:00AM +0800, Wei Yang wrote:
>>In current implementation, when VF BAR is bigger than 64MB, it uses 4 M64
>>BAR in Single PE mode to cover the number of VFs required to be enabled.
>>By doing so, several VFs would be in one VF Group and leads to interference
>>between VFs in the same group.
>>
>>This patch changes the design by using one M64 BAR in Single PE mode for
>>one VF BAR. This gives absolute isolation for VFs.
>>
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>---
>> arch/powerpc/include/asm/pci-bridge.h     |    5 +-
>> arch/powerpc/platforms/powernv/pci-ioda.c |  180 ++++++++++++-----------------
>> 2 files changed, 76 insertions(+), 109 deletions(-)
>>
>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>index 712add5..8aeba4c 100644
>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>@@ -214,10 +214,9 @@ struct pci_dn {
>> 	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
>> 	u16     num_vfs;		/* number of VFs enabled*/
>> 	int     offset;			/* PE# for the first VF PE */
>>-#define M64_PER_IOV 4
>>-	int     m64_per_iov;
>>+	bool    m64_single_mode;	/* Use M64 BAR in Single Mode */
>> #define IODA_INVALID_M64        (-1)
>>-	int     m64_wins[PCI_SRIOV_NUM_BARS][M64_PER_IOV];
>>+	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
>
>It can be explicit? For example:
>
>	int	*m64_map;
>
>	/* Initialization */
>	size_t size = sizeof(*pdn->m64_map) * PCI_SRIOV_NUM_BARS * num_of_max_VFs;
>	pdn->m64_map = kmalloc(size, GFP_KERNEL);
>	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
>		for (j = 0; j < num_of_max_VFs; j++)
>			pdn->m64_map[i * PCI_SRIOV_NUM_BARS + j] = PNV_INVALID_M64;
>
>	/* Destroy */
>	int step = 1;
>
>	if (!pdn->m64_single_mode)
>		step = phb->ioda.total_pe;
>	for (i = 0; i < PCI_SRIOV_NUM_BARS * num_of_max_VFs; i += step)
>		if (pdn->m64_map[i] == PNV_INVALID_M64)
>			continue;
>
>		/* Unmap the window */
>	

The m64_map is a pointer to an array with 6 elements, which represents the 6
M64 BAR index for the 6 VF BARs.

    When we use Shared Mode, one array is allocated. The six elements
    represents the six M64 BAR(at most) used to map the whole IOV BAR.
    
    When we use Single Mode, num_vfs array is allocate. Each array represents
    the map between one VF's BAR and M64 BAR index.

During the map and un-map, M64 BAR is assigned one by one in VF BAR's order.
So I think the code is explicit.

In your code, you allocate a big one dimension array to hold the M64 BAR
index. It works, while I don't think this is more explicit than original code.

-- 
Richard Yang
Help you, Help me
