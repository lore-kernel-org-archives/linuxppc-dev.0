Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8CA2C2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 05:06:52 +1100 (EST)
Date: Fri, 15 Mar 2013 18:05:03 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH 3/4 v2] net: mvmdio: enhance driver to support SMI
 error/done interrupts
Message-ID: <20130315180503.GU4977@n2100.arm.linux.org.uk>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-4-git-send-email-florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363284515-9865-4-git-send-email-florian@openwrt.org>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 netdev@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-arm-kernel@lists.infradead.org, Rob Landley <rob@landley.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net, Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 14, 2013 at 07:08:34PM +0100, Florian Fainelli wrote:
> +	if (dev->err_interrupt == NO_IRQ) {
...
> +	init_waitqueue_head(&dev->smi_busy_wait);
> +
> +	dev->err_interrupt = platform_get_irq(pdev, 0);
> +	if (dev->err_interrupt != -ENXIO) {
...
> +	} else
> +		dev->err_interrupt = NO_IRQ;


FYI, NO_IRQ is not supposed to be used anymore (we're supposed to be
removing it).  platform_get_irq() returns negative numbers for failure,
so why not test for < 0 in both the above tests, or maybe <= 0 (as
IRQ0 is also not supposed to be valid.)?
