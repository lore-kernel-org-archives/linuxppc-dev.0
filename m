Return-Path: <B11780@freescale.com>
Subject: Re: [PATCH 10/15] powerpc: Define slb0_limit() for BOOK3E
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <021a5af117537ce9f7c6c3b27310f15851ab5034.1302856271.git.michael@ellerman.id.au>
Date: Mon, 18 Apr 2011 07:42:47 -0500
Message-ID: <DB59DA71-C6DA-4E65-9251-C29B973345AD@freescale.com>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
	<021a5af117537ce9f7c6c3b27310f15851ab5034.1302856271.git.michael@ellerman.id.au>
To: Michael Ellerman <michael@ozlabs.org>
Cc: Jimi Xenidis <jimix@watson.ibm.com>, linuxppc-dev@ozlabs.org,
	David Gibson <david@gibson.dropbear.id.au>, imunsie@au.ibm.com,
	jack@codezen.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 15, 2011, at 3:32 AM, Michael Ellerman wrote:

> From: Michael Ellerman <michael@ellerman.id.au>
>=20
> On BOOK3E we don't have an SLB 0, but the equivalent concept is the
> bolted entry mapping the kernel. Currently this is a 1G entry, so
> for now hardcode that. This will probably need to be reworked in
> future.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> arch/powerpc/kernel/setup_64.c |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/setup_64.c =
b/arch/powerpc/kernel/setup_64.c
> index 91a5cc5..3d0daf4 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -436,10 +436,14 @@ void __init setup_system(void)
>=20
> static u64 slb0_limit(void)
> {
> +#ifdef CONFIG_PPC_BOOK3E
> +	return 1 << 30;
> +#else
> 	if (cpu_has_feature(CPU_FTR_1T_SEGMENT)) {
> 		return 1UL << SID_SHIFT_1T;
> 	}
> 	return 1UL << SID_SHIFT;
> +#endif
> }
>=20

Let's rename this function to something 'linear_map'.  As on FSL Book-E =
64 we do things a bit differently and have more covered in linear map =
than 1G

> static void __init irqstack_early_init(void)
> --=20
> 1.7.1
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
