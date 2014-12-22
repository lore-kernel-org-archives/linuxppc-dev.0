Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1F2D1A0BC4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 06:31:20 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 22 Dec 2014 14:31:18 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id AD15E38C804A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 14:31:15 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBMJVFiX27001030
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 19:31:15 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBMJVECT005154
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 14:31:15 -0500
Date: Mon, 22 Dec 2014 11:30:45 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v6 1/4] tools/perf: support parsing parameterized events
Message-ID: <20141222193045.GA19784@us.ibm.com>
References: <1419234567-22784-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1419234567-22784-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <20141222143710.GA29096@krava.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141222143710.GA29096@krava.brq.redhat.com>
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
| On Sun, Dec 21, 2014 at 11:49:24PM -0800, Sukadev Bhattiprolu wrote:
| 
| SNIP
| 
| > +	}
| >  
| >  	switch (format->value) {
| >  	case PERF_PMU_FORMAT_VALUE_CONFIG:
| > @@ -592,11 +629,16 @@ static int pmu_config_term(struct list_head *formats,
| >  	}
| >  
| >  	/*
| > -	 * XXX If we ever decide to go with string values for
| > -	 * non-hardcoded terms, here's the place to translate
| > -	 * them into value.
| > +	 * Either directly use a numeric term, or try to translate string terms
| > +	 * using event parameters.
| >  	 */
| > -	pmu_format_value(format->bits, term->val.num, vp, zero);
| > +	if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
| > +		val = term->val.num;
| > +	else
| > +		if (pmu_resolve_param_term(term, head_terms, &val))
| > +			return -EINVAL;
| > +
| 
| I'm ok with the change logic, but I'm missing here check for the 'term'
| string value to be '?', so we force subst terms to have '?' as value..
| I believe thats what we decided in the previous set discussion, right?

The =? is not a user input, so I did not think of validating that.

perf tool expects kernel/sysfs to show entries like 'core=?'. Are you
saying that we should error out if kernel mistakenly displays 'core=$val'
or 'core=?val' ? 

If a required parameter is missing, we catch that in pmu_resolve_param_term().
If a bogus parameter is specified we catch that above in pmu_config_term().


| 
| I guess the it'd be nice to parse it directly in the bison code like
| below (could be done later), but I'd be ok with simple check on this
| place for now.
| 
| thanks,
| jirka
| 
| 
| ---
| diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
| index 93c4c9fbc922..7e021c64d5cc 100644
| --- a/tools/perf/util/parse-events.y
| +++ b/tools/perf/util/parse-events.y
| @@ -484,6 +484,14 @@ PE_TERM '=' PE_VALUE
|  	$$ = term;
|  }
|  |
| +PE_TERM '=' PE_SUBST
| +{
| +	struct parse_events_term *term;
| +
| +	ABORT_ON(parse_events_term__subst(&term, (int)$1, NULL, NULL));
| +	$$ = term;
| +}
| +|
|  PE_TERM
|  {
|  	struct parse_events_term *term;
