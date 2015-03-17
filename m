Return-Path: <alex.williamson@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 475B31A0010
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 07:45:59 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C1DA2140077
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2015 07:45:58 +1100 (AEDT)
Message-ID: <1426625149.3643.335.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] drivers/vfio: Support EEH error injection
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Tue, 17 Mar 2015 14:45:49 -0600
In-Reply-To: <1426489282-16725-2-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1426489282-16725-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1426489282-16725-2-git-send-email-gwshan@linux.vnet.ibm.com>
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

On Mon, 2015-03-16 at 18:01 +1100, Gavin Shan wrote:
> The patch adds one more EEH sub-command (VFIO_EEH_PE_INJECT_ERR)
> to inject the specified EEH error, which is represented by
> (struct vfio_eeh_pe_err), to the indicated PE for testing purpose.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
> v2: Put additional arguments for error injection to union
> ---
>  Documentation/vfio.txt        | 12 ++++++++++++
>  drivers/vfio/vfio_spapr_eeh.c | 10 ++++++++++
>  include/uapi/linux/vfio.h     | 36 +++++++++++++++++++++++++++++++++++-
>  3 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> index 96978ec..c6e11a3 100644
> --- a/Documentation/vfio.txt
> +++ b/Documentation/vfio.txt
> @@ -385,6 +385,18 @@ The code flow from the example above should be slightly changed:
>  
>  	....
>  
> +	/* Inject EEH error, which is expected to be caused by 32-bits
> +	 * config load.
> +	 */
> +	pe_op.op = VFIO_EEH_PE_INJECT_ERR;
> +	pe_op.err.type = VFIO_EEH_ERR_TYPE_32;
> +	pe_op.err.func = VFIO_EEH_ERR_FUNC_LD_CFG_ADDR;
> +	pe_op.err.addr = 0ul;
> +	pe_op.err.mask = 0ul;
> +	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
> +
> +	....
> +
>  	/* When 0xFF's returned from reading PCI config space or IO BARs
>  	 * of the PCI device. Check the PE's state to see if that has been
>  	 * frozen.
> diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
> index 5fa42db..25ca634 100644
> --- a/drivers/vfio/vfio_spapr_eeh.c
> +++ b/drivers/vfio/vfio_spapr_eeh.c
> @@ -85,6 +85,16 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
>  		case VFIO_EEH_PE_CONFIGURE:
>  			ret = eeh_pe_configure(pe);
>  			break;
> +		case VFIO_EEH_PE_INJECT_ERR:
> +			if (op.argsz < sizeof(struct vfio_eeh_pe_op))

This will need to be updated if vfio_eeh_pe_op ever gets updated again,
why not just use offsetofend() now and avoid that future hassle and
breakage.

> +				return -EINVAL;
> +			if (copy_from_user(&op, (void __user *)arg,
> +					   sizeof(struct vfio_eeh_pe_op)))

And here.

BTW, please use cover letters

> +				return -EFAULT;
> +
> +			ret = eeh_pe_inject_err(pe, op.err.type, op.err.func,
> +						op.err.addr, op.err.mask);
> +			break;
>  		default:
>  			ret = -EINVAL;
>  		}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 82889c3..f68e962 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -468,12 +468,23 @@ struct vfio_iommu_spapr_tce_info {
>   * - unfreeze IO/DMA for frozen PE;
>   * - read PE state;
>   * - reset PE;
> - * - configure PE.
> + * - configure PE;
> + * - inject EEH error.
>   */
> +struct vfio_eeh_pe_err {
> +	__u32 type;
> +	__u32 func;
> +	__u64 addr;
> +	__u64 mask;
> +};
> +
>  struct vfio_eeh_pe_op {
>  	__u32 argsz;
>  	__u32 flags;
>  	__u32 op;
> +	union {
> +		struct vfio_eeh_pe_err err;
> +	};
>  };
>  
>  #define VFIO_EEH_PE_DISABLE		0	/* Disable EEH functionality */
> @@ -490,6 +501,29 @@ struct vfio_eeh_pe_op {
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
>  
>  #define VFIO_EEH_PE_OP			_IO(VFIO_TYPE, VFIO_BASE + 21)
>  
