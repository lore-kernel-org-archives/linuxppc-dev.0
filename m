Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rY50V31QzzDqr5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 19:19:38 +1000 (AEST)
Date: Mon, 20 Jun 2016 11:19:31 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Yury Norov <ynorov@caviumnetworks.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@intel.com>, Wang Nan <wangnan0@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] tools/perf: Fix the mask in regs_dump__printf and
Message-ID: <20160620091931.GD27702@krava>
References: <1466412241-27502-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466412241-27502-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 20, 2016 at 02:14:01PM +0530, Madhavan Srinivasan wrote:

SNIP

> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index e3ce2f34d3ad..76d5006ebcc3 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -412,11 +412,16 @@ static void print_sample_iregs(struct perf_sample *sample,
>  	struct regs_dump *regs = &sample->intr_regs;
>  	uint64_t mask = attr->sample_regs_intr;
>  	unsigned i = 0, r;
> +	unsigned long _mask[sizeof(mask)/sizeof(unsigned long)];
>  
>  	if (!regs)
>  		return;
>  
> -	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
> +	_mask[0] = mask & ULONG_MAX;
> +	if (sizeof(mask) > sizeof(unsigned long))
> +		_mask[1] = mask >> 32;
> +
> +	for_each_set_bit(r, _mask, sizeof(mask) * 8) {
>  		u64 val = regs->regs[i++];
>  		printf("%5s:0x%"PRIx64" ", perf_reg_name(r), val);
>  	}
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 5214974e841a..2eaa42a4832a 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -940,8 +940,13 @@ static void branch_stack__printf(struct perf_sample *sample)
>  static void regs_dump__printf(u64 mask, u64 *regs)
>  {
>  	unsigned rid, i = 0;
> +	unsigned long _mask[sizeof(mask)/sizeof(unsigned long)];
>  
> -	for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
> +	_mask[0] = mask & ULONG_MAX;
> +	if (sizeof(mask) > sizeof(unsigned long))
> +		_mask[1] = mask >> 32;
> +
> +	for_each_set_bit(rid, _mask, sizeof(mask) * 8) {
>  		u64 val = regs[i++];

could you please move the common code into the function?

thanks,
jirka
