Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 278331A0205
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 22:51:50 +1000 (AEST)
Date: Wed, 13 May 2015 14:51:36 +0200
From: Thomas Huth <thuth@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v10 05/34] powerpc/iommu: Always release
 iommu_table in iommu_free_table()
Message-ID: <20150513145136.1a85f536@thh440s>
In-Reply-To: <5552EF78.6020301@ozlabs.ru>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-6-git-send-email-aik@ozlabs.ru>
 <20150513053337.GA479@gwshan> <5552EF78.6020301@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 13 May 2015 16:30:16 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 05/13/2015 03:33 PM, Gavin Shan wrote:
> > On Tue, May 12, 2015 at 01:38:54AM +1000, Alexey Kardashevskiy wrote:
> >> At the moment iommu_free_table() only releases memory if
> >> the table was initialized for the platform code use, i.e. it had
> >> it_map initialized (which purpose is to track DMA memory space use).
> >>
> >> With dynamic DMA windows, we will need to be able to release
> >> iommu_table even if it was used for VFIO in which case it_map is NULL
> >> so does the patch.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >
> > Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> >
> >> ---
> >> arch/powerpc/kernel/iommu.c | 3 +--
> >> 1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> >> index 3d47eb3..2c02d4c 100644
> >> --- a/arch/powerpc/kernel/iommu.c
> >> +++ b/arch/powerpc/kernel/iommu.c
> >> @@ -714,8 +714,7 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
> >> 	unsigned int order;
> >>
> >> 	if (!tbl || !tbl->it_map) {
> >> -		printk(KERN_ERR "%s: expected TCE map for %s\n", __func__,
> >> -				node_name);
> >> +		kfree(tbl);
> >
> > I'm not sure if the "tbl" needs to be checked against NULL as kfree() already
> > has the check. But it looks a bit strange to free NULL "tbl" from the code
> > itself.
> 
> Yeah, looks a bit weird, agree, I'll change but in general kfree/vfree/... 
> - they all check the passed pointer for NULL.

But if tbl is NULL, the tbl->it_map check will fail, won't it? So in
this case, I think you have to keep it.

 Thomas
