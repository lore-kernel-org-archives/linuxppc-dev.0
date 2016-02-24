Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A57CC1A049B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 04:37:39 +1100 (AEDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 5C3E1140CC9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 04:37:39 +1100 (AEDT)
Message-ID: <1456335458.3941.3.camel@neuling.org>
Subject: Re: [PATCH] cxl: Fix PSL timebase synchronization detection
From: Michael Neuling <mikey@neuling.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, ian@ozlabs.au.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 24 Feb 2016 11:37:38 -0600
In-Reply-To: <1456334871-30397-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1456334871-30397-1-git-send-email-fbarrat@linux.vnet.ibm.com>
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

On Wed, 2016-02-24 at 18:27 +0100, Frederic Barrat wrote:
> The PSL timebase synchronization is seemingly failing for
> configuration not including VIRT_CPU_ACCOUNTING_NATIVE. The driver
> shows the following trace in dmesg:
> PSL: Timebase sync: giving up!
>=20
> The PSL timebase register is actually syncing correctly, but the cxl
> driver is not detecting it. Fix is to use the proper timebase-to-time
> conversion.
>=20
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Looks good!

Acked-by: Michael Neuling <mikey@neuling.org>


> Cc: <stable@vger.kernel.org> # 4.3+
> ---
>  drivers/misc/cxl/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 4c1903f..0c6c17a1 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -415,7 +415,7 @@ static int cxl_setup_psl_timebase(struct cxl
> *adapter, struct pci_dev *dev)
>  		delta =3D mftb() - psl_tb;
>  		if (delta < 0)
>  			delta =3D -delta;
> -	} while (cputime_to_usecs(delta) > 16);
> +	} while (tb_to_ns(delta) > 16000);
> =20
>  	return 0;
>  }
