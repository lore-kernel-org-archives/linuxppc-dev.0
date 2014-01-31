Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0C5D02C009F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Feb 2014 09:53:42 +1100 (EST)
Message-ID: <1391208815.27142.38.camel@pasglop>
Subject: Re: PCIe Access - achieve bursts without DMA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Moese, Michael" <michael.moese@men.de>
Date: Sat, 01 Feb 2014 09:53:35 +1100
In-Reply-To: <2DF74D4E746FF14C8697D5041AAE72D56A2B1420@MEN-EX2.intra.men.de>
References: <2DF74D4E746FF14C8697D5041AAE72D56A2B1420@MEN-EX2.intra.men.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-01-30 at 12:20 +0000, Moese, Michael wrote:
> Hello PPC-developers,
> I'm currently trying to benchmark access speeds to our PCIe-connected IP-cores
> located inside our FPGA. On x86-based systems I was able to achieve bursts for
> both read and write access. On PPC32, using an e500v2, I had no success at all 
> so far. 
> I tried using ioremap_wc(), like I did on x86, for writing, and it only results in my
> writes just being single requests, one after another.

Hrm, ioremap_wc will give you a mapping without the G (guard) bit.
Whether that results in some store gathering or not on IOs depends on a
specific HW implementation, you'll have to check with the FSP folks on
that one, there could also be a chicken switch (HID bit or similar)
needed to enable that (there was on some earlier ppc32 chips).

Another thing you can try is to use FP register load/stores.

> For reads, I noticed I could not ioremap_cache() on PPC, so I used simple ioremap()
> here. 
> I used several ways to read from the device, from simple readl(),memcpy_from_io(), 
> memcpy()  to cacheable_memcpy() - with no improvements.  Even when just issuing
> a batch of prefetch()-calls for all the memory to read did not result in read bursts.
> 
> I only get really poor results, writing is possible with around 40 MiByte/s, whereas I  
> can read at about only 3 MiByte/s.
> After hours of studying the reference manual from freescale, looking into other code
> and searching the web, I'm close to resignation.
> 
> Maybe someone of you has some more directions for me, I'd appreciate every hint
> that leads me to my problem's solution - maybe I just missed something or lack 
> knowledge about this architecture in general.
> 
> Thanks for your reading.
> 
> 
> Michael
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
