Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xVw44DjyzDqww
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 15:59:00 +1000 (AEST)
Date: Fri, 24 Aug 2018 08:00:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Anshuman Khandual <anshuman.linux@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christoph Hellwig <hch@lst.de>, Michael Ellerman <mpe@ellerman.id.au>,
 Mike Anderson <andmike@linux.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ram Pai <linuxram@us.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 10/11] powerpc/svm: Force the use of bounce buffers
Message-ID: <20180824060055.GB13689@lst.de>
References: <20180824025933.24319-1-bauerman@linux.ibm.com>
 <20180824025933.24319-11-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180824025933.24319-11-bauerman@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 23, 2018 at 11:59:32PM -0300, Thiago Jung Bauermann wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> SWIOTLB checks range of incoming CPU addresses to be bounced and see if the
> device can access it through it's DMA window without requiring bouncing. In
> such cases it just chooses to skip bouncing. But for cases like secure
> guests on powerpc platform all addresses need to be bounced into the shared
> pool of memory because the host cannot access it otherwise. Hence the need
> to do the bouncing is not related to device's DMA window. Hence force the
> use of bouncing by setting the swiotlb_force variable on secure guests.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/powerpc/kernel/svm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/kernel/svm.c b/arch/powerpc/kernel/svm.c
> index 1af5caa955f5..f0576ad65cd0 100644
> --- a/arch/powerpc/kernel/svm.c
> +++ b/arch/powerpc/kernel/svm.c
> @@ -17,6 +17,7 @@ static int __init init_svm(void)
>  		return 0;
>  
>  	ppc_swiotlb_enable = 1;
> +	swiotlb_force = SWIOTLB_FORCE;
>  	swiotlb_update_mem_attributes();

This needs a comment.
