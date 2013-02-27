Return-Path: <joro@8bytes.org>
Received: from mail.8bytes.org (8bytes.org
 [IPv6:2a01:238:4242:f000:64f:6c43:3523:e535])
 by ozlabs.org (Postfix) with ESMTP id 1166A2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2013 22:30:51 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id E9B9C12B0EE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2013 12:30:46 +0100 (CET)
Date: Wed, 27 Feb 2013 12:30:45 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information pointer
 in archdata.
Message-ID: <20130227113045.GH26252@8bytes.org>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
 <1361191939-21260-2-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361191939-21260-2-git-send-email-Varun.Sethi@freescale.com>
Cc: scottwood@freescale.com, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stuart.yoder@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 18, 2013 at 06:22:14PM +0530, Varun Sethi wrote:
> Add a new field in the device (powerpc) archdata structure for storing iommu domain
> information pointer. This pointer is stored when the device is attached to a particular
> domain.
> 
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> - no change.
>  arch/powerpc/include/asm/device.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
> index 77e97dd..6dc79fe 100644
> --- a/arch/powerpc/include/asm/device.h
> +++ b/arch/powerpc/include/asm/device.h
> @@ -28,6 +28,10 @@ struct dev_archdata {
>  		void		*iommu_table_base;
>  	} dma_data;
>  
> +	/* IOMMU domain information pointer. This would be set
> +	 * when this device is attached to an iommu_domain.
> +	 */
> +	void			*iommu_domain;

Please Cc the PowerPC Maintainers on this, so that they can have a look
at it. This also must be put this into an #ifdef CONFIG_IOMMU_API.


	Joerg
