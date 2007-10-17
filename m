Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 890EDDDECE
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 10:00:51 +1000 (EST)
Subject: Re: [PATCH] net: Add napi_sycnhronize() to sync with napi poll
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1192664183.13993.30.camel@localhost.localdomain>
References: <1192513792.19073.23.camel@pasglop>
	<20071016115318.0fc36af3@freepuppy.rosehill>
	<1192589522.11899.130.camel@pasglop> <47157EA4.1000500@garzik.org>
	<1192591481.11899.134.camel@pasglop>
	<20071017083107.6a1b1bd3@freepuppy.rosehill>
	<1192658654.6783.43.camel@pasglop>
	<1192664183.13993.30.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 09:59:57 +1000
Message-Id: <1192665597.12789.0.camel@pasglop>
Mime-Version: 1.0
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
	Roland Dreier <rdreier@cisco.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Stephen Hemminger <shemminger@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2007-10-17 at 18:36 -0500, Josh Boyer wrote:
> On Thu, 2007-10-18 at 08:04 +1000, Benjamin Herrenschmidt wrote:
> > net: Add __napi_synchronize() to sync with napi poll
> > 
> > The EMAC driver which needs to handle multiple devices with one
> > NAPI instance implements its own per-channel disable bit. However,
> > when setting such a bit, it needs to synchronize with the poller
> > (that is make sure that any pending poller instance has completed,
> > or is started late enough to see that disable bit).
> > 
> > This implements a low level __napi_synchronize() function to acheive
> > that. The underscores are to emphasis the low level aspect of it and
> > to discourage driver writers who don't know what they are doing to
> > use it (to please DaveM :-)
> 
> Erm.. your commit log calls it __napi_synchronize still.

The commit is a mistake, I sent a patch to rename it, or did I miss
something ?

Ben.
