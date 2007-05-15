Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A675DDF39
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 17:34:31 +1000 (EST)
Subject: Re: [patch 4/4] powerpc 2.6.21-rt1: reduce scheduling latency by
	changing tlb flush size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
In-Reply-To: <yyir6pi67yd.wl@toshiba.co.jp>
References: <yyi3b1zapqa.wl@toshiba.co.jp>
	<1179125506.22481.297.camel@localhost.localdomain>
	<yyitzuf9857.wl@toshiba.co.jp> <200705141640.02561.arnd@arndb.de>
	<yyir6pi67yd.wl@toshiba.co.jp>
Content-Type: text/plain
Date: Tue, 15 May 2007 17:34:12 +1000
Message-Id: <1179214452.32247.170.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	mingo@elte.hu, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 13:12 +0900, Tsutomu OWA wrote:

> > With this code, you get silent side-effects of enabling PPC_CELLEB
> > along with another platform.
> 
>   Yeah, thank you for pointing it out.
>   I'll send revised patch later.
> 
> > Maybe instead you should change the hpte_need_flush() to always flush
> > when running on the celleb platform and PREEMPT_RT is enabled.
> 
>   Hmm... Is it in linux-2.6.21?  grep'ing it did not help... 
> 
>   Is http://patchwork.ozlabs.org/linuxppc/patch?id=10361 is the first place
> where the hpte_need_flush() appears?

Yes, I added that when reworking the batching mecanism.

Ben.
