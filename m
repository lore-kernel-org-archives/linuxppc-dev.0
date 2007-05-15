Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 940C2DDED5
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 17:23:56 +1000 (EST)
Subject: Re: [patch 4/4] powerpc 2.6.21-rt1: reduce scheduling latency by
	changing tlb flush size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200705141640.02561.arnd@arndb.de>
References: <yyi3b1zapqa.wl@toshiba.co.jp>
	<1179125506.22481.297.camel@localhost.localdomain>
	<yyitzuf9857.wl@toshiba.co.jp>  <200705141640.02561.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 15 May 2007 17:23:09 +1000
Message-Id: <1179213789.32247.166.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	mingo@elte.hu, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-14 at 16:40 +0200, Arnd Bergmann wrote:
> On Monday 14 May 2007, Tsutomu OWA wrote:
> > --- linux-2.6.21-rt1/include/asm-powerpc/tlbflush.h     2007-04-26 12:08:32.000000000 +0900
> > +++ rt/include/asm-powerpc/tlbflush.h   2007-05-14 16:12:47.000000000 +0900
> > @@ -25,7 +25,12 @@ struct mm_struct;
> >  #include <linux/percpu.h>
> >  #include <asm/page.h>
> >  
> > +#if defined(CONFIG_PPC_CELLEB) && defined(CONFIG_PREEMPT_RT)
> > +/* Since tlb flush takes long time on Celleb, reduce it to 1 when Celleb && RT */
> > +#define PPC64_TLB_BATCH_NR 1
> > +#else
> >  #define PPC64_TLB_BATCH_NR 192
> > +#endif /* defined(CONFIG_PPC_CELLEB) && defined(CONFIG_PREEMPT_RT) */
> 
> With this code, you get silent side-effects of enabling PPC_CELLEB
> along with another platform.
> 
> Maybe instead you should change the hpte_need_flush() to always flush
> when running on the celleb platform and PREEMPT_RT is enabled.

I think it's wrong either way.... Maybe we can make it a variable and
measure how much we can reasonably do in a given time frame at
boot ? :-) Since it depends wether there's an hypervisor etc...

Ben.
