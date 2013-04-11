Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
 by ozlabs.org (Postfix) with ESMTP id 6A0AC2C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 01:03:50 +1000 (EST)
Date: Thu, 11 Apr 2013 17:03:26 +0200
From: Willy Tarreau <w@1wt.eu>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH] net: mv643xx_eth: Add GRO support
Message-ID: <20130411150326.GA19978@1wt.eu>
References: <1365684023-9967-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130411131333.GD1910@1wt.eu>
 <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Soeren Moch <smoch@web.de>, Paul Mackerras <paulus@samba.org>,
 linux-arm-kernel@lists.infradead.org, Dale Farnsworth <dale@farnsworth.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Florian Fainelli <florian@openwrt.org>,
 Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sebastian,

On Thu, Apr 11, 2013 at 04:47:49PM +0200, Sebastian Hesselbarth wrote:
> I did some simple tests on Dove/Cubox with 'netperf -cCD' and
> gso/gro/lro options on
> mv643xx_eth. The tests may not be sufficient, as I am not that into
> net performance testing.

In fact the difference only happens when the NIC has not verified the
checksum itself IIRC, which should be for non-IPv4 traffic. I agree
that it's not easy to test a bridge with a cubox which has a single
port :-) Maybe you'll see a difference in IPv6 traffic or with VLAN
traffic, as I seem to remember this chip does not do cksum offloading
on VLANs, but I could be wrong.

> I tried todays net-next on top of 3.9-rc6 without any gro patch, with
> the initial
> patch (Soeren) and your proposed patch (Willy). The results show that
> both patches
> allow a significant increase in throughput compared to
> netif_receive_skb (!gro, !lro)
> alone. Having gro with lro disabled gives some 2% more throughput
> compared to lro only.

Indeed this is consistent with my memories, since Eric improved the
GRO path, it became faster than LRO on this chip.

Regards,
Willy
