Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B502DDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 08:44:24 +1100 (EST)
Subject: Re: pmac_zilog debugging ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <491C11B2.1060909@hypersurf.com>
References: <4914B549.9010805@hypersurf.com>
	<1226096603.13603.74.camel@pasglop>  <491C11B2.1060909@hypersurf.com>
Content-Type: text/plain
Date: Fri, 14 Nov 2008 08:44:14 +1100
Message-Id: <1226612654.7178.84.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-11-13 at 03:38 -0800, Kevin Diggs wrote:

> 12,206 PowerMac Zilog interrupts
> 
> Interrupt load is higher without the DMA support.
> 
> Is it possible that this hardware was not meant to be used without the
> DMA (i.e. it does not work quite right?)?

Well, the HW Rx buffer is only 3 bytes so if you have high interrupt
latencies you are more likely to loose data...

Now, as I said, have you looked at flow control ? It's a likely cause of
problems and it's possible that pmac_zilog doesn't do it the way
macserial did...

Regarding DMA, it's possible to implement, though there were interesting
issues with the way it was done in macserial, it should be done
differently in pmac_zilog.

I think the only approach that really works properly (though it's fugly)
is what Apple does in OSX I think, which is to have a DMA descriptor per
input byte (no need for a huge DMA buffer anyway).

Cheers,
Ben.
