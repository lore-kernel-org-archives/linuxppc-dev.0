Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 27F36DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 17:25:43 +1000 (EST)
Subject: Re: [PATCH HACK] powerpc: quick hack to get a functional eHEA with
	hardirq preemption
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastien Dugue <sebastien.dugue@bull.net>
In-Reply-To: <20080925091827.29b5087c@bull.net>
References: <200809231743.23828.ossthema@de.ibm.com>
	<20080915100406.342e027a@bull.net>
	<200809240958.m8O9wM7k010996@sullivan.realtime.net>
	<1222251467.8277.73.camel@pasglop> <20080924143552.29a14f10@bull.net>
	<1222290917.8277.83.camel@pasglop> <20080925091827.29b5087c@bull.net>
Content-Type: text/plain
Date: Thu, 25 Sep 2008 17:22:41 +1000
Message-Id: <1222327361.8277.179.camel@pasglop>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Jan-Bernd Themann <ossthema@de.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-09-25 at 09:18 +0200, Sebastien Dugue wrote:
> 
> > Ok, that's the right approach then. It should work. I don't know
> what
> > the specific problems with HEA are at this stage.
> 
>   Yep, except as it behaves in way that the current -rt fasteoi flow
> cannot handle.

We probably need to make a special xics flow handler for -rt that does
what Milton suggested, ie, bring down the CPU priority right away and
only EOI later or something like that, instead of masking/unmasking.

I don't know what are the other potential issues with the HEA though.

Ben.
