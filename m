Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sptpF41TpzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 22:28:52 +1100 (AEDT)
Date: Wed, 5 Oct 2016 08:28:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, kim.phillips@arm.com,
 linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 treeze.taeung@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 markus@trippelsdorf.de, namhyung@kernel.org, pawel.moll@arm.com,
 chris.ryder@arm.com, jolsa@kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH v7 4/6] perf annotate: Support jump instruction with
 target as second operand
Message-ID: <20161005112823.GT7143@kernel.org>
References: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1474472876-2706-5-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474472876-2706-5-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Sep 21, 2016 at 09:17:54PM +0530, Ravi Bangoria escreveu:
> Current perf is not able to parse jump instruction when second operand
> contains target address. Arch like powerpc has such instructions. For
> example, 'bne  cr7,0xc0000000000f6154'.
> 
> objdump o/p:
>   c0000000000f6140:   ld     r9,1032(r31)
>   c0000000000f6144:   cmpdi  cr7,r9,0
>   c0000000000f6148:   bne    cr7,0xc0000000000f6154
>   c0000000000f614c:   ld     r9,2312(r30)
>   c0000000000f6150:   std    r9,1032(r31)
>   c0000000000f6154:   ld     r9,88(r31)

So the above is what is parsed to generate the following? Or these
aren't related?
 
> Before patch:
>          ld     r9,1032(r31)
>          cmpdi  cr7,r9,0
>       v  bne    3ffffffffff09f2c
>          ld     r9,2312(r30)
>          std    r9,1032(r31)
>   74:    ld     r9,88(r31)
> 
> After patch:
>          ld     r9,1032(r31)
>          cmpdi  cr7,r9,0
>       v  bne    74
>          ld     r9,2312(r30)
>          std    r9,1032(r31)
>   74:    ld     r9,88(r31)
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
> Changes in v7:
>   - Added example in description
> 
>  tools/perf/util/annotate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 1ccf26a..a9dbac1 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -122,8 +122,12 @@ bool ins__is_call(const struct ins *ins)
>  static int jump__parse(struct ins_operands *ops, struct map *map __maybe_unused)
>  {
>  	const char *s = strchr(ops->raw, '+');
> +	const char *c = strchr(ops->raw, ',');
>  
> -	ops->target.addr = strtoull(ops->raw, NULL, 16);
> +	if (c++ != NULL)
> +		ops->target.addr = strtoull(c, NULL, 16);
> +	else
> +		ops->target.addr = strtoull(ops->raw, NULL, 16);
>  
>  	if (s++ != NULL)
>  		ops->target.offset = strtoull(s, NULL, 16);
> -- 
> 2.5.5
