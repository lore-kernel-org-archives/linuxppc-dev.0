Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F5791A0071
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2014 10:23:29 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 22 Aug 2014 20:23:26 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 9757C38C804D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 20:23:24 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7N0NOLW7537040
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2014 00:23:24 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7N0NNEV001247
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 20:23:24 -0400
Date: Fri, 22 Aug 2014 17:23:21 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 00/14] Add support for parameterized events from sysfs
Message-ID: <20140823002321.GA22172@us.ibm.com>
References: <1408087583-32239-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20140820141545.GA3242@krava.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140820141545.GA3242@krava.brq.redhat.com>
Cc: ak@linux.intel.com, Michael Ellerman <michaele@au1.ibm.com>,
 peterz@infradead.org, linux-kernel@vger.kernel.org, eranian@google.com,
 dev@codyps.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri Olsa [jolsa@redhat.com] wrote:

<snip>
| > Description of the sysfs contents when events are parameterized (copied from an
| > included patch):
| > 
| > 	Examples:
| > 
| > 		domain=0x1,offset=0x8,starting_index=phys_cpu
| > 
| > 	In the case of the last example, a value replacing "phys_cpu"
| > 	would need to be provided by the user selecting the particular
| > 	event. This is refered to as "event parameterization". All
| > 	non-numerical values indicate an event parameter.
| > 
| > Notes on how perf-list displays parameterized events (and how to use them,
| > again culled from an included patch):
| > 
| > 	PARAMETERIZED EVENTS
| > 	--------------------
| > 
| > 	Some pmu events listed by 'perf-list' will be displayed with '?' in
| > 	them. For example:
| > 
| > 	  hv_gpci/dtbp_ptitc,phys_processor_idx=?/
| > 
| > 	This means that when provided as an event, a value for
| > 	phys_processor_idx must also be supplied. For example:
| > 
| > 	  perf stat -e 'hv_gpci/dtbp_ptitc,phys_processor_idx=0x2/' ...
| 
| hi,
| is the reason for this to document this field for event
| in "events/<event>" file?

We are trying to document that for the parameters that have the ? in
perf list, the parameter must be specified otherwise the event will
not be recognized.

| 
| Because once you have the field (phys_processor_idx) defined in
| "formats/phys_processor_idx" you should be able to use it as in
| your example:
| 
|    perf stat -e 'hv_gpci/dtbp_ptitc,phys_processor_idx=0x2/'
| 
| without any changes

For some events 'starting_index' refers to physical processor index
as shown in the sysfs entry:

	$ cd /sys/bus/event_source/devices/hv_gpci/events
 	$ cat dispatch_timebase_by_processor_processor_time_in_timebase_cycles
	request=0x10,starting_index=phys_processor_idx,counter_info_version=0x8,length=8,offset=0

and 'perf list' for this entry shows 'starting_index' with a ?
indicating it is a requireed parameter.

IIUC, rather than have the user specify a value for 'phys_processor_idx'

	-e hv_gpci/dtbp_ptitc,phys_processor_idx=4/'

we would use following right ?

	-e hv_gpci/dtbp_ptitc,starting_index=4/'

If so, I think the interface change makes sense.  perf list would also
show 'starting_index=?' for the event. 

But in the sysfs entry, rather than show 'starting_index=?', should we
leave it as:

	'starting_index=phys_processor_idx' 

For some events 'startind_index' refers to a physical processor id
and for others it is virtual processor id. So, showing phys_processor_idx
could serve as a hint.

Michael, Cody, Ingo, Peter, let me know if you agree or have other
comments on the inteface.

Thanks,

Sukadev



| 
| thanks,
| jirka
