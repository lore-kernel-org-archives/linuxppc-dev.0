Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 91318DDE01
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 09:59:23 +1100 (EST)
Subject: Re: [PATCH][OF] Add of_device_is_available function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080226.144423.138965691.davem@davemloft.net>
References: <18371.54796.174623.988521@cargo.ozlabs.ibm.com>
	<20080226.133430.41760910.davem@davemloft.net>
	<1204062337.15052.160.camel@pasglop>
	<20080226.144423.138965691.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 27 Feb 2008 09:58:49 +1100
Message-Id: <1204066729.15052.179.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-02-26 at 14:44 -0800, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Wed, 27 Feb 2008 08:45:37 +1100
> 
> > I doubt we do that. Properties that contain things like ranges, or "reg"
> > properties are expected to be of a size that is a multiple of
> > #size-cells/#address-cells and I'm not sure that won't break things here
> > or there if they suddenly get one more byte..
> > 
> > Or do you mean you/we are appending that-without- changing the length
> > field ?
> 
> Right, simply don't change the length field.  Put the zero byte
> at offset "length + 1"
> 
> It's stupid to validate NULL termination everywhere when we
> can make it an invariant in one spot.

Fair enough.

Ben.
