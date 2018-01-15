Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zL2np3KDpzF0YP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 06:03:55 +1100 (AEDT)
Subject: DPAA Ethernet traffice troubles with Linux kernel
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
 "madskateman@gmail.com" <madskateman@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <CAHkrCmFCzPd_a1UmyfuZHKM4hXvou0uO0FYoG5bd_fxE8QMueg@mail.gmail.com>
 <DB3PR0402MB3849EEF00D71FF7A230B70C3ECEB0@DB3PR0402MB3849.eurprd04.prod.outlook.com>
 <1516035556.18795.71.camel@infinera.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <346361be-ce30-6a13-c154-5192d2668723@xenosoft.de>
Date: Mon, 15 Jan 2018 20:03:45 +0100
MIME-Version: 1.0
In-Reply-To: <1516035556.18795.71.camel@infinera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I compiled the RC8 of kernel 4.15 with Joakim's patch for the AmigaOne 
X5000 today. Many thanks to Joakim for the mdio patch.

Please test it on your X5000.

Thanks,
Christian


On 15 January 2018 at 5:59PM, Joakim Tjernlund wrote:
>>
>> Hi,
>>
>> Please use text logs instead of pictures next time, it's easier to read.
>> The errors you see are related to missing MAC addresses for the unused
>> interfaces, you can ignore these are they are not relevant for the issue
>> you encounter. Normally the unused interfaces should have status disabled
>> in the device tree but there is not a big deal if they fail like that.
>> As I've advised Jamie on the other thread, please try to connect the device
>> back 2 back to a known good machine and determine what is broken - Rx/Tx?
>> Is there another software version that does work on these machines?
> Hi, just saw this and thought of a small patch I just wrote for mdio bus, o idea
> if it is relevant but here goes:
>
>  From fe0b98d54a79779482700676331b4d10a0f3cada Mon Sep 17 00:00:00 2001
> From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> Date: Sun, 14 Jan 2018 21:27:20 +0100
> Subject: [PATCH] of_mdiobus_register: Continue after error
>
> of_mdiobus_register unregister itself if one phy fails to register
> which is bad for system having all its PHYs on the same MDIO bus.
> Just log the error and continue with the remaining PHYs instead.
>
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
> ---
>   drivers/of/of_mdio.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
> index 98258583abb0..76ff28a41dad 100644
> --- a/drivers/of/of_mdio.c
> +++ b/drivers/of/of_mdio.c
> @@ -229,7 +229,8 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
>   		else
>   			rc = of_mdiobus_register_device(mdio, child, addr);
>   		if (rc)
> -			goto unregister;
> +			pr_warn(FW_WARN
> +				"%pOF: Failed to register MDIO device.\n", child);
>   	}
>   
>   	if (!scanphys)
> @@ -253,7 +254,8 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
>   			if (of_mdiobus_child_is_phy(child)) {
>   				rc = of_mdiobus_register_phy(mdio, child, addr);
>   				if (rc)
> -					goto unregister;
> +					pr_warn(FW_WARN
> +						"%pOF: Failed to register MDIO PHY.\n", child);
>   			}
>   		}
>   	}
