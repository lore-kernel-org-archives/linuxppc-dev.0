Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.180])
	by ozlabs.org (Postfix) with ESMTP id 57CE2DDE0E
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 07:43:26 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1861599wag
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 14:43:25 -0700 (PDT)
Message-ID: <fa686aa40710141443u4defd1f4m8076a730a185135b@mail.gmail.com>
Date: Sun, 14 Oct 2007 15:43:25 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH v3 3/4] FEC mpc52xx: the driver
In-Reply-To: <20071014075921.GF3000@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071014075511.GC3000@nd47.coderock.org>
	<20071014075921.GF3000@nd47.coderock.org>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/14/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> Driver for ethernet on mpc5200/mpc5200b SoCs (FEC).
>
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

Looks quite good to me.  Comments below...

>
> ---
>  drivers/net/Kconfig              |    1
>  drivers/net/Makefile             |    1
>  drivers/net/fec_mpc52xx/Kconfig  |   15
>  drivers/net/fec_mpc52xx/Makefile |    2
>  drivers/net/fec_mpc52xx/fec.c    | 1098 +++++++++++++++++++++++++++++++++++++++
>  drivers/net/fec_mpc52xx/fec.h    |  313 +++++++++++
>  6 files changed, 1430 insertions(+)
>
> Index: linux.git/drivers/net/Kconfig
> ===================================================================
> --- linux.git.orig/drivers/net/Kconfig
> +++ linux.git/drivers/net/Kconfig
> @@ -1894,6 +1894,7 @@ config NE_H8300
>           controller on the Renesas H8/300 processor.
>
>  source "drivers/net/fec_8xx/Kconfig"
> +source "drivers/net/fec_mpc52xx/Kconfig"

Personally, I'd just add the mpc52xx items to drivers/net/Kconfig; but
I won't make a fuss either way.

===================================================================
> --- linux.git.orig/drivers/net/Makefile
> +++ linux.git/drivers/net/Makefile
> @@ -210,6 +210,7 @@ obj-$(CONFIG_SMC911X) += smc911x.o
>  obj-$(CONFIG_BFIN_MAC) += bfin_mac.o
>  obj-$(CONFIG_DM9000) += dm9000.o
>  obj-$(CONFIG_FEC_8XX) += fec_8xx/
> +obj-$(CONFIG_FEC_MPC52xx) += fec_mpc52xx/

Ditto here;  Heck, we're only talking about 3 files here.  I'd
probably put all three into drivers/net...  or even merge the 2 .c and
one .h files into a single file.  But, again, it's not a big deal.

>  obj-$(CONFIG_PASEMI_MAC) += pasemi_mac.o
>  obj-$(CONFIG_MLX4_CORE) += mlx4/
>
> Index: linux.git/drivers/net/fec_mpc52xx/Kconfig
> ===================================================================
> --- /dev/null
> +++ linux.git/drivers/net/fec_mpc52xx/Kconfig
> @@ -0,0 +1,15 @@
> +menu "MPC5200 Networking Options"
> +       depends PPC_MPC52xx && NET_ETHERNET

Drop the menu

> +
> +config FEC_MPC52xx
> +       tristate "FEC driver"
> +       depends on NET_ETHERNET

Drop "NET_ETHERNET"; if you're here, then NET_ETHERNET *is* selected.
Add "PPC_MPC52xx"

> +       select PPC_BESTCOMM
> +       select PPC_BESTCOMM_FEC
> +       select CRC32
> +       select PHYLIB
> +       ---help---
> +         This option enables support for the MPC5200's on-chip
> +         Fast Ethernet Controller
> +
> +endmenu
> Index: linux.git/drivers/net/fec_mpc52xx/Makefile
>

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
