Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A1EEDB7081
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 19:40:20 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DB594DDD1B
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 19:40:19 +1000 (EST)
Subject: Re: [PATCH] powerpc: Add configurable -Werror for arch/powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1245052241.7705.78.camel@concordia>
References: <adf502e7c85161d77fdcaca24f55ba6b418c7f04.1244616523.git.michael@ellerman.id.au>
	<1245052241.7705.78.camel@concordia>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 19:40:07 +1000
Message-Id: <1245058807.12400.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Currently this appears to break only one of the defconfigs, chrp32.
> 
> http://kisskb.ellerman.id.au/kisskb/head/1907/
> 
> And that's a legitimate error AFAICT:
> 
> arch/powerpc/platforms/chrp/setup.c:378: error: the frame size of 1040 bytes is larger than 1024 bytes
> 
> From:
> 
> 367 void
> 368 chrp_event_scan(unsigned long unused)
> 369 {
> 370         unsigned char log[1024];
> 371         int ret = 0;

I wonder to what extent we could merge that with the pSeries
event-scan...

We can have a closer look tomorrow. In any case, stack alloc for that is
indeed fishy.

Cheers,
Ben.
