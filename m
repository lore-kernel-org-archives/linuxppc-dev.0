Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Mar 2008 11:38:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: dtc: Make some functions local to parser
Message-ID: <20080305003801.GF8399@localhost.localdomain>
References: <20080304043700.GB2757@localhost.localdomain>
	<20080304191844.GA7810@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080304191844.GA7810@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 04, 2008 at 01:18:44PM -0600, Scott Wood wrote:
> On Tue, Mar 04, 2008 at 03:37:00PM +1100, David Gibson wrote:
> > * The Bison documentation explicitly permits yyerror() to be a
> >   variadic function, so fold yyerror() and yyerrorf() into a single
> >   printf-style function.
> 
> Then the bison documentation is not consistent with the bison
> implementation when verbose error messages are enabled.  How can it possibly
> know whether to put % or %% in the string when an unexpected % is
> encountered?

Ah crap.  I'd forgotten the specific case you mentioned before.

> Reading bison internals makes my head hurt...
> 
> >   The combined function is defined and used
> >   only in the parse, so make it static.
> 
> Static-izing something that is used externally in a posted patch where
> you've provided no alternate to use is rather bad form...

IIRC, I already asked you *not* to use it externally, though.  And a
lot of these patches I've been posting lately are yak-shaving leading
up to a generally available error function.

Still, forget this patch for now.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
