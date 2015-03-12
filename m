Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 9B1B51A0D10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 07:25:16 +1100 (AEDT)
Date: Thu, 12 Mar 2015 17:25:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [PATCHv2 2/8] perf probe: Improve detection of file/function
 name in the probe pattern
Message-ID: <20150312202511.GE3550@kernel.org>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
 <d60cf320bc3d51ca8980e48bc31044cacba8a920.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
 <20150312202414.GD3550@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150312202414.GD3550@kernel.org>
Cc: linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Thu, Mar 12, 2015 at 05:24:14PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Dec 15, 2014 at 08:20:32PM +0530, Naveen N. Rao escreveu:
> > Currently, perf probe considers patterns including a '.' to be a file.
> > However, this causes problems on powerpc ABIv1 where all functions have
> > a leading '.':
> > 
> >   $ perf probe -F | grep schedule_timeout_interruptible
> >   .schedule_timeout_interruptible
> >   $ perf probe .schedule_timeout_interruptible
> >   Semantic error :File always requires line number or lazy pattern.
> >     Error: Command Parse Error.
> > 
> > Fix this by checking the probe pattern in more detail.
> 
> Masami, can I have your Acked-by or Reviewed-by?

It is limited to powerpc, but I would even so be happy if you could look
at it,

Thanks,

- Arnaldo
 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  tools/perf/util/probe-event.c | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index 28eb141..9943ff3 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -999,6 +999,24 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
> >  		arg = tmp;
> >  	}
> >  
> > +	/*
> > +	 * Check arg is function or file name and copy it.
> > +	 *
> > +	 * We consider arg to be a file spec if and only if it satisfies
> > +	 * all of the below criteria::
> > +	 * - it does not include any of "+@%",
> > +	 * - it includes one of ":;", and
> > +	 * - it has a period '.' in the name.
> > +	 *
> > +	 * Otherwise, we consider arg to be a function specification.
> > +	 */
> > +	c = 0;
> > +	if (!strpbrk(arg, "+@%") && (ptr = strpbrk(arg, ";:")) != NULL) {
> > +		/* This is a file spec if it includes a '.' before ; or : */
> > +		if (memchr(arg, '.', ptr-arg))
> > +			c = 1;
> > +	}
> > +
> >  	ptr = strpbrk(arg, ";:+@%");
> >  	if (ptr) {
> >  		nc = *ptr;
> > @@ -1009,10 +1027,9 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
> >  	if (tmp == NULL)
> >  		return -ENOMEM;
> >  
> > -	/* Check arg is function or file and copy it */
> > -	if (strchr(tmp, '.'))	/* File */
> > +	if (c == 1)
> >  		pp->file = tmp;
> > -	else			/* Function */
> > +	else
> >  		pp->function = tmp;
> >  
> >  	/* Parse other options */
> > -- 
> > 2.1.3
