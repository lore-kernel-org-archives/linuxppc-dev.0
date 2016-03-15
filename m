Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPFnF5HHXzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 11:27:29 +1100 (AEDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 3qPFnF4Lfdz9sdb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 11:27:29 +1100 (AEDT)
Message-ID: <1458001649.12098.59.camel@neuling.org>
Subject: Re: [PATCH next] cxl: Allow PSL timebase to not sync
From: Michael Neuling <mikey@neuling.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 15 Mar 2016 11:27:29 +1100
In-Reply-To: <1457983772-4206-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1457983772-4206-1-git-send-email-fbarrat@linux.vnet.ibm.com>
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

On Mon, 2016-03-14 at 20:29 +0100, Frederic Barrat wrote:
> CXL driver synchronizes the PSL timebase with the CAPP during
> initialization. If it can't synchronize, then the driver currently
> fails and the cxl adapter is not usable. That behavior is a bit
> extreme for the time being, as some adapters are known to have
> troubles syncing their PSL timebase and there are no known use of it.
>=20
> Introduce a psl_timebase module parameter to control whether PSL
> timebase is required or not. Default is to allow initializaton even
> if
> syncing failed.
> Default behavior will be changed when current issues with some cxl
> adapters are resolved.

I'm not happy with doing this unless we add something which advertises
that it's synced or not to userspace.

If we do that, I'm happy to just fail without the need of the parameter
but advertise it to userspace.

The parameter is a bit of a PITA too, as it's a driver level config not
card level.  You really want to turn it on/off based on the card, not
the whole system.

Mikey

>=20
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
>=20
> Same as before, but this patch applies on 'next'
>=20
>  drivers/misc/cxl/cxl.h  | 1 +
>  drivers/misc/cxl/main.c | 4 ++++
>  drivers/misc/cxl/pci.c  | 7 +++++--
>  3 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
> index 38e21cf..84b563c 100644
> --- a/drivers/misc/cxl/cxl.h
> +++ b/drivers/misc/cxl/cxl.h
> @@ -27,6 +27,7 @@
>  #include <uapi/misc/cxl.h>
> =20
>  extern uint cxl_verbose;
> +extern uint cxl_psl_timebase;
> =20
>  #define CXL_TIMEOUT 5
> =20
> diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
> index ae68c32..0344010 100644
> --- a/drivers/misc/cxl/main.c
> +++ b/drivers/misc/cxl/main.c
> @@ -32,6 +32,10 @@ uint cxl_verbose;
>  module_param_named(verbose, cxl_verbose, uint, 0600);
>  MODULE_PARM_DESC(verbose, "Enable verbose dmesg output");
> =20
> +uint cxl_psl_timebase;
> +module_param_named(psl_timebase, cxl_psl_timebase, uint, 0600);

Can we make this a bool?

> +MODULE_PARM_DESC(psl_timebase, "Require PSL timebase
> synchronization");
> +
>  const struct cxl_backend_ops *cxl_ops;
> =20
>  int cxl_afu_slbia(struct cxl_afu *afu)
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 2844e97..02fd1f8 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1144,8 +1144,11 @@ static int cxl_configure_adapter(struct cxl
> *adapter, struct pci_dev *dev)
>  	if ((rc =3D pnv_phb_to_cxl_mode(dev,
> OPAL_PHB_CAPI_MODE_SNOOP_ON)))
>  		goto err;
> =20
> -	if ((rc =3D cxl_setup_psl_timebase(adapter, dev)))
> -		goto err;
> +	if ((rc =3D cxl_setup_psl_timebase(adapter, dev))) {
> +		if (cxl_psl_timebase)
> +			goto err;
> +		pr_err("PSL: Timebase sync: ignoring error\n");
> +	}
> =20
>  	if ((rc =3D cxl_native_register_psl_err_irq(adapter)))
>  		goto err;
