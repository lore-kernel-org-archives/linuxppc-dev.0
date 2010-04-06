Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
	[209.85.211.196]) by ozlabs.org (Postfix) with ESMTP id B7CAEB7D13
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Apr 2010 10:08:55 +1000 (EST)
Received: by ywh34 with SMTP id 34so2916118ywh.17
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Apr 2010 17:08:53 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <d9134316-bd07-46a8-91d4-c30f27baeb60@SG2EHSMHS007.ehs.local>
References: <d9134316-bd07-46a8-91d4-c30f27baeb60@SG2EHSMHS007.ehs.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 5 Apr 2010 18:08:33 -0600
Message-ID: <l2hfa686aa41004051708h1abd23b1qe52d06731089764c@mail.gmail.com>
Subject: Re: [PATCH] [V3] Add non-Virtex5 support for LL TEMAC driver
To: John Linn <john.linn@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	John Tyner <jtyner@cs.ucr.edu>, michal.simek@petalogix.com,
	David Miller <davem@davemloft.net>, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 5, 2010 at 3:11 PM, John Linn <john.linn@xilinx.com> wrote:
> This patch adds support for using the LL TEMAC Ethernet driver on
> non-Virtex 5 platforms by adding support for accessing the Soft DMA
> registers as if they were memory mapped instead of solely through the
> DCR's (available on the Virtex 5).
>
> The patch also updates the driver so that it runs on the MicroBlaze.
> The changes were tested on the PowerPC 440, PowerPC 405, and the
> MicroBlaze platforms.
>
> Signed-off-by: John Tyner <jtyner@cs.ucr.edu>
> Signed-off-by: John Linn <john.linn@xilinx.com>
>
> ---
>
> V2 - Incorporated comments from Grant and added more logic to allow the d=
river
> to work on MicroBlaze.
>
> V3 - Only updated it to apply to head, minor change to include slab.h. Al=
so
> verified that it now builds for MicroBlaze. Retested on PowerPC and Micro=
Blaze.
> ---
> =A0drivers/net/Kconfig =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0drivers/net/ll_temac.h =A0 =A0 =A0| =A0 17 +++++-
> =A0drivers/net/ll_temac_main.c | =A0124 +++++++++++++++++++++++++++++++++=
+---------
> =A03 files changed, 113 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 0ba5b8e..17044dc 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -2435,7 +2435,6 @@ config MV643XX_ETH
> =A0config XILINX_LL_TEMAC
> =A0 =A0 =A0 =A0tristate "Xilinx LL TEMAC (LocalLink Tri-mode Ethernet MAC=
) driver"
> =A0 =A0 =A0 =A0select PHYLIB
> - =A0 =A0 =A0 depends on PPC_DCR_NATIVE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This driver supports the Xilinx 10/100/1000 LocalLink =
TEMAC
> =A0 =A0 =A0 =A0 =A0core used in Xilinx Spartan and Virtex FPGAs


This still at the very least needs to depend on CONFIG_OF.  Otherwise
allmodconfig and allyesconfig on x86 and others will break.  The
driver also doesn't build on sparc, so you'll need to either exclude
CONFIG_SPARC or depend on (PPC || MICROBLAZE) too.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
