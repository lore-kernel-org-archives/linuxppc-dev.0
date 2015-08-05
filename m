Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 113191A1D6C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 17:48:02 +1000 (AEST)
Message-ID: <1438760880.20978.2.camel@neuling.org>
Subject: Re: [PATCH 1/8] misc: cxl: clean up afu_read_config()
From: Michael Neuling <mikey@neuling.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ian Munsie
 <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 05 Aug 2015 17:48:00 +1000
In-Reply-To: <1437945533-27996-1-git-send-email-vz@mleia.com>
References: <1437945502-27944-1-git-send-email-vz@mleia.com>
 <1437945533-27996-1-git-send-email-vz@mleia.com>
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

On Mon, 2015-07-27 at 00:18 +0300, Vladimir Zapolskiy wrote:
> The sanity checks for overflow are not needed, because this is done on
> caller side in fs/sysfs/file.c
>=20
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Ian Munsie <imunsie@au1.ibm.com>
> Cc: Michael Neuling <mikey@neuling.org>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
>  drivers/misc/cxl/sysfs.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
> index 31f38bc..87cd747 100644
> --- a/drivers/misc/cxl/sysfs.c
> +++ b/drivers/misc/cxl/sysfs.c
> @@ -443,12 +443,7 @@ static ssize_t afu_read_config(struct file *filp, st=
ruct kobject *kobj,
>  	struct afu_config_record *cr =3D to_cr(kobj);
>  	struct cxl_afu *afu =3D to_cxl_afu(container_of(kobj->parent, struct de=
vice, kobj));
> =20
> -	u64 i, j, val, size =3D afu->crs_len;
> -
> -	if (off > size)
> -		return 0;
> -	if (off + count > size)
> -		count =3D size - off;
> +	u64 i, j, val;
> =20
>  	for (i =3D 0; i < count;) {
>  		val =3D cxl_afu_cr_read64(afu, cr->cr, off & ~0x7);
