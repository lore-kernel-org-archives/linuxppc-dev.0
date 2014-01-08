Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0208.outbound.protection.outlook.com [207.46.163.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2CDF22C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 02:56:15 +1100 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: "agraf@suse.de" <agraf@suse.de>, "kvm-ppc@vger.kernel.org"
 <kvm-ppc@vger.kernel.org>
Subject: RE: [PATCH] KVM: PPC: Add devname:kvm aliases for modules
Date: Wed, 8 Jan 2014 15:41:41 +0000
Message-ID: <d9b953bc6fa44dfd85dab5ca36b0174e@BLUPR03MB503.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: kvm-ppc-owner@vger.kernel.org [mailto:kvm-ppc-
> owner@vger.kernel.org] On Behalf Of Alexander Graf
> Sent: Monday, December 09, 2013 5:02 PM
> To: "; " <kvm-ppc@vger.kernel.org>"@suse.de
> Cc: kvm@vger.kernel.org mailing list
> Subject: [PATCH] KVM: PPC: Add devname:kvm aliases for modules
>=20
> Systems that support automatic loading of kernel modules through
> device aliases should try and automatically load kvm when /dev/kvm
> gets opened.
>=20
> Add code to support that magic for all PPC kvm targets, even the
> ones that don't support modules yet.
>=20
> Signed-off-by: Alexander Graf <agraf@suse.de>

...

> --- a/arch/powerpc/kvm/e500mc.c
> +++ b/arch/powerpc/kvm/e500mc.c
> @@ -391,3 +391,6 @@ static void __exit kvmppc_e500mc_exit(void)
>=20
>  module_init(kvmppc_e500mc_init);
>  module_exit(kvmppc_e500mc_exit);
> +#include <linux/miscdevice.h>
> +MODULE_ALIAS_MISCDEV(KVM_MINOR);
> +MODULE_ALIAS("devname:kvm");
> --

This patch breaks the build on KMV Book3E, you need to include
<linux/module.h> too.

-Mike
