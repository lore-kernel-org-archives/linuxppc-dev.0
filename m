Return-Path: <ananth@in.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 01EC81A0371
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 13:02:02 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Thu, 12 Mar 2015 22:02:00 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6B70438C8026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 22:01:57 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2D21vl428246184
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 02:01:57 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2D21tBQ011159
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 22:01:56 -0400
Date: Fri, 13 Mar 2015 07:33:19 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCHv2 2/8] perf probe: Improve detection of file/function
 name in the probe pattern
Message-ID: <20150313020319.GB14092@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
 <d60cf320bc3d51ca8980e48bc31044cacba8a920.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
 <20150312202414.GD3550@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150312202414.GD3550@kernel.org>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 12, 2015 at 05:24:14PM -0300, Arnaldo Carvalho de Melo wrote:
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

Arnaldo,

FWIW, I have reviewed this code...

Reviewed-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

> 
> 
> - Arnaldo
> 
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
