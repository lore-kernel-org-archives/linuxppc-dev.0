Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/4] powerpc/mpic: Use the MPIC_LARGE_VECTORS flag for FSL
 MPIC.
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1332850557-23557-1-git-send-email-Varun.Sethi@freescale.com>
Date: Tue, 27 Mar 2012 08:30:50 -0500
Message-Id: <295B3D3A-F038-4176-90EF-423A6BB84F62@kernel.crashing.org>
References: <1332850557-23557-1-git-send-email-Varun.Sethi@freescale.com>
To: Varun Sethi <Varun.Sethi@freescale.com>
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 27, 2012, at 7:15 AM, Varun Sethi wrote:

> FSL MPIC supports 16 bit vectors so our vector number space isn't
> restricted to 256 vectors. We should use the MPIC_LARG_VECTORS flag
> while intializing the MPIC. This also prevents us from eating in to=20
> hardware vector number space (MSIs) while setting up internal sources.

What is driving this change?  The commit message isn't quite correct as =
MPIC_LARGE_VECTORS is about the # of IRQs, not the fact that vector =
field is 16-bits.

>=20
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> arch/powerpc/sysdev/mpic.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 8be1ea2..33520dd 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1191,7 +1191,7 @@ struct mpic * __init mpic_alloc(struct =
device_node *node,
> 	if (of_get_property(node, "single-cpu-affinity", NULL))
> 		flags |=3D MPIC_SINGLE_DEST_CPU;
> 	if (of_device_is_compatible(node, "fsl,mpic"))
> -		flags |=3D MPIC_FSL;
> +		flags |=3D MPIC_FSL | MPIC_LARGE_VECTORS;
>=20
> 	mpic =3D kzalloc(sizeof(struct mpic), GFP_KERNEL);
> 	if (mpic =3D=3D NULL)
> --=20
> 1.7.2.2
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
