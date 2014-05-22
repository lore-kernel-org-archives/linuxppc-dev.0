Return-Path: <jolsa@redhat.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE0731A0593
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 20:04:17 +1000 (EST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 431B1140083
 for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2014 20:04:17 +1000 (EST)
Date: Thu, 22 May 2014 12:04:04 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] powerpc/perf: Adjust callchain based on DWARF debug
Message-ID: <20140522100404.GB4789@krava.brq.redhat.com>
References: <20140521012644.GA2890@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140521012644.GA2890@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 michael@ellerman.id.au, Ulrich.Weigand@de.ibm.com,
 Maynard Johnson <mpjohn@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 20, 2014 at 06:26:44PM -0700, Sukadev Bhattiprolu wrote:

SNIP

> + * TODO:
> + *	Rather than returning an index into the callchain and have the
> + *	caller skip that entry, we could modify the callchain in-place
> + *	by putting a PERF_CONTEXT_IGNORE marker in the affected entry.
> + *
> + *	But @chain points to read-only mmap, so the caller needs to
> + *	duplicate the callchain to modify in-place - something like:
> + *
> + *		new_callchain = arch_duplicate_callchain();
> + *		arch_adjust_callchain(new_callchain);
> + *		...
> + *		arch_free_callchain(new_callchain);
> + *
> + *	Since we only expect to adjust <= 1 entry for now, just return
> + *	the index.
> + */
> +int arch_adjust_callchain(struct machine *machine, struct thread *thread,
> +				struct ip_callchain *chain)
> +{

so in case we dont do the real adjusting of the callchain (see the other email)
and just returning the index, I think we should rename this accordingly,
so it's not confusing.. arch_callchain_skip_idx ? ;-)

SNIP

> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -165,4 +165,16 @@ int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *samp
>  
>  extern const char record_callchain_help[];
>  int parse_callchain_report_opt(const char *arg);
> +
> +#ifdef HAVE_ADJUST_CALLCHAIN
> +extern int arch_adjust_callchain(struct machine *machine,
> +			struct thread *thread, struct ip_callchain *chain);
> +#else
> +static inline int arch_adjust_callchain(struct machine *machine,
> +			struct thread *thread, struct ip_callchain *chain)

this needs 'maybe_unused' attribute at each parameter, otherwise
it won't compile for arch != ppc 

thanks,
jirka
