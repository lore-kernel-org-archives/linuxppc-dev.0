Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 898891A0A50
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 20:55:40 +1100 (AEDT)
Date: Tue, 23 Dec 2014 10:55:06 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 1/4] tools/perf: support parsing parameterized events
Message-ID: <20141223095506.GB22265@krava.brq.redhat.com>
References: <1419234567-22784-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1419234567-22784-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <20141222143710.GA29096@krava.brq.redhat.com>
 <20141222193045.GA19784@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141222193045.GA19784@us.ibm.com>
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

On Mon, Dec 22, 2014 at 11:30:45AM -0800, Sukadev Bhattiprolu wrote:
> Jiri Olsa [jolsa@redhat.com] wrote:
> | On Sun, Dec 21, 2014 at 11:49:24PM -0800, Sukadev Bhattiprolu wrote:
> | 
> | SNIP
> | 
> | > +	}
> | >  
> | >  	switch (format->value) {
> | >  	case PERF_PMU_FORMAT_VALUE_CONFIG:
> | > @@ -592,11 +629,16 @@ static int pmu_config_term(struct list_head *formats,
> | >  	}
> | >  
> | >  	/*
> | > -	 * XXX If we ever decide to go with string values for
> | > -	 * non-hardcoded terms, here's the place to translate
> | > -	 * them into value.
> | > +	 * Either directly use a numeric term, or try to translate string terms
> | > +	 * using event parameters.
> | >  	 */
> | > -	pmu_format_value(format->bits, term->val.num, vp, zero);
> | > +	if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
> | > +		val = term->val.num;
> | > +	else
> | > +		if (pmu_resolve_param_term(term, head_terms, &val))
> | > +			return -EINVAL;
> | > +
> | 
> | I'm ok with the change logic, but I'm missing here check for the 'term'
> | string value to be '?', so we force subst terms to have '?' as value..
> | I believe thats what we decided in the previous set discussion, right?
> 
> The =? is not a user input, so I did not think of validating that.
> 
> perf tool expects kernel/sysfs to show entries like 'core=?'. Are you
> saying that we should error out if kernel mistakenly displays 'core=$val'
> or 'core=?val' ? 

I think the we should at least try to have interface unambiguous
from the beginning

> If a required parameter is missing, we catch that in pmu_resolve_param_term().
> If a bogus parameter is specified we catch that above in pmu_config_term().

but the value of that param is unspecified, and if we later want to
add another type of string values we would be screwed.. as I described
in the previous reply for your other patch.

jirka
