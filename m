Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 119D7DE0B4
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 15:16:01 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] [POWERPC] AMCC Kilauea (405EX): Disable EMAC loopback mode
Date: Tue, 22 Apr 2008 07:15:51 +0200
References: <1203669132-9385-1-git-send-email-sr@denx.de>
	<1203715656.6976.7.camel@pasglop>
	<1208821568.9640.67.camel@pasglop>
In-Reply-To: <1208821568.9640.67.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200804220715.51736.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 22 April 2008, Benjamin Herrenschmidt wrote:
> On Sat, 2008-02-23 at 08:27 +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2008-02-22 at 09:32 +0100, Stefan Roese wrote:
> > > 405EX(r) has SDR0_MFR[E0CS/E1CS] set after reset. This selects
> > > the internal loopback mode. Clear these bits so that both EMACs
> > > don't use loopback mode as default.
> > >
> > > Signed-off-by: Stefan Roese <sr@denx.de>
> > > ---
> > > I'm not sure if this should be done here in the board platform code,
> > > or in the newemac driver or perhaps in some code common for 405EX.
> > >
> > > Any thoughts on this welcome.
> >
> > This should be done in EMAC since we also need to force internal
> > loopback & clocking when probing the PHY or we might not probe
> > it properly (and fail reset) if there is no link.
>
> Is that patch still needed if I apply Valentine patches ? I'm fixing
> them up so they don't break DCR MMIO anymore.

Great. I will send an additional patch to take care of this 405EX(r) loopback 
issue once your version of Valentines patches is available.

Best regards,
Stefan
