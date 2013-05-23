Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 61D292C007C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 May 2013 03:54:02 +1000 (EST)
Date: Thu, 23 May 2013 11:53:57 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 2/2] net: mv643xx_eth: proper initialization for Kirkwood
 SoCs
Message-ID: <20130523175357.GB2821@obsidianresearch.com>
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130522201607.GA18823@obsidianresearch.com>
 <20130523160111.GP31290@titan.lakedaemon.net>
 <20130523171112.GB31281@obsidianresearch.com>
 <20130523172339.GQ31290@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130523172339.GQ31290@titan.lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 Lennert Buytenhek <buytenh@wantstofly.org>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 23, 2013 at 01:23:39PM -0400, Jason Cooper wrote:

> Shouldn't it rather be
> 
> 	compatible = "marvell,kirkwood-eth", "marvell,orion-eth";

Not sure about orion-eth?
 
> I'm inclined to go with of_machine_is_compatible() since the only
> concrete difference we know is that the tweak is needed on kirkwood and
> nowhere else.

But there is a larger problem here then just this one bit.

The PSC1 register must be set properly for the board layout, and today
we rely on the bootloader to set it. In fact, even with Sebastian's
change the ethernet port won't work without bootloader
intervention. The PortReset bit should also be cleared by the driver
(and it is only present on some variants of this IP block,
apparently).

We know that some Marvell SOC's wack the ethernet registers when they
clock gate, and the flip of Clk125Bypass is another symptom of this
general problem.

So, long term, the PSC1 must be fully set by the driver, based on DT
information describing the board (eg RGMII/MII/1000Base-X [SFP] Phy
type), and the layout of this register seems to vary on a SOC by SOC
basis.

Thus, I think it is appropriate to call this variant of the eth IP
'marvell,kirkwood-eth' which indicates that the register block follows
the kirkwood manual and the PSC1 register specifically has the
kirkwood layout.

The question is what other Marvell SOCs have the same PSC1 layout as
kirkwood?

Jason
