Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32072B6F88
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 00:22:08 +1000 (EST)
Subject: Re: [PATCH 01/14] 83xx: consolidate init_IRQ functions
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1311065631-3429-2-git-send-email-dbaryshkov@gmail.com>
Date: Tue, 19 Jul 2011 09:21:54 -0500
Message-Id: <14FCADA9-6C49-4DFE-8DCD-6861528608BC@kernel.crashing.org>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-2-git-send-email-dbaryshkov@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 19, 2011, at 3:53 AM, Dmitry Eremin-Solenikov wrote:

> On mpc83xx platform nearly all _init_IRQ functions look alike. They =
either
> just setup ipic, or setup ipic and QE PIC. Separate this to special =
functions
> to be either referenced from ppc_md, or called from board file.
>=20
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
> arch/powerpc/platforms/83xx/asp834x.c     |   20 +------------
> arch/powerpc/platforms/83xx/km83xx.c      |   33 +--------------------
> arch/powerpc/platforms/83xx/misc.c        |   46 =
+++++++++++++++++++++++++++++
> arch/powerpc/platforms/83xx/mpc830x_rdb.c |   18 +----------
> arch/powerpc/platforms/83xx/mpc831x_rdb.c |   18 +----------
> arch/powerpc/platforms/83xx/mpc832x_mds.c |   30 +------------------
> arch/powerpc/platforms/83xx/mpc832x_rdb.c |   31 +-------------------
> arch/powerpc/platforms/83xx/mpc834x_itx.c |   18 +----------
> arch/powerpc/platforms/83xx/mpc834x_mds.c |   18 +----------
> arch/powerpc/platforms/83xx/mpc836x_mds.c |   30 +------------------
> arch/powerpc/platforms/83xx/mpc836x_rdk.c |   28 +-----------------
> arch/powerpc/platforms/83xx/mpc837x_mds.c |   18 +----------
> arch/powerpc/platforms/83xx/mpc837x_rdb.c |   18 +----------
> arch/powerpc/platforms/83xx/mpc83xx.h     |    9 +++++
> arch/powerpc/platforms/83xx/sbc834x.c     |   20 +------------
> 15 files changed, 68 insertions(+), 287 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/83xx/asp834x.c =
b/arch/powerpc/platforms/83xx/asp834x.c
> index aa0d84d..90b6c06 100644
> --- a/arch/powerpc/platforms/83xx/asp834x.c
> +++ b/arch/powerpc/platforms/83xx/asp834x.c
> @@ -36,24 +36,6 @@ static void __init asp834x_setup_arch(void)
> 	mpc834x_usb_cfg();
> }
>=20
> -static void __init asp834x_init_IRQ(void)
> -{
> -	struct device_node *np;
> -
> -	np =3D of_find_node_by_type(NULL, "ipic");
> -	if (!np)
> -		return;
> -
> -	ipic_init(np, 0);
> -
> -	of_node_put(np);
> -
> -	/* Initialize the default interrupt mapping priorities,
> -	 * in case the boot rom changed something on us.
> -	 */
> -	ipic_set_default_priority();
> -}
> -
> static struct __initdata of_device_id asp8347_ids[] =3D {
> 	{ .type =3D "soc", },
> 	{ .compatible =3D "soc", },
> @@ -82,7 +64,7 @@ define_machine(asp834x) {
> 	.name			=3D "ASP8347E",
> 	.probe			=3D asp834x_probe,
> 	.setup_arch		=3D asp834x_setup_arch,
> -	.init_IRQ		=3D asp834x_init_IRQ,
> +	.init_IRQ		=3D mpc83xx_ipic_init_IRQ,
> 	.get_irq		=3D ipic_get_irq,
> 	.restart		=3D mpc83xx_restart,
> 	.time_init		=3D mpc83xx_time_init,
> diff --git a/arch/powerpc/platforms/83xx/km83xx.c =
b/arch/powerpc/platforms/83xx/km83xx.c
> index a2b9b9e..71ba863 100644
> --- a/arch/powerpc/platforms/83xx/km83xx.c
> +++ b/arch/powerpc/platforms/83xx/km83xx.c
> @@ -140,37 +140,6 @@ static int __init =
kmeter_declare_of_platform_devices(void)
> }
> machine_device_initcall(mpc83xx_km, =
kmeter_declare_of_platform_devices);
>=20
> -static void __init mpc83xx_km_init_IRQ(void)
> -{
> -	struct device_node *np;
> -
> -	np =3D of_find_compatible_node(NULL, NULL, "fsl,pq2pro-pic");
> -	if (!np) {
> -		np =3D of_find_node_by_type(NULL, "ipic");
> -		if (!np)
> -			return;
> -	}
> -
> -	ipic_init(np, 0);
> -
> -	/* Initialize the default interrupt mapping priorities,
> -	 * in case the boot rom changed something on us.
> -	 */
> -	ipic_set_default_priority();
> -	of_node_put(np);
> -
> -#ifdef CONFIG_QUICC_ENGINE
> -	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> -	if (!np) {
> -		np =3D of_find_node_by_type(NULL, "qeic");
> -		if (!np)
> -			return;
> -	}
> -	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, =
qe_ic_cascade_high_ipic);
> -	of_node_put(np);
> -#endif				/* CONFIG_QUICC_ENGINE */
> -}
> -
> /* list of the supported boards */
> static char *board[] __initdata =3D {
> 	"Keymile,KMETER1",
> @@ -198,7 +167,7 @@ define_machine(mpc83xx_km) {
> 	.name		=3D "mpc83xx-km-platform",
> 	.probe		=3D mpc83xx_km_probe,
> 	.setup_arch	=3D mpc83xx_km_setup_arch,
> -	.init_IRQ	=3D mpc83xx_km_init_IRQ,
> +	.init_IRQ	=3D mpc83xx_both_init_IRQ,

make this mpc83xx_ipic_and_qe_init_IRQ

> 	.get_irq	=3D ipic_get_irq,
> 	.restart	=3D mpc83xx_restart,
> 	.time_init	=3D mpc83xx_time_init,
> diff --git a/arch/powerpc/platforms/83xx/misc.c =
b/arch/powerpc/platforms/83xx/misc.c
> index f01806c..95f2274 100644
> --- a/arch/powerpc/platforms/83xx/misc.c
> +++ b/arch/powerpc/platforms/83xx/misc.c
> @@ -11,9 +11,12 @@
>=20
> #include <linux/stddef.h>
> #include <linux/kernel.h>
> +#include <linux/of_platform.h>
>=20
> #include <asm/io.h>
> #include <asm/hw_irq.h>
> +#include <asm/ipic.h>
> +#include <asm/qe_ic.h>
> #include <sysdev/fsl_soc.h>
>=20
> #include "mpc83xx.h"
> @@ -65,3 +68,46 @@ long __init mpc83xx_time_init(void)
>=20
> 	return 0;
> }
> +
> +void __init mpc83xx_ipic_init_IRQ(void)
> +{
> +	struct device_node *np;
> +
> +	/* looking for fsl,pq2pro-pic which is asl compatible with =
fsl,ipic */
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,ipic");
> +	if (!np)
> +		np =3D of_find_node_by_type(NULL, "ipic");
> +	if (!np)
> +		return;
> +
> +	ipic_init(np, 0);
> +
> +	of_node_put(np);
> +
> +	/* Initialize the default interrupt mapping priorities,
> +	 * in case the boot rom changed something on us.
> +	 */
> +	ipic_set_default_priority();
> +}
> +
> +#ifdef CONFIG_QUICC_ENGINE
> +void __init mpc83xx_qe_init_IRQ(void)
> +{
> +	struct device_node *np;
> +
> +	np =3D of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
> +	if (!np) {
> +		np =3D of_find_node_by_type(NULL, "qeic");
> +		if (!np)
> +			return;
> +	}
> +	qe_ic_init(np, 0, qe_ic_cascade_low_ipic, =
qe_ic_cascade_high_ipic);
> +	of_node_put(np);
> +}
> +
> +void __init mpc83xx_both_init_IRQ(void)

make this mpc83xx_ipic_and_qe_init_IRQ

> +{
> +	mpc83xx_ipic_init_IRQ();
> +	mpc83xx_qe_init_IRQ();
> +}
> +#endif /* CONFIG_QUICC_ENGINE */

- k
