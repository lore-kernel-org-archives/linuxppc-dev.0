Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSLPV6njgzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 00:07:10 +1100 (AEDT)
Date: Tue, 21 Feb 2017 22:06:55 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, Namhyung Kim
 <namhyung@kernel.org>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar
 <mingo@redhat.com>
Subject: Re: [PATCH 0/2] powerpc: kretprobe updates
Message-Id: <20170221220655.19df81e829e3f5f16e82954d@kernel.org>
In-Reply-To: <20170220114305.8998-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20170217204254.GH4109@kernel.org>
 <20170220114305.8998-1-naveen.n.rao@linux.vnet.ibm.com>
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

On Mon, 20 Feb 2017 17:13:05 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On 2017/02/17 05:42PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Feb 17, 2017 at 07:44:33PM +0900, Masami Hiramatsu escreveu:
> > > On Thu, 16 Feb 2017 13:47:37 +0530
> > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > > 
> > > > I am posting the powerpc bits in the same thread so as to keep these
> > > > changes together. I am not sure how this should be taken upstream as
> > > > there are atleast three different trees involved: one for the core
> > > > kprobes infrastructure, one for powerpc and one for perf.
> > 
> > > Hmm, could you make these (and other related) patches and
> > > other series in one series? Or wait for the other series
> > > are merged correctly.
> > 
> > Well, patches like these should be done in a way that the tooling parts
> > can deal with kernels with or without the kernel changes, so that older
> > tools work with new kernels and new tools work with older kernels.
> 
> Does the below work?

Sorry, no that is not what we meant. Please see my previous reply.

> 
> The idea is to just prefer the real function names when probing 
> functions that do not have duplicate names. Offset from _text only if we 
> detect that a function name has multiple entries. In this manner,
> existing perf will continue to work with newer kernels and vice-versa.

Even with this, the latter will fail (instead of putting rprobe on the
first symbol) on older kernel. Instead, we'll check the ftrace's README
on current kernel and if it supports sym+offs style on retprobe,
we'll use _text+offs event definition. If not, we continue to use
older style.

Thank you,

