Return-Path: <alastair@d-silva.org>
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com
 [167.160.173.127])
 by lists.ozlabs.org (Postfix) with ESMTP id 40j5Wf3rx2zF2Ft
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 20:13:02 +1000 (AEST)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: "'Frederic Barrat'" <fbarrat@linux.ibm.com>,
 "'Alastair D'Silva'" <alastair@au1.ibm.com>,
 <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <mikey@neuling.org>, <vaibhav@linux.vnet.ibm.com>,
 <aneesh.kumar@linux.vnet.ibm.com>, <malat@debian.org>,
 <felix@linux.vnet.ibm.com>, <pombredanne@nexb.com>,
 <sukadev@linux.vnet.ibm.com>, <npiggin@gmail.com>,
 <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
 <andrew.donnellan@au1.ibm.com>, <fbarrat@linux.vnet.ibm.com>,
 <corbet@lwn.net>
References: <20180511061303.10728-1-alastair@au1.ibm.com>
 <20180511061303.10728-6-alastair@au1.ibm.com>
 <9656b063-eafd-a882-c678-a1c4d504cd54@linux.ibm.com>
In-Reply-To: <9656b063-eafd-a882-c678-a1c4d504cd54@linux.ibm.com>
Subject: RE: [PATCH v5 5/7] ocxl: Expose the thread_id needed for wait on
 POWER9
Date: Fri, 11 May 2018 20:06:54 +1000
Message-ID: <02a401d3e90f$cdb0be90$69123bb0$@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: Frederic Barrat <fbarrat@linux.ibm.com>
> Sent: Friday, 11 May 2018 7:25 PM
> To: Alastair D'Silva <alastair@au1.ibm.com>; =
linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org; linux-doc@vger.kernel.org;
> mikey@neuling.org; vaibhav@linux.vnet.ibm.com;
> aneesh.kumar@linux.vnet.ibm.com; malat@debian.org;
> felix@linux.vnet.ibm.com; pombredanne@nexb.com;
> sukadev@linux.vnet.ibm.com; npiggin@gmail.com;
> gregkh@linuxfoundation.org; arnd@arndb.de;
> andrew.donnellan@au1.ibm.com; fbarrat@linux.vnet.ibm.com;
> corbet@lwn.net; Alastair D'Silva <alastair@d-silva.org>
> Subject: Re: [PATCH v5 5/7] ocxl: Expose the thread_id needed for wait =
on
> POWER9
>=20
>=20
>=20
> Le 11/05/2018 =C3=A0 08:13, Alastair D'Silva a =C3=A9crit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> >
> > In order to successfully issue as_notify, an AFU needs to know the =
TID
> > to notify, which in turn means that this information should be
> > available in userspace so it can be communicated to the AFU.
> >
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
>=20
> Ok, so we keep the limitation of having only one thread per context =
able to
> call 'wait', even though we don't have to worry about depleting the =
pool of
> TIDs any more. I think that's acceptable, though we don't really have =
a reason
> to justify it any more. Any reason you want to keep it that way?
>=20

No strong reason, just trying to minimise the amount of changes. We can =
always expand the scope later, if we have a use-case for it.

