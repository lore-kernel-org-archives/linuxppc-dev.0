Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8016A2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jul 2013 17:21:03 +1000 (EST)
Message-ID: <1373268055.4446.31.camel@pasglop>
Subject: Re: [PATCH v2] powerpc: add real mode support for dma operations on
 powernv
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 08 Jul 2013 17:20:55 +1000
In-Reply-To: <1373258669-3130-1-git-send-email-aik@ozlabs.ru>
References: <1373123227-22969-6-git-send-email-aik@ozlabs.ru>
 <1373258669-3130-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-07-08 at 14:44 +1000, Alexey Kardashevskiy wrote:

> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
> index 25d76c4..7ea82c1 100644
> --- a/arch/powerpc/platforms/powernv/pci.h
> +++ b/arch/powerpc/platforms/powernv/pci.h
> @@ -52,6 +52,7 @@ struct pnv_ioda_pe {
>  	int			tce32_seg;
>  	int			tce32_segcount;
>  	struct iommu_table	tce32_table;
> +	phys_addr_t		it_index_rm;

Please ....

The fact that we hijack the it_index field of the iommu table
for the virtual address is bad enough, but really don't need
to perpetuate this :-)

Call the field something decent such as "tce_inval_reg_phys"

Cheers,
Ben.
