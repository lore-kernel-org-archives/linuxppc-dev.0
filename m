Return-Path: <w@1wt.eu>
Received: from 1wt.eu (1wt.eu [62.212.114.60])
 by ozlabs.org (Postfix) with ESMTP id 366282C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 03:52:07 +1000 (EST)
Date: Thu, 11 Apr 2013 19:51:47 +0200
From: Willy Tarreau <w@1wt.eu>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: mv643xx_eth: Add GRO support
Message-ID: <20130411175147.GN1910@1wt.eu>
References: <CABJ1b_TQDabT1J7ffo5cb1Th=71bcSduifMJaDpfVRiiHvtWDw@mail.gmail.com>
 <20130411150326.GA19978@1wt.eu>
 <CABJ1b_TRxm97DKJLP_h0VwMJvcYmSpjoJvtg1KvBNGah=VzqMQ@mail.gmail.com>
 <20130411.133119.913809939413807690.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130411.133119.913809939413807690.davem@davemloft.net>
Cc: andrew@lunn.ch, jason@lakedaemon.net, linux-kernel@vger.kernel.org,
 smoch@web.de, paulus@samba.org, linux-arm-kernel@lists.infradead.org,
 dale@farnsworth.org, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 florian@openwrt.org, buytenh@wantstofly.org, sebastian.hesselbarth@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 11, 2013 at 01:31:19PM -0400, David Miller wrote:
> From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Date: Thu, 11 Apr 2013 17:27:03 +0200
> 
> > On Thu, Apr 11, 2013 at 5:03 PM, Willy Tarreau <w@1wt.eu> wrote:
> >> On Thu, Apr 11, 2013 at 04:47:49PM +0200, Sebastian Hesselbarth wrote:
> >>> I tried todays net-next on top of 3.9-rc6 without any gro patch, with
> >>> the initial
> >>> patch (Soeren) and your proposed patch (Willy). The results show that
> >>> both patches
> >>> allow a significant increase in throughput compared to
> >>> netif_receive_skb (!gro, !lro)
> >>> alone. Having gro with lro disabled gives some 2% more throughput
> >>> compared to lro only.
> >>
> >> Indeed this is consistent with my memories, since Eric improved the
> >> GRO path, it became faster than LRO on this chip.
> > 
> > I don't have a strong opinion on whether Soeren's or your proposal should
> > be submitted. But I insist on having one of them in, as GRO significantly
> > improves the common use case, is enabled by default, and not as
> > constrained as LRO.
> 
> I think, as per other drivers, LRO should be eliminated completely from
> all drivers, including this one, and GRO used exclusively instead.

Eric provided me with one such experimental patch in the past for this
driver. It worked for me but we never tried to clean it up to propose
it for inclusion.

If anyone is interested, I might still have it in experimental shape.

Willy
