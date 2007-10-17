Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C3019DDEC2
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 09:50:10 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9HNpT1r008394
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 19:51:29 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9HNnvFI041782
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 19:49:57 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9HNnpKY006929
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 19:49:52 -0400
Subject: Re: [PATCH] net: Add napi_sycnhronize() to sync with napi poll
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
In-Reply-To: <1192658654.6783.43.camel@pasglop>
References: <1192513792.19073.23.camel@pasglop>
	<20071016115318.0fc36af3@freepuppy.rosehill>
	<1192589522.11899.130.camel@pasglop> <47157EA4.1000500@garzik.org>
	<1192591481.11899.134.camel@pasglop>
	<20071017083107.6a1b1bd3@freepuppy.rosehill>
	<1192658654.6783.43.camel@pasglop>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 18:36:23 -0500
Message-Id: <1192664183.13993.30.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
	Roland Dreier <rdreier@cisco.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Stephen Hemminger <shemminger@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-10-18 at 08:04 +1000, Benjamin Herrenschmidt wrote:
> net: Add __napi_synchronize() to sync with napi poll
> 
> The EMAC driver which needs to handle multiple devices with one
> NAPI instance implements its own per-channel disable bit. However,
> when setting such a bit, it needs to synchronize with the poller
> (that is make sure that any pending poller instance has completed,
> or is started late enough to see that disable bit).
> 
> This implements a low level __napi_synchronize() function to acheive
> that. The underscores are to emphasis the low level aspect of it and
> to discourage driver writers who don't know what they are doing to
> use it (to please DaveM :-)

Erm.. your commit log calls it __napi_synchronize still.

josh
