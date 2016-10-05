Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sptmK0XMFzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 22:27:13 +1100 (AEDT)
Date: Wed, 5 Oct 2016 08:27:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, kim.phillips@arm.com,
 linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
 mingo@redhat.com, alexander.shishkin@linux.intel.com,
 treeze.taeung@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 markus@trippelsdorf.de, namhyung@kernel.org, pawel.moll@arm.com,
 chris.ryder@arm.com, jolsa@kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH v7 3/6] perf annotate: Show raw form for jump instruction
 with indirect target
Message-ID: <20161005112701.GS7143@kernel.org>
References: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1474472876-2706-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474472876-2706-4-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Sep 21, 2016 at 09:17:53PM +0530, Ravi Bangoria escreveu:
> For jump instructions that does not include target address as direct
> operand, use raw value for that. This is needed for certain powerpc

  "use raw value" looks vague, as the example below makes is go from
using a value (ffffffffffffca2c) to no value at all, i.e. the output
looks backwards from what you describe, can you instead show the
original disassembled line from objdump, which I think is what you're
calling "raw value" in this case?

- Arnaldo

> jump instructions that use target address in a register (such as bctr,
> btar, ...).
> 
> Before:
>      ld     r12,32088(r12)
>      mtctr  r12
>   v  bctr   ffffffffffffca2c
>      std    r2,24(r1)
>      addis  r12,r2,-1
> 
> After:
>      ld     r12,32088(r12)
>      mtctr  r12
>   v  bctr
>      std    r2,24(r1)
>      addis  r12,r2,-1
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
> Changes in v7:
>   - Added example in description
> 
>  tools/perf/util/annotate.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 5aa72d9..1ccf26a 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -136,6 +136,9 @@ static int jump__parse(struct ins_operands *ops, struct map *map __maybe_unused)
>  static int jump__scnprintf(struct ins *ins, char *bf, size_t size,
>  			   struct ins_operands *ops)
>  {
> +	if (!ops->target.addr)
> +		return ins__raw_scnprintf(ins, bf, size, ops);
> +
>  	return scnprintf(bf, size, "%-6.6s %" PRIx64, ins->name, ops->target.offset);
>  }
>  
> -- 
> 2.5.5
