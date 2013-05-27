Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 52EF62C02E9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2013 08:17:58 +1000 (EST)
Date: Mon, 27 May 2013 15:17:44 -0700 (PDT)
Message-Id: <20130527.151744.1526437556583356156.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] ARM: kirkwood: proper retain MAC address
 workaround on DT ethernet
From: David Miller <davem@davemloft.net>
In-Reply-To: <1369691406.3557.35.camel@pasglop>
References: <1369655404.3557.33.camel@pasglop> <2255648.0KEmXfjCx5@wuerfel>
 <1369691406.3557.35.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: andrew@lunn.ch, jason@lakedaemon.net, arnd@arndb.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 grant.likely@linaro.org, linuxppc-dev@lists.ozlabs.org, buytenh@wantstofly.org,
 sebastian.hesselbarth@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 28 May 2013 07:50:06 +1000

> On Mon, 2013-05-27 at 14:47 +0200, Arnd Bergmann wrote:
>> On Monday 27 May 2013 21:50:04 Benjamin Herrenschmidt wrote:
>> > However, that wouldn't help much with the allocation/leak problem,
>> > though at least it would be easier to use. It could also *try* to re-use
>> > the current allocation if the new content is of smaller or equal size.
>> 
>> I thought that dtc tried to aggressively save space by folding identical
>> strings. If you tried to reuse a property that had its contents shared
>> with another one, you would get interesting results I guess.
> 
> It used to be only property names, unless that has changed in recent
> dtc. But that's a good point, we probably want a flag in struct property
> like we have for nodes, indicating whether it comes from the original
> fdt data pool or not.

This is similar to what the "OF_IS_DYNAMIC()" thing on sparc
indicates.
