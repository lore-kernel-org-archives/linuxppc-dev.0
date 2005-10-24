Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 9F6C9685AE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Oct 2005 08:03:11 +1000 (EST)
In-Reply-To: <1130165338$29160$83019474@info@moreframe.com>
References: <1130165338$29160$83019474@info@moreframe.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <936F247D-4CB6-4CF3-B805-77901DC1EB61@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 24 Oct 2005 09:56:42 -0500
To: info <info@moreframe.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 85xx PHY Platform Update
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

You need the corresponding patches that are in the netdev tree for  
the PHY subsystem.

- kumar

On Oct 24, 2005, at 9:49 AM, info wrote:

> Andy, Kumar
>
> I try this patch for RMC-G8500 from GDAtech, error message below:
> ---------------------------------------------------------------------- 
> -----------
>  [root@ppclinux linux-2.6.13]# make uImage
>   CHK     include/linux/version.h
>   CHK     include/linux/compile.h
>   CHK     usr/initramfs_list
>   CC      drivers/net/gianfar.o
> drivers/net/gianfar.c: In function `gfar_probe':
> drivers/net/gianfar.c:217: error: structure has no member named  
> `phy_reg_addr'
> drivers/net/gianfar.c: In function `init_phy':
> drivers/net/gianfar.c:452: error: structure has no member named  
> `phyid'
> drivers/net/gianfar.c: In function `stop_gfar':
> drivers/net/gianfar.c:636: error: structure has no member named  
> `interruptPHY'
> drivers/net/gianfar.c: In function `gfar_phy_startup_timer':
> drivers/net/gianfar.c:1818: error: structure has no member named  
> `interruptPHY'
> drivers/net/gianfar.c:1826: error: structure has no member named  
> `interruptPHY'
> make[2]: *** [drivers/net/gianfar.o] Error 1
> make[1]: *** [drivers/net] Error 2
> make: *** [drivers] Error 2
>
> ---------------------------------------------------------------------- 
> -----------
> because???
>
>  /* Internal interrupts are all Level Sensitive, and Positive  
> Polarity */
> diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
> --- a/include/linux/fsl_devices.h
> +++ b/include/linux/fsl_devices.h
> @@ -47,14 +47,19 @@
>  struct gianfar_platform_data {
>      /* device specific information */
>      u32 device_flags;
> -    u32 phy_reg_addr;
>
>      /* board specific information */
>      u32 board_flags;
> -    u32 phy_flags;
> -    u32 phyid;
> -    u32 interruptPHY;
> +    const char *bus_id;
>      u8 mac_addr[6];
> +};
> +
>
>
> ---------------------------------------------------------------------- 
> ---------------------
> <This patch updates the 85xx platform code to support the new PHY  
> Layer.
> <
> <Signed-off-by: Andy Fleming <afleming at freescale.com>
> <Signed-off-by: Kumar Gala <Kumar.gala at freescale.com>
> <
> <
> <diff --git a/arch/ppc/platforms/85xx/mpc8540_ads.c b/arch/ppc/ 
> platforms/85xx/mpc8540_ads.c
> <--- a/arch/ppc/platforms/85xx/mpc8540_ads.c
> <+++ b/arch/ppc/platforms/85xx/mpc8540_ads.c
> <@@ -53,6 +53,10 @@
> <
> < #include <syslib/ppc85xx_setup.h>
> <
> <+static const char *GFAR_PHY_0 = "phy0:0";
> <+static const char *GFAR_PHY_1 = "phy0:1";
> <+static const char *GFAR_PHY_3 = "phy0:3";
> <+
> < /*  
> ********************************************************************** 
> **
> <  *
> <  * Setup the architecture
> <@@ -64,6 +68,7 @@ mpc8540ads_setup_arch(void)
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
