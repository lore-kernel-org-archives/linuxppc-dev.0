Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 9C708DE487
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 07:29:25 +1000 (EST)
Message-ID: <48655BAC.8080800@ru.mvista.com>
Date: Sat, 28 Jun 2008 01:29:16 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Nye Liu <nyet@nyet.org>
Subject: Re: [PATCH] FS_ENET: Don't attempt to set mii_speed when fec_inf
	is null
References: <20080627192651.GA28291@curtisfong.org>
In-Reply-To: <20080627192651.GA28291@curtisfong.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Nye Liu wrote:
> From: Nye Liu <nyet@mrv.com>
>
> When using CONFIG_FIXED_PHY, fec_inf (fep->phydev->bus->priv) is NULL in
> fs_enet/mac-fec.c restart(). Dereferencing fec_inf when trying to set the
> mii_speed causes a kernel oops.
>
> Signed-off-by: Nye Liu <nyet@mrv.com>
>
> ---
>
> diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
> index 8a311d1..350bc73 100644
> --- a/drivers/net/fs_enet/mac-fec.c
> +++ b/drivers/net/fs_enet/mac-fec.c
> @@ -328,7 +328,8 @@ static void restart(struct net_device *dev)
>         /*
>          * Set MII speed.
>          */
> -       FW(fecp, mii_speed, fec_inf->mii_speed);
> +       if (fec_inf)
> +           FW(fecp, mii_speed, fec_inf->mii_speed);
>   

   Alas, Your patch is whitespace damaged.


WBR, Sergei
