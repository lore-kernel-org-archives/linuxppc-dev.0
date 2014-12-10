Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BBBA1A05EE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 21:59:43 +1100 (AEDT)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 16:29:40 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0415C1258044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 16:30:00 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBAB0Bhl65994756
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 16:30:12 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBAAxYQ0009369
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 16:29:34 +0530
Date: Wed, 10 Dec 2014 16:29:00 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 3/8] perf probe: Improve detection of file/function
 name in the probe pattern
Message-ID: <20141210105900.GC16045@naverao1-tp.in.ibm.com>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <de6c0cd8236de1cabc179e456514c2a399cbc7b5.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <1418205606.9279.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418205606.9279.6.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/12/10 09:00PM, Michael Ellerman wrote:
> On Tue, 2014-12-09 at 23:04 +0530, Naveen N. Rao wrote:
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
> > 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  tools/perf/util/probe-event.c | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index c150ca4..c7e01ef 100644
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
> 
> I don't think we need to be this elaborate.
> 
> AFAIK there are no source files in the kernel that start with '.'
> 
> So if the arg starts with '.' it must be a function?

Indeed, but this is also used for parsing uprobes. So, I coded this 
based on the spec for the probe pattern.

- Naveen
