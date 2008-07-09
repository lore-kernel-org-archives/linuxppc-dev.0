Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93960DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 13:23:39 +1000 (EST)
Subject: Re: [PATCH v2] ibm_newemac: Add MII mode support to the EMAC RGMII
	bridge.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Erickson <gerickson@nuovations.com>
In-Reply-To: <1215529386-12749-1-git-send-email-gerickson@nuovations.com>
References: <C497F939.104DB%gerickson@nuovations.com>
	<1215529386-12749-1-git-send-email-gerickson@nuovations.com>
Content-Type: text/plain
Date: Wed, 09 Jul 2008 13:23:22 +1000
Message-Id: <1215573802.8970.302.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, jgarzik@pobox.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-08 at 08:03 -0700, Grant Erickson wrote:
> This patch adds support to the RGMII handler in the EMAC driver for
> the MII PHY mode such that device tree entries of the form `phy-mode = "mii";'
> are recognized and handled appropriately.
> 
> While logically, in software, "gmii" and "mii" modes are the same,
> they are wired differently, so it makes sense to allow DTS authors to
> specify each explicitly.
> 
> Signed-off-by: Grant Erickson <gerickson@nuovations.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Jeff, I'd like to apply that (and other EMAC patches for 2.6.27, do you
have anything else pending ?) via my tree provided you give me your ack.
The reason is that the multicast fix one is going that way as it touches
other arch files, and subsequent ones are now likely to conflict.

Let me know if that's ok with you in which case I'll stick your ack in
there.

Cheers,
Ben.

> ---
>  drivers/net/ibm_newemac/rgmii.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/ibm_newemac/rgmii.c b/drivers/net/ibm_newemac/rgmii.c
> index e32da3d..5acb006 100644
> --- a/drivers/net/ibm_newemac/rgmii.c
> +++ b/drivers/net/ibm_newemac/rgmii.c
> @@ -39,6 +39,7 @@
>  #define RGMII_FER_RGMII(idx)	(0x5 << ((idx) * 4))
>  #define RGMII_FER_TBI(idx)	(0x6 << ((idx) * 4))
>  #define RGMII_FER_GMII(idx)	(0x7 << ((idx) * 4))
> +#define RGMII_FER_MII(idx)	RGMII_FER_GMII(idx)
>  
>  /* RGMIIx_SSR */
>  #define RGMII_SSR_MASK(idx)	(0x7 << ((idx) * 8))
> @@ -49,6 +50,7 @@
>  static inline int rgmii_valid_mode(int phy_mode)
>  {
>  	return  phy_mode == PHY_MODE_GMII ||
> +		phy_mode == PHY_MODE_MII ||
>  		phy_mode == PHY_MODE_RGMII ||
>  		phy_mode == PHY_MODE_TBI ||
>  		phy_mode == PHY_MODE_RTBI;
> @@ -63,6 +65,8 @@ static inline const char *rgmii_mode_name(int mode)
>  		return "TBI";
>  	case PHY_MODE_GMII:
>  		return "GMII";
> +	case PHY_MODE_MII:
> +		return "MII";
>  	case PHY_MODE_RTBI:
>  		return "RTBI";
>  	default:
> @@ -79,6 +83,8 @@ static inline u32 rgmii_mode_mask(int mode, int input)
>  		return RGMII_FER_TBI(input);
>  	case PHY_MODE_GMII:
>  		return RGMII_FER_GMII(input);
> +	case PHY_MODE_MII:
> +		return RGMII_FER_MII(input);
>  	case PHY_MODE_RTBI:
>  		return RGMII_FER_RTBI(input);
>  	default:
> --
> 1.5.4.3
