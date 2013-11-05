Return-Path: <arno@natisbad.org>
Received: from smtp.natisbad.org (unknown
 [IPv6:2a01:e35:139b:9f90:221:70ff:fe55:8f78])
 by ozlabs.org (Postfix) with ESMTP id 405402C016B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 09:17:41 +1100 (EST)
From: arno@natisbad.org (Arnaud Ebalard)
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH] net: mv643xx_eth: Add missing phy_addr_set in DT mode
References: <1383611239-14556-1-git-send-email-jgunthorpe@obsidianresearch.com>
Date: Tue, 05 Nov 2013 23:12:00 +0100
In-Reply-To: <1383611239-14556-1-git-send-email-jgunthorpe@obsidianresearch.com>
 (Jason Gunthorpe's message of "Mon, 4 Nov 2013 17:27:19 -0700")
Message-ID: <87sivacxcf.fsf@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Hi Jason,

Jason Gunthorpe <jgunthorpe@obsidianresearch.com> writes:

> Commit cc9d4598 'net: mv643xx_eth: use of_phy_connect if phy_node
> present' made the call to phy_scan optional, if the DT has a link to
> the phy node.
>
> However phy_scan has the side effect of calling phy_addr_set, which
> writes the phy MDIO address to the ethernet controller. If phy_addr_set
> is not called, and the bootloader has not set the correct address then
> the driver will fail to function.

Thanks *a lot* for fixing this one! I had the issue on my ReadyNAS 102
(Armada 370 based) which I had put on a todo list and temporarily
workarounded by including a 'ping whatever' call in my u-boot env in
order to force it to do the init. Without it, I was unable to properly
use the interface. With your fix, after multiple reboots to test it,
everything works as expected. So, FWIW: 

Tested-by: Arnaud Ebalard <arno@natisbad.org>

Cheers,

a+
