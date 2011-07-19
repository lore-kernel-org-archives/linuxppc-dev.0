Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3976CB6F89
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jul 2011 21:35:35 +1000 (EST)
Subject: Re: [PATCH] net: ibm_newemac: Don't start autonegotiation when
	disabled in BMCR (genmii)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1311072604-24840-1-git-send-email-sr@denx.de>
References: <1311072604-24840-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Jul 2011 21:35:22 +1000
Message-ID: <1311075322.25044.418.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-07-19 at 12:50 +0200, Stefan Roese wrote:
> As noticed on a custom 440GX board using the Micrel KSZ8041 PHY in
> fiber mode, a strapped fixed PHY configuration will currently restart
> the autonegotiation. This patch checks the BMCR_ANENABLE bit and
> skips this autonegotiation if its disabled.

Won't that just break aneg on everything else ?

IE, most other PHYs rely on ANENABLE being set further down this same
function (especially if the FW doesn't do it but even then, we may reset
PHYs along the way etc...)

This is something that really a case where the device-tree should
indicate that aneg shall not be performed and from there don't call
setup_aneg at all.

Cheers,
Ben.

> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/net/ibm_newemac/phy.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/ibm_newemac/phy.c b/drivers/net/ibm_newemac/phy.c
> index ac9d964..90afc58 100644
> --- a/drivers/net/ibm_newemac/phy.c
> +++ b/drivers/net/ibm_newemac/phy.c
> @@ -116,6 +116,11 @@ static int genmii_setup_aneg(struct mii_phy *phy, u32 advertise)
>  	ctl = phy_read(phy, MII_BMCR);
>  	if (ctl < 0)
>  		return ctl;
> +
> +	/* Don't start auto negotiation when its disabled in BMCR */
> +	if (!(ctl & BMCR_ANENABLE))
> +		return 0;
> +
>  	ctl &= ~(BMCR_FULLDPLX | BMCR_SPEED100 | BMCR_SPEED1000 | BMCR_ANENABLE);
>  
>  	/* First clear the PHY */
