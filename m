Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r550419mzzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 17:56:04 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 12 May 2016 17:56:02 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B1E8F357806A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 17:55:50 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4C7tNWJ27525192
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 17:55:40 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4C7srr7019749
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 17:54:54 +1000
Date: Thu, 12 May 2016 16:59:51 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Alistair Popple <alistair@popple.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 1/2] powerpc/powernv: Fix insufficient memory
 allocation
Message-ID: <20160512065951.GA11255@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1463032030-38974-1-git-send-email-aik@ozlabs.ru>
 <1463032030-38974-2-git-send-email-aik@ozlabs.ru>
 <20160512060925.GA3167@gwshan>
 <7b3e82d4-f300-3e10-907f-790a5ce20876@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7b3e82d4-f300-3e10-907f-790a5ce20876@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 12, 2016 at 04:39:57PM +1000, Alexey Kardashevskiy wrote:
>On 05/12/2016 04:09 PM, Gavin Shan wrote:
>>On Thu, May 12, 2016 at 03:47:09PM +1000, Alexey Kardashevskiy wrote:
>>>The pnv_pci_init_ioda_phb() helper allocates a blob to store auxilary
>>>data such PE and M32/M64 segment allocation maps; this single blob has few
>>>partitions, size of each is derived from the PE number -
>>>phb->ioda.total_pe_num.
>>>
>>>It was assumed that the minimum PE number is 8, however it is 4 for NPU
>>>so the pe_alloc part was missing in the allocated blob.
>>>It was invisible till recently as we were not tracking used M64 segments
>>>and NPUs do not use M32 segments so the phb->ioda.m32_segmap
>>>(which was pointing to the same address as phb->ioda.pe_alloc)
>>>has never been written to leaving the pe_alloc memory intact.
>>>
>>>After 401203ac2d "powerpc/powernv: Track M64 segment consumption"
>>>the pe_alloc gets corrupted and PE allocation cannot work.
>>>This fixes the issue by enforcing the minimum PE number to 8.
>>>
>>
>>As I said offline yesterday, the issue exists from day-1 when NPU PHB
>>is supported. I don't think it's related to 401203ac2d. Without the logic
>>tracking M64 segments, the PE# bitmap still can be corrupted when writting
>>to M32 segment map. It's confusing to mention a unrelated commit in the
>>changelog.
>
>
>The bug exists from day 1. The actual corruption started happening from
>401203ac2d, it could be happening before but it was not.
>

well, Are you sure it starts from 401203ac2d? I would believe it starts
from commit 3fa23ff ("powerpc/powernv: Fix initial IO and M32 segmap").
Please fix the commit log.

>>
>>Since the issue exists from day-1 when NPU PHB is supported, is a stable
>>tag needed?
>>
>>>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>>With above parts fixed:
>>
>>Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>
>>>---
>>>arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
>>>1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>index 6cda2a8..d0d32c2 100644
>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>@@ -3507,7 +3507,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>>				PNV_IODA1_DMA32_SEGSIZE;
>>>
>>>	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */
>>>-	size = _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
>>>+	size = _ALIGN_UP(max_t(unsigned, phb->ioda.total_pe_num, 8) / 8,
>>>+			sizeof(unsigned long));
>>>	m64map_off = size;
>>>	size += phb->ioda.total_pe_num * sizeof(phb->ioda.m64_segmap[0]);
>>>	m32map_off = size;
>>>--
>>>2.5.0.rc3
>>>
>>
>
>
>-- 
>Alexey
>
