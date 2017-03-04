Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZmdb6h87zDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Mar 2017 11:09:55 +1100 (AEDT)
Date: Sat, 4 Mar 2017 09:09:41 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ananth N
 Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 1/3] perf: probe: factor out the ftrace README scanning
Message-Id: <20170304090941.7ae300ff7db9c96a081d0935@kernel.org>
In-Reply-To: <e4ea4dcc09ac167cc47026e6db73ac67ca001772.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
 <e4ea4dcc09ac167cc47026e6db73ac67ca001772.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  2 Mar 2017 23:25:05 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Simplify and separate out the ftrace README scanning logic into a
> separate helper. This is used subsequently to scan for all patterns of
> interest and to cache the result.
> 
> Since we are only interested in availability of probe argument type x,
> we will only scan for that.

Ah, OK, this can simplify and shorten the actual scanning time.
If there are any needs for checking those in the future, we can
add it again at that moment.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/util/probe-file.c | 70 +++++++++++++++++++++++---------------------
>  1 file changed, 37 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index 1a62daceb028..8a219cd831b7 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -877,35 +877,31 @@ int probe_cache__show_all_caches(struct strfilter *filter)
>  	return 0;
>  }
>  
> +enum ftrace_readme {
> +	FTRACE_README_PROBE_TYPE_X = 0,
> +	FTRACE_README_END,
> +};
> +
>  static struct {
>  	const char *pattern;
> -	bool	avail;
> -	bool	checked;
> -} probe_type_table[] = {
> -#define DEFINE_TYPE(idx, pat, def_avail)	\
> -	[idx] = {.pattern = pat, .avail = (def_avail)}
> -	DEFINE_TYPE(PROBE_TYPE_U, "* u8/16/32/64,*", true),
> -	DEFINE_TYPE(PROBE_TYPE_S, "* s8/16/32/64,*", true),
> -	DEFINE_TYPE(PROBE_TYPE_X, "* x8/16/32/64,*", false),
> -	DEFINE_TYPE(PROBE_TYPE_STRING, "* string,*", true),
> -	DEFINE_TYPE(PROBE_TYPE_BITFIELD,
> -		    "* b<bit-width>@<bit-offset>/<container-size>", true),
> +	bool avail;
> +} ftrace_readme_table[] = {
> +#define DEFINE_TYPE(idx, pat)			\
> +	[idx] = {.pattern = pat, .avail = false}
> +	DEFINE_TYPE(FTRACE_README_PROBE_TYPE_X, "*type: * x8/16/32/64,*"),
>  };
>  
> -bool probe_type_is_available(enum probe_type type)
> +static bool scan_ftrace_readme(enum ftrace_readme type)
>  {
> +	int fd;
>  	FILE *fp;
>  	char *buf = NULL;
>  	size_t len = 0;
> -	bool target_line = false;
> -	bool ret = probe_type_table[type].avail;
> -	int fd;
> +	bool ret = false;
> +	static bool scanned = false;
>  
> -	if (type >= PROBE_TYPE_END)
> -		return false;
> -	/* We don't have to check the type which supported by default */
> -	if (ret || probe_type_table[type].checked)
> -		return ret;
> +	if (scanned)
> +		goto result;
>  
>  	fd = open_trace_file("README", false);
>  	if (fd < 0)
> @@ -917,21 +913,29 @@ bool probe_type_is_available(enum probe_type type)
>  		return ret;
>  	}
>  
> -	while (getline(&buf, &len, fp) > 0 && !ret) {
> -		if (!target_line) {
> -			target_line = !!strstr(buf, " type: ");
> -			if (!target_line)
> -				continue;
> -		} else if (strstr(buf, "\t          ") != buf)
> -			break;
> -		ret = strglobmatch(buf, probe_type_table[type].pattern);
> -	}
> -	/* Cache the result */
> -	probe_type_table[type].checked = true;
> -	probe_type_table[type].avail = ret;
> +	while (getline(&buf, &len, fp) > 0)
> +		for (enum ftrace_readme i = 0; i < FTRACE_README_END; i++)
> +			if (!ftrace_readme_table[i].avail)
> +				ftrace_readme_table[i].avail =
> +					strglobmatch(buf, ftrace_readme_table[i].pattern);
> +	scanned = true;
>  
>  	fclose(fp);
>  	free(buf);
>  
> -	return ret;
> +result:
> +	if (type >= FTRACE_README_END)
> +		return false;
> +
> +	return ftrace_readme_table[type].avail;
> +}
> +
> +bool probe_type_is_available(enum probe_type type)
> +{
> +	if (type >= PROBE_TYPE_END)
> +		return false;
> +	else if (type == PROBE_TYPE_X)
> +		return scan_ftrace_readme(FTRACE_README_PROBE_TYPE_X);
> +
> +	return true;
>  }
> -- 
> 2.11.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
