Return-Path: <kenneth@southpole.se>
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id 2856CDDE01
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 00:36:43 +1000 (EST)
Subject: Re: [PATCH] powerpc: tiny memcpy_(to|from)io optimisation
From: Kenneth Johansson <kenneth@southpole.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1243983086.27194.7.camel@pasglop>
References: <1243968361.4951.0@antares>  <1243983086.27194.7.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Wed, 03 Jun 2009 16:36:36 +0200
Message-Id: <1244039796.20864.48.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Albrecht =?ISO-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-06-03 at 08:51 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2009-06-02 at 20:45 +0200, Albrecht Dreß wrote:
> 
> > 
> > which drops the r1 accesses, but still produces the sub-optimal loop.   
> > Is this a gcc regression, or did I miss something here?  Probably the  
> > only bullet-proof way is to write some core loops in assembly... :-/
> 
> Well, gcc may be right here. What you call the "optimal" loop uses the
> lwzu instruction. An interesting thing about this instruction is that
> it updates two GPRs at completion (I'm ignoring the load multiple and
> string instructions on purpose here).

> I wouldn't be surprised thus if the loop variant with the separate add
> ends up more efficient on most implementations around.

On an e300 core using the lwzu/stwu is about 20% faster so at least one
core prefer that optimization. 
