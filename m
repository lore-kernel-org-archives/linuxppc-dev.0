Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 283E2DDED2
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 15:08:49 +1000 (EST)
Subject: Re: [PATCH] powerpc/mm: Lockless get_user_pages_fast()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1217394382.10646.13.camel@localhost>
References: <1217389038.11188.285.camel@pasglop>
	<1217391656.11188.292.camel@pasglop>
	<1217394382.10646.13.camel@localhost>
Content-Type: text/plain
Date: Wed, 30 Jul 2008 15:08:40 +1000
Message-Id: <1217394520.11188.298.camel@pasglop>
Mime-Version: 1.0
Cc: Nick Piggin <npiggin@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-30 at 15:06 +1000, Michael Ellerman wrote:
> > +
> > +/*
> > + * The performance critical leaf functions are made noinline otherwise gcc
> > + * inlines everything into a single function which results in too much
> > + * register pressure.
> > + */
> 
> This strikes me as something that is liable to change for compiler
> version n+1, or n with -fsomething - and might leave us shooting
> ourselves in the foot, just a thought.
> 

Not that much I'd say... In fact, I wouldn't be too worried on powerpc,
I wonder if that comment is stale from the x86 variant :-) Nick ?

Cheers,
Ben.