>    Fred
>=20
>=20
> >   drivers/misc/ocxl/context.c       |  5 ++-
> >   drivers/misc/ocxl/file.c          | 53 =
+++++++++++++++++++++++++++++++
> >   drivers/misc/ocxl/link.c          | 36 +++++++++++++++++++++
> >   drivers/misc/ocxl/ocxl_internal.h |  1 +
> >   include/misc/ocxl.h               |  9 ++++++
> >   include/uapi/misc/ocxl.h          |  8 +++++
> >   6 files changed, 111 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/ocxl/context.c =
b/drivers/misc/ocxl/context.c
> > index 909e8807824a..95f74623113e 100644
> > --- a/drivers/misc/ocxl/context.c
> > +++ b/drivers/misc/ocxl/context.c
> > @@ -34,6 +34,8 @@ int ocxl_context_init(struct ocxl_context *ctx, =
struct
> ocxl_afu *afu,
> >   	mutex_init(&ctx->xsl_error_lock);
> >   	mutex_init(&ctx->irq_lock);
> >   	idr_init(&ctx->irq_idr);
> > +	ctx->tidr =3D 0;
> > +
> >   	/*
> >   	 * Keep a reference on the AFU to make sure it's valid for the
> >   	 * duration of the life of the context @@ -65,6 +67,7 @@ int
> > ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
> >   {
> >   	int rc;
> >
> > +	// Locks both status & tidr
> >   	mutex_lock(&ctx->status_mutex);
> >   	if (ctx->status !=3D OPENED) {
> >   		rc =3D -EIO;
> > @@ -72,7 +75,7 @@ int ocxl_context_attach(struct ocxl_context *ctx, =
u64
> amr)
> >   	}
> >
> >   	rc =3D ocxl_link_add_pe(ctx->afu->fn->link, ctx->pasid,
> > -			current->mm->context.id, 0, amr, current->mm,
> > +			current->mm->context.id, ctx->tidr, amr, current-
> >mm,
> >   			xsl_fault_error, ctx);
> >   	if (rc)
> >   		goto out;
> > diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c =
index
> > 038509e5d031..eb409a469f21 100644
> > --- a/drivers/misc/ocxl/file.c
> > +++ b/drivers/misc/ocxl/file.c
> > @@ -5,6 +5,8 @@
> >   #include <linux/sched/signal.h>
> >   #include <linux/uaccess.h>
> >   #include <uapi/misc/ocxl.h>
> > +#include <asm/reg.h>
> > +#include <asm/switch_to.h>
> >   #include "ocxl_internal.h"
> >
> >
> > @@ -123,11 +125,55 @@ static long afu_ioctl_get_metadata(struct
> ocxl_context *ctx,
> >   	return 0;
> >   }
> >
> > +#ifdef CONFIG_PPC64
> > +static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
> > +		struct ocxl_ioctl_p9_wait __user *uarg) {
> > +	struct ocxl_ioctl_p9_wait arg;
> > +
> > +	memset(&arg, 0, sizeof(arg));
> > +
> > +	if (cpu_has_feature(CPU_FTR_P9_TIDR)) {
> > +		enum ocxl_context_status status;
> > +
> > +		// Locks both status & tidr
> > +		mutex_lock(&ctx->status_mutex);
> > +		if (!ctx->tidr) {
> > +			if (set_thread_tidr(current))
> > +				return -ENOENT;
> > +
> > +			ctx->tidr =3D current->thread.tidr;
> > +		}
> > +
> > +		status =3D ctx->status;
> > +		mutex_unlock(&ctx->status_mutex);
> > +
> > +		if (status =3D=3D ATTACHED) {
> > +			int rc;
> > +			struct link *link =3D ctx->afu->fn->link;
> > +
> > +			rc =3D ocxl_link_update_pe(link, ctx->pasid, ctx->tidr);
> > +			if (rc)
> > +				return rc;
> > +		}
> > +
> > +		arg.thread_id =3D ctx->tidr;
> > +	} else
> > +		return -ENOENT;
> > +
> > +	if (copy_to_user(uarg, &arg, sizeof(arg)))
> > +		return -EFAULT;
> > +
> > +	return 0;
> > +}
> > +#endif
> > +
> >   #define CMD_STR(x) (x =3D=3D OCXL_IOCTL_ATTACH ? "ATTACH" :
> 		\
> >   			x =3D=3D OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC" :	\
> >   			x =3D=3D OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE" :
> 	\
> >   			x =3D=3D OCXL_IOCTL_IRQ_SET_FD ? "IRQ_SET_FD" :
> 	\
> >   			x =3D=3D OCXL_IOCTL_GET_METADATA ?
> "GET_METADATA" :	\
> > +			x =3D=3D OCXL_IOCTL_ENABLE_P9_WAIT ?
> "ENABLE_P9_WAIT" :	\
> >   			"UNKNOWN")
> >
> >   static long afu_ioctl(struct file *file, unsigned int cmd, @@ =
-186,6
> > +232,13 @@ static long afu_ioctl(struct file *file, unsigned int =
cmd,
> >   				(struct ocxl_ioctl_metadata __user *) args);
> >   		break;
> >
> > +#ifdef CONFIG_PPC64
> > +	case OCXL_IOCTL_ENABLE_P9_WAIT:
> > +		rc =3D afu_ioctl_enable_p9_wait(ctx,
> > +				(struct ocxl_ioctl_p9_wait __user *) args);
> > +		break;
> > +#endif
> > +
> >   	default:
> >   		rc =3D -EINVAL;
> >   	}
> > diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c =
index
> > 656e8610eec2..88876ae8f330 100644
> > --- a/drivers/misc/ocxl/link.c
> > +++ b/drivers/misc/ocxl/link.c
> > @@ -544,6 +544,42 @@ int ocxl_link_add_pe(void *link_handle, int =
pasid,
> u32 pidr, u32 tidr,
> >   }
> >   EXPORT_SYMBOL_GPL(ocxl_link_add_pe);
> >
> > +int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid) {
> > +	struct link *link =3D (struct link *) link_handle;
> > +	struct spa *spa =3D link->spa;
> > +	struct ocxl_process_element *pe;
> > +	int pe_handle, rc;
> > +
> > +	if (pasid > SPA_PASID_MAX)
> > +		return -EINVAL;
> > +
> > +	pe_handle =3D pasid & SPA_PE_MASK;
> > +	pe =3D spa->spa_mem + pe_handle;
> > +
> > +	mutex_lock(&spa->spa_lock);
> > +
> > +	pe->tid =3D tid;
> > +
> > +	/*
> > +	 * The barrier makes sure the PE is updated
> > +	 * before we clear the NPU context cache below, so that the
> > +	 * old PE cannot be reloaded erroneously.
> > +	 */
> > +	mb();
> > +
> > +	/*
> > +	 * hook to platform code
> > +	 * On powerpc, the entry needs to be cleared from the context
> > +	 * cache of the NPU.
> > +	 */
> > +	rc =3D pnv_ocxl_spa_remove_pe_from_cache(link->platform_data,
> pe_handle);
> > +	WARN_ON(rc);
> > +
> > +	mutex_unlock(&spa->spa_lock);
> > +	return rc;
> > +}
> > +
> >   int ocxl_link_remove_pe(void *link_handle, int pasid)
> >   {
> >   	struct link *link =3D (struct link *) link_handle; diff --git
> > a/drivers/misc/ocxl/ocxl_internal.h
> > b/drivers/misc/ocxl/ocxl_internal.h
> > index 5d421824afd9..a32f2151029f 100644
> > --- a/drivers/misc/ocxl/ocxl_internal.h
> > +++ b/drivers/misc/ocxl/ocxl_internal.h
> > @@ -77,6 +77,7 @@ struct ocxl_context {
> >   	struct ocxl_xsl_error xsl_error;
> >   	struct mutex irq_lock;
> >   	struct idr irq_idr;
> > +	u16 tidr; // Thread ID used for P9 wait implementation
> >   };
> >
> >   struct ocxl_process_element {
> > diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h index
> > 51ccf76db293..9ff6ddc28e22 100644
> > --- a/include/misc/ocxl.h
> > +++ b/include/misc/ocxl.h
> > @@ -188,6 +188,15 @@ extern int ocxl_link_add_pe(void *link_handle, =
int
> pasid, u32 pidr, u32 tidr,
> >   		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
> >   		void *xsl_err_data);
> >
> > +/**
> > + * Update values within a Process Element
> > + *
> > + * link_handle: the link handle associated with the process element
> > + * pasid: the PASID for the AFU context
> > + * tid: the new thread id for the process element  */ extern int
> > +ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
> > +
> >   /*
> >    * Remove a Process Element from the Shared Process Area for a =
link
> >    */
> > diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h =
index
> > 0af83d80fb3e..561e6f0dfcb7 100644
> > --- a/include/uapi/misc/ocxl.h
> > +++ b/include/uapi/misc/ocxl.h
> > @@ -48,6 +48,13 @@ struct ocxl_ioctl_metadata {
> >   	__u64 reserved[13]; // Total of 16*u64
> >   };
> >
> > +struct ocxl_ioctl_p9_wait {
> > +	__u16 thread_id; // The thread ID required to wake this thread
> > +	__u16 reserved1;
> > +	__u32 reserved2;
> > +	__u64 reserved3[3];
> > +};
> > +
> >   struct ocxl_ioctl_irq_fd {
> >   	__u64 irq_offset;
> >   	__s32 eventfd;
> > @@ -62,5 +69,6 @@ struct ocxl_ioctl_irq_fd {
> >   #define OCXL_IOCTL_IRQ_FREE	_IOW(OCXL_MAGIC, 0x12, __u64)
> >   #define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct
> ocxl_ioctl_irq_fd)
> >   #define OCXL_IOCTL_GET_METADATA _IOR(OCXL_MAGIC, 0x14, struct
> > ocxl_ioctl_metadata)
> > +#define OCXL_IOCTL_ENABLE_P9_WAIT	_IOR(OCXL_MAGIC, 0x15,
> struct ocxl_ioctl_p9_wait)
> >
> >   #endif /* _UAPI_MISC_OCXL_H */
> >
>=20
>=20
> ---
> This email has been checked for viruses by AVG.
> http://www.avg.com
