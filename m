Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0108.outbound.protection.outlook.com [207.46.100.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 743E61A08F0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 13:28:52 +1100 (AEDT)
Message-ID: <1422325718.10544.31.camel@freescale.com>
Subject: Re: How long am I allowed to disable preemption? (was How to make
 use of SPE instructions?)
From: Scott Wood <scottwood@freescale.com>
To: Markus Stockhausen <stockhausen@collogia.de>
Date: Mon, 26 Jan 2015 20:28:38 -0600
In-Reply-To: <12EF8D94C6F8734FB2FF37B9FBEDD1735F913EE6@EXCHANGE.collogia.de>
References: <12EF8D94C6F8734FB2FF37B9FBEDD1735F913EE6@EXCHANGE.collogia.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-01-20 at 14:53 +0000, Markus Stockhausen wrote:
> > Von: Scott Wood [scottwood@freescale.com]
> > Gesendet: Dienstag, 20. Januar 2015 08:38
> > An: Markus Stockhausen
> > Cc: Michael Ellerman; linuxppc-dev@lists.ozlabs.org
> > Betreff: Re: AW: How to make use of SPE instructions?
> > ...
> > > I did some tests with the tcrypt module and I get a hashing speed of
> > > ~ 46MByte/s for 2K data chunks. Stock module gives 29MByte/s. In
> > > other words ~22,000 hashes per second. Overhead of the tcrypt data
> > > feeder of around 10% included. That are worst case 46us per hash and
> > > therefore 46us inside a non preemptive task.
> > ...
> > It's OK if the worst case is really 46 us, but if you can find a way to
> > break it up a bit without affecting throughput too much, I'd do so.
> 
> Hi Scott (and all),
> 
> with your answer I'm a bit confused about disabling preemption inside the 
> kernel right now. I understand that the interval between preempt_disable()
> and preempt_enable() should not take too long. But when I look at other
> kernel hash crypto modules I see that nobody really cares about that.

"Some people don't care about that" doesn't imply "nobody cares about
that".

>  Take sha256_ssse3_update() in sha256_ssse3_glue.c for example. It runs
> 
>   kernel_fpu_begin();
>   res = __sha256_ssse3_update(desc, data, len, partial);
>   kernel_fpu_end();
> 
> The kernel_fpu_xxx() enables/disables preemption like I need to do. 
>
> Nevertheless parameter len can be any number of bytes. Just take 
> reasonable parameters of 256K of input data, a 3GHz core and 13 
> cycles/byte of SHA256 throughput. That will be a 1ms timeframe.

That's bad.  Don't create more bad stuff. :-)

> Can I rely on that implementation, or do I have to take special care 
> because I'm only programming for a single core CPU? 

Not sure what you mean here.

> With your advice I would place a enable/disable preemption call after 
> 1K of processed data. But wil that be sufficient if I only reeanble it
> for a short timeframe like this:
> 
>   do {
>     disable_preemption()
>     ... calc hashes for 1K of data with 16.000 CPU cycles (or 20us) ...
>     enable_preemption()
>   while (dataleft>0);

Yes, it's sufficient.  When you enable preemption it will check to see
whether there is a pending reschedule.

-Scott
