Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 616D11A0EBE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 17:10:36 +1100 (AEDT)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 22 Jan 2015 23:10:33 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id E40D13E40030
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 23:10:31 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0N6AN5N49938566
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 23:10:31 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0N69wts032740
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 23:09:59 -0700
Date: Thu, 22 Jan 2015 22:09:23 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v6 1/7] perf: provide sysfs_show for struct
 perf_pmu_events_attr
Message-ID: <20150123060923.GA24722@us.ibm.com>
References: <1419234532-22657-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1419234532-22657-2-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419234532-22657-2-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, dev@codyps.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri, Arnaldo,

Can you please review/ack this and the next (i.e patches 1 and 2)
of this set ? Since other patches in this set depend on these two,
it maybe easier to have them all go through the ppc tree ?

Thanks,

Sukadev

Sukadev Bhattiprolu [sukadev@linux.vnet.ibm.com] wrote:
| From: Cody P Schafer <cody@linux.vnet.ibm.com>
| 
| (struct perf_pmu_events_attr) is defined in include/linux/perf_event.h,
| but the only "show" for it is in x86 and contains x86 specific stuff.
| 
| Make a generic one for those of us who are just using the event_str.
| 
| CC: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
| CC: Haren Myneni <hbabu@us.ibm.com>
| CC: Cody P Schafer <dev@codyps.com>
| Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
| ---
|  include/linux/perf_event.h | 3 +++
|  kernel/events/core.c       | 8 ++++++++
|  2 files changed, 11 insertions(+)
| 
| diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
| index 486e84c..58f59bd 100644
| --- a/include/linux/perf_event.h
| +++ b/include/linux/perf_event.h
| @@ -897,6 +897,9 @@ struct perf_pmu_events_attr {
|  	const char *event_str;
|  };
|  
| +ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
| +			      char *page);
| +
|  #define PMU_EVENT_ATTR(_name, _var, _id, _show)				\
|  static struct perf_pmu_events_attr _var = {				\
|  	.attr = __ATTR(_name, 0444, _show, NULL),			\
| diff --git a/kernel/events/core.c b/kernel/events/core.c
| index af0a5ba..1808d0e 100644
| --- a/kernel/events/core.c
| +++ b/kernel/events/core.c
| @@ -8276,6 +8276,14 @@ void __init perf_event_init(void)
|  		     != 1024);
|  }
|  
| +ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
| +			      char *page)
| +{
| +	struct perf_pmu_events_attr *pmu_attr =
| +		container_of(attr, struct perf_pmu_events_attr, attr);
| +	return sprintf(page, "%s\n", pmu_attr->event_str);
| +}
| +
|  static int __init perf_event_sysfs_init(void)
|  {
|  	struct pmu *pmu;
| -- 
| 1.8.3.1
| 
| _______________________________________________
| Linuxppc-dev mailing list
| Linuxppc-dev@lists.ozlabs.org
| https://lists.ozlabs.org/listinfo/linuxppc-dev
