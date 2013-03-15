Return-Path: <thomas.petazzoni@free-electrons.com>
Date: Fri, 15 Mar 2013 12:42:10 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH 4/4 v2] mv643xx_eth: convert to use the Marvell Orion
 MDIO driver
Message-ID: <20130315124210.27d0794a@skate>
In-Reply-To: <514300E0.2030108@openwrt.org>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-1-git-send-email-florian@openwrt.org>
 <1363284515-9865-5-git-send-email-florian@openwrt.org>
 <514300E0.2030108@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@arm.linux.org.uk>,
 Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, netdev@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.infradead.org,
 Rob Landley <rob@landley.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Florian Fainelli,

On Fri, 15 Mar 2013 12:07:12 +0100, Florian Fainelli wrote:

> Thanks to the help of Andrew Lunn, there is at least two known issues 
> with this patch version:
> 
> - we need to move up the mvmdio line in 
> drivers/net/ethernet/marvell/Makefile to make sure that configs having 
> both mvmdio and mv643xx_eth built-in get the probing order right

I don't think it's the right way of fixing the problem. If there is no
dependency on the two devices through the device model (i.e they don't
have a parent->child relationship), then the mv643xx_eth driver should
probably return -EPROBE_DEFER when it can't find its PHY so that its
->probe() operation gets called once again by the kernel when other
drivers (including mvmdio) have been probed.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
