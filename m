Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) by ozlabs.org (Postfix) with ESMTP id 1D26E67A3D
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 07:25:12 +1000 (EST)
Date: Fri, 18 Aug 2006 14:25:13 -0700 (PDT)
Message-Id: <20060818.142513.29571851.davem@davemloft.net>
To: linas@austin.ibm.com
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060818192356.GD26889@austin.ibm.com>
References: <20060811170813.GJ10638@austin.ibm.com>
	<1155771820.11312.116.camel@localhost.localdomain>
	<20060818192356.GD26889@austin.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: arnd@arndb.de, jklewis@us.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, Jens.Osterkamp@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: linas@austin.ibm.com (Linas Vepstas)
Date: Fri, 18 Aug 2006 14:23:56 -0500

> On Thu, Aug 17, 2006 at 01:43:40AM +0200, Benjamin Herrenschmidt wrote:
> > 
> > Sounds good (without actually looking at the code though :), that was a
> > long required improvement to that driver. Also, we should probably look
> > into using NAPI polling for tx completion queue as well, no ?
> 
> Just for a lark, I tried using NAPI polling, while disabling all TX
> interrupts. Performance was a disaster: 8Mbits/sec, fom which I conclude
> that the tcp ack packets do not flow back fast enough to allw reliance
> on NAPI polling for transmit.

The idea is to use NAPI polling with TX interrupts disabled.

We're not saying to use the RX interrupt as the trigger for
RX and TX work.  Rather, either of RX or TX interrupt will
schedule the NAPI poll.
