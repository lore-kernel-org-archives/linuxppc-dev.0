Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1584D1007D5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2011 07:04:20 +1100 (EST)
Date: Wed, 07 Dec 2011 15:02:08 -0500 (EST)
Message-Id: <20111207.150208.588206951117780997.davem@davemloft.net>
To: afleming@freescale.com
Subject: Re: [PATCH] powerpc: Add TBI PHY node to first MDIO bus
From: David Miller <davem@davemloft.net>
In-Reply-To: <1323287457-6085-1-git-send-email-afleming@freescale.com>
References: <1323287457-6085-1-git-send-email-afleming@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andy Fleming <afleming@freescale.com>
Date: Wed, 7 Dec 2011 13:50:57 -0600

> Systems which use the fsl_pq_mdio driver need to specify an
> address for TBI PHY transactions such that the address does
> not conflict with any PHYs on the bus (all transactions to
> that address are directed to the onboard TBI PHY). The driver
> used to scan for a free address if no address was specified,
> however this ran into issues when the PHY Lib was fixed so
> that all MDIO transactions were protected by a mutex. As it
> is, the code was meant to serve as a transitional tool until
> the device trees were all updated to specify the TBI address.
> 
> The best fix for the mutex issue was to remove the scanning code,
> but it turns out some of the newer SoCs have started to omit
> the tbi-phy node when SGMII is not being used. As such, these
> devices will now fail unless we add a tbi-phy node to the first
> mdio controller.
> 
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
> 
> This requires fsl_pq_mdio: Clean up tbi address configuration from
> the net tree in order to achieve its full effect.
> 
> This needs to go into 3.2.

I'm fine if the powerpc tree takes this one:

Acked-by: David S. Miller <davem@davemloft.net>