> 
> Before this patch:
> 
> naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe -D _do_fork
> p:probe/_do_fork _text+857288
> naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe -D _do_fork%return
> r:probe/_do_fork _text+857288
> naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe -D read_mem
> p:probe/read_mem _text+10019704
> p:probe/read_mem_1 _text+6228424
> naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe -D read_mem%return
> r:probe/read_mem _text+10019704
> r:probe/read_mem_1 _text+6228424
> 
> 
> With the below patch (lightly tested):
> 
> naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe -D _do_fork
> p:probe/_do_fork _do_fork+8
> naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe -D _do_fork%return
> r:probe/_do_fork _do_fork+8
> naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe -D read_mem
> p:probe/read_mem _text+10019704
> p:probe/read_mem_1 _text+6228424
> naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe -D read_mem%return
> r:probe/read_mem _text+10019704
> r:probe/read_mem_1 _text+6228424
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  tools/perf/util/machine.h     |  7 +++++
>  tools/perf/util/map.c         | 41 +++++++++++++++++++++++++++++
>  tools/perf/util/map.h         | 13 ++++++++++
>  tools/perf/util/probe-event.c | 18 +++++++++++++
>  tools/perf/util/symbol.c      | 60 +++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/symbol.h      |  2 ++
>  6 files changed, 141 insertions(+)
> 
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index 354de6e56109..277ffb1e0896 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -203,6 +203,13 @@ struct symbol *machine__find_kernel_function_by_name(struct machine *machine,
>  	return map_groups__find_function_by_name(&machine->kmaps, name, mapp);
>  }
>  
> +static inline
> +unsigned int machine__find_kernel_function_count_by_name(struct machine *machine,
> +						     const char *name)
> +{
> +	return map_groups__find_function_count_by_name(&machine->kmaps, name);
> +}
> +
>  struct map *machine__findnew_module_map(struct machine *machine, u64 start,
>  					const char *filename);
>  int arch__fix_module_text_start(u64 *start, const char *name);
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 4f9a71c63026..b75b35dc54ad 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -349,6 +349,17 @@ struct symbol *map__find_symbol_by_name(struct map *map, const char *name)
>  	return dso__find_symbol_by_name(map->dso, map->type, name);
>  }
>  
> +unsigned int map__find_symbol_count_by_name(struct map *map, const char *name)
> +{
> +	if (map__load(map) < 0)
> +		return 0;
> +
> +	if (!dso__sorted_by_name(map->dso, map->type))
> +		dso__sort_by_name(map->dso, map->type);
> +
> +	return dso__find_symbol_count_by_name(map->dso, map->type, name);
> +}
> +
>  struct map *map__clone(struct map *from)
>  {
>  	struct map *map = memdup(from, sizeof(*map));
> @@ -593,6 +604,29 @@ struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
>  	return sym;
>  }
>  
> +unsigned int maps__find_symbol_count_by_name(struct maps *maps, const char *name)
> +{
> +	struct symbol *sym;
> +	struct rb_node *nd;
> +	unsigned int count = 0;
> +
> +	pthread_rwlock_rdlock(&maps->lock);
> +
> +	for (nd = rb_first(&maps->entries); nd; nd = rb_next(nd)) {
> +		struct map *pos = rb_entry(nd, struct map, rb_node);
> +
> +		sym = map__find_symbol_by_name(pos, name);
> +
> +		if (sym != NULL) {
> +			count = map__find_symbol_count_by_name(pos, name);
> +			break;
> +		}
> +	}
> +
> +	pthread_rwlock_unlock(&maps->lock);
> +	return count;
> +}
> +
>  struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg,
>  					       enum map_type type,
>  					       const char *name,
> @@ -603,6 +637,13 @@ struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg,
>  	return sym;
>  }
>  
> +unsigned int map_groups__find_symbol_count_by_name(struct map_groups *mg,
> +					       enum map_type type,
> +					       const char *name)
> +{
> +	return maps__find_symbol_count_by_name(&mg->maps[type], name);
> +}
> +
>  int map_groups__find_ams(struct addr_map_symbol *ams)
>  {
>  	if (ams->addr < ams->map->start || ams->addr >= ams->map->end) {
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index abdacf800c98..ecf995f033ed 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -173,6 +173,7 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
>  int map__load(struct map *map);
>  struct symbol *map__find_symbol(struct map *map, u64 addr);
>  struct symbol *map__find_symbol_by_name(struct map *map, const char *name);
> +unsigned int map__find_symbol_count_by_name(struct map *map, const char *name);
>  void map__fixup_start(struct map *map);
>  void map__fixup_end(struct map *map);
>  
> @@ -187,6 +188,7 @@ struct map *maps__first(struct maps *maps);
>  struct map *map__next(struct map *map);
>  struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
>                                           struct map **mapp);
> +unsigned int maps__find_symbol_count_by_name(struct maps *maps, const char *name);
>  void map_groups__init(struct map_groups *mg, struct machine *machine);
>  void map_groups__exit(struct map_groups *mg);
>  int map_groups__clone(struct thread *thread,
> @@ -233,6 +235,10 @@ struct symbol *map_groups__find_symbol_by_name(struct map_groups *mg,
>  					       const char *name,
>  					       struct map **mapp);
>  
> +unsigned int map_groups__find_symbol_count_by_name(struct map_groups *mg,
> +					       enum map_type type,
> +					       const char *name);
> +
>  struct addr_map_symbol;
>  
>  int map_groups__find_ams(struct addr_map_symbol *ams);
> @@ -244,6 +250,13 @@ struct symbol *map_groups__find_function_by_name(struct map_groups *mg,
>  	return map_groups__find_symbol_by_name(mg, MAP__FUNCTION, name, mapp);
>  }
>  
> +static inline
> +unsigned int map_groups__find_function_count_by_name(struct map_groups *mg,
> +						 const char *name)
> +{
> +	return map_groups__find_symbol_count_by_name(mg, MAP__FUNCTION, name);
> +}
> +
>  int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map,
>  				   FILE *fp);
>  
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index fa7f81af11e8..011e938a0a84 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -113,6 +113,11 @@ static struct symbol *__find_kernel_function_by_name(const char *name,
>  	return machine__find_kernel_function_by_name(host_machine, name, mapp);
>  }
>  
> +static unsigned int __find_kernel_function_count_by_name(const char *name)
> +{
> +	return machine__find_kernel_function_count_by_name(host_machine, name);
> +}
> +
>  static struct symbol *__find_kernel_function(u64 addr, struct map **mapp)
>  {
>  	return machine__find_kernel_function(host_machine, addr, mapp);
> @@ -155,6 +160,11 @@ static int kernel_get_symbol_address_by_name(const char *name, u64 *addr,
>  	return 0;
>  }
>  
> +static unsigned int kernel_get_symbol_count_by_name(const char *name)
> +{
> +	return __find_kernel_function_count_by_name(name);
> +}
> +
>  static struct map *kernel_get_module_map(const char *module)
>  {
>  	struct map_groups *grp = &host_machine->kmaps;
> @@ -259,6 +269,11 @@ static bool kprobe_warn_out_range(const char *symbol, unsigned long address)
>  	return true;
>  }
>  
> +static bool kprobe_is_duplicate_symbol(const char *symbol)
> +{
> +	return kernel_get_symbol_count_by_name(symbol) > 1;
> +}
> +
>  /*
>   * @module can be module name of module file path. In case of path,
>   * inspect elf and find out what is actual module name.
> @@ -759,6 +774,9 @@ post_process_kernel_probe_trace_events(struct probe_trace_event *tevs,
>  	for (i = 0; i < ntevs; i++) {
>  		if (!tevs[i].point.address)
>  			continue;
> +		if (!kprobe_is_duplicate_symbol(tevs[i].point.symbol))
> +			continue;
> +
>  		/* If we found a wrong one, mark it by NULL symbol */
>  		if (kprobe_warn_out_range(tevs[i].point.symbol,
>  					  tevs[i].point.address)) {
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index dc93940de351..ca4a11a92c6f 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -438,6 +438,60 @@ static struct symbol *symbols__find_by_name(struct rb_root *symbols,
>  	return &s->sym;
>  }
>  
> +static unsigned int symbols__find_count_by_name(struct rb_root *symbols,
> +					    const char *name)
> +{
> +	struct rb_node *n, *m;
> +	struct symbol_name_rb_node *s = NULL;
> +	unsigned int count = 0;
> +
> +	if (symbols == NULL)
> +		return 0;
> +
> +	n = symbols->rb_node;
> +
> +	while (n) {
> +		int cmp;
> +
> +		s = rb_entry(n, struct symbol_name_rb_node, rb_node);
> +		cmp = arch__compare_symbol_names(name, s->sym.name);
> +
> +		if (cmp < 0)
> +			n = n->rb_left;
> +		else if (cmp > 0)
> +			n = n->rb_right;
> +		else
> +			break;
> +	}
> +
> +	if (n == NULL)
> +		return 0;
> +
> +	count++;
> +
> +	for (m = rb_prev(n); m; m = rb_prev(m)) {
> +		struct symbol_name_rb_node *tmp;
> +
> +		tmp = rb_entry(m, struct symbol_name_rb_node, rb_node);
> +		if (arch__compare_symbol_names(tmp->sym.name, s->sym.name))
> +			break;
> +
> +		count++;
> +	}
> +
> +	for (m = rb_next(n); m; m = rb_next(m)) {
> +		struct symbol_name_rb_node *tmp;
> +
> +		tmp = rb_entry(m, struct symbol_name_rb_node, rb_node);
> +		if (arch__compare_symbol_names(tmp->sym.name, s->sym.name))
> +			break;
> +
> +		count++;
> +	}
> +
> +	return count;
> +}
> +
>  void dso__reset_find_symbol_cache(struct dso *dso)
>  {
>  	enum map_type type;
> @@ -503,6 +557,12 @@ struct symbol *dso__find_symbol_by_name(struct dso *dso, enum map_type type,
>  	return symbols__find_by_name(&dso->symbol_names[type], name);
>  }
>  
> +unsigned int dso__find_symbol_count_by_name(struct dso *dso, enum map_type type,
> +					const char *name)
> +{
> +	return symbols__find_count_by_name(&dso->symbol_names[type], name);
> +}
> +
>  void dso__sort_by_name(struct dso *dso, enum map_type type)
>  {
>  	dso__set_sorted_by_name(dso, type);
> diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> index 6c358b7ed336..c4bd1b035a9b 100644
> --- a/tools/perf/util/symbol.h
> +++ b/tools/perf/util/symbol.h
> @@ -260,6 +260,8 @@ struct symbol *dso__find_symbol(struct dso *dso, enum map_type type,
>  				u64 addr);
>  struct symbol *dso__find_symbol_by_name(struct dso *dso, enum map_type type,
>  					const char *name);
> +unsigned int dso__find_symbol_count_by_name(struct dso *dso, enum map_type type,
> +					const char *name);
>  struct symbol *symbol__next_by_name(struct symbol *sym);
>  
>  struct symbol *dso__first_symbol(struct dso *dso, enum map_type type);
> -- 
> 2.11.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
