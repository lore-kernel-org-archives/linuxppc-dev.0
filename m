Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 107D21A04B7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 07:28:23 +1100 (AEDT)
Date: Thu, 12 Mar 2015 17:26:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCHv2 4/8] perf probe powerpc: Handle powerpc dot symbols
Message-ID: <20150312202650.GF3550@kernel.org>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
 <09c7f8741ea27aea8666f9d0e9caa828ff40fba9.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <09c7f8741ea27aea8666f9d0e9caa828ff40fba9.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Dec 15, 2014 at 08:20:34PM +0530, Naveen N. Rao escreveu:
> Fix up various perf aspects related to ppc64's usage of dot functions:
> - ignore leading '.' when generating event names and when looking for
>   existing events.
> - use the proper prefix when ignoring SyS symbol lookups.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/util/probe-event.c | 8 ++++++++
>  tools/perf/util/symbol.c      | 6 ++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 9943ff3..74b7fef 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -2080,6 +2080,10 @@ static int get_new_event_name(char *buf, size_t len, const char *base,
>  {
>  	int i, ret;
>  
> +	/* Skip the leading dot on powerpc */
> +	if (*base == '.')
> +		base++;
> +
>  	/* Try no suffix */
>  	ret = e_snprintf(buf, len, "%s", base);
>  	if (ret < 0) {
> @@ -2538,6 +2542,10 @@ int del_perf_probe_events(struct strlist *dellist)
>  			event = str;
>  		}
>  
> +		/* Skip the leading dot on powerpc */

Ok, but this is not powerpc specific code, is it?

> +		if (event && *event == '.')
> +			event++;
> +
>  		ret = e_snprintf(buf, 128, "%s:%s", group, event);
>  		if (ret < 0) {
>  			pr_err("Failed to copy event.");
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index c24c5b8..e7b9bae 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -139,6 +139,12 @@ static int choose_best_symbol(struct symbol *syma, struct symbol *symb)
>  	if (na >= 10 && !strncmp(syma->name, "compat_SyS", 10))
>  		return SYMBOL_B;
>  
> +	/* On powerpc, ignore the dot variants */
> +	if (na >= 4 && !strncmp(syma->name, ".SyS", 4))
> +		return SYMBOL_B;
> +	if (na >= 11 && !strncmp(syma->name, ".compat_SyS", 11))
> +		return SYMBOL_B;
> +
>  	return SYMBOL_A;
>  }
>  
> -- 
> 2.1.3
