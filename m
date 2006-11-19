Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7648567C1F
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 07:49:29 +1100 (EST)
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061119202348.GA27649@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
	<1163967590.5826.104.camel@localhost.localdomain>
	<20061119202348.GA27649@elte.hu>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 07:49:42 +1100
Message-Id: <1163969383.5826.123.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-11-19 at 21:23 +0100, Ingo Molnar wrote:
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > > dont worry, it's -rt only stuff.
> > 
> > Still, I'm curious :-) Besides, there have been people talking about 
> > having -rt work on ppc64 so ...
> 
> ok :)
> 
> > What do you need an ack() for on fasteoi ? On all fasteoi controllers 
> > I have, ack is implicit by obtaining the vector number and all there 
> > is is an eoi...
> 
> it's a compatibility hack only. Threaded handlers are a different type 
> of flow, but often the fasteoi handler is not changed to the threaded 
> handler so i changed it to be a threaded handler too.
> 
> threaded handlers need a mask() + an ack(), because that's the correct 
> model to map them to kernel threads - threaded handlers can be delayed 
> for a long time if something higher-prio is preempting them.

Well, the principle of controllers that do fasteoi is that all
interrupts of the same priority or below are masked until eoi happens...
so I still don't see why you need that...

Ben.
