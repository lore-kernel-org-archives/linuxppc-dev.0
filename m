Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0104.outbound.protection.outlook.com [157.56.110.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F2431A0739
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 15:21:35 +1100 (AEDT)
Message-ID: <1422418883.10544.73.camel@freescale.com>
Subject: Re: SPE & Interrupt context (was how to make use of SPE instructions)
From: Scott Wood <scottwood@freescale.com>
To: Markus Stockhausen <stockhausen@collogia.de>
Date: Tue, 27 Jan 2015 22:21:23 -0600
In-Reply-To: <12EF8D94C6F8734FB2FF37B9FBEDD1735F915B69@EXCHANGE.collogia.de>
References: <12EF8D94C6F8734FB2FF37B9FBEDD1735F915B69@EXCHANGE.collogia.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-01-27 at 05:09 +0000, Markus Stockhausen wrote:
> On Tue, 2015-01-20 at 14:53 +0000, Markus Stockhausen wrote:
> > > Von: Scott Wood [scottwood@freescale.com]
> > > Gesendet: Dienstag, 20. Januar 2015 08:38
> > > An: Markus Stockhausen
> > > Cc: Michael Ellerman; linuxppc-dev@lists.ozlabs.org
> > > Betreff: Re: AW: How to make use of SPE instructions?
> > > ...
> > > With your advice I would place a enable/disable preemption call after
> > > 1K of processed data. But wil that be sufficient if I only reeanble it
> > > for a short timeframe like this:
> > >
> > >   do {
> > >     disable_preemption()
> > >     ... calc hashes for 1K of data with 16.000 CPU cycles (or 20us) ...
> > >     enable_preemption()
> > >   while (dataleft>0);
> > 
> > Yes, it's sufficient.  When you enable preemption it will check to see
> > whether there is a pending reschedule.
> > 
> 
> Hi Scott,
> 
> thanks for your helpful feedback. As you might have seen I sent a first
> patch for the sha256 kernel module that takes care about preemption.
> 
> Herbert Xu noticed that my module won't run in for IPsec as all
> work will be done from interrupt context. Do you have a tip how I can
> mitigate the check I implemented:
> 
> static bool spe_usable(void)
> {
>   return !in_interrupt();
> }
> 
> Intel guys have something like that
> 
> bool irq_fpu_usable(void)
> {
>   return !in_interrupt() ||
>     interrupted_user_mode() ||
>     interrupted_kernel_fpu_idle();
> }
> 
> But I have no idea how to transfer it to the PPC/SPE case.

I'm not sure what sort of tip you're looking for, other than
implementing it myself. :-)

-Scott
