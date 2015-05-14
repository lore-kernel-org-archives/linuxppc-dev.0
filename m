Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3A111A03B4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 13:37:58 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 14 May 2015 13:37:57 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 92C382CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 13:37:53 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4E3bjqp44957916
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 13:37:53 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4E3bKPr030839
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 13:37:21 +1000
Date: Thu, 14 May 2015 13:36:55 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v10 19/34] powerpc/iommu: Fix IOMMU ownership
 control functions
Message-ID: <20150514033655.GA13032@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-20-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431358763-24371-20-git-send-email-aik@ozlabs.ru>
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

On Tue, May 12, 2015 at 01:39:08AM +1000, Alexey Kardashevskiy wrote:
>This adds missing locks in iommu_take_ownership()/
>iommu_release_ownership().
>
>This marks all pages busy in iommu_table::it_map in order to catch
>errors if there is an attempt to use this table while ownership over it
>is taken.
>
>This only clears TCE content if there is no page marked busy in it_map.
>Clearing must be done outside of the table locks as iommu_clear_tce()
>called from iommu_clear_tces_and_put_pages() does this.
>
>In order to use bitmap_empty(), the existing code clears bit#0 which
>is set even in an empty table if it is bus-mapped at 0 as
>iommu_init_table() reserves page#0 to prevent buggy drivers
>from crashing when allocated page is bus-mapped at zero
>(which is correct). This restores the bit in the case of failure
>to bring the it_map to the state it was in when we called
>iommu_take_ownership().
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
>Changes:
>v9:
>* iommu_table_take_ownership() did not return @ret (and ignored EBUSY),
>now it does return correct error.
>* updated commit log about setting bit#0 in the case of failure
>
>v5:
>* do not store bit#0 value, it has to be set for zero-based table
>anyway
>* removed test_and_clear_bit
>---
> arch/powerpc/kernel/iommu.c | 30 +++++++++++++++++++++++++-----
> 1 file changed, 25 insertions(+), 5 deletions(-)
>
>diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>index 7e54714..6275164 100644
>--- a/arch/powerpc/kernel/iommu.c
>+++ b/arch/powerpc/kernel/iommu.c
>@@ -1032,31 +1032,51 @@ EXPORT_SYMBOL_GPL(iommu_tce_build);
>
> int iommu_take_ownership(struct iommu_table *tbl)
> {
>-	unsigned long sz = (tbl->it_size + 7) >> 3;
>+	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
>+	int ret = 0;
>+
>+	spin_lock_irqsave(&tbl->large_pool.lock, flags);
>+	for (i = 0; i < tbl->nr_pools; i++)
>+		spin_lock(&tbl->pools[i].lock);
>
> 	if (tbl->it_offset == 0)
> 		clear_bit(0, tbl->it_map);
>
> 	if (!bitmap_empty(tbl->it_map, tbl->it_size)) {
> 		pr_err("iommu_tce: it_map is not empty");
>-		return -EBUSY;
>+		ret = -EBUSY;
>+		/* Restore bit#0 set by iommu_init_table() */
>+		if (tbl->it_offset == 0)
>+			set_bit(0, tbl->it_map);
>+	} else {
>+		memset(tbl->it_map, 0xff, sz);
> 	}
>
>-	memset(tbl->it_map, 0xff, sz);
>+	for (i = 0; i < tbl->nr_pools; i++)
>+		spin_unlock(&tbl->pools[i].lock);
>+	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
>
>-	return 0;
>+	return ret;
> }
> EXPORT_SYMBOL_GPL(iommu_take_ownership);
>
> void iommu_release_ownership(struct iommu_table *tbl)
> {
>-	unsigned long sz = (tbl->it_size + 7) >> 3;
>+	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
>+
>+	spin_lock_irqsave(&tbl->large_pool.lock, flags);
>+	for (i = 0; i < tbl->nr_pools; i++)
>+		spin_lock(&tbl->pools[i].lock);
>
> 	memset(tbl->it_map, 0, sz);
>
> 	/* Restore bit#0 set by iommu_init_table() */
> 	if (tbl->it_offset == 0)
> 		set_bit(0, tbl->it_map);
>+
>+	for (i = 0; i < tbl->nr_pools; i++)
>+		spin_unlock(&tbl->pools[i].lock);
>+	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
> }
> EXPORT_SYMBOL_GPL(iommu_release_ownership);
>
>-- 
>2.4.0.rc3.8.gfb3e7d5
>
