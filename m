Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE005.bigfish.com (sg2ehsobe005.messaging.microsoft.com
	[207.46.51.79]) by ozlabs.org (Postfix) with ESMTP id EFFEBB7CD5
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Feb 2010 01:09:11 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH] [V2] net: emaclite: adding MDIO and phy lib support
Date: Mon, 8 Feb 2010 07:09:01 -0700
In-Reply-To: <1265409646-11882-1-git-send-email-john.linn@xilinx.com>
References: <1265409646-11882-1-git-send-email-john.linn@xilinx.com>
From: John Linn <John.Linn@xilinx.com>
To: "John Linn" <john.linn@xilinx.com>, <netdev@vger.kernel.org>,
	<linuxppc-dev@ozlabs.org>, <jgarzik@pobox.com>,
	<grant.likely@secretlab.ca>, <jwboyer@linux.vnet.ibm.com>
Message-ID: <260b8801-53bd-44fe-a6b8-7d1d0f56fef5@SG2EHSMHS011.ehs.local>
Cc: Sadanand Mutyala <sadanan@xilinx.com>, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: John Linn [mailto:john.linn@xilinx.com]
> Sent: Friday, February 05, 2010 3:41 PM
> To: netdev@vger.kernel.org; linuxppc-dev@ozlabs.org;
jgarzik@pobox.com; grant.likely@secretlab.ca;
> jwboyer@linux.vnet.ibm.com
> Cc: john.williams@petalogix.com; John Linn; Sadanand Mutyala
> Subject: [PATCH] [V2] net: emaclite: adding MDIO and phy lib support
> =

> These changes add MDIO and phy lib support to the driver as the
> IP core now supports the MDIO bus.
> =

> The MDIO bus and phy are added as a child to the emaclite in the
device
> tree as illustrated below.
> =

> mdio {
> 	#address-cells =3D <1>;
> 	#size-cells =3D <0>;
> 	compatible =3D "xlnx,emaclite-mdio";
> 	phy0: phy@7 {
> 		reg =3D <7>;
> 	} ;
> }
> =

> Signed-off-by: Sadanand Mutyala <Sadanand.Mutyala@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>
> =

> ---
> =

> V2 - updated it for Grant's comments, except I couldn't find any tabs
> converted to white space issue, let's see if V2 has it also
> ---
>  drivers/net/Kconfig           |    1 +
>  drivers/net/xilinx_emaclite.c |  393
++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 351 insertions(+), 43 deletions(-)
> =

> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index dd9a09c..9509a36 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -1939,6 +1939,7 @@ config ATL2
>  config XILINX_EMACLITE
>  	tristate "Xilinx 10/100 Ethernet Lite support"
>  	depends on PPC32 || MICROBLAZE
> +	select PHYLIB
>  	help
>  	  This driver supports the 10/100 Ethernet Lite from Xilinx.
> =

> diff --git a/drivers/net/xilinx_emaclite.c
b/drivers/net/xilinx_emaclite.c
> index 8c777ba..02f18dd 100644
> --- a/drivers/net/xilinx_emaclite.c
> +++ b/drivers/net/xilinx_emaclite.c
> @@ -22,11 +22,17 @@
> =

>  #include <linux/of_device.h>
>  #include <linux/of_platform.h>
> +#include <linux/of_mdio.h>
> +#include <linux/phy.h>
> =


<snip>

> +static int xemaclite_mdio_read(struct mii_bus *bus, int phy_id, int
reg)
> +{
> +	struct net_local *lp =3D bus->priv;
> +	u32 ctrl_reg;
> +	u32 rc;
> +
> +	mutex_lock(&lp->mdio_mutex);
> +
> +	if (xemaclite_mdio_wait(lp))
> +		return -ETIMEDOUT;


I already see a problem with this patch as when there's a timeout
waiting for the mdio the mutex won't get unlocked.  This is true
anywhere the timeout happens (other places also).

I tested it with normal operation, but don't have a great way to test
the timeout paths.

I'll wait for other comments then spin it again to unlock the mutex when
there's a timeout.

Thanks,
John


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
