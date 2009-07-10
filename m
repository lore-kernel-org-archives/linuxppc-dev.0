Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ABBCEB7096
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 11:47:44 +1000 (EST)
Date: Fri, 10 Jul 2009 10:47:37 +0900
To: linuxppc-dev@lists.ozlabs.org
Subject: removing addr_needs_map in struct dma_mapping_ops
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20090710104706I.fujita.tomonori@lab.ntt.co.jp>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm trying to convert POWERPC to use asm-generic/dma-mapping-common.h.

POWERPC needs addr_needs_map() in struct dma_mapping_ops for SWIOTLB
support but I want to avoid add addr_needs_map() in struct
dma_map_ops. IIRC, you guys think it as a temporary solution and
talked about defining something like struct dma_data. Then we could

struct dev_archdata {
       ...

       struct dma_data *ddata;
};

or

struct dev_archdata {
       ...

       struct dma_data ddata;
};


struct dma_data needs dma_direct_offset, iommu_table, dma_base, and
dma_window_size, anything else?


Is it acceptable?
