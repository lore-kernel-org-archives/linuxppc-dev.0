Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9E7B1A0F3A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 10:42:42 +1100 (AEDT)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 7 Jan 2015 16:42:40 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A116F19D801C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 16:31:14 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t07NgbtZ52953154
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jan 2015 16:42:37 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t07NgahS028323
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jan 2015 16:42:37 -0700
Date: Wed, 7 Jan 2015 15:41:56 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v6 2/4] tools/perf: extend format_alias() to include
 event parameters
Message-ID: <20150107234156.GA9769@us.ibm.com>
References: <1419234567-22784-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1419234567-22784-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150106093910.GA24841@krava.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150106093910.GA24841@krava.brq.redhat.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, dev@codyps.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri Olsa [jolsa@redhat.com] wrote:
| On Sun, Dec 21, 2014 at 11:49:25PM -0800, Sukadev Bhattiprolu wrote:
| > From: Cody P Schafer <cody@linux.vnet.ibm.com>
| > 
| > This causes `perf list pmu` to show parameters for parameterized events
| > like:
| > 
| >   pmu/event_name,param1=?,param2=?/ [Kernel PMU event]
| > 
| > An example:
| > 
| >   hv_24x7/HPM_TLBIE__PHYS_CORE,core=?/ [Kernel PMU event]
| > 
| > Changelog[v6]
| > 	[Jir Olsa, Sukadev Bhattiprolu] Drop the '$' sign and go back to
| > 	just printing whatevever sysfs provides (which is '=?') to identify
| > 	required parameters. sysfs also now uses parameters like 'core'
| > 	and 'vcpu' rather than 'starting_index'.
| > 
| > Changelog[v5]
| > 	[Jiri Olsa, Peter Zijlstra] Use '$' to prefix parameterized events.
| > 
| > Changelog[v4]
| > 	[Jiri Olsa] If the parameter for an event in sysfs is 'param=val',
| > 	have perf-list show the event as 'param=?' rather than 'val=?'.
| > 
| > CC: Haren Myneni <hbabu@us.ibm.com>
| > CC: Cody P Schafer <dev@codyps.com>
| > Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
| > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
| > ---
| >  tools/perf/util/pmu.c | 27 ++++++++++++++++++++++++++-
| >  1 file changed, 26 insertions(+), 1 deletion(-)
| > 
| > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
| > index cb516dd..d208fef 100644
| > --- a/tools/perf/util/pmu.c
| > +++ b/tools/perf/util/pmu.c
| > @@ -810,10 +810,35 @@ void perf_pmu__set_format(unsigned long *bits, long from, long to)
| >  		set_bit(b, bits);
| >  }
| >  
| > +static int sub_non_neg(int a, int b)
| > +{
| > +	if (b > a)
| > +		return 0;
| > +	return a - b;
| > +}
| > +
| >  static char *format_alias(char *buf, int len, struct perf_pmu *pmu,
| >  			  struct perf_pmu_alias *alias)
| >  {
| > -	snprintf(buf, len, "%s/%s/", pmu->name, alias->name);
| > +	struct parse_events_term *term;
| > +	int used = snprintf(buf, len, "%s/%s", pmu->name, alias->name);
| > +
| > +	list_for_each_entry(term, &alias->terms, list)
| > +		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
| > +			used += snprintf(buf + used, sub_non_neg(len, used),
| > +					",%s=%s", term->config,
| > +					term->val.str);
| 
| why not display PARSE_EVENTS__TERM_TYPE_NUM as well?

Well, we are only trying to list the attributes that user needs to specify:

	hv_24x7/HPM_0THRD_NON_IDLE_CCYC__PHYS_CORE,core=?/

We could print the PARSE_EVENTS__TERM_TYPE_NUM terms as well,

	hv_24x7/HPM_0THRD_NON_IDLE_CCYC__PHYS_CORE,domain=2,offset=e0,core=?,lpar=0/

but it would be needlessly verbose. The attributes with numeric values
like domain and offset, have fixed values for the event and user doesn't
need to know. If they do really need to know, they could just look up in
sysfs ?

Sukadev
