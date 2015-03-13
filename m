Return-Path: <alex.williamson@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA9471A08E9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2015 07:35:25 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 342D814009B
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2015 07:35:25 +1100 (AEDT)
Message-ID: <1426278918.3643.123.camel@redhat.com>
Subject: Re: [PATCH 2/2] drivers/vfio: Support EEH error injection
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Fri, 13 Mar 2015 14:35:18 -0600
In-Reply-To: <1426055651-22925-2-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1426055651-22925-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1426055651-22925-2-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, agraf@suse.de, kvm@vger.kernel.org,
 david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-03-11 at 17:34 +1100, Gavin Shan wrote:
> The patch adds one more EEH sub-command (VFIO_EEH_PE_INJECT_ERR)
> to inject the specified EEH error, which is represented by
> (struct vfio_eeh_pe_err), to the indicated PE for testing purpose.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  Documentation/vfio.txt        | 47 ++++++++++++++++++++++++++++++-------------
>  drivers/vfio/vfio_spapr_eeh.c | 14 +++++++++++++
>  include/uapi/linux/vfio.h     | 34 ++++++++++++++++++++++++++++++-
>  3 files changed, 80 insertions(+), 15 deletions(-)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
[snip]
> @@ -490,6 +499,29 @@ struct vfio_eeh_pe_op {
>  #define VFIO_EEH_PE_RESET_HOT		6	/* Assert hot reset          */
>  #define VFIO_EEH_PE_RESET_FUNDAMENTAL	7	/* Assert fundamental reset  */
>  #define VFIO_EEH_PE_CONFIGURE		8	/* PE configuration          */
> +#define VFIO_EEH_PE_INJECT_ERR		9	/* Inject EEH error          */
> +#define  VFIO_EEH_ERR_TYPE_32		0	/* 32-bits EEH error type    */
> +#define  VFIO_EEH_ERR_TYPE_64		1	/* 64-bits EEH error type    */
> +#define  VFIO_EEH_ERR_FUNC_LD_MEM_ADDR		0	/* Memory load  */
> +#define  VFIO_EEH_ERR_FUNC_LD_MEM_DATA		1
> +#define  VFIO_EEH_ERR_FUNC_LD_IO_ADDR		2	/* IO load      */
> +#define  VFIO_EEH_ERR_FUNC_LD_IO_DATA		3
> +#define  VFIO_EEH_ERR_FUNC_LD_CFG_ADDR		4	/* Config load  */
> +#define  VFIO_EEH_ERR_FUNC_LD_CFG_DATA		5
> +#define  VFIO_EEH_ERR_FUNC_ST_MEM_ADDR		6	/* Memory store */
> +#define  VFIO_EEH_ERR_FUNC_ST_MEM_DATA		7
> +#define  VFIO_EEH_ERR_FUNC_ST_IO_ADDR		8	/* IO store     */
> +#define  VFIO_EEH_ERR_FUNC_ST_IO_DATA		9
> +#define  VFIO_EEH_ERR_FUNC_ST_CFG_ADDR		10	/* Config store */
> +#define  VFIO_EEH_ERR_FUNC_ST_CFG_DATA		11
> +#define  VFIO_EEH_ERR_FUNC_DMA_RD_ADDR		12	/* DMA read     */
> +#define  VFIO_EEH_ERR_FUNC_DMA_RD_DATA		13
> +#define  VFIO_EEH_ERR_FUNC_DMA_RD_MASTER	14
> +#define  VFIO_EEH_ERR_FUNC_DMA_RD_TARGET	15
> +#define  VFIO_EEH_ERR_FUNC_DMA_WR_ADDR		16	/* DMA write    */
> +#define  VFIO_EEH_ERR_FUNC_DMA_WR_DATA		17
> +#define  VFIO_EEH_ERR_FUNC_DMA_WR_MASTER	18
> +#define  VFIO_EEH_ERR_FUNC_DMA_WR_TARGET	19

This data duplication from patch 1/2 is kind of concerning.  In one case
we're adding to arch/powerpc/include/asm/eeh.h, which is a kernel
internal interface and entirely changeable, in the other we're matching
those current definitions in uapi, which needs to be stable.  Are these
indexes part of a spec that we can rely on them being stable or do we
need some sort of translation layer to go from the vfio uapi defined
value to the kernel internal version?  Thanks,

Alex
