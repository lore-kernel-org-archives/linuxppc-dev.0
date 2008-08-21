Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DB2E6DDED0
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 08:40:05 +1000 (EST)
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080821.152857.84114588.davem@davemloft.net>
References: <20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com> <1219356302.21386.147.camel@pasglop>
	<20080821.152857.84114588.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 22 Aug 2008 08:39:53 +1000
Message-Id: <1219358393.21386.158.camel@pasglop>
Mime-Version: 1.0
Cc: scottwood@freescale.com, sparclinux@vger.kernel.org, paulus@samba.org,
	linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-08-21 at 15:28 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Fri, 22 Aug 2008 08:05:02 +1000
> 
> > Apple additionally have different ways of representing multiple busses
> > on one controller though. On some machines, they just use bits 0xF00 of
> > the address as the bus number, which is a bit gross, and on some, they
> > have sub-nodes i2c-bus@NN under the controller.
> 
> Ok, Sun uses a 2-cell scheme.  We can handle both cases of reg
> encoding quite easily:
> 
> 1) If there is a single cell, tread bits 8 and above as bus number.
>    They will be zero on Sparc.

Depends if you want also to handle 10-bit addresses... though the
support for that could be enabled by an explicit property
10-bit-addresses in the controller node...  But as I said before, I
wouldn't worry too much about powermac for now, it's not using this code
and may never do.

> 2) If there are two cells, first cell is bus number.
> 
> For the hierarchical case, I'm not so sure how to handle it.
> 
> Also, last night, I posted patches to the I2C list to add bus
> addressing support to the I2C code and the PCF algo implementation.

Ben.
