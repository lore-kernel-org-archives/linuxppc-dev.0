Return-Path: <kenneth@southpole.se>
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id 0B69ADE019
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 07:16:13 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.southpole.se (Postfix) with SMTP id B652F4ED0FA
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 23:16:02 +0200 (CEST)
Subject: Re: [U-Boot-Users] mpc5121 cache coherency
From: kenneth johansson <kenneth@southpole.se>
To: John Rigby <jcrigby@gmail.com>
In-Reply-To: <4b73d43f0806181238k4ab0b900w3f18216a5c083248@mail.gmail.com>
References: <1213817391.27790.27.camel@localhost.localdomain>
	<4b73d43f0806181238k4ab0b900w3f18216a5c083248@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 18 Jun 2008 23:16:04 +0200
Message-Id: <1213823764.10172.3.camel@duo>
Mime-Version: 1.0
Cc: u-boot-users <u-boot-users@lists.sourceforge.net>,
	linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-06-18 at 13:38 -0600, John Rigby wrote:
> Unlike other SOCs with e300 cores the 5121 is not cache coherent.  The
> problem is an internal bridge that the processor can not snoop across.

I do not have access to the manuals right now but I search all over an
this was not something I found. Is this a design decision or an errata
for the current version of the chip ?   


> On Wed, Jun 18, 2008 at 1:29 PM, Kenneth Johansson <kenneth@southpole.se> wrote:
> > I have  tried to speed up u-boot by turning on I/D cache during boot.
> >
> > It sort of works and gives quite a boost but I'm having problems with
> > the ethernet driver that no longer works.
> >
> > What I'm seeing is that the cpu do not notice the ethernet hardwares
> > updates that is located in DRAM. Basically what is expected from a cache
> > incoherent system.
> >
> > Now my question is should not the e300 core detect writes to the DRAM
> > and reload the cached data ??
> >
> > ---
> > To get cache working I'm turning on the MMU and program some BAT
> > registers to a 1-1 mapping where only DRAM has cache on and all other
> > memory regions like the IMMR, flash ... has cache off.
> >
> >
> >
> > -------------------------------------------------------------------------
> > Check out the new SourceForge.net Marketplace.
> > It's the best place to buy or sell services for
> > just about anything Open Source.
> > http://sourceforge.net/services/buy/index.php
> > _______________________________________________
> > U-Boot-Users mailing list
> > U-Boot-Users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/u-boot-users
> >
> 
