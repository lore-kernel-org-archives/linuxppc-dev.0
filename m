Return-Path: <R65777@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 43DD62C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Oct 2013 16:18:00 +1100 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Bhushan Bharat-R65777 <R65777@freescale.com>, Wood Scott-B07421
 <B07421@freescale.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>
Subject: RE: [PATCH 1/4] powerpc: Added __cmpdi2 for signed 64bit comparision
Date: Wed, 9 Oct 2013 05:17:23 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D071A6828@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1381295322-7197-1-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1381295322-7197-1-git-send-email-Bharat.Bhushan@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Oops it came as 1/4,
I am sorry, please ignore this

Thanks
-Bharat

> -----Original Message-----
> From: Bhushan Bharat-R65777
> Sent: Wednesday, October 09, 2013 10:39 AM
> To: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; benh@kernel.crashin=
g.org
> Cc: Bhushan Bharat-R65777; Bhushan Bharat-R65777
> Subject: [PATCH 1/4] powerpc: Added __cmpdi2 for signed 64bit comparision
>=20
> This was missing on powerpc and I am getting compilation error
> drivers/vfio/pci/vfio_pci_rdwr.c:193: undefined reference to `__cmpdi2'
> drivers/vfio/pci/vfio_pci_rdwr.c:193: undefined reference to `__cmpdi2'
>=20
> Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> ---
>  arch/powerpc/kernel/misc_32.S   |   14 ++++++++++++++
>  arch/powerpc/kernel/ppc_ksyms.c |    2 ++
>  2 files changed, 16 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.=
S index
> 777d999..7c0eec2 100644
> --- a/arch/powerpc/kernel/misc_32.S
> +++ b/arch/powerpc/kernel/misc_32.S
> @@ -644,6 +644,20 @@ _GLOBAL(__lshrdi3)
>  	blr
>=20
>  /*
> + * 64-bit comparison: __cmpdi2(s64 a, s64 b)
> + * Returns 0 if a < b, 1 if a =3D=3D b, 2 if a > b.
> + */
> +_GLOBAL(__cmpdi2)
> +	cmpw	r3,r5
> +	li	r3,1
> +	bne	1f
> +	cmplw	r4,r6
> +	beqlr
> +1:	li	r3,0
> +	bltlr
> +	li	r3,2
> +	blr
> +/*
>   * 64-bit comparison: __ucmpdi2(u64 a, u64 b)
>   * Returns 0 if a < b, 1 if a =3D=3D b, 2 if a > b.
>   */
> diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ks=
yms.c
> index 21646db..5674c00 100644
> --- a/arch/powerpc/kernel/ppc_ksyms.c
> +++ b/arch/powerpc/kernel/ppc_ksyms.c
> @@ -143,6 +143,8 @@ EXPORT_SYMBOL(__ashldi3);  EXPORT_SYMBOL(__lshrdi3); =
 int
> __ucmpdi2(unsigned long long, unsigned long long);  EXPORT_SYMBOL(__ucmpd=
i2);
> +int __cmpdi2(long long, long long);
> +EXPORT_SYMBOL(__cmpdi2);
>  #endif
>  long long __bswapdi2(long long);
>  EXPORT_SYMBOL(__bswapdi2);
> --
> 1.7.0.4
