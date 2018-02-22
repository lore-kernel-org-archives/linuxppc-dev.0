Return-Path: <srs0=6jub=fq=linux.vnet.ibm.com=fbarrat@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znCy63q4CzDqtP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 23:16:30 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3znCy31pRpz8t6w
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 23:16:27 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3znCy00dCDz9sWQ
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 23:16:23 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MCCAJG105340
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 07:16:21 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g9sy0hx8y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 07:16:17 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 12:16:11 -0000
Subject: Re: [PATCH v3 1/2] ocxl: Add get_metadata IOCTL to share OCXL
 information to userspace
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, frederic.barrat@fr.ibm.com, gregkh@linuxfoundation.org,
 andrew.donnellan@au1.ibm.com, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180222030334.14060-1-alastair@au1.ibm.com>
 <20180222041739.27899-1-alastair@au1.ibm.com>
 <20180222041739.27899-2-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 22 Feb 2018 13:16:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180222041739.27899-2-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b9e7dc51-33b2-f72f-6687-3ee8f6bccc21@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/02/2018 à 05:17, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Some required information is not exposed to userspace currently (eg. the
> PASID), pass this information back, along with other information which
> is currently communicated via sysfs, which saves some parsing effort in
> userspace.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---

Thanks!
Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   drivers/misc/ocxl/file.c | 27 +++++++++++++++++++++++++++
>   include/uapi/misc/ocxl.h | 17 +++++++++++++++++
>   2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
> index d9aa407db06a..90df1be5ef3f 100644
> --- a/drivers/misc/ocxl/file.c
> +++ b/drivers/misc/ocxl/file.c
> @@ -102,10 +102,32 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
>   	return rc;
>   }
> 
> +static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
> +		struct ocxl_ioctl_metadata __user *uarg)
> +{
> +	struct ocxl_ioctl_metadata arg;
> +
> +	memset(&arg, 0, sizeof(arg));
> +
> +	arg.version = 0;
> +
> +	arg.afu_version_major = ctx->afu->config.version_major;
> +	arg.afu_version_minor = ctx->afu->config.version_minor;
> +	arg.pasid = ctx->pasid;
> +	arg.pp_mmio_size = ctx->afu->config.pp_mmio_stride;
> +	arg.global_mmio_size = ctx->afu->config.global_mmio_size;
> +
> +	if (copy_to_user(uarg, &arg, sizeof(arg)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>   #define CMD_STR(x) (x == OCXL_IOCTL_ATTACH ? "ATTACH" :			\
>   			x == OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC" :	\
>   			x == OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE" :		\
>   			x == OCXL_IOCTL_IRQ_SET_FD ? "IRQ_SET_FD" :	\
> +			x == OCXL_IOCTL_GET_METADATA ? "GET_METADATA" :	\
>   			"UNKNOWN")
> 
>   static long afu_ioctl(struct file *file, unsigned int cmd,
> @@ -157,6 +179,11 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
>   					irq_fd.eventfd);
>   		break;
> 
> +	case OCXL_IOCTL_GET_METADATA:
> +		rc = afu_ioctl_get_metadata(ctx,
> +				(struct ocxl_ioctl_metadata __user *) args);
> +		break;
> +
>   	default:
>   		rc = -EINVAL;
>   	}
> diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
> index 4b0b0b756f3e..0af83d80fb3e 100644
> --- a/include/uapi/misc/ocxl.h
> +++ b/include/uapi/misc/ocxl.h
> @@ -32,6 +32,22 @@ struct ocxl_ioctl_attach {
>   	__u64 reserved3;
>   };
> 
> +struct ocxl_ioctl_metadata {
> +	__u16 version; // struct version, always backwards compatible
> +
> +	// Version 0 fields
> +	__u8  afu_version_major;
> +	__u8  afu_version_minor;
> +	__u32 pasid;		// PASID assigned to the current context
> +
> +	__u64 pp_mmio_size;	// Per PASID MMIO size
> +	__u64 global_mmio_size;
> +
> +	// End version 0 fields
> +
> +	__u64 reserved[13]; // Total of 16*u64
> +};
> +
>   struct ocxl_ioctl_irq_fd {
>   	__u64 irq_offset;
>   	__s32 eventfd;
> @@ -45,5 +61,6 @@ struct ocxl_ioctl_irq_fd {
>   #define OCXL_IOCTL_IRQ_ALLOC	_IOR(OCXL_MAGIC, 0x11, __u64)
>   #define OCXL_IOCTL_IRQ_FREE	_IOW(OCXL_MAGIC, 0x12, __u64)
>   #define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct ocxl_ioctl_irq_fd)
> +#define OCXL_IOCTL_GET_METADATA _IOR(OCXL_MAGIC, 0x14, struct ocxl_ioctl_metadata)
> 
>   #endif /* _UAPI_MISC_OCXL_H */
> 
