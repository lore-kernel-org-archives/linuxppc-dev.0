Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 96F2447719
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 08:28:58 +1000 (EST)
Date: Thu, 21 Aug 2008 15:28:57 -0700 (PDT)
Message-Id: <20080821.152857.84114588.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1219356302.21386.147.camel@pasglop>
References: <20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com>
	<1219356302.21386.147.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: scottwood@freescale.com, sparclinux@vger.kernel.org, paulus@samba.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 22 Aug 2008 08:05:02 +1000

> Apple additionally have different ways of representing multiple busses
> on one controller though. On some machines, they just use bits 0xF00 of
> the address as the bus number, which is a bit gross, and on some, they
> have sub-nodes i2c-bus@NN under the controller.

Ok, Sun uses a 2-cell scheme.  We can handle both cases of reg
encoding quite easily:

1) If there is a single cell, tread bits 8 and above as bus number.
   They will be zero on Sparc.

2) If there are two cells, first cell is bus number.

For the hierarchical case, I'm not so sure how to handle it.

Also, last night, I posted patches to the I2C list to add bus
addressing support to the I2C code and the PCF algo implementation.
