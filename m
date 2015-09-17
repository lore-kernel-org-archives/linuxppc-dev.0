Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0062.hostedemail.com
 [216.40.44.62])
 by lists.ozlabs.org (Postfix) with ESMTP id C160D1A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 23:37:36 +1000 (AEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 6FDA711A329
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2015 13:29:39 +0000 (UTC)
Date: Thu, 17 Sep 2015 09:29:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Scott Wood <scottwood@freescale.com>, Christophe Leroy
 <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [BUG] Revert 0b05e2d671c4 'powerpc/32: cacheable_memcpy becomes
 memcpy'
Message-ID: <20150917092931.56475b7d@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.11.1509170911120.3951@nanos>
References: <alpine.DEB.2.11.1509161816310.3951@nanos>
 <1442420984.2909.179.camel@freescale.com>
 <alpine.DEB.2.11.1509162159110.3951@nanos>
 <20150916215435.48bee4d3@grimm.local.home>
 <alpine.DEB.2.11.1509170911120.3951@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 17 Sep 2015 12:13:15 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> Digging deeper. My assumption that it's a post powerpc merge failure
> turned out to be wrong.

Does 4.2 have the problem?

> 
> Some more data points. I see the above splat with
> 
> CONFIG_FUNCTION_TRACER=y
> CONFIG_FUNCTION_GRAPH_TRACER=y
> 
> It goes away with 
> 
> CONFIG_FUNCTION_TRACER=y
> CONFIG_FUNCTION_GRAPH_TRACER=n

Strange, because function graph tracer should have no effect on the
conversions of mcount calls into nops.


> 
> But the box still does not get to the login prompt.
> 
> CONFIG_FUNCTION_TRACER=n
> 
> makes it work again.
> 
> It's not observable before the ppc merge, but I can't identify the
> culprit by bisection. bisection led into lala land.
> 

If it's a corruption of the mcount tables, it could be specific on what
the compiler does. That is, the working of one kernel to the other, may
only depend on how gcc compiled something. Have you tried different
compilers? Maybe one version of gcc may work over another?

This may explain why turning off function graph made the splat go away.
It changes the way the compiler built the code.

-- Steve
