Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2E0EB67CCD
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 11:48:05 +1000 (EST)
Date: Fri, 20 Oct 2006 11:47:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Badness in irq_create_mapping at arch/powerpc/kernel/irq.c:527
Message-Id: <20061020114749.fe7b71d6.sfr@canb.auug.org.au>
In-Reply-To: <1161308221.10524.92.camel@localhost.localdomain>
References: <20061019122802.GA26637@aepfle.de> <45377ED3.9030001@bplan-gmbh.de>
	<1161308221.10524.92.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__20_Oct_2006_11_47_49_+1000_hcS5D6F+KX79LmRP"
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__20_Oct_2006_11_47_49_+1000_hcS5D6F+KX79LmRP
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Ben,

On Fri, 20 Oct 2006 11:37:01 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> Index: linux-cell/arch/powerpc/sysdev/i8259.c
> ===================================================================
> --- linux-cell.orig/arch/powerpc/sysdev/i8259.c	2006-10-09 12:03:33.000000000 +1000
> +++ linux-cell/arch/powerpc/sysdev/i8259.c	2006-10-20 11:32:07.000000000 +1000
> @@ -13,6 +13,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/delay.h>
> +#include <linux/module.h>
>  #include <asm/io.h>
>  #include <asm/i8259.h>
>  #include <asm/prom.h>
> @@ -224,6 +225,12 @@ static struct irq_host_ops i8259_host_op
>  	.xlate = i8259_host_xlate,
>  };
>
> +struct irq_host *i8259_get_host(void)
> +{
> +	return i8259_host;
> +}
> +EXPORT_SYMBOL(i8259_get_host);

Surely it doesn't need exporting is its only caller is in
arch/powerpc/platforms/chrp/setup.c?

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__20_Oct_2006_11_47_49_+1000_hcS5D6F+KX79LmRP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFOCrFFdBgD/zoJvwRAj96AKCf28+zNMiddHmPCL7SLjNAIRyaNACgiM+y
gdzKlzwxoqLEnGcqz3gOgUg=
=dMvI
-----END PGP SIGNATURE-----

--Signature=_Fri__20_Oct_2006_11_47_49_+1000_hcS5D6F+KX79LmRP--
