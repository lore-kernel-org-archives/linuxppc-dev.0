Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 919DA67B43
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Feb 2006 10:28:07 +1100 (EST)
Date: Fri, 24 Feb 2006 17:18:26 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix mem= cmdline handling on arch/powerpc for
	!MULTIPLATFORM
In-Reply-To: <200602251025.55741.michael@ellerman.id.au>
Message-ID: <Pine.LNX.4.44.0602241717340.11527-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 25 Feb 2006, Michael Ellerman wrote:

> On Sat, 25 Feb 2006 09:43, Kumar Gala wrote:
> > On Feb 24, 2006, at 4:27 PM, Michael Ellerman wrote:
> > > Hi Kumar,
> > >
> > > On Sat, 25 Feb 2006 03:54, Kumar Gala wrote:
> > >> mem= command line option was being ignored in arch/powerpc if we
> > >> were not
> > >> a CONFIG_MULTIPLATFORM (which is handled via prom_init stub). The
> > >> initial
> > >> command line extraction and parsing needed to be moved earlier in
> > >> the boot
> > >> process and have code to actual parse mem= and do something about it.
> > >>
> > >> @@ -1004,6 +991,41 @@ static int __init early_init_dt_scan_cho
> > >>                 crashk_res.end = crashk_res.start + *lprop - 1;
> > >>  #endif
> > >>
> > >> +	/* Retreive command line */
> > >> + 	p = of_get_flat_dt_prop(node, "bootargs", &l);
> > >> +	if (p != NULL && l > 0)
> > >> +		strlcpy(cmd_line, p, min((int)l, COMMAND_LINE_SIZE));
> > >> +
> > >> +#ifdef CONFIG_CMDLINE
> > >> +	if (l == 0 || (l == 1 && (*p) == 0))
> > >> +		strlcpy(cmd_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> > >> +#endif /* CONFIG_CMDLINE */
> > >> +
> > >> +	DBG("Command line is: %s\n", cmd_line);
> > >> +
> > >> +	if (strstr(cmd_line, "mem=")) {
> > >> +		char *p, *q;
> > >> +		unsigned long maxmem = 0;
> > >> +
> > >> +		for (q = cmd_line; (p = strstr(q, "mem=")) != 0; ) {
> > >> +			q = p + 4;
> > >> +			if (p > cmd_line && p[-1] != ' ')
> > >> +				continue;
> > >> +			maxmem = simple_strtoul(q, &q, 0);
> > >> +			if (*q == 'k' || *q == 'K') {
> > >> +				maxmem <<= 10;
> > >> +				++q;
> > >> +			} else if (*q == 'm' || *q == 'M') {
> > >> +				maxmem <<= 20;
> > >> +				++q;
> > >> +			} else if (*q == 'g' || *q == 'G') {
> > >> +				maxmem <<= 30;
> > >> +				++q;
> > >> +			}
> > >> +		}
> > >> +		memory_limit = maxmem;
> > >> +	}
> > >> +
> > >
> > > Why not make the mem= parsing an early_param() handler and then call
> > > parse_early_param() here?
> >
> > This would put constraints on the early_param()'s that I dont think
> > we should impose.
> 
> All they should really be doing is parsing the string and setting some 
> variables, so that seems reasonable to me. Is there anything in particular?

If you ever had to do some memory allocation as part of the parsing that 
might be an issue, since we haven't setup the LMB at that point.

- kumar
