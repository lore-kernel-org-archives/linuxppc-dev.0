Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 3D850DE53B
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 03:41:00 +1000 (EST)
Date: Tue, 29 Apr 2008 12:54:17 -0500
From: Olof Johansson <olof@lixom.net>
To: Mark Nelson <markn@au1.ibm.com>
Subject: Re: [PATCH] [POWERPC] Add struct iommu_table argument to
	iommu_map_sg()
Message-ID: <20080429175413.GA10269@lixom.net>
References: <4816AF79.502@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4816AF79.502@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 29, 2008 at 03:17:45PM +1000, Mark Nelson wrote:
> Make iommu_map_sg take a struct iommu_table. It did so before commit
> 740c3ce66700640a6e6136ff679b067e92125794 (iommu sg merging: ppc: make
> iommu respect the segment size limits).
>
> This stops the function looking in the archdata.dma_data for the iommu
> table because in the future it will be called with a device that has
> no table there.

The logical thing would be to add the archdata.dma_data to said device
instead, no? Without seeing the rest of the code that makes use of it
it's hard to tell anyway, so please post that.

> This also has the nice side effect of making iommu_map_sg() match the
> other map functions.

Consistency is good, but I wonder if the opposite wouldn't be the better
way to go here: always just pass down just the dev pointer instead. The
table can be reached from it.


-Olof
