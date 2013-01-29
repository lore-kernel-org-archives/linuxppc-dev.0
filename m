Return-Path: <thomas.petazzoni@free-electrons.com>
Date: Tue, 29 Jan 2013 17:46:09 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH 5/5] mv643xx_eth: convert to use the Marvell Orion MDIO
 driver
Message-ID: <20130129174609.6ff6fe03@skate>
In-Reply-To: <5107F88C.8030002@openwrt.org>
References: <1359473048-26551-1-git-send-email-florian@openwrt.org>
 <1359473048-26551-6-git-send-email-florian@openwrt.org>
 <20130129170131.7964a110@skate> <5107F88C.8030002@openwrt.org>
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

On Tue, 29 Jan 2013 17:27:56 +0100, Florian Fainelli wrote:

> It looks like I introduced two redundant mvmdio instances as ge01
> refers to the ge00 smi bus (the same applies to ge11 and ge10).
> Thanks for spotting this.

Ok, good.

> If you take a closer look at mv643xx_eth you will see that the
> "shared" driver still handles the mconf bus window configuration,
> which is not abstracted yet.

Indeed, I've seen that. But I don't understand why it's done in the
mv643xx_eth_shared_probe(). The mbus window configuration registers are
per-network interface, so this call to mv643xx_eth_conf_mbus_windows()
could presumably be done in mv643xx_eth_probe().

At least in mvneta, we have the same registers, and we do their
initialization in the driver normal (and only) ->probe() routine.

> Besides that, I would rather do it step by step.

Yes, agreed. But I think it would be good to have followed patches that
progressively get rid of the shared driver thing, as it will help in
bringing a proper DT binding in the mv643xx_eth driver. But it
certainly doesn't need to be part of this specific patch.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
