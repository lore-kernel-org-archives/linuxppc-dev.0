Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id C74302C00E1
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2012 21:25:51 +1100 (EST)
Date: Wed, 14 Nov 2012 11:25:34 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] perf/POWER7: Make event translations available in
 sysfs
Message-ID: <20121114102534.GA2220@krava.brq.redhat.com>
References: <20121107191818.GA16211@us.ibm.com>
 <20121107191927.GC16211@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121107191927.GC16211@us.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, robert.richter@amd.com,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 07, 2012 at 11:19:28AM -0800, Sukadev Bhattiprolu wrote:

SNIP

> +struct perf_pmu_events_attr {
> +	struct device_attribute attr;
> +	u64 id;
> +};
> +
> +extern ssize_t power_events_sysfs_show(struct device *dev,
> +				struct device_attribute *attr, char *page);
> +
> +#define EVENT_VAR(_id)	event_attr_##_id
> +#define EVENT_PTR(_id) &event_attr_##_id.attr.attr
> +
> +#define EVENT_ATTR(_name, _id)                                             \
> +	static struct perf_pmu_events_attr EVENT_VAR(_id) = {              \
> +		.attr = __ATTR(_name, 0444, power_events_sysfs_show, NULL),\
> +		.id   = PM_##_id,                                               \
> +	};

this is duplicating the x86 code, perhaps it could be moved
to include/linux/perf_event.h and shared globaly


> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index aa2465e..19b23bd 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -1305,6 +1305,16 @@ static int power_pmu_event_idx(struct perf_event *event)
>  	return event->hw.idx;
>  }
>  
> +ssize_t power_events_sysfs_show(struct device *dev,
> +				struct device_attribute *attr, char *page)
> +{
> +       struct perf_pmu_events_attr *pmu_attr;
> +       
> +       pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
> +        
> +       return sprintf(page, "event=0x%02llx\n", pmu_attr->id);

whitespace issues


jirka
