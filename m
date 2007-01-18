Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC0B1DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 11:22:22 +1100 (EST)
Subject: Re: [PATCH 8/19] powerpc: supporting interrupts for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200701120101.l0C11V4J026479@toshiba.co.jp>
References: <200701120101.l0C11V4J026479@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 11:22:39 +1100
Message-Id: <1169079759.4965.7.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-01-12 at 10:01 +0900, Ishizaki Kou wrote:
> This patch creates Celleb platform dependent files to support interrupts.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> ---

There might be ways to make this code simpler and possibily even remove
the spinlock, I have to think about it a bit more and maybe test when/if
we get some hardware here.

One thing is, since you need to mask interrupts while handling them,
you might as well use something like the level handler instead of
fasteoi (unless interrupts behave as edge on your HV in which case the
edge handle woudl do the job though it won't mask the same way).

Then you might also be able to use atomic operations rather than
spinlocks for the updates of the various masks.

There is nothing urgent about those change though, that I would consider
more as optimisations, and I need to better understand what your
hypervisor exactly does to be sure about it, so in the meantime,

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
