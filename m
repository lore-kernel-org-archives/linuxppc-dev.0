Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF1751A084F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Dec 2014 15:05:35 +1100 (AEDT)
Message-ID: <1419134735.27324.41.camel@neuling.org>
Subject: Re: [PATCH] misc: cxl: sysfs.c:  Remove unused function
From: Michael Neuling <mikey@neuling.org>
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sun, 21 Dec 2014 15:05:35 +1100
In-Reply-To: <1419092024-6701-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1419092024-6701-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Remove the function mmio_size_show() that is not used anywhere.

Did you compile check this patch?

  drivers/misc/cxl/sysfs.c:291:74: error: =E2=80=98mmio_size_show=E2=80=99 =
undeclared here (not in a function)

It's used here:
        static struct device_attribute afu_attrs[] =3D {
        	__ATTR_RO(mmio_size),

> This was partially found by using a static code analysis program called c=
ppcheck.

Thanks for letting me know which tool to avoid :-)

Mikey


>=20
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.s=
e>
> ---
>  drivers/misc/cxl/sysfs.c |   11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
> index ce7ec06..0431ec3 100644
> --- a/drivers/misc/cxl/sysfs.c
> +++ b/drivers/misc/cxl/sysfs.c
> @@ -102,17 +102,6 @@ static struct device_attribute afu_master_attrs[] =
=3D {
> =20
>  /*********  AFU attributes  ********************************************=
******/
> =20
> -static ssize_t mmio_size_show(struct device *device,
> -			      struct device_attribute *attr,
> -			      char *buf)
> -{
> -	struct cxl_afu *afu =3D to_cxl_afu(device);
> -
> -	if (afu->pp_size)
> -		return scnprintf(buf, PAGE_SIZE, "%llu\n", afu->pp_size);
> -	return scnprintf(buf, PAGE_SIZE, "%llu\n", afu->adapter->ps_size);
> -}
> -
>  static ssize_t reset_store_afu(struct device *device,
>  			       struct device_attribute *attr,
>  			       const char *buf, size_t count)
