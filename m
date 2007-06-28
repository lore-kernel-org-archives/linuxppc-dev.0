Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A51B0DDF1F
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 19:13:55 +1000 (EST)
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <ce09df5afe642e8f6e9a576306cc1e41@kernel.crashing.org>
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>
	<467176EB.7060404@ru.mvista.com>
	<6c416bf9f79a648fc82f64619aca86de@kernel.crashing.org>
	<20070615212016.GB18055@mag.az.mvista.com>
	<1182429443.24740.8.camel@localhost.localdomain>
	<467BE91F.1030003@ru.mvista.com>
	<3372b921591ca9731d2703f04e6c35f1@kernel.crashing.org>
	<467FCC9D.6010904@ru.mvista.com>
	<ce09df5afe642e8f6e9a576306cc1e41@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 28 Jun 2007 19:13:46 +1000
Message-Id: <1183022026.5521.269.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > The erratum says nothing about any HW bugs with L3 cache flush. I just 
> > mentioned that the L3 cache flush operation described in MPC7450 
> > Reference manual is similar to the L2 using the L3 cache hardware 
> > flushing mechanism. For instance, it requires a complete L3 locking 
> > before flushing.
> 
> Then I think we should use that mechanism in the Linux kernel.
> Anything else is waiting for bugs to bite.

I just figured out ... we actually already have all of that cache flush
code :-) I wrote most of it in fact. It's just that for some (bad)
reasons, it's somewhat hidden in arch/powerpc/platforms/powermac/cache.S

So I think best would be to take it from there and make it more
generic ...

Cheers,
Ben.
