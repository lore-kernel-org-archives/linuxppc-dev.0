Return-Path: <jason@lakedaemon.net>
Received: from mho-01-ewr.mailhop.org (mho-03-ewr.mailhop.org [204.13.248.66])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5948A2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Nov 2013 12:13:19 +1100 (EST)
Date: Mon, 4 Nov 2013 19:36:35 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH] net: mv643xx_eth: Add missing phy_addr_set in DT mode
Message-ID: <20131105003635.GG3060@titan.lakedaemon.net>
References: <1383611239-14556-1-git-send-email-jgunthorpe@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383611239-14556-1-git-send-email-jgunthorpe@obsidianresearch.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 Lennert Buytenhek <buytenh@wantstofly.org>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jason,

On Mon, Nov 04, 2013 at 05:27:19PM -0700, Jason Gunthorpe wrote:
> Commit cc9d4598 'net: mv643xx_eth: use of_phy_connect if phy_node

fyi: set core.abbrev = 12 in your git config, according to Linus, 7/8
was a bad decision...

> present' made the call to phy_scan optional, if the DT has a link to
> the phy node.
> 
> However phy_scan has the side effect of calling phy_addr_set, which
> writes the phy MDIO address to the ethernet controller. If phy_addr_set
> is not called, and the bootloader has not set the correct address then
> the driver will fail to function.
> 
> Tested on Kirkwood.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Fixes: cc9d459894b0 "net: mv643xx_eth: use of_phy_connect if phy_node present"
Acked-by: Jason Cooper <jason@lakedaemon.net>

And it should be suitable for v3.11+

thx,

Jason.
