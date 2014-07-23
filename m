Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 175CC1A01AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 14:00:44 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 23 Jul 2014 14:00:41 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7D4813578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 14:00:41 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6N3bnRP4849718
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 13:37:49 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6N40eUK023088
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 14:00:40 +1000
Date: Wed, 23 Jul 2014 14:00:40 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v2 06/18] powerpc/powernv: Use it_page_shift in TCE build
Message-ID: <20140723040040.GB5531@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
 <1406084764-24685-7-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406084764-24685-7-git-send-email-aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 23, 2014 at 01:05:52PM +1000, Alexey Kardashevskiy wrote:
>This makes use of iommu_table::it_page_shift instead of TCE_SHIFT and
>TCE_RPN_SHIFT hardcoded values.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> arch/powerpc/platforms/powernv/pci.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>index f91a4e5..b6cb996 100644
>--- a/arch/powerpc/platforms/powernv/pci.c
>+++ b/arch/powerpc/platforms/powernv/pci.c
>@@ -564,10 +564,11 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
> 		proto_tce |= TCE_PCI_WRITE;
>
> 	tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
>-	rpn = __pa(uaddr) >> TCE_SHIFT;
>+	rpn = __pa(uaddr) >> tbl->it_page_shift;
>

I'm not sure for 100%. It might be worthy to have some check somewhere:

	WARN_ON(uaddr & ((1ull << tbl->it_page_shift) - 1))

The "uaddr" are required to be "0x1ull << tbl->it_page_shift" aligned :-)

Thanks,
Gavin

> 	while (npages--)
>-		*(tcep++) = cpu_to_be64(proto_tce | (rpn++ << TCE_RPN_SHIFT));
>+		*(tcep++) = cpu_to_be64(proto_tce |
>+				(rpn++ << tbl->it_page_shift));
>
> 	/* Some implementations won't cache invalid TCEs and thus may not
> 	 * need that flush. We'll probably turn it_type into a bit mask
>-- 
>2.0.0
>
