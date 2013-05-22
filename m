Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CC9AA2C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 06:16:20 +1000 (EST)
Date: Wed, 22 May 2013 14:16:07 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/2] net: mv643xx_eth: proper initialization for Kirkwood
 SoCs
Message-ID: <20130522201607.GA18823@obsidianresearch.com>
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369253042-15082-2-git-send-email-sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369253042-15082-2-git-send-email-sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-kernel@vger.kernel.org, Lennert Buytenhek <buytenh@wantstofly.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 22, 2013 at 10:04:02PM +0200, Sebastian Hesselbarth wrote:

> Ethernet controllers found on Kirkwood SoCs not only suffer from loosing
> MAC address register contents on clock gating but also some important
> registers are reset to values that would break ethernet. This patch

FWIW, we found that the bootloader has to write to PSC1, the driver
doesn't work with the power on/reset value of the register. So I think
it is safe to assume that all kirkwood bootloaders alter the value.

Our systems write the value 0x00638488 to PSC1.

I looked at patching mv643xx_eth, but ran into the same complexity you
did, it isn't clear what variants of this IP block have the
register/etc.

> +	/* Kirkwood resets some registers on gated clocks. Especially
> +	 * CLK125_BYPASS_EN must be cleared but is not available on
> +	 * all other SoCs/System Controllers using this driver.
> +	 */
> +	if (of_machine_is_compatible("marvell,kirkwood"))
> +		wrlp(mp, PORT_SERIAL_CONTROL1,
> +		     rdlp(mp, PORT_SERIAL_CONTROL1) & ~CLK125_BYPASS_EN);

of_machine_is_compatible seems heavy handed, I would expect this to be
based on the compatible string of the ethernet node itself, not the
machine??

Jason
