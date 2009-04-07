Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 841AADDFE2
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 00:30:13 +1000 (EST)
Date: Tue, 7 Apr 2009 18:30:11 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc: 85xx: Add PHY fixup to socrates board code
Message-ID: <20090407143011.GA15727@oksana.dev.rtsoft.ru>
References: <1239113988-4579-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1239113988-4579-1-git-send-email-agust@denx.de>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 07, 2009 at 04:19:48PM +0200, Anatolij Gustschin wrote:
> If the firmware missed to initialize the PHY correctly,
> Linux may hang up on socrates while eth0/eth1 interface
> startup (caused by continuous unacknowledged PHY interrupt).
> 
> This patch adds PHY fixup to socrates platform code to
> ensure the PHY is pre-initialized correctly. It is needed
> to be compatible with older firmware.

Is that really board-specific fixup, or can it be placed
somewhere inside drivers/net/phy/marvell.c?

Has this fixup any effect after phy power down/up sequence?
Otherwise you may encounter same problem after suspend/resume.

> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  arch/powerpc/platforms/85xx/socrates.c |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
> index d0e8443..2275a39 100644
> --- a/arch/powerpc/platforms/85xx/socrates.c
> +++ b/arch/powerpc/platforms/85xx/socrates.c
> @@ -28,6 +28,7 @@
>  #include <linux/delay.h>
>  #include <linux/seq_file.h>
>  #include <linux/of_platform.h>
> +#include <linux/phy.h>
>  
>  #include <asm/system.h>
>  #include <asm/time.h>
> @@ -78,6 +79,21 @@ static void __init socrates_pic_init(void)
>  	of_node_put(np);
>  }
>  
> +static int socrates_m88e1121_fixup(struct phy_device *phydev)
> +{
> +	int err;
> +
> +	err = phy_write(phydev, 0x12, 0);

Do you know the proper names for 0x12 and 0x13 registers
on that chip?

> +	if (err < 0)
> +		return err;
> +
> +	err = phy_read(phydev, 0x13);
> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}
> +
>  /*
>   * Setup the architecture
>   */
> @@ -105,6 +121,8 @@ static struct of_device_id __initdata socrates_of_bus_ids[] = {
>  static void __init socrates_init(void)
>  {
>  	of_platform_bus_probe(NULL, socrates_of_bus_ids, NULL);
> +	phy_register_fixup_for_uid(0x1410cb0, 0xffffff0,
> +				   socrates_m88e1121_fixup);
>  }
>  
>  /*
> -- 
> 1.5.6.3

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
