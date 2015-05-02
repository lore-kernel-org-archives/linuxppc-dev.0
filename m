Return-Path: <Vineet.Gupta1@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay.synopsys.com [198.182.47.9])
 (using TLSv1.1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA5321A0D1C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 17:04:25 +1000 (AEST)
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "ak@linux.intel.com" <ak@linux.intel.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC][PATCH 4/4] perf: Create aliases for PMU events
Date: Sat, 2 May 2015 07:04:20 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230756659D93F@IN01WEMBXB.internal.synopsys.com>
References: <1430463941-26109-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1430463941-26109-5-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 01 May 2015 12:35 PM, Sukadev Bhattiprolu wrote:=0A=
> Using the tables of Power7 and Power8 events, create aliases for the=0A=
> Power PMU events. This would allow us to specify all Power events by=0A=
> name rather than by raw code:=0A=
> =0A=
> 	$ /tmp/perf stat -e PM_1PLUS_PPC_CMPL sleep 1=0A=
> =0A=
> 	 Performance counter stats for 'sleep 1':=0A=
> =0A=
> 		   757,661      PM_1PLUS_PPC_CMPL=0A=
> =0A=
> 	       1.001620145 seconds time elapsed=0A=
> =0A=
> The perf binary built on Power8 can be copied to Power7 and it will use=
=0A=
> the Power7 events (if arch/powerpc/util/pmu-events.h knows the CPU string=
).=0A=
> =0A=
> Hopefully other architecutres can also implement arch_get_events_table()=
=0A=
> and take advantage of this.=0A=
> =0A=
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>=0A=
> ---=0A=
>  tools/perf/arch/powerpc/util/Build        |    2 +-=0A=
>  tools/perf/arch/powerpc/util/pmu-events.c |   52 +++++++++++++++++++=0A=
>  tools/perf/arch/powerpc/util/pmu-events.h |   17 +++++++=0A=
>  tools/perf/util/pmu.c                     |   77 +++++++++++++++++++++++=
++++++=0A=
>  tools/perf/util/pmu.h                     |   10 ++++=0A=
>  5 files changed, 157 insertions(+), 1 deletion(-)=0A=
>  create mode 100644 tools/perf/arch/powerpc/util/pmu-events.c=0A=
>  create mode 100644 tools/perf/arch/powerpc/util/pmu-events.h=0A=
> =0A=
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc=
/util/Build=0A=
> index 0af6e9b..52fbc7f 100644=0A=
> --- a/tools/perf/arch/powerpc/util/Build=0A=
> +++ b/tools/perf/arch/powerpc/util/Build=0A=
> @@ -1,4 +1,4 @@=0A=
> -libperf-y +=3D header.o=0A=
> +libperf-y +=3D header.o pmu-events.o=0A=
>  =0A=
>  libperf-$(CONFIG_DWARF) +=3D dwarf-regs.o=0A=
>  libperf-$(CONFIG_DWARF) +=3D skip-callchain-idx.o=0A=
> diff --git a/tools/perf/arch/powerpc/util/pmu-events.c b/tools/perf/arch/=
powerpc/util/pmu-events.c=0A=
> new file mode 100644=0A=
> index 0000000..7036f6d=0A=
> --- /dev/null=0A=
> +++ b/tools/perf/arch/powerpc/util/pmu-events.c=0A=
> @@ -0,0 +1,52 @@=0A=
> +#include <stdio.h>=0A=
> +#include <unistd.h>=0A=
> +#include <sys/types.h>=0A=
> +#include "pmu.h"=0A=
> +#include "pmu-events.h"=0A=
> +#include "../../util/debug.h"			/* verbose */=0A=
> +#include "header.h"				/* mfspr */=0A=
> +=0A=
> +static char *get_cpu_str(void)=0A=
> +{=0A=
> +	char *bufp;=0A=
> +=0A=
> +	if (asprintf(&bufp, "%.8lx-core", mfspr(SPRN_PVR)) < 0)=0A=
> +		bufp =3D NULL;=0A=
> +=0A=
> +	return bufp;=0A=
> +}=0A=
> +=0A=
> +struct perf_pmu_event *arch_get_events_table(char *cpustr)=0A=
> +{=0A=
> +	int i, nmaps, must_free;=0A=
> +	struct  perf_pmu_event *table;=0A=
> +=0A=
> +	must_free =3D 0;=0A=
> +	if (!cpustr) {=0A=
> +		cpustr =3D get_cpu_str();=0A=
> +		if (!cpustr)=0A=
> +			return NULL;=0A=
> +		must_free =3D 1;=0A=
> +	}=0A=
> +=0A=
> +	nmaps =3D sizeof(pvr_events_map) / sizeof(struct pvr_events_map_entry);=
=0A=
> +=0A=
> +	for (i =3D 0; i < nmaps; i++) {=0A=
> +		if (!strcmp(pvr_events_map[i].pvr, cpustr))=0A=
> +			break;=0A=
> +	}=0A=
> +=0A=
> +	table =3D NULL;=0A=
> +	if (i < nmaps) {=0A=
> +		/* pvr_events_map is a const; cast to override */=0A=
> +		table =3D (struct perf_pmu_event *)pvr_events_map[i].pmu_events;=0A=
> +	} else if (verbose) {=0A=
> +		printf("Unknown CPU %s, ignoring aliases\n", cpustr);=0A=
> +	}=0A=
> +=0A=
> +	if (must_free)=0A=
> +		free(cpustr);=0A=
> +=0A=
> +	return table;=0A=
> +}=0A=
> +=0A=
> diff --git a/tools/perf/arch/powerpc/util/pmu-events.h b/tools/perf/arch/=
powerpc/util/pmu-events.h=0A=
> new file mode 100644=0A=
> index 0000000..1daf8e5=0A=
> --- /dev/null=0A=
> +++ b/tools/perf/arch/powerpc/util/pmu-events.h=0A=
> @@ -0,0 +1,17 @@=0A=
> +/*=0A=
> + * Include all Power processor tables that we care about.=0A=
> + */=0A=
> +#include "power7-events.h"=0A=
> +#include "power8-events.h"=0A=
> +=0A=
> +/*=0A=
> + * Map a processor version (PVR) to its table of events.=0A=
> + */=0A=
> +struct pvr_events_map_entry {=0A=
> +	const char *pvr;=0A=
> +	const struct perf_pmu_event *pmu_events;=0A=
> +} pvr_events_map[] =3D {=0A=
> +	{ .pvr =3D "004d0100-core",	.pmu_events =3D power8_pmu_events },=0A=
> +	{ .pvr =3D "003f0201-core",	.pmu_events =3D power7_pmu_events }=0A=
> +};=0A=
=0A=
Do u really need the header - this could go in the .c file ?=0A=
=0A=
> +=0A=
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c=0A=
> index 4841167..f998d91 100644=0A=
> --- a/tools/perf/util/pmu.c=0A=
> +++ b/tools/perf/util/pmu.c=0A=
> @@ -435,6 +435,80 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __=
maybe_unused)=0A=
>  	return NULL;=0A=
>  }=0A=
>  =0A=
> +/*=0A=
> + * Default arch_get_events_table() is empty.=0A=
> + *=0A=
> + * Actual implementation is in arch/$(ARCH)/util/pmu-events.c. This=0A=
> + * allows architectures could choose what set(s) of events to a) include=
=0A=
> + * in perf binary b) consider for _this_ invocation of perf.=0A=
> + *=0A=
> + * Eg: For Power, we include both Power7 and Power8 event tables in the=
=0A=
> + * 	perf binary. But depending on the processor where perf is executed,=
=0A=
> + * 	either the Power7 or Power8 table is returned.=0A=
> + */=0A=
> +struct perf_pmu_event * __attribute__ ((weak))=0A=
> +arch_get_events_table(char *cpustr __maybe_unused)=0A=
> +{=0A=
> +	return NULL;=0A=
> +}=0A=
> +=0A=
> +static int pmu_add_cpu_aliases(char *cpustr, void *data)=0A=
> +{=0A=
> +	struct list_head *head =3D (struct list_head *)data;=0A=
> +	struct perf_pmu_alias *alias;=0A=
> +	int i;=0A=
> +	struct perf_pmu_event *events_table, *event;=0A=
> +	struct parse_events_term *term;=0A=
> +=0A=
> +	events_table =3D arch_get_events_table(cpustr);=0A=
> +	if (!events_table)=0A=
> +		return 0;=0A=
> +=0A=
> +	for (i =3D 0; events_table[i].name !=3D NULL; i++) {=0A=
> +		event =3D &events_table[i];=0A=
> +=0A=
> +		alias =3D malloc(sizeof(*alias));=0A=
> +		if (!alias)=0A=
> +			return -ENOMEM;=0A=
> +=0A=
> +		term =3D malloc(sizeof(*term));=0A=
> +		if (!term) {=0A=
> +			/*=0A=
> +			 * TODO: cleanup aliases allocated so far?=0A=
> +			 */=0A=
> +			free(alias);=0A=
> +			return -ENOMEM;=0A=
> +		}=0A=
> +=0A=
> +		/* ->config is not const; cast to override */=0A=
> +		term->config =3D (char *)"event";=0A=
> +		term->val.num =3D event->code;=0A=
> +		term->type_val =3D PARSE_EVENTS__TERM_TYPE_NUM;=0A=
> +		term->type_term =3D PARSE_EVENTS__TERM_TYPE_USER;=0A=
> +		INIT_LIST_HEAD(&term->list);=0A=
> +		term->used =3D 0;=0A=
> +=0A=
> +		INIT_LIST_HEAD(&alias->terms);=0A=
> +		list_add_tail(&alias->terms, &term->list);=0A=
> +=0A=
> +		alias->scale =3D 1.0;=0A=
> +		alias->unit[0] =3D '\0';=0A=
> +		alias->per_pkg =3D false;=0A=
> +=0A=
> +		alias->name =3D strdup(event->name);=0A=
> +#if 0=0A=
> +		/*=0A=
> +		 * TODO: Need Andi Kleen's patch for ->desc=0A=
> +		 */=0A=
> +		alias->desc =3D event->short_desc ?=0A=
> +					strdup(event->short_desc) : NULL;=0A=
> +#endif=0A=
> +		list_add_tail(&alias->list, head);=0A=
> +	}=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>  static struct perf_pmu *pmu_lookup(const char *name)=0A=
>  {=0A=
>  	struct perf_pmu *pmu;=0A=
> @@ -453,6 +527,9 @@ static struct perf_pmu *pmu_lookup(const char *name)=
=0A=
>  	if (pmu_aliases(name, &aliases))=0A=
>  		return NULL;=0A=
>  =0A=
> +	if (!strcmp(name, "cpu"))=0A=
> +		(void)pmu_add_cpu_aliases(NULL, &aliases);=0A=
> +=0A=
>  	if (pmu_type(name, &type))=0A=
>  		return NULL;=0A=
>  =0A=
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h=0A=
> index 6b1249f..ca3e7a0 100644=0A=
> --- a/tools/perf/util/pmu.h=0A=
> +++ b/tools/perf/util/pmu.h=0A=
> @@ -45,6 +45,14 @@ struct perf_pmu_alias {=0A=
>  	bool snapshot;=0A=
>  };=0A=
>  =0A=
> +struct perf_pmu_event {=0A=
> +	const char *name;=0A=
> +	const unsigned long code;=0A=
> +	const char *short_desc;=0A=
> +	const char *long_desc;=0A=
> +	/* add unit, mask etc as needed here */=0A=
> +};=0A=
> +=0A=
>  struct perf_pmu *perf_pmu__find(const char *name);=0A=
>  int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,=
=0A=
>  		     struct list_head *head_terms);=0A=
> @@ -76,4 +84,6 @@ int perf_pmu__test(void);=0A=
>  =0A=
>  struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pm=
u);=0A=
>  =0A=
> +struct perf_pmu_event *arch_get_events_table(char *cpustr);=0A=
> +=0A=
>  #endif /* __PMU_H */=0A=
> =0A=
=0A=
