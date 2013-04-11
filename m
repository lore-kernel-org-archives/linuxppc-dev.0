Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 684662C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 03:31:25 +1000 (EST)
Date: Thu, 11 Apr 2013 13:31:19 -0400 (EDT)
Message-Id: <20130411.133119.913809939413807690.davem@davemloft.net>
To: sebastian.hesselbarth@gmail.com
Subject: Re: [PATCH] net: mv643xx_eth: Add GRO support
From: David Miller <davem@davemloft.net>
In-Reply-To: <CABJ1b_TRxm97DKJLP_h0VwMJvcYmSpjoJvtg1KvBNGah=VzqMQ@mail.gmail.com>
References: <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
 <20130411150326.GA19978@1wt.eu>
 <CABJ1b_TRxm97DKJLP_h0VwMJvcYmSpjoJvtg1KvBNGah=VzqMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: andrew@lunn.ch, jason@lakedaemon.net, linux-kernel@vger.kernel.org,
 w@1wt.eu, smoch@web.de, paulus@samba.org, linux-arm-kernel@lists.infradead.org,
 dale@farnsworth.org, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 florian@openwrt.org, buytenh@wantstofly.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Date: Thu, 11 Apr 2013 17:27:03 +0200

> On Thu, Apr 11, 2013 at 5:03 PM, Willy Tarreau <w@1wt.eu> wrote:
>> On Thu, Apr 11, 2013 at 04:47:49PM +0200, Sebastian Hesselbarth wrote:
>>> I tried todays net-next on top of 3.9-rc6 without any gro patch, with
>>> the initial
>>> patch (Soeren) and your proposed patch (Willy). The results show that
>>> both patches
>>> allow a significant increase in throughput compared to
>>> netif_receive_skb (!gro, !lro)
>>> alone. Having gro with lro disabled gives some 2% more throughput
>>> compared to lro only.
>>
>> Indeed this is consistent with my memories, since Eric improved the
>> GRO path, it became faster than LRO on this chip.
> 
> I don't have a strong opinion on whether Soeren's or your proposal should
> be submitted. But I insist on having one of them in, as GRO significantly
> improves the common use case, is enabled by default, and not as
> constrained as LRO.

I think, as per other drivers, LRO should be eliminated completely from
all drivers, including this one, and GRO used exclusively instead.
