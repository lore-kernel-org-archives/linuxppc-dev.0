Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FDDD1A001B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 15:34:41 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 13 May 2015 15:34:40 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C64D62BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 15:34:35 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4D5YRW141812190
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 15:34:35 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4D5Y2gK019409
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 15:34:02 +1000
Date: Wed, 13 May 2015 15:33:37 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v10 05/34] powerpc/iommu: Always release
 iommu_table in iommu_free_table()
Message-ID: <20150513053337.GA479@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-6-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431358763-24371-6-git-send-email-aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 12, 2015 at 01:38:54AM +1000, Alexey Kardashevskiy wrote:
>At the moment iommu_free_table() only releases memory if
>the table was initialized for the platform code use, i.e. it had
>it_map initialized (which purpose is to track DMA memory space use).
>
>With dynamic DMA windows, we will need to be able to release
>iommu_table even if it was used for VFIO in which case it_map is NULL
>so does the patch.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> arch/powerpc/kernel/iommu.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>index 3d47eb3..2c02d4c 100644
>--- a/arch/powerpc/kernel/iommu.c
>+++ b/arch/powerpc/kernel/iommu.c
>@@ -714,8 +714,7 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
> 	unsigned int order;
>
> 	if (!tbl || !tbl->it_map) {
>-		printk(KERN_ERR "%s: expected TCE map for %s\n", __func__,
>-				node_name);
>+		kfree(tbl);

I'm not sure if the "tbl" needs to be checked against NULL as kfree() already
has the check. But it looks a bit strange to free NULL "tbl" from the code
itself.

Thanks,
Gavin

> 		return;
> 	}
>
>-- 
>2.4.0.rc3.8.gfb3e7d5
>
