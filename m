Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (unknown [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69A9E1A0515
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 22:19:44 +1000 (AEST)
Date: Wed, 8 Apr 2015 14:19:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/5] perf: Add a flags parameter to pmu txn interfaces
Message-ID: <20150408121923.GD23123@twins.programming.kicks-ass.net>
References: <1428453299-19121-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1428453299-19121-2-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428453299-19121-2-git-send-email-sukadev@linux.vnet.ibm.com>
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

On Tue, Apr 07, 2015 at 05:34:55PM -0700, Sukadev Bhattiprolu wrote:
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 2b62198..4dc3d70 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -240,20 +240,27 @@ struct pmu {
>  	 *
>  	 * Start the transaction, after this ->add() doesn't need to
>  	 * do schedulability tests.
> +	 *
> +	 * Optional.
>  	 */
> -	void (*start_txn)		(struct pmu *pmu); /* optional */
> +#define PERF_PMU_TXN_ADD  0x1		/* txn to add/schedule event on PMU */

Please do not interleave these flags in the structure. Maybe place it
near PERF_EVENT_TXN.

> +	void (*start_txn)		(struct pmu *pmu, int flags);
>  	/*
>  	 * If ->start_txn() disabled the ->add() schedulability test
>  	 * then ->commit_txn() is required to perform one. On success
>  	 * the transaction is closed. On error the transaction is kept
>  	 * open until ->cancel_txn() is called.
> +	 *
> +	 * Optional.
>  	 */
> -	int  (*commit_txn)		(struct pmu *pmu); /* optional */
> +	int  (*commit_txn)		(struct pmu *pmu, int flags);
>  	/*
>  	 * Will cancel the transaction, assumes ->del() is called
>  	 * for each successful ->add() during the transaction.
> +	 *
> +	 * Optional.
>  	 */
> -	void (*cancel_txn)		(struct pmu *pmu); /* optional */
> +	void (*cancel_txn)		(struct pmu *pmu, int flags);
>  
>  	/*
>  	 * Will return the value for perf_event_mmap_page::index for this event,

So (again), why also pass the flags to cancel/commit ?

The transaction state _has_ to already record it, otherwise it doesn't
know if add/read are part of one.
