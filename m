Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0106.outbound.protection.outlook.com [207.46.100.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C3A41A0035
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 07:08:31 +1000 (AEST)
Message-ID: <1439845694.15601.51.camel@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/e6500: hw tablewalk: optimize a bit for tcd
 lock acquiring codes
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 17 Aug 2015 16:08:14 -0500
In-Reply-To: <20150817111655.GA26870@pek-khao-d1.corp.ad.wrs.com>
References: <1439466697-18989-1-git-send-email-haokexin@gmail.com>
 <1439466697-18989-2-git-send-email-haokexin@gmail.com>
 <1439491483.4099.101.camel@freescale.com>
 <20150814071309.GH30310@pek-khao-d1.corp.ad.wrs.com>
 <1439606668.15601.15.camel@freescale.com>
 <20150817111655.GA26870@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-08-17 at 19:16 +0800, Kevin Hao wrote:
> On Fri, Aug 14, 2015 at 09:44:28PM -0500, Scott Wood wrote:
> > I tried a couple different benchmarks and didn't find a significant 
> > difference, relative to the variability of the results running on the 
> > same 
> > kernel.  A patch that claims to "optimize a bit" as its main purpose 
> > ought to 
> > show some results. :-)
> 
> I tried to compare the execution time of these two code sequences with the
> following test module:
> 
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/printk.h>
> 
> static void test1(void)
> {
>       int i;
>       unsigned char lock, c;
>       unsigned short cpu, s;
> 
>       for (i = 0; i < 100000; i++) {
>               lock = 0;
>               cpu = 1;
> 
>               asm volatile (  
> "1:           lbarx   %0,0,%2\n\
>               lhz     %1,0(%3)\n\
>               cmpdi   %0,0\n\
>               cmpdi   cr1,%1,1\n\

This should be either "cmpdi cr1,%0,1" or crclr, not that it made much 
difference.  The test seemed to be rather sensitive to additional 
instructions inserted at the beginning of the asm statement (especially 
isync), so the initial instructions before the loop are probably pairing with 
something outside the asm.

That said, it looks like this patch at least doesn't make things worse, and 
does convert cmpdi to a more readable crclr, so I guess I'll apply it even 
though it doesn't show any measurable benefit when testing entire TLB misses 
(much less actual applications).

I suspect the point where I misunderstood the core manual was where it listed 
lbarx as having a repeat-rate of 3 cycles.  I probably assumed that that was 
because of the presync, and thus a subsequent unrelated load could execute 
partially in parallel, but it looks like the repeat rate is specifically 
talking about how long it is until the execution unit can accept any other 
instruction.

-Scott
