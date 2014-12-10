Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3351A1A04F2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 22:49:22 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 10 Dec 2014 17:19:19 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id BF4B8E0058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 17:19:52 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBABnqjo53412062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 17:19:53 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBABnECX021361
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 17:19:14 +0530
Date: Wed, 10 Dec 2014 17:18:44 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH 7/8] perf probe powerpc: Use DWARF info only if
 necessary
Message-ID: <20141210114844.GE16045@naverao1-tp.in.ibm.com>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <50dd0fedb50e3a56ff8f25c44098db3e2a2d6374.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
 <1418206640.9279.10.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418206640.9279.10.camel@ellerman.id.au>
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

On 2014/12/10 09:17PM, Michael Ellerman wrote:
> On Tue, 2014-12-09 at 23:04 +0530, Naveen N. Rao wrote:
> > Use symbol table lookups by default if DWARF is not necessary, since
> > powerpc ABIv2 encodes local entry points in the symbol table and the
> > function entry address in DWARF may not be appropriate for kprobes,
> > as described here:
> > https://sourceware.org/bugzilla/show_bug.cgi?id=17638
> 
> Needs a better changelog.

Ok. Will add, but to elaborate quickly: DWARF will only include the 
entire function in low_pc/entry_pc and high_pc. It can't indicate the 
local entry point. Hence, we need to use the symbol table instead of 
DWARF on ABIv2.

> 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index 174c22e..adcdbd2 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -2382,6 +2382,14 @@ static int convert_to_probe_trace_events(struct perf_probe_event *pev,
> >  		}
> >  	}
> >  
> > +#if defined(__powerpc64__) && defined(_CALL_ELF) && _CALL_ELF == 2
> > +	if (!perf_probe_event_need_dwarf(pev)) {
> > +		ret = find_probe_trace_events_from_map(pev, tevs, max_tevs, target);
> > +		if (ret > 0)
> > +			return ret;	/* Found in symbol table */
> > +	}
> > +#endif
> 
> And should be in an arch helper, not a big powerpc wart dropped in the middle
> of the generic code.

Sure - will change.

Thanks for the review!
- Naveen
