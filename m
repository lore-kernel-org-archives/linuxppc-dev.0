Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6CD2BDDFE8
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 13:45:30 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc - Make the irq reverse mapping radix tree
	lockless
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastien Dugue <sebastien.dugue@bull.net>
In-Reply-To: <20080903154105.7dff49db@bull.net>
References: <1218029429-21114-1-git-send-email-sebastien.dugue@bull.net>
	<1218029429-21114-3-git-send-email-sebastien.dugue@bull.net>
	<1219209781.21386.25.camel@pasglop> <20080903154105.7dff49db@bull.net>
Content-Type: text/plain
Date: Thu, 04 Sep 2008 12:52:19 +1000
Message-Id: <1220496739.4879.20.camel@pasglop>
Mime-Version: 1.0
Cc: dwalker@mvista.com, tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	jean-pierre.dion@bull.net, michael@ellerman.id.au,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	gilles.carry@ext.bull.net, tglx@linutronix.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-09-03 at 15:41 +0200, Sebastien Dugue wrote:
> On Wed, 20 Aug 2008 15:23:01 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > BTW. It would be good to try to turn the GFP_ATOMIC into GFP_KERNEL,
> 
>   That would be nice indeed
> 
> > maybe using a semaphore instead of a lock to protect insertion vs.
> > initialisation.
> 
>   a semaphore? are you meaning a mutex? If not, I fail to understand what you're
> implying.

Right, a mutex, bad habit calling those semaphores from the old days :-)

>   Right, that's the problem with this new scheme and I'm still trying
> to find a way to handle memory allocation failures be it for GFP_ATOMIC or
> GFP_KERNEL.
> 
>   I could not think of anything simple so far and I'm open for suggestions.

GFP_KERNEL should not fail, it will just block no ? If it fails, it's
probably catastrophic enough not to care. You can always fallback to
linear lookup. I don't know if it's worth trying to fire off a new
allocation attempt later, probably not.

Ben.
