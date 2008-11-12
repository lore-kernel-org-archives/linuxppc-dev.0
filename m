Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D3E8DDDE7
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 22:50:51 +1100 (EST)
Subject: Re: [PATCH] powerpc: Fix 460EX/460GT machine check handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20081112062737.19a01a22@zod.rchland.ibm.com>
References: <20081112020409.4FFBCDDDDB@ozlabs.org>
	<20081112062737.19a01a22@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 12 Nov 2008 22:50:44 +1100
Message-Id: <1226490644.7154.14.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-11-12 at 06:27 -0500, Josh Boyer wrote:
> On Wed, 12 Nov 2008 13:02:43 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Those cores use the 440A type machine check (ie, they have
> > MCSRR0/MCSRR1). They thus need to call the appropriate fixup
> > function to hook the right variant of the exception.
> > 
> > Without this, all machine checks become fatal due to loss
> > of context when entering the exception handler.
> 
> Looks fine to me.  However, what machine checks were you getting that
> caused you to see this that aren't fatal anyway?

PCI aborts from userspace when toying with video card POSTing &
x86emu :-)

Cheers,
Ben.
