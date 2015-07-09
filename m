Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8D361A0018
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 09:50:02 +1000 (AEST)
Message-ID: <1436485802.10184.15.camel@neuling.org>
Subject: Re: [PATCH] cxl: Check if afu is not null in cxl_slbia
From: Michael Neuling <mikey@neuling.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
 imunsie@au.ibm.com
Date: Fri, 10 Jul 2015 09:50:02 +1000
In-Reply-To: <1436483065-9202-1-git-send-email-dja@axtens.net>
References: <1436483065-9202-1-git-send-email-dja@axtens.net>
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

On Fri, 2015-07-10 at 09:04 +1000, Daniel Axtens wrote:
> The pointer to an AFU in the adapter's list of AFUs can be null
> if we're in the process of removing AFUs. The afu_list_lock
> doesn't guard against this.
>=20
> Say we have 2 slices, and we're in the process of removing cxl.
>  - We remove the AFUs in order (see cxl_remove). In cxl_remove_afu
>    for AFU 0, we take the lock, set adapter->afu[0] =3D NULL, and
>    release the lock.
>  - Then we get an slbia. In cxl_slbia we take the lock, and set
>    afu =3D adapter->afu[0], which is NULL.
>  - Therefore our attempt to check afu->enabled will blow up.
>=20
> Therefore, check if afu is a null pointer before dereferencing it.
>=20
> cc: STABLE

FYI This needs to be (see Documentation/stable_kernel_rules.txt):
Cc: stable@vger.kernel.org

Other than that, looks good.  Thanks.

Acked-by: Michael Neuling <mikey@neuling.org>

> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  drivers/misc/cxl/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
> index 11a2044d6b0f..5bcd676bfd59 100644
> --- a/drivers/misc/cxl/main.c
> +++ b/drivers/misc/cxl/main.c
> @@ -86,7 +86,7 @@ static inline void cxl_slbia_core(struct mm_struct *mm)
>  		spin_lock(&adapter->afu_list_lock);
>  		for (slice =3D 0; slice < adapter->slices; slice++) {
>  			afu =3D adapter->afu[slice];
> -			if (!afu->enabled)
> +			if (!afu || !afu->enabled)
>  				continue;
>  			rcu_read_lock();
>  			idr_for_each_entry(&afu->contexts_idr, ctx, id)
