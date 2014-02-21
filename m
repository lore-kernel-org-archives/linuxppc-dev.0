Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id B324D2C0312
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 22:18:28 +1100 (EST)
Date: Fri, 21 Feb 2014 11:18:23 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Alistair Popple <alistair@popple.id.au>
Subject: Re: [PATCH 2/7] IBM Akebono: Add support for a new PHY interface
 to the IBM emac driver
Message-ID: <20140221111823.GA8783@e106331-lin.cambridge.arm.com>
References: <1392964293-13687-1-git-send-email-alistair@popple.id.au>
 <1392964293-13687-3-git-send-email-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392964293-13687-3-git-send-email-alistair@popple.id.au>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 21, 2014 at 06:31:28AM +0000, Alistair Popple wrote:
> The IBM PPC476GTR SoC that is used on the Akebono board uses a
> different ethernet PHY interface that has wake on lan (WOL) support
> with the IBM emac. This patch adds support to the IBM emac driver for
> this new PHY interface.
> 
> At this stage the wake on lan functionality has not been implemented.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> ---

[...]

> +       /* Check for RGMII flags */
> +       if (of_get_property(ofdev->dev.of_node, "has-mdio", NULL))
> +               dev->flags |= EMAC_RGMII_FLAG_HAS_MDIO;

You can use of_property_read_bool here.

Cheers,
Mark.
