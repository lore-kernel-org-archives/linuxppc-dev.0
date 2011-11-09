Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B72F51007DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 04:15:55 +1100 (EST)
Received: from mail109-ch1 (localhost.localdomain [127.0.0.1])	by
 mail109-ch1-R.bigfish.com (Postfix) with ESMTP id D245A28007A	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 17:15:38 +0000 (UTC)
Received: from CH1EHSMHS025.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.251])	by mail109-ch1.bigfish.com (Postfix) with ESMTP id
 1EFBE9E0052	for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 17:15:25
 +0000 (UTC)
Date: Wed, 9 Nov 2011 11:15:33 -0600
From: Scott Wood <scottwood@freescale.com>
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH 5/7] fsl_pmc: update device bindings
Message-ID: <20111109171533.GA7982@schlenkerla.am.freescale.net>
References: <1320410207-14537-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB4456F.9020005@freescale.com>
 <3F607A5180246847A760FD34122A1E052BC964@039-SN1MPN1-004.039d.mgd.msft.net>
 <4EB9939E.8070800@freescale.com>
 <3F607A5180246847A760FD34122A1E052BD6F1@039-SN1MPN1-004.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <3F607A5180246847A760FD34122A1E052BD6F1@039-SN1MPN1-004.039d.mgd.msft.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 09, 2011 at 04:59:16AM -0600, Li Yang-R58472 wrote:
> >>> Do we have any chips that have ethernet controller support for wake
> >>> on user-defined packet, but a sleep mode that doesn't let it be used?
> >>
> >> I think it is more a PMC feature cause Ethernet controller on many
> >> SoCs have the filer feature, but only very limited SoCs can support
> >> using it as a wake-up source.  The differences should be mostly in the
> >> PM controller block.
> >
> >Have you tried waking from sleep with it on those other SoCs?
> 
> We have tried and it's not working.

OK.

> AFAIKT, the purpose of defining the clock binding is used to describe
> the topology of clocks in a system.  And then used for runtime control
> of enabling/disabling clocks or getting/changing clock frequencies.
>
> But in this PM case, we just set the wakeup capability 

Where "wakeup capability" means deciding whether to turn off the clock
during a low-power state.  The basic information you need from the device
tree is the same -- a connection from here to there.

> and provide little runtime control of the clocks for on-chip devices.

My original intent for the binding you replaced was that it could be used
for other clock management as well -- you could use it to describe
DEVDISR or 83xx SCCR mappings as well.  It was when I sent that binding
out that I recall being asked to use the clock binding.

That said, Grant has recently said he's unhappy with the current state of
the clock binding, so I'm not sure what the right thing to do here is.

>  And it doesn't get any benefit of using this binding.  If your concern
> is the confusion with the already existing clock binding, we can remove
> the clk in the name of the PM binding.

My concern, besides unnecessary duplication of ways to express something,
is a loss of generality.

> If we are to use the clock binding, I think adding the CSB clock, DDR
> clock, core clock, and etc with this binding is more appropriate.

That would be another use of it, but one doesn't need to imply the other.

-Scott
