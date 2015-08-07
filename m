Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19F7C1A0BEA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 14:13:13 +1000 (AEST)
Message-ID: <1438920792.16275.3.camel@neuling.org>
Subject: Re: [PATCH 4/4] cxl: sparse: Silence iomem warning in debugfs file
 creation
From: Michael Neuling <mikey@neuling.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 imunsie@au.ibm.com
Date: Fri, 07 Aug 2015 14:13:12 +1000
In-Reply-To: <1438917500-12100-4-git-send-email-dja@axtens.net>
References: <1438917500-12100-1-git-send-email-dja@axtens.net>
 <1438917500-12100-4-git-send-email-dja@axtens.net>
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
> An IO address, tagged with __iomem, is passed to debugfs_create_file
> as private data. This requires that it be cast to void *. The cast
> creates a sparse warning:
> /scratch/dja/linux-capi/drivers/misc/cxl/debugfs.c:51:57: warning: cast r=
emoves address space of expression
>=20
> The address space marker is added back in the file operations
> (fops_io_u64).
>=20
> Silence the warning with __force.
>=20
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
>  drivers/misc/cxl/debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/cxl/debugfs.c b/drivers/misc/cxl/debugfs.c
> index 825c412580bc..18df6f44af2a 100644
> --- a/drivers/misc/cxl/debugfs.c
> +++ b/drivers/misc/cxl/debugfs.c
> @@ -48,7 +48,7 @@ DEFINE_SIMPLE_ATTRIBUTE(fops_io_x64, debugfs_io_u64_get=
, debugfs_io_u64_set, "0x
>  static struct dentry *debugfs_create_io_x64(const char *name, umode_t mo=
de,
>  					    struct dentry *parent, u64 __iomem *value)
>  {
> -	return debugfs_create_file(name, mode, parent, (void *)value, &fops_io_=
x64);
> +	return debugfs_create_file(name, mode, parent, (void __force *)value, &=
fops_io_x64);
>  }
> =20
>  int cxl_debugfs_adapter_add(struct cxl *adapter)
