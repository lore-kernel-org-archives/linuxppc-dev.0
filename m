Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A802DE019
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 19:30:36 +1100 (EST)
Subject: Re: [BUG] 2.6.25-rc3-mm1 kernel panic while bootup on powerpc ()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080304103350.12d26560.akpm@linux-foundation.org>
References: <20080304011928.e8c82c0c.akpm@linux-foundation.org>
	<47CD4AB3.3080409@linux.vnet.ibm.com> <20778.1204641656@neuling.org>
	<20080304103350.12d26560.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 05 Mar 2008 19:23:40 +1100
Message-Id: <1204705420.21545.192.camel@pasglop>
Mime-Version: 1.0
Cc: Matthew Wilcox <willy@debian.org>, linuxppc-dev@ozlabs.org,
	Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-03-04 at 10:33 -0800, Andrew Morton wrote:
> > Are we somehow enabling interrupts before we've setup
> ppc_md.get_irq?
> > 
> 
> Yes, we are - it's the semaphore rewrite which is doing this in
> start_kernel().  It's being discussed.
> 
> Enabling interrupts too early on powerpc was discovered to be fatal on
> powerpc years ago.  It looks like that remains the case.

Yes, it is and will probably always be. All that semaphore mucking
around that hard-enables interrupts is just asking for trouble (and on
more than just powerpc... heh, how do you do if your main interrupt
controller hasn't even been initialized yet ?)

Ben.
