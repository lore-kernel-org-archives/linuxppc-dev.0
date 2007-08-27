Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D6B67DE004
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2007 11:58:18 +1000 (EST)
Date: Sun, 26 Aug 2007 18:58:15 -0700 (PDT)
Message-Id: <20070826.185815.93042514.davem@davemloft.net>
To: jchapman@katalix.com
Subject: Re: RFC: issues concerning the next NAPI interface
From: David Miller <davem@davemloft.net>
In-Reply-To: <46D1D634.7060007@katalix.com>
References: <46CF127D.1090609@katalix.com>
	<20070824.144711.18301866.davem@davemloft.net>
	<46D1D634.7060007@katalix.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, themann@de.ibm.com, stefan.roscher@de.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, linuxppc-dev@ozlabs.org, akepner@sgi.com,
	meder@de.ibm.com, ossthema@de.ibm.com, shemminger@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: James Chapman <jchapman@katalix.com>
Date: Sun, 26 Aug 2007 20:36:20 +0100

> David Miller wrote:
> > From: James Chapman <jchapman@katalix.com>
> > Date: Fri, 24 Aug 2007 18:16:45 +0100
> > 
> >> Does hardware interrupt mitigation really interact well with NAPI?
> > 
> > It interacts quite excellently.
> 
> If NAPI disables interrupts and keeps them disabled while there are more 
> packets arriving or more transmits being completed, why do hardware 
> interrupt mitigation / coalescing features of the network silicon help?

Because if your packet rate is low enough such that the cpu can
process the interrupt fast enough and thus only one packet gets
processed per NAPI poll, the cost of going into and out of NAPI mode
dominates the packet processing costs.
