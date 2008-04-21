Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DFA24DE187
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 09:46:19 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] AMCC Kilauea (405EX): Disable EMAC loopback mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1203715656.6976.7.camel@pasglop>
References: <1203669132-9385-1-git-send-email-sr@denx.de>
	<1203715656.6976.7.camel@pasglop>
Content-Type: text/plain
Date: Tue, 22 Apr 2008 09:46:08 +1000
Message-Id: <1208821568.9640.67.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-02-23 at 08:27 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2008-02-22 at 09:32 +0100, Stefan Roese wrote:
> > 405EX(r) has SDR0_MFR[E0CS/E1CS] set after reset. This selects
> > the internal loopback mode. Clear these bits so that both EMACs
> > don't use loopback mode as default.
> > 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > ---
> > I'm not sure if this should be done here in the board platform code,
> > or in the newemac driver or perhaps in some code common for 405EX.
> > 
> > Any thoughts on this welcome.
> 
> This should be done in EMAC since we also need to force internal
> loopback & clocking when probing the PHY or we might not probe
> it properly (and fail reset) if there is no link.

Is that patch still needed if I apply Valentine patches ? I'm fixing
them up so they don't break DCR MMIO anymore.

Cheers,
Ben.
