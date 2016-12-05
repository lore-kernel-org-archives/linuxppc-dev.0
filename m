Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXZQh5jXrzDvw7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 06:22:36 +1100 (AEDT)
Date: Mon, 5 Dec 2016 16:22:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, chris.ryder@arm.com,
 mhiramat@kernel.org, kim.phillips@arm.com, treeze.taeung@gmail.com,
 markus@trippelsdorf.de, naveen.n.rao@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 1/3] perf annotate: Show raw form for jump instruction
 with indirect target
Message-ID: <20161205192229.GA28260@kernel.org>
References: <1480953407-7605-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480953407-7605-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Dec 05, 2016 at 09:26:45PM +0530, Ravi Bangoria escreveu:
> For jump instructions that does not include target address as direct
> operand, show the original disassembled line for them. This is needed
> for certain powerpc jump instructions that use target address in a
> register (such as bctr, btar, ...).

Please, mention the name of the function where you copy annotated
examples from, so that I can reproduce it here, using the files you
provided (perf.data and vmlinux for powerpc).

Searching one such function now...
 
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
> Changes in v8:
>   - v7: https://lkml.org/lkml/2016/9/21/436
>   - Rebase to acme/perf/core
>   - No logical changes. (Cross arch annotate patches are in. This patch
>     is for hardening annotate for powerpc.)
> 
>  tools/perf/util/annotate.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 4012b1d..ea7e0de 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -237,6 +237,9 @@ static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *op
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
> 2.4.11
