Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28D381A0758
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 15:05:58 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 27 Apr 2015 10:35:56 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5CE33E0044
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 10:38:37 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3R55lXi58458326
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 10:35:47 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3R4ciIG009563
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 10:08:46 +0530
Date: Mon, 27 Apr 2015 10:35:17 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [PATCHv2 2/8] perf probe: Improve detection of file/function
 name in the probe pattern
Message-ID: <20150427050517.GA6113@naverao1-tp.in.ibm.com>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
 <d60cf320bc3d51ca8980e48bc31044cacba8a920.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
 <20150312202414.GD3550@kernel.org> <5502C7EF.8080007@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5502C7EF.8080007@hitachi.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/03/13 08:20PM, Masami Hiramatsu wrote:
> (2015/03/13 5:24), Arnaldo Carvalho de Melo wrote:
> > Em Mon, Dec 15, 2014 at 08:20:32PM +0530, Naveen N. Rao escreveu:
> >> Currently, perf probe considers patterns including a '.' to be a file.
> >> However, this causes problems on powerpc ABIv1 where all functions have
> >> a leading '.':
> >>
> >>   $ perf probe -F | grep schedule_timeout_interruptible
> >>   .schedule_timeout_interruptible
> >>   $ perf probe .schedule_timeout_interruptible
> >>   Semantic error :File always requires line number or lazy pattern.
> >>     Error: Command Parse Error.
> >>
> >> Fix this by checking the probe pattern in more detail.
> > 
> > Masami, can I have your Acked-by or Reviewed-by?
> 
> As far as I can see, this is not enough for fixing that issue.
> Could you fold the first half of [4/8] to this patch?

Sure.

> I also have some comments on it. See below.
> 
> >  
> >> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> >> ---
> >>  tools/perf/util/probe-event.c | 23 ++++++++++++++++++++---
> >>  1 file changed, 20 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> >> index 28eb141..9943ff3 100644
> >> --- a/tools/perf/util/probe-event.c
> >> +++ b/tools/perf/util/probe-event.c
> >> @@ -999,6 +999,24 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
> >>  		arg = tmp;
> >>  	}
> >>  
> >> +	/*
> >> +	 * Check arg is function or file name and copy it.
> >> +	 *
> >> +	 * We consider arg to be a file spec if and only if it satisfies
> >> +	 * all of the below criteria::
> >> +	 * - it does not include any of "+@%",
> >> +	 * - it includes one of ":;", and
> >> +	 * - it has a period '.' in the name.
> >> +	 *
> >> +	 * Otherwise, we consider arg to be a function specification.
> >> +	 */
> >> +	c = 0;
> 
> Oh please, don't reuse 'char c' for a boolean flag, you should
> introduce new 'bool file_loc' etc.
> 
> >> +	if (!strpbrk(arg, "+@%") && (ptr = strpbrk(arg, ";:")) != NULL) {
> >> +		/* This is a file spec if it includes a '.' before ; or : */
> >> +		if (memchr(arg, '.', ptr-arg))
>                                         ^^ add spaces around '-'.

Sure.

- Naveen
 
