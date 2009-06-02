Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75092DDD04
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 08:51:35 +1000 (EST)
Subject: Re: [PATCH] powerpc: tiny memcpy_(to|from)io optimisation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albrecht =?ISO-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>
In-Reply-To: <1243968361.4951.0@antares>
References: <1243968361.4951.0@antares>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 03 Jun 2009 08:51:25 +1000
Message-Id: <1243983086.27194.7.camel@pasglop>
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

On Tue, 2009-06-02 at 20:45 +0200, Albrecht Dreß wrote:

> 
> which drops the r1 accesses, but still produces the sub-optimal loop.   
> Is this a gcc regression, or did I miss something here?  Probably the  
> only bullet-proof way is to write some core loops in assembly... :-/

Well, gcc may be right here. What you call the "optimal" loop uses the
lwzu instruction. An interesting thing about this instruction is that
it updates two GPRs at completion (I'm ignoring the load multiple and
string instructions on purpose here).

Now, quite a few simple implementations don't have two write ports to
the GPR file, nor the logic to handle hazards properly with two GPRs
being updated... which means the instruction is very likely to take a
very inefficient path through the pipeline. On server processors, I'm
pretty sure it's just cracked into a load and an add anyway.

I wouldn't be surprised thus if the loop variant with the separate add
ends up more efficient on most implementations around.

Of course, the loop above could use some unrolling to put some distance
between the load and the store of the loaded value.

Cheers,
Ben.
