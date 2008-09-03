Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id D5839DDE17
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Sep 2008 23:41:15 +1000 (EST)
Date: Wed, 3 Sep 2008 15:41:05 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2/2] powerpc - Make the irq reverse mapping radix tree
	lockless
Message-ID: <20080903154105.7dff49db@bull.net>
In-Reply-To: <1219209781.21386.25.camel@pasglop>
References: <1218029429-21114-1-git-send-email-sebastien.dugue@bull.net>
	<1218029429-21114-3-git-send-email-sebastien.dugue@bull.net>
	<1219209781.21386.25.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: dwalker@mvista.com, tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	jean-pierre.dion@bull.net, michael@ellerman.id.au,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	gilles.carry@ext.bull.net, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 20 Aug 2008 15:23:01 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> BTW. It would be good to try to turn the GFP_ATOMIC into GFP_KERNEL,

  That would be nice indeed

> maybe using a semaphore instead of a lock to protect insertion vs.
> initialisation.

  a semaphore? are you meaning a mutex? If not, I fail to understand what you're
implying.

> The old scheme was fine because if the atomic allocation
> failed, it could fallback to the linear search and try again on the next
> interrupt. Not anymore.

  Right, that's the problem with this new scheme and I'm still trying
to find a way to handle memory allocation failures be it for GFP_ATOMIC or
GFP_KERNEL.

  I could not think of anything simple so far and I'm open for suggestions.

  Thanks,

  Sebastien.
