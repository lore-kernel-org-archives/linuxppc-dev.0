Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 6CF62B7D45
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 23:43:19 +1000 (EST)
Received: by gyf2 with SMTP id 2so99755gyf.15
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 06:43:18 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1272633687-6935-2-git-send-email-agust@denx.de>
References: <1272633687-6935-1-git-send-email-agust@denx.de>
	<1272633687-6935-2-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 30 Apr 2010 07:42:58 -0600
Message-ID: <z2lfa686aa41004300642k2df3b5b3ofa7c00ae4d563a63@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/mpc5121: move PSC FIFO memory init to
	platform code
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>,
	Wolfgang Denk <wd@denx.de>, Detelv Zundel <dzu@denx.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 30, 2010 at 7:21 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Since PSC could also be used in other modes than UART mode
> we move PSC FIFO memory initialization from serial driver to
> common platform code. The initialized FIFO memory slices may
> not overlap, so the most easy way would be to configure them
> all at once at init time for all PSC devices. This is now done
> by this patch.
>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>

Looks good.  I'll pick it up.

g.

> ---
> =A0arch/powerpc/platforms/512x/mpc512x_shared.c | =A0 78 ++++++++++++++++=
++++++++++
> =A0drivers/serial/mpc52xx_uart.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 69 =
-----------------------
> =A02 files changed, 78 insertions(+), 69 deletions(-)
>
> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/=
platforms/512x/mpc512x_shared.c
> index 796080c..a717466 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -26,6 +26,7 @@
> =A0#include <asm/prom.h>
> =A0#include <asm/time.h>
> =A0#include <asm/mpc5121.h>
> +#include <asm/mpc52xx_psc.h>
>
> =A0#include "mpc512x.h"
>
> @@ -369,9 +370,86 @@ void __init mpc512x_declare_of_platform_devices(void=
)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +#define DEFAULT_FIFO_SIZE 16
> +
> +static unsigned int __init get_fifo_size(struct device_node *np,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0char *prop_name)
> +{
> + =A0 =A0 =A0 const unsigned int *fp;
> +
> + =A0 =A0 =A0 fp =3D of_get_property(np, prop_name, NULL);
> + =A0 =A0 =A0 if (fp)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return *fp;
> +
> + =A0 =A0 =A0 pr_warning("no %s property in %s node, defaulting to %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prop_name, np->full_name, DEFAULT_FI=
FO_SIZE);
> +
> + =A0 =A0 =A0 return DEFAULT_FIFO_SIZE;
> +}
> +
> +#define FIFOC(_base) ((struct mpc512x_psc_fifo __iomem *) \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((u32)(_base) + sizeof(struct mpc52=
xx_psc)))
> +
> +/* Init PSC FIFO space for TX and RX slices */
> +void __init mpc512x_psc_fifo_init(void)
> +{
> + =A0 =A0 =A0 struct device_node *np;
> + =A0 =A0 =A0 void __iomem *psc;
> + =A0 =A0 =A0 unsigned int tx_fifo_size;
> + =A0 =A0 =A0 unsigned int rx_fifo_size;
> + =A0 =A0 =A0 int fifobase =3D 0; /* current fifo address in 32 bit words=
 */
> +
> + =A0 =A0 =A0 for_each_compatible_node(np, NULL, "fsl,mpc5121-psc") {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_fifo_size =3D get_fifo_size(np, "fsl,tx-=
fifo-size");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_fifo_size =3D get_fifo_size(np, "fsl,rx-=
fifo-size");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* size in register is in 4 byte units */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_fifo_size /=3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_fifo_size /=3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!tx_fifo_size)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_fifo_size =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!rx_fifo_size)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_fifo_size =3D 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc =3D of_iomap(np, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Can't map %s de=
vice\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, n=
p->full_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIFO space is 4KiB, check if requested s=
ize is available */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((fifobase + tx_fifo_size + rx_fifo_size=
) > 0x1000) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: no fifo space a=
vailable for %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, n=
p->full_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(psc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* chances are that anoth=
er device requests less
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fifo space, so we cont=
inue.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set tx and rx fifo size registers */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&FIFOC(psc)->txsz, (fifobase << 16=
) | tx_fifo_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fifobase +=3D tx_fifo_size;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&FIFOC(psc)->rxsz, (fifobase << 16=
) | rx_fifo_size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fifobase +=3D rx_fifo_size;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* reset and enable the slices */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&FIFOC(psc)->txcmd, 0x80);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&FIFOC(psc)->txcmd, 0x01);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&FIFOC(psc)->rxcmd, 0x80);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&FIFOC(psc)->rxcmd, 0x01);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(psc);
> + =A0 =A0 =A0 }
> +}
> +
> =A0void __init mpc512x_init(void)
> =A0{
> =A0 =A0 =A0 =A0mpc512x_declare_of_platform_devices();
> =A0 =A0 =A0 =A0mpc5121_clk_init();
> =A0 =A0 =A0 =A0mpc512x_restart_init();
> + =A0 =A0 =A0 mpc512x_psc_fifo_init();
> =A0}
> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.=
c
> index 3119fdd..843e7fb 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -430,34 +430,10 @@ static unsigned long mpc512x_getuartclk(void *p)
> =A0 =A0 =A0 =A0return mpc5xxx_get_bus_frequency(p);
> =A0}
>
> -#define DEFAULT_FIFO_SIZE 16
> -
> -static unsigned int __init get_fifo_size(struct device_node *np,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0char *fifo_name)
> -{
> - =A0 =A0 =A0 const unsigned int *fp;
> -
> - =A0 =A0 =A0 fp =3D of_get_property(np, fifo_name, NULL);
> - =A0 =A0 =A0 if (fp)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return *fp;
> -
> - =A0 =A0 =A0 pr_warning("no %s property in %s node, defaulting to %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fifo_name, np->full_name, DEFAULT_FI=
FO_SIZE);
> -
> - =A0 =A0 =A0 return DEFAULT_FIFO_SIZE;
> -}
> -
> -#define FIFOC(_base) ((struct mpc512x_psc_fifo __iomem *) \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((u32)(_base) + sizeof(struct mpc52=
xx_psc)))
> -
> =A0/* Init PSC FIFO Controller */
> =A0static int __init mpc512x_psc_fifoc_init(void)
> =A0{
> =A0 =A0 =A0 =A0struct device_node *np;
> - =A0 =A0 =A0 void __iomem *psc;
> - =A0 =A0 =A0 unsigned int tx_fifo_size;
> - =A0 =A0 =A0 unsigned int rx_fifo_size;
> - =A0 =A0 =A0 int fifobase =3D 0; /* current fifo address in 32 bit words=
 */
>
> =A0 =A0 =A0 =A0np =3D of_find_compatible_node(NULL, NULL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "=
fsl,mpc5121-psc-fifo");
> @@ -480,51 +456,6 @@ static int __init mpc512x_psc_fifoc_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 for_each_compatible_node(np, NULL, "fsl,mpc5121-psc-uart") =
{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_fifo_size =3D get_fifo_size(np, "fsl,tx-=
fifo-size");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_fifo_size =3D get_fifo_size(np, "fsl,rx-=
fifo-size");
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* size in register is in 4 byte units */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_fifo_size /=3D 4;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_fifo_size /=3D 4;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!tx_fifo_size)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_fifo_size =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!rx_fifo_size)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_fifo_size =3D 1;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 psc =3D of_iomap(np, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!psc) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Can't map %s de=
vice\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, n=
p->full_name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIFO space is 4KiB, check if requested s=
ize is available */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((fifobase + tx_fifo_size + rx_fifo_size=
) > 0x1000) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: no fifo space a=
vailable for %s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, n=
p->full_name);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(psc);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* chances are that anoth=
er device requests less
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fifo space, so we cont=
inue.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set tx and rx fifo size registers */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&FIFOC(psc)->txsz, (fifobase << 16=
) | tx_fifo_size);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fifobase +=3D tx_fifo_size;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&FIFOC(psc)->rxsz, (fifobase << 16=
) | rx_fifo_size);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fifobase +=3D rx_fifo_size;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* reset and enable the slices */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&FIFOC(psc)->txcmd, 0x80);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&FIFOC(psc)->txcmd, 0x01);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&FIFOC(psc)->rxcmd, 0x80);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&FIFOC(psc)->rxcmd, 0x01);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(psc);
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> --
> 1.6.3.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
