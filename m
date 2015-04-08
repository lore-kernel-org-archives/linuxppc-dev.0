Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C0D51A0048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 03:27:42 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 16 Apr 2015 11:27:39 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D27E71FF002C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 11:18:47 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3GHRaGk39846134
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 10:27:36 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3GHRZZh020173
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 11:27:36 -0600
Date: Wed, 8 Apr 2015 08:40:54 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/5] perf: Add a flags parameter to pmu txn interfaces
Message-ID: <20150408154054.GA3525@us.ibm.com>
References: <1428453299-19121-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1428453299-19121-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150408121923.GD23123@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150408121923.GD23123@twins.programming.kicks-ass.net>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 mingo@redhat.com, Paul Mackerras <paulus@samba.org>, dev@codyps.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra [peterz@infradead.org] wrote:
| On Tue, Apr 07, 2015 at 05:34:55PM -0700, Sukadev Bhattiprolu wrote:
| > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
| > index 2b62198..4dc3d70 100644
| > --- a/include/linux/perf_event.h
| > +++ b/include/linux/perf_event.h
| > @@ -240,20 +240,27 @@ struct pmu {
| >  	 *
| >  	 * Start the transaction, after this ->add() doesn't need to
| >  	 * do schedulability tests.
| > +	 *
| > +	 * Optional.
| >  	 */
| > -	void (*start_txn)		(struct pmu *pmu); /* optional */
| > +#define PERF_PMU_TXN_ADD  0x1		/* txn to add/schedule event on PMU */
| 
| Please do not interleave these flags in the structure. Maybe place it
| near PERF_EVENT_TXN.

Ok.

| 
| > +	void (*start_txn)		(struct pmu *pmu, int flags);
| >  	/*
| >  	 * If ->start_txn() disabled the ->add() schedulability test
| >  	 * then ->commit_txn() is required to perform one. On success
| >  	 * the transaction is closed. On error the transaction is kept
| >  	 * open until ->cancel_txn() is called.
| > +	 *
| > +	 * Optional.
| >  	 */
| > -	int  (*commit_txn)		(struct pmu *pmu); /* optional */
| > +	int  (*commit_txn)		(struct pmu *pmu, int flags);
| >  	/*
| >  	 * Will cancel the transaction, assumes ->del() is called
| >  	 * for each successful ->add() during the transaction.
| > +	 *
| > +	 * Optional.
| >  	 */
| > -	void (*cancel_txn)		(struct pmu *pmu); /* optional */
| > +	void (*cancel_txn)		(struct pmu *pmu, int flags);
| >  
| >  	/*
| >  	 * Will return the value for perf_event_mmap_page::index for this event,
| 
| So (again), why also pass the flags to cancel/commit ?
| 
| The transaction state _has_ to already record it, otherwise it doesn't
| know if add/read are part of one.

I had replied to your earlier mail and added a Note to this patch
description. I was hesitating making more intrusive changes to PMUs
that don't care about the new txn type.

But, I agree, it is better to go ahead and update all PMUs to save
the state and check. Will do that in the next version.

Sukadev
