Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C55C1A2FFA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 15:55:47 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sun, 26 Jul 2015 23:55:45 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 596DEC90041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 01:46:48 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6R5tgmH43188478
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 05:55:42 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6R5tfC5013828
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 01:55:42 -0400
Date: Sun, 26 Jul 2015 22:54:25 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 5/8] perf: Split perf_event_read_value()
Message-ID: <20150727055425.GB872@us.ibm.com>
References: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1436929315-28520-6-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150723074509.GD25159@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150723074509.GD25159@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra [peterz@infradead.org] wrote:
| On Tue, Jul 14, 2015 at 08:01:52PM -0700, Sukadev Bhattiprolu wrote:
| > Move the part of perf_event_read_value() that computes the event
| > counts and event times into a new function, perf_event_compute().
| > 
| > This would allow us to call perf_event_compute() independently.
| > 
| > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
| > 
| > Changelog[v3]
| > 	Rather than move perf_event_read() into callers and then
| > 	rename, just move the computations into a separate function
| > 	(redesign to address comment from Peter Zijlstra).
| > ---
| >  kernel/events/core.c |   37 ++++++++++++++++++++++++-------------
| >  1 file changed, 24 insertions(+), 13 deletions(-)
| > 
| > diff --git a/kernel/events/core.c b/kernel/events/core.c
| > index 44fb89d..b1e9a42 100644
| > --- a/kernel/events/core.c
| > +++ b/kernel/events/core.c
| > @@ -3704,6 +3704,29 @@ static int perf_release(struct inode *inode, struct file *file)
| >  	return 0;
| >  }
| >  
| > +static u64 perf_event_compute(struct perf_event *event, u64 *enabled,
| > +			      u64 *running)
| > +{
| > +	struct perf_event *child;
| > +	u64 total;
| > +
| > +	total = perf_event_count(event);
| > +
| > +	*enabled += event->total_time_enabled +
| > +			atomic64_read(&event->child_total_time_enabled);
| > +	*running += event->total_time_running +
| > +			atomic64_read(&event->child_total_time_running);
| > +
| > +	list_for_each_entry(child, &event->child_list, child_list) {
| > +		perf_event_read(child);
| 
| Sure we don't want that..

So if say x86 calls perf_event_read_value() the current upstream code
makes the perf_event_read(child).

If we remove this, then it would be a change in behavior?

I have commented it out and have TODO in the latest patchset. Pls
review and let me know if we should drop this read (and the TODO)
of the child event.

Sukadev
