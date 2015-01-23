Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B13321A0D00
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 20:47:29 +1100 (AEDT)
Date: Fri, 23 Jan 2015 10:46:51 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 1/7] perf: provide sysfs_show for struct
 perf_pmu_events_attr
Message-ID: <20150123094651.GB4654@krava.brq.redhat.com>
References: <1419234532-22657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1419234532-22657-2-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419234532-22657-2-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, dev@codyps.com,
 Stephane Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 21, 2014 at 11:48:46PM -0800, Sukadev Bhattiprolu wrote:
> From: Cody P Schafer <cody@linux.vnet.ibm.com>
> 
> (struct perf_pmu_events_attr) is defined in include/linux/perf_event.h,
> but the only "show" for it is in x86 and contains x86 specific stuff.
> 
> Make a generic one for those of us who are just using the event_str.
> 
> CC: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> CC: Haren Myneni <hbabu@us.ibm.com>
> CC: Cody P Schafer <dev@codyps.com>
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> ---
>  include/linux/perf_event.h | 3 +++
>  kernel/events/core.c       | 8 ++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 486e84c..58f59bd 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -897,6 +897,9 @@ struct perf_pmu_events_attr {
>  	const char *event_str;
>  };
>  
> +ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
> +			      char *page);
> +
>  #define PMU_EVENT_ATTR(_name, _var, _id, _show)				\
>  static struct perf_pmu_events_attr _var = {				\
>  	.attr = __ATTR(_name, 0444, _show, NULL),			\
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index af0a5ba..1808d0e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8276,6 +8276,14 @@ void __init perf_event_init(void)
>  		     != 1024);
>  }
>  
> +ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
> +			      char *page)
> +{
> +	struct perf_pmu_events_attr *pmu_attr =
> +		container_of(attr, struct perf_pmu_events_attr, attr);
> +	return sprintf(page, "%s\n", pmu_attr->event_str);
> +}
> +

Stephane just added same local one for RAPL pmu:
  433678bdc6ed perf/rapl: Fix sysfs_show() initialization for RAPL PMU

with additional pmu_attr->event_str check

same for PMU_EVENT_ATTR_STRING macro

if you could add this additional check plus the id initialization
in the PMU_EVENT_ATTR_STRING macro, we could use the generic
version in RAPL object as well

thanks,
jirka
