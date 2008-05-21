Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C7D35DE11D
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 02:02:21 +1000 (EST)
Subject: Re: [patch 2/2] powerpc: optimise smp_wmb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20080521154701.GH8897@wotan.suse.de>
References: <20080521141056.GC8897@wotan.suse.de>
	<20080521141231.GD8897@wotan.suse.de>
	<1211383592.8297.195.camel@pasglop>
	<20080521153420.GG8897@wotan.suse.de>
	<1211384580.8297.199.camel@pasglop>
	<20080521154701.GH8897@wotan.suse.de>
Content-Type: text/plain
Date: Wed, 21 May 2008 12:02:15 -0400
Message-Id: <1211385735.8297.204.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-05-21 at 17:47 +0200, Nick Piggin wrote:
> 
> OK, but I just don't understand what the problem is... your synch.h
> has
> 
> #ifdef __powerpc64__
> #define __SUBARCH_HAS_LWSYNC
> #endif
> 
> #ifdef __SUBARCH_HAS_LWSYNC
> #    define LWSYNC      lwsync
> #else
> #    define LWSYNC      sync
> #endif
> 

This is mostly useless then since lwsync is just a sync to a processor
that doesn't know it (it's a sync with a reservd bit set) :-) Or it's
just to make gas happy if you specify a processor type that doesn't have
lwsync ?

Paul, do we have a case of a 32 bits CPU that chokes on the added bit ?

Ben.
