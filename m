Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 267611A001E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 15:48:53 +1000 (AEST)
Message-ID: <1438926532.16275.9.camel@neuling.org>
Subject: Re: [PATCH 2/4] cxl: sparse: Make declarations static
From: Michael Neuling <mikey@neuling.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, imunsie@au.ibm.com
Date: Fri, 07 Aug 2015 15:48:52 +1000
In-Reply-To: <1438917500-12100-2-git-send-email-dja@axtens.net>
References: <1438917500-12100-1-git-send-email-dja@axtens.net>
 <1438917500-12100-2-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-08-07 at 13:18 +1000, Daniel Axtens wrote:
> A few declarations were identified by sparse as needing to be static:
>=20
> /scratch/dja/linux-capi/drivers/misc/cxl/irq.c:408:6: warning: symbol 'af=
u_irq_name_free' was not declared. Should it be static?
> /scratch/dja/linux-capi/drivers/misc/cxl/irq.c:467:6: warning: symbol 'af=
u_register_hwirqs' was not declared. Should it be static?
> /scratch/dja/linux-capi/drivers/misc/cxl/file.c:254:6: warning: symbol 'a=
fu_compat_ioctl' was not declared. Should it be static?
> /scratch/dja/linux-capi/drivers/misc/cxl/file.c:399:30: warning: symbol '=
afu_master_fops' was not declared. Should it be static?
>=20
> Make them static.
>=20
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
>  drivers/misc/cxl/file.c | 4 ++--
>  drivers/misc/cxl/irq.c  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> index e3f4b69527a9..c8c8bfa2679b 100644
> --- a/drivers/misc/cxl/file.c
> +++ b/drivers/misc/cxl/file.c
> @@ -251,7 +251,7 @@ long afu_ioctl(struct file *file, unsigned int cmd, u=
nsigned long arg)
>  	return -EINVAL;
>  }
> =20
> -long afu_compat_ioctl(struct file *file, unsigned int cmd,
> +static long afu_compat_ioctl(struct file *file, unsigned int cmd,
>  			     unsigned long arg)
>  {
>  	return afu_ioctl(file, cmd, arg);
> @@ -396,7 +396,7 @@ const struct file_operations afu_fops =3D {
>  	.mmap           =3D afu_mmap,
>  };
> =20
> -const struct file_operations afu_master_fops =3D {
> +static const struct file_operations afu_master_fops =3D {
>  	.owner		=3D THIS_MODULE,
>  	.open           =3D afu_master_open,
>  	.poll		=3D afu_poll,
> diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
> index 680cd263436d..77e5d0e7ebe1 100644
> --- a/drivers/misc/cxl/irq.c
> +++ b/drivers/misc/cxl/irq.c
> @@ -405,7 +405,7 @@ void cxl_release_psl_irq(struct cxl_afu *afu)
>  	kfree(afu->psl_irq_name);
>  }
> =20
> -void afu_irq_name_free(struct cxl_context *ctx)
> +static void afu_irq_name_free(struct cxl_context *ctx)
>  {
>  	struct cxl_irq_name *irq_name, *tmp;
> =20
> @@ -464,7 +464,7 @@ out:
>  	return -ENOMEM;
>  }
> =20
> -void afu_register_hwirqs(struct cxl_context *ctx)
> +static void afu_register_hwirqs(struct cxl_context *ctx)
>  {
>  	irq_hw_number_t hwirq;
>  	struct cxl_irq_name *irq_name;
