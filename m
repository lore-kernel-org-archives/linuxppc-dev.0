Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0E1DDDE04
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 14:42:57 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] Fix thinko in cpu_thread_mask_to_cores()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20080222032708.689FFDDE08@ozlabs.org>
References: <20080222032708.689FFDDE08@ozlabs.org>
Content-Type: text/plain
Date: Fri, 22 Feb 2008 14:42:36 +1100
Message-Id: <1203651756.10422.248.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-02-22 at 14:26 +1100, Benjamin Herrenschmidt wrote:
> The function cpu_thread_mask_to_cores() which returns a cpumask
> of one and only one thread enabled for a given core has a bug
> as it's shifting things in the wrong direction.
> 
> Note: The implementation is still sub-optimal in the sense that
> for a given core, the thread set in the result may not be any of
> the threads set in the input, which can lead to more IPIs then
> strictly necessary, but it isn't incorrect per-se. I'll improve
> that later.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

Note that this function is, afaik, not used by anything in-tree at the 
moment, so the bug isn't hurting anybody, but I'd rather have it
fixed anyway.

Ben.
