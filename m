Return-Path: <alex.williamson@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B7021A0739
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 06:13:35 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C8381140083
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2015 06:13:34 +1100 (AEDT)
Message-ID: <1427829206.5567.184.camel@redhat.com>
Subject: Re: [PATCH v5 3/3] drivers/vfio: Support EEH error injection
From: Alex Williamson <alex.williamson@redhat.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Tue, 31 Mar 2015 13:13:26 -0600
In-Reply-To: <1427348529-7060-4-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1427348529-7060-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1427348529-7060-4-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, agraf@suse.de, kvm@vger.kernel.org,
 david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-26 at 16:42 +1100, Gavin Shan wrote:
> The patch adds one more EEH sub-command (VFIO_EEH_PE_INJECT_ERR)
> to inject the specified EEH error, which is represented by
> (struct vfio_eeh_pe_err), to the indicated PE for testing purpose.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  Documentation/vfio.txt        | 12 ++++++++++++
>  drivers/vfio/vfio_spapr_eeh.c | 10 ++++++++++
>  include/uapi/linux/vfio.h     | 14 +++++++++++++-
>  3 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> index 96978ec..4c746a7 100644
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
> +	pe_op.err.type = EEH_ERR_TYPE_32;
> +	pe_op.err.func = EEH_ERR_FUNC_LD_CFG_ADDR;
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
> index 5fa42db..38edeb4 100644
> --- a/drivers/vfio/vfio_spapr_eeh.c
> +++ b/drivers/vfio/vfio_spapr_eeh.c
> @@ -85,6 +85,16 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
>  		case VFIO_EEH_PE_CONFIGURE:
>  			ret = eeh_pe_configure(pe);
>  			break;
> +		case VFIO_EEH_PE_INJECT_ERR:
> +			minsz = offsetofend(struct vfio_eeh_pe_op, err.mask);
> +			if (op.argsz < minsz)
> +				return -EINVAL;
> +			if (copy_from_user(&op, (void __user *)arg, minsz))
> +				return -EFAULT;
> +
> +			ret = eeh_pe_inject_err(pe, op.err.type, op.err.func,
> +						op.err.addr, op.err.mask);
> +			break;
>  		default:
>  			ret = -EINVAL;
>  		}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 82889c3..d81c17f 100644
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
> @@ -490,6 +501,7 @@ struct vfio_eeh_pe_op {
>  #define VFIO_EEH_PE_RESET_HOT		6	/* Assert hot reset          */
>  #define VFIO_EEH_PE_RESET_FUNDAMENTAL	7	/* Assert fundamental reset  */
>  #define VFIO_EEH_PE_CONFIGURE		8	/* PE configuration          */
> +#define VFIO_EEH_PE_INJECT_ERR		9	/* Inject EEH error          */
>  
>  #define VFIO_EEH_PE_OP			_IO(VFIO_TYPE, VFIO_BASE + 21)
>  

I assume you want this to go in through the PPC tree, so

Acked-by: Alex Williamson <alex.williamson@redhat.com>
