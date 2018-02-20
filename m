Return-Path: <mhairgrove@nvidia.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmF270qmdzF19w
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 09:01:34 +1100 (AEDT)
Date: Tue, 20 Feb 2018 10:34:49 -0800
From: Mark Hairgrove <mhairgrove@nvidia.com>
To: Balbir Singh <bsingharora@gmail.com>
CC: Alistair Popple <alistair@popple.id.au>, <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>, Javier Cabezas <jcabezas@nvidia.com>
Subject: Re: [PATCH] powerpc/npu-dma.c: Fix deadlock in mmio_invalidate
In-Reply-To: <20180219135704.3bd0cfb9@balbir.ozlabs.ibm.com>
Message-ID: <alpine.DEB.2.00.1802201031020.18286@mdh-linux64-2.nvidia.com>
References: <20180213031734.19831-1-alistair@popple.id.au>
 <20180213170620.409daf29@balbir.ozlabs.ibm.com>
 <3544963.SI8Y64vzmd@new-mexico>
 <alpine.DEB.2.00.1802151910400.10245@mdh-linux64-2.nvidia.com>
 <20180219135704.3bd0cfb9@balbir.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Mon, 19 Feb 2018, Balbir Singh wrote:

> Good point, although I think the acquire_* function itself may be called
> from a higher layer with the mmap_sem always held. I wonder if we need
> barriers around get and put mmio_atsd_reg.

I agree with the need for memory barriers. FWIW, page tables can be
invalidated without mmap_sem being held, for example by
unmap_mapping_range.
