Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdQ3z0XHCzDvM9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 03:23:10 +1100 (AEDT)
Date: Tue, 13 Dec 2016 13:23:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, chris.ryder@arm.com,
 mhiramat@kernel.org, kim.phillips@arm.com, treeze.taeung@gmail.com,
 markus@trippelsdorf.de, naveen.n.rao@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 2/3] perf annotate: Support jump instruction with
 target as second operand
Message-ID: <20161213162301.GM5482@kernel.org>
References: <1480953407-7605-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1480953407-7605-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480953407-7605-2-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Dec 05, 2016 at 09:26:46PM +0530, Ravi Bangoria escreveu:
> +++ b/tools/perf/util/annotate.c
> @@ -223,8 +223,12 @@ bool ins__is_call(const struct ins *ins)
>  static int jump__parse(struct arch *arch __maybe_unused, struct ins_operands *ops, struct map *map __maybe_unused)
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

Simple enough, applied.

- Arnaldo
