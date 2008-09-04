Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E215DDDFE8
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 17:40:15 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc - Make the irq reverse mapping radix tree
	lockless
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastien Dugue <sebastien.dugue@bull.net>
In-Reply-To: <20080904092252.12b3df4a@bull.net>
References: <1218029429-21114-1-git-send-email-sebastien.dugue@bull.net>
	<1218029429-21114-3-git-send-email-sebastien.dugue@bull.net>
	<1219209781.21386.25.camel@pasglop> <20080903154105.7dff49db@bull.net>
	<1220496739.4879.20.camel@pasglop> <20080904092252.12b3df4a@bull.net>
Content-Type: text/plain
Date: Thu, 04 Sep 2008 17:34:03 +1000
Message-Id: <1220513643.4879.68.camel@pasglop>
Mime-Version: 1.0
Cc: dwalker@mvista.com, tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	jean-pierre.dion@bull.net, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, michael@ellerman.id.au,
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


> > >   I could not think of anything simple so far and I'm open for suggestions.
> > 
> > GFP_KERNEL should not fail, it will just block no ?
> 
>   No it won't block and will fail (returns NULL).

hrm... it used to never fail.. that may have changed. But it will
definitely block and try very hard to push things out to make space,
which is the whole point :-)

>   I will have to add that back as there is no more fallback.

Well, the must be one in the case the tree isn't initialized yet, so if
there's an allocation failure, you may "de-initialize" it or
something... Or you can fallback if you don't find, as easy, probably
easier since it shouldn't happen in practice.

> > I don't know if it's worth trying to fire off a new
> > allocation attempt later, probably not.
> 
>   I've been pondering with this lately, but I think that adding a linear
> lookup fallback should be OK.

Yup.

Cheers,
Ben.
