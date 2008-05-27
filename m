Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3EBADDF78
	for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2008 18:41:18 +1000 (EST)
Date: Tue, 27 May 2008 09:24:30 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Miller <davem@davemloft.net>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080527092430.6380d962@core>
In-Reply-To: <20080526.192812.184590464.davem@davemloft.net>
References: <1211852026.3286.36.camel@pasglop>
	<20080526.184047.88207142.davem@davemloft.net>
	<1211854540.3286.42.camel@pasglop>
	<20080526.192812.184590464.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	torvalds@linux-foundation.org, tpiepho@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> It's just another complicated thing for driver authors to get wrong.
> The other side of the coin is of course the cost.
> 
> The only thing I am absolutely sure of is that we should make a
> decision fast, document it, and just stick to it.

It's unfortunate that the __read/___write versions have other different
semantics. The default should definitely be ordered but having un-ordered
ones as an option would be good for zapping the hot paths that matter.

Most I/O paths aren't even worth the thinking time for non-ordered I/O.

Alan
