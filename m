Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vVHj103y3zDqH1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Feb 2017 04:12:20 +1100 (AEDT)
Date: Sat, 25 Feb 2017 02:12:08 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Ingo Molnar
 <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho
 de Melo <acme@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/2] perf: kretprobes: offset from reloc_sym if
 kernel supports it
Message-Id: <20170225021208.3bb8f7810ae1c5644df3ae6a@kernel.org>
In-Reply-To: <2f4181ecccf794d05065cb10648badc290aa4c28.1487849577.git.naveen.n.rao@linux.vnet.ibm.com>
References: <b580465c7a4dcd5d3b40fdf8568e6be45d0a6333.1487849577.git.naveen.n.rao@linux.vnet.ibm.com>
 <2f4181ecccf794d05065cb10648badc290aa4c28.1487849577.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Thu, 23 Feb 2017 17:07:24 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> We indicate support for accepting sym+offset with kretprobes through a
> line in ftrace README. Parse the same to identify support and choose the
> appropriate format for kprobe_events.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/util/probe-event.c | 49 ++++++++++++++++++++++++++++++++++++-------
>  tools/perf/util/probe-event.h |  2 ++
>  2 files changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 35f5b7b7715c..dd6b9ce0eef3 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -737,6 +737,43 @@ post_process_module_probe_trace_events(struct probe_trace_event *tevs,
>  	return ret;
>  }
>  
> +bool is_kretprobe_offset_supported(void)
> +{
> +	FILE *fp;
> +	char *buf = NULL;
> +	size_t len = 0;
> +	bool target_line = false;
> +	static int supported = -1;
> +	int fd;
> +
> +	if (supported >= 0)
> +		return !!supported;
> +
> +	fd = open_trace_file("README", false);
> +	if (fd < 0)
> +		return false;
> +
> +	fp = fdopen(fd, "r");
> +	if (!fp) {
> +		close(fd);
> +		return false;
> +	}
> +
> +	while (getline(&buf, &len, fp) > 0) {
> +		target_line = !!strstr(buf, "place (kretprobe): ");
> +		if (!target_line)
> +			continue;
> +		supported = 1;
> +	}
> +	if (supported == -1)
> +		supported = 0;
> +
> +	fclose(fp);
> +	free(buf);
> +
> +	return !!supported;
> +}

Hmm, I think you can do more than that. 
Can you reuse probe_type_is_available() to scan README?
I think we can have something like scan_ftrace_readme() in probe-file.c
to scan all the options and cache the results. 

probe_type_is_available() and kreprobe_offset_is_available()
just returns cached result or scan it in first call.(I would like to
ask you to do it in probe-file.c too)

Thank you,


> +
>  static int
>  post_process_kernel_probe_trace_events(struct probe_trace_event *tevs,
>  				       int ntevs)
> @@ -757,7 +794,9 @@ post_process_kernel_probe_trace_events(struct probe_trace_event *tevs,
>  	}
>  
>  	for (i = 0; i < ntevs; i++) {
> -		if (!tevs[i].point.address || tevs[i].point.retprobe)
> +		if (!tevs[i].point.address)
> +			continue;
> +		if (tevs[i].point.retprobe && !is_kretprobe_offset_supported())
>  			continue;
>  		/* If we found a wrong one, mark it by NULL symbol */
>  		if (kprobe_warn_out_range(tevs[i].point.symbol,
> @@ -1528,11 +1567,6 @@ static int parse_perf_probe_point(char *arg, struct perf_probe_event *pev)
>  		return -EINVAL;
>  	}
>  
> -	if (pp->retprobe && !pp->function) {
> -		semantic_error("Return probe requires an entry function.\n");
> -		return -EINVAL;
> -	}
> -
>  	if ((pp->offset || pp->line || pp->lazy_line) && pp->retprobe) {
>  		semantic_error("Offset/Line/Lazy pattern can't be used with "
>  			       "return probe.\n");
> @@ -2841,7 +2875,8 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
>  	}
>  
>  	/* Note that the symbols in the kmodule are not relocated */
> -	if (!pev->uprobes && !pp->retprobe && !pev->target) {
> +	if (!pev->uprobes && !pev->target &&
> +			(!pp->retprobe || is_kretprobe_offset_supported())) {
>  		reloc_sym = kernel_get_ref_reloc_sym();
>  		if (!reloc_sym) {
>  			pr_warning("Relocated base symbol is not found!\n");
> diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
> index 5d4e94061402..449d4f311355 100644
> --- a/tools/perf/util/probe-event.h
> +++ b/tools/perf/util/probe-event.h
> @@ -135,6 +135,8 @@ bool perf_probe_with_var(struct perf_probe_event *pev);
>  /* Check the perf_probe_event needs debuginfo */
>  bool perf_probe_event_need_dwarf(struct perf_probe_event *pev);
>  
> +bool is_kretprobe_offset_supported(void);
> +
>  /* Release event contents */
>  void clear_perf_probe_event(struct perf_probe_event *pev);
>  void clear_probe_trace_event(struct probe_trace_event *tev);
> -- 
> 2.11.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
