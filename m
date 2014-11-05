Return-Path: <joro@8bytes.org>
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D4251A0615
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Nov 2014 22:24:40 +1100 (AEDT)
Date: Wed, 5 Nov 2014 12:16:56 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the iommu tree
Message-ID: <20141105111656.GJ10744@8bytes.org>
References: <20141105134731.799a1a3d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141105134731.799a1a3d@canb.auug.org.au>
Cc: Olav Haugan <ohaugan@codeaurora.org>, linux-next@vger.kernel.org,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 05, 2014 at 01:47:31PM +1100, Stephen Rothwell wrote:
> Hi Joerg,
> 
> After merging the iommu tree, today's linux-next build (powerpc
> pc64_defconfig) failed like this:
> 
> In file included from arch/powerpc/platforms/powernv/pci.c:33:0:
> arch/powerpc/include/asm/iommu.h:140:12: error: conflicting types for 'iommu_map_sg'
>  extern int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
>             ^
> In file included from arch/powerpc/platforms/powernv/pci.c:23:0:
> include/linux/iommu.h:311:22: note: previous definition of 'iommu_map_sg' was here
>  static inline size_t iommu_map_sg(struct iommu_domain *domain,
>                       ^
> 
> Caused by commit 315786ebbf4a ("iommu: Add iommu_map_sg() function").
> Grep is your friend ...
> 
> I have used the iommu tree from next-20141104 for today.

Thanks Stephen, I exluded the my core branch from next for now until the
issue is fixed.


	Joerg
