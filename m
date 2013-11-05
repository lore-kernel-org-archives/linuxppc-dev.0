Return-Path: <jason@lakedaemon.net>
Received: from mho-01-ewr.mailhop.org (mho-03-ewr.mailhop.org [204.13.248.66])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D4B752C0079
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 10:00:33 +1100 (EST)
Date: Tue, 5 Nov 2013 18:00:24 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Arnaud Ebalard <arno@natisbad.org>
Subject: Re: [PATCH] net: mv643xx_eth: Add missing phy_addr_set in DT mode
Message-ID: <20131105230024.GB8308@titan.lakedaemon.net>
References: <1383611239-14556-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <87sivacxcf.fsf@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87sivacxcf.fsf@natisbad.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Lennert Buytenhek <buytenh@wantstofly.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 05, 2013 at 11:12:00PM +0100, Arnaud Ebalard wrote:
> Hi Jason,
> 
> Jason Gunthorpe <jgunthorpe@obsidianresearch.com> writes:
> 
> > Commit cc9d4598 'net: mv643xx_eth: use of_phy_connect if phy_node
> > present' made the call to phy_scan optional, if the DT has a link to
> > the phy node.
> >
> > However phy_scan has the side effect of calling phy_addr_set, which
> > writes the phy MDIO address to the ethernet controller. If phy_addr_set
> > is not called, and the bootloader has not set the correct address then
> > the driver will fail to function.
> 
> Thanks *a lot* for fixing this one! I had the issue on my ReadyNAS 102
> (Armada 370 based) which I had put on a todo list and temporarily

readynas duo v2?

thx,

Jason.

> workarounded by including a 'ping whatever' call in my u-boot env in
> order to force it to do the init. Without it, I was unable to properly
> use the interface. With your fix, after multiple reboots to test it,
> everything works as expected. So, FWIW: 
> 
> Tested-by: Arnaud Ebalard <arno@natisbad.org>
> 
> Cheers,
> 
> a+
