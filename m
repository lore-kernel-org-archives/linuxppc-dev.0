Return-Path: <andrew@lunn.ch>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B70B1A0036
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 04:25:40 +1100 (AEDT)
Date: Thu, 14 Jan 2016 17:44:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: shh.xie@gmail.com
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, f.fainelli@gmail.com,
 davem@davemloft.net, Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: Re: [PATCH 1/3][v2] net: phy: introduce 1000BASE-KX and 10GBASE-KR
Message-ID: <20160114164418.GD19773@lunn.ch>
References: <1452759839-9874-1-git-send-email-shh.xie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452759839-9874-1-git-send-email-shh.xie@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 14, 2016 at 04:23:59PM +0800, shh.xie@gmail.com wrote:
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
> 
> This commit adds necessary definitions for the PHY layer to recognize
> backplane Ethernet 1000BASE-KX and 10GBASE-KR as valid PHY interfaces,
> "1000base-kx" for 1000BASE-KX, "10gbase-kr" for 10GBASE-KR.
> 
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> changes in v2:
> new patch.
> 
>  Documentation/devicetree/bindings/net/ethernet.txt | 4 ++--
>  include/linux/phy.h                                | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ethernet.txt b/Documentation/devicetree/bindings/net/ethernet.txt
> index 5d88f37..1166a5c 100644
> --- a/Documentation/devicetree/bindings/net/ethernet.txt
> +++ b/Documentation/devicetree/bindings/net/ethernet.txt
> @@ -11,8 +11,8 @@ The following properties are common to the Ethernet controllers:
>    the maximum frame size (there's contradiction in ePAPR).
>  - phy-mode: string, operation mode of the PHY interface; supported values are
>    "mii", "gmii", "sgmii", "qsgmii", "tbi", "rev-mii", "rmii", "rgmii", "rgmii-id",
> -  "rgmii-rxid", "rgmii-txid", "rtbi", "smii", "xgmii"; this is now a de-facto
> -  standard property;
> +  "rgmii-rxid", "rgmii-txid", "rtbi", "smii", "xgmii", "1000base-kx", "10gbase-kr";
> +  this is now a de-facto standard property;

I know very little about this, so i'm just asking a question. None of
the other interface modes contain a bit rate. So is the bit rate
needed for your two new modes?

With a bit of googling, K means copper backplane, X means 4B/5B and R
means 64B/66B. Could there be a 10Gbps KX? a 1GBps KR? Do we actually
need the speed here, or is kx and kr sufficient?

     Thanks
	Andrew
