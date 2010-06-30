Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 43C7AB6F0C
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 04:36:54 +1000 (EST)
Date: Wed, 30 Jun 2010 11:37:06 -0700 (PDT)
Message-Id: <20100630.113706.133400770.davem@davemloft.net>
To: avorontsov@mvista.com
Subject: Re: [PATCH 1/3] gianfar: Implement workaround for eTSEC74 erratum
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100630163804.GA636@oksana.dev.rtsoft.ru>
References: <20100629205959.GA10905@oksana.dev.rtsoft.ru>
	<20100629.151626.90794001.davem@davemloft.net>
	<20100630163804.GA636@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com,
	Sandeep.Kumar@freescale.com, manfred.rudigier@omicron.at,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@mvista.com>
Date: Wed, 30 Jun 2010 20:38:04 +0400

> On Tue, Jun 29, 2010 at 03:16:26PM -0700, David Miller wrote:
>> 
>> I really don't see any value at all to this config option,
>> the errata fixup code should be there all the time.
> 
> Well, at least for eTSEC76 erratum (patch 2/3) we have to touch
> fast path (i.e. start_xmit), so I just wanted to make zero
> overhead for controllers that don't need any fixups.
> 
> Not that there's much of the overhead in a single additional
> 'if' condition, no. ;-)

The register accesses will dominate the costs with this chip.

The only case where a if() test is going to potentially create
some practical performance impact is if the TX is performed
purely using changes to a shared memory data structure and
absolutely no MMIO register reads or writes.
