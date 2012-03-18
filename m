Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 205BDB6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 08:22:29 +1100 (EST)
Date: Sun, 18 Mar 2012 22:22:18 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 1/4] net, phy: am79c874 support
Message-ID: <20120318222218.6c87878d@wker>
In-Reply-To: <1308729311-15375-2-git-send-email-hs@denx.de>
References: <1308729311-15375-1-git-send-email-hs@denx.de>
 <1308729311-15375-2-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Heiko,

some comments below.

On Wed, 22 Jun 2011 09:55:08 +0200
Heiko Schocher <hs@denx.de> wrote:
...
> diff --git a/drivers/net/phy/amd79.c b/drivers/net/phy/amd79.c
> new file mode 100644
> index 0000000..914d696
> --- /dev/null
> +++ b/drivers/net/phy/amd79.c
...
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/errno.h>
> +#include <linux/unistd.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <linux/skbuff.h>
> +#include <linux/spinlock.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/mii.h>
> +#include <linux/ethtool.h>
> +#include <linux/phy.h>
> +#include <linux/uaccess.h>
> +
> +#include <asm/irq.h>

We should remove not needed headers here.

...
> +static int amd79_config_intr(struct phy_device *phydev)
> +{
> +	int err;
> +
> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
> +		err = phy_write(phydev, MII_AMD79_IR_EN_LINK,
> +			MII_AMD79_IR_EN_LINK);
> +	else
> +		err = phy_write(phydev, MII_AMD79_IR_EN_LINK, 0);

Here is an issue, we should write to the interrupt control/status
register, so the 2nd argument of phy_write() should be MII_AMD79_IR.
I've fixed this and resubmitted your patch to the netdev list.

Thanks,
Anatolij
