Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5DF6D67B52
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 21:45:33 +1000 (EST)
Subject: Re: G5 troubles booting powerpc-git (July 6)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060707021137.7f5dd182.akpm@osdl.org>
References: <1152197602.14547.10.camel@farscape.rchland.ibm.com>
	<1152226587.9862.19.camel@localhost.localdomain>
	<20060707012330.f1dea5ac.akpm@osdl.org>
	<1152260824.9862.57.camel@localhost.localdomain>
	<20060707015237.68c768f2.akpm@osdl.org>
	<1152262667.9862.64.camel@localhost.localdomain>
	<20060707021137.7f5dd182.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 21:45:10 +1000
Message-Id: <1152272710.9862.74.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-07-07 at 02:11 -0700, Andrew Morton wrote:
> On Fri, 07 Jul 2006 18:57:47 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > 
> > In the meantime, try on your quad using a g5_defconfig
> 
> I tried it with your recently-sent patch applied.  It still dies in
> smu_sensors_init().

Do you have lockdep ? There have been some changes to the completion
stuff, I'm wondering if the DECLARE_COMPLETION in windfarm_smu_sensors.c
need to be change to DECLARE_COMLETION_ONSTACK... (And other similars in
windfarm_*).

I haven't had a chance to test yet but I'll audit through all the
powerpc uses of DECLARE_COMPLETION since I use DECLARE_COMPLETION on
stack variables often.

Ben.
