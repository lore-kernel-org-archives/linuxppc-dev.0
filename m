Return-Path: <jason@lakedaemon.net>
Received: from mho-01-ewr.mailhop.org (mho-03-ewr.mailhop.org [204.13.248.66])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2E9B92C0350
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 06:01:23 +1000 (EST)
Date: Wed, 29 May 2013 16:00:53 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v5 01/13] net: mv643xx_eth: use phy_disconnect instead
 of phy_detach
Message-ID: <20130529200053.GA31290@titan.lakedaemon.net>
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369855975-21489-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369855975-21489-2-git-send-email-sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369855975-21489-2-git-send-email-sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lennert Buytenhek <buytenh@wantstofly.org>,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sebastian,

On Wed, May 29, 2013 at 09:32:43PM +0200, Sebastian Hesselbarth wrote:
> Using a separated mdio bus driver with mvmdio, phy_detach on network device
> removal will not stop the phy and finally lead to NULL pointer dereference
> in mvmdio due to non-existent network device. Use phy_disconnect instead
> to properly stop phy device from accessing network device prior removal of
> the network device.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Note: I observed this behavior when removing a modular mv643xx_eth driver
> after attaching it to a phy handled by (also modular) mvmdio. The mvmdio
> conversion has been done in
> 
> commit c3a07134e6aa5b93a37f72ffa3d11fadf72bf757
>  ("mv643xx_eth: convert to use the Marvell Orion MDIO driver")
> 
> and should go back any -stable version with that commit (propably only 3.9)

It looks like just v3.10-rcX, here.

thx,

Jason.
