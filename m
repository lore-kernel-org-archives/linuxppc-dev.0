Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77EFBDDD0C
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Oct 2008 08:34:04 +1100 (EST)
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20081024.161813.193686281.davem@davemloft.net>
References: <1224863858-7933-1-git-send-email-galak@kernel.crashing.org>
	<20081024.161813.193686281.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 26 Oct 2008 08:33:09 +1100
Message-Id: <1224970389.7654.473.camel@pasglop>
Mime-Version: 1.0
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	torvalds@osdl.org, maxk@qualcomm.com, tglx@linutronix.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-24 at 16:18 -0700, David Miller wrote:
> From: Kumar Gala <galak@kernel.crashing.org>
> Date: Fri, 24 Oct 2008 10:57:38 -0500
> 
> > Commit 18404756765c713a0be4eb1082920c04822ce588 introduced a regression
> > on a subset of SMP based PPC systems whose interrupt controller only
> > allow setting an irq to a single processor.  The previous behavior
> > was only CPU0 was initially setup to get interrupts.  Revert back
> > to that behavior.
> > 
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> 
> I really don't remember getting all of my interrupts only on cpu 0
> on sparc64 before any of these changes.  I therefore find all of
> this quite mysterious. :-)

Well, I don't know how you do it but on powerpc, we explicitely fill the
affinity masks at boot time when we can spread interrupts... Maybe we
should change it the other way around and limit the mask when we can't ?
It's hard to tell for sure at this stage.

Ben.
