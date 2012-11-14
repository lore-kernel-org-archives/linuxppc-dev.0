Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C33D2C0092
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2012 05:26:26 +1100 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 14 Nov 2012 13:26:23 -0500
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4299938C80A9
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2012 13:26:21 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAEIQJkL120414
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2012 13:26:19 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAEIPwJW011710
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2012 13:26:19 -0500
Date: Wed, 14 Nov 2012 10:20:45 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 3/4] perf/POWER7: Make event translations available in
 sysfs
Message-ID: <20121114182045.GA2240@us.ibm.com>
References: <20121107191818.GA16211@us.ibm.com>
 <20121107191927.GC16211@us.ibm.com>
 <20121114102534.GA2220@krava.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121114102534.GA2220@krava.brq.redhat.com>
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

Jiri Olsa [jolsa@redhat.com] wrote:
| On Wed, Nov 07, 2012 at 11:19:28AM -0800, Sukadev Bhattiprolu wrote:
| 
| SNIP
| 
| > +struct perf_pmu_events_attr {
| > +	struct device_attribute attr;
| > +	u64 id;
| > +};
| > +
| > +extern ssize_t power_events_sysfs_show(struct device *dev,
| > +				struct device_attribute *attr, char *page);
| > +
| > +#define EVENT_VAR(_id)	event_attr_##_id
| > +#define EVENT_PTR(_id) &event_attr_##_id.attr.attr
| > +
| > +#define EVENT_ATTR(_name, _id)                                             \
| > +	static struct perf_pmu_events_attr EVENT_VAR(_id) = {              \
| > +		.attr = __ATTR(_name, 0444, power_events_sysfs_show, NULL),\
| > +		.id   = PM_##_id,                                               \
| > +	};
| 
| this is duplicating the x86 code, perhaps it could be moved
| to include/linux/perf_event.h and shared globaly

Ok.

Can we remove the assumption that the event id is a generic event that
has PERF_COUNT_HW_ prefix and also let the architectures pass in a "show"
function ? This would allow architectures to display any arch specific
events that don't yet have a generic counterpart.

IOW, can we do something like this (untested) and make PERF_EVENT_ATTR global:



diff --git a/arch/x86/kernel/cpu/perf_event.c b/arch/x86/kernel/cpu/perf_event.c
index 4428fd1..25298f7 100644
--- a/arch/x86/kernel/cpu/perf_event.c
+++ b/arch/x86/kernel/cpu/perf_event.c
@@ -1354,12 +1354,15 @@ static ssize_t events_sysfs_show(struct device *dev, struct device_attribute *at
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr

-#define EVENT_ATTR(_name, _id)                                 \
+#define PERF_EVENT_ATTR(_name, _id, _show)                     \
 static struct perf_pmu_events_attr EVENT_VAR(_id) = {          \
-       .attr = __ATTR(_name, 0444, events_sysfs_show, NULL),   \
-       .id   =  PERF_COUNT_HW_##_id,                           \
+       .attr = __ATTR(_name, 0444, _show, NULL),               \
+       .id   =  _id,                                           \
 };

+#define EVENT_ATTR(_name, _id)                                         \
+       PERF_EVENT_ATTR(_name, PERF_COUNT_HW_##_id, events_sysfs_show)
+
 EVENT_ATTR(cpu-cycles,                 CPU_CYCLES              );
 EVENT_ATTR(instructions,               INSTRUCTIONS            );
 EVENT_ATTR(cache-references,           CACHE_REFERENCES        );

| 
| 
| > diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
| > index aa2465e..19b23bd 100644
| > --- a/arch/powerpc/perf/core-book3s.c
| > +++ b/arch/powerpc/perf/core-book3s.c
| > @@ -1305,6 +1305,16 @@ static int power_pmu_event_idx(struct perf_event *event)
| >  	return event->hw.idx;
| >  }
| >  
| > +ssize_t power_events_sysfs_show(struct device *dev,
| > +				struct device_attribute *attr, char *page)
| > +{
| > +       struct perf_pmu_events_attr *pmu_attr;
| > +       
| > +       pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
| > +        
| > +       return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
| 
| whitespace issues

Will fix. Thanks for the review.

Sukadev
