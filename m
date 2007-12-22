Return-Path: <dgibson@ozlabs.org>
Date: Sat, 22 Dec 2007 13:43:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [DTC PATCH 1/2] Add yyerrorf() for formatted error messages.
Message-ID: <20071222024353.GB7891@localhost.localdomain>
References: <20071220164823.GA32193@ld0162-tx32.am.freescale.net>
	<20071221000439.GC2665@localhost.localdomain>
	<20071221212856.GA8208@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221212856.GA8208@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com, u-boot-users@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 21, 2007 at 03:28:56PM -0600, Scott Wood wrote:
> On Fri, Dec 21, 2007 at 11:04:39AM +1100, David Gibson wrote:
> > On Thu, Dec 20, 2007 at 10:48:23AM -0600, Scott Wood wrote:
> > > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > 
> > No need for a new function.  If yyerror() is defined as a varargs
> > function it's still compatible with bison's built-in usage.
> 
> Not if yyerror() is called with a percent symbol in the string, which
> looks possible if a percent token is added and verbose syntax errors are
> enabled.

Ah, yes, I guess so.

However from discussion on the other thread, it looks like this
extended yyerror() isn't really what you want.  Maybe instead we
should look a more general error/warning printing function, and make
yyerror() call that.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
