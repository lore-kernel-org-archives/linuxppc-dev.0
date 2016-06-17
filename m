Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW9XX0xgZzDqsD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 16:37:16 +1000 (AEST)
Date: Fri, 17 Jun 2016 08:37:07 +0200
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
Subject: Re: [PATCH] tools/perf: Fix the mask in regs_dump__printf
Message-ID: <20160617063707.GA31475@krava>
References: <1466140958-1928-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466140958-1928-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 17, 2016 at 10:52:38AM +0530, Madhavan Srinivasan wrote:
> When decoding the perf_regs mask in regs_dump__printf(),
> we loop through the mask using find_first_bit and find_next_bit functions.
> And mask is of type "u64". But "u64" is send as a "unsigned long *" to
> lib functions along with sizeof().
> 
> While the exisitng code works fine in most of the case, when using a
> 32bit perf on a 64bit kernel (Big Endian), we end up reading the wrong word
> in the u64 mask. Patch to fix the mask in regs_dump__printf().
> 
> Suggested-by: Yury Norov <ynorov@caviumnetworks.com>
> Cc: Yury Norov <ynorov@caviumnetworks.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Kan Liang <kan.liang@intel.com>
> Cc: Wang Nan <wangnan0@huawei.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  tools/perf/util/session.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
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

I think we should do this earlier when reading the mask,
not at the moment we just print it, like we do for other
types.. maybe we could do this as an extra bit for
perf_event__swap_ops[PERF_RECORD_SAMPLE] function

also there's print_sample_iregs in builtin-script.c that's
most likely affected as well

thanks,
jirka

> +	for_each_set_bit(rid, _mask, sizeof(mask) * 8) {
>  		u64 val = regs[i++];
>  
>  		printf(".... %-5s 0x%" PRIx64 "\n",
> -- 
> 1.9.1
> 
