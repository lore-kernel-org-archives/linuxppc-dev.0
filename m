Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 006451A0AB3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 22:25:13 +1000 (AEST)
Date: Wed, 8 Apr 2015 14:24:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/5] perf: Rename perf_event_read_value
Message-ID: <20150408122459.GE23123@twins.programming.kicks-ass.net>
References: <1428453299-19121-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1428453299-19121-4-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428453299-19121-4-git-send-email-sukadev@linux.vnet.ibm.com>
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

On Tue, Apr 07, 2015 at 05:34:57PM -0700, Sukadev Bhattiprolu wrote:
> perf_event_read_value() is mostly computing the event count and enabled/
> running times. Move the perf_event_read() into caller and rename
> perf_event_read_value() to perf_event_compute_values().
> 
> Changelog[v2]
> 	Export symbol perf_event_read() since x86/kvm needs it now.

FWIW these changed since last things go below the --- since they're
pointless for the permanent record.

> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  arch/x86/kvm/pmu.c         |    6 ++++--
>  include/linux/perf_event.h |    3 ++-
>  kernel/events/core.c       |   18 +++++++++++-------
>  3 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 8e6b7d8..5896cb1 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -144,9 +144,11 @@ static u64 read_pmc(struct kvm_pmc *pmc)
>  
>  	counter = pmc->counter;
>  
> -	if (pmc->perf_event)
> -		counter += perf_event_read_value(pmc->perf_event,
> +	if (pmc->perf_event) {
> +		perf_event_read(pmc->perf_event);
> +		counter += perf_event_compute_values(pmc->perf_event,
>  						 &enabled, &running);
> +	}

That's more than a rename, that's a functionality split just like the
previous patch.
