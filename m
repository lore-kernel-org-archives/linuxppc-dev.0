Return-Path: <michael.neuling@au.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 99FEB1A11B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 13:20:49 +1100 (AEDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 6F64D14031D
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2016 13:20:49 +1100 (AEDT)
Message-ID: <1453256449.28504.56.camel@au.ibm.com>
Subject: Re: [PATCH] cxl: Add cxl_read_adapter_vpd() to the kernel API
From: Michael Neuling <michael.neuling@au.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, ian@ozlabs.au.ibm.com,
 linuxppc-dev@ozlabs.org
Date: Wed, 20 Jan 2016 13:20:49 +1100
In-Reply-To: <1453223694-5190-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1453223694-5190-1-git-send-email-fbarrat@linux.vnet.ibm.com>
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

On Tue, 2016-01-19 at 18:14 +0100, Frederic Barrat wrote:
> Introduce a new API to read the VPD of the adapter. In bare-metal, a
> kernel driver can find out the adapter pci_dev behind the AFU device
> and call pci_read_vpd() directly, but it won't work in a (powerVM)
> guest.
> Current implementation is a stub to allow existing drivers (cxlflash)
> to start using it.

This looks good.

The only thing I'm a bit concerned about is are we going to end up
duplicating a lot of the linux PCI API, but I guess we are only going
to do this for things the papr HCALL interface mimics.

Mikey

> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
>  drivers/misc/cxl/api.c | 8 ++++++++
>  include/misc/cxl.h     | 5 +++++
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index ea3eeb7..c73aa3a 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -363,3 +363,11 @@ void cxl_perst_reloads_same_image(struct cxl_afu
> *afu,
>  	afu->adapter->perst_same_image =3D perst_reloads_same_image;
>  }
>  EXPORT_SYMBOL_GPL(cxl_perst_reloads_same_image);
> +
> +ssize_t cxl_read_adapter_vpd(struct pci_dev *afu_dev, void *buf,
> size_t count)
> +{
> +	struct device *parent =3D cxl_get_phys_dev(afu_dev);
> +
> +	return pci_read_vpd(to_pci_dev(parent), 0, count, buf);
> +}
> +EXPORT_SYMBOL_GPL(cxl_read_adapter_vpd);
> diff --git a/include/misc/cxl.h b/include/misc/cxl.h
> index f2ffe5b..3f9e84f 100644
> --- a/include/misc/cxl.h
> +++ b/include/misc/cxl.h
> @@ -210,4 +210,9 @@ ssize_t cxl_fd_read(struct file *file, char
> __user *buf, size_t count,
>  void cxl_perst_reloads_same_image(struct cxl_afu *afu,
>  				  bool perst_reloads_same_image);
> =20
> +/*
> + * Read the VPD of the adapter where the AFU pci dev resides
> + */
> +ssize_t cxl_read_adapter_vpd(struct pci_dev *afu_dev, void *buf,
> size_t count);
> +
>  #endif /* _MISC_CXL_H */
