Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 341FB1A0162
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 00:16:49 +1000 (EST)
Date: Wed, 20 Aug 2014 16:15:45 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 00/14] Add support for parameterized events from sysfs
Message-ID: <20140820141545.GA3242@krava.brq.redhat.com>
References: <1408087583-32239-1-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408087583-32239-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: ak@linux.intel.com, Michael Ellerman <michaele@au1.ibm.com>,
 peterz@infradead.org, linux-kernel@vger.kernel.org, eranian@google.com,
 dev@codyps.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 15, 2014 at 12:26:09AM -0700, Sukadev Bhattiprolu wrote:
> From: Cody P Schafer <dev@codyps.com>
> 
> What this patchset does:
> 
>  - the first patch (override sysfs in tools/perf via SYSFS_PATH) was sent out
>    previously, but needed a resend anyhow. Having it is useful for testing the
>    later changes to tools/perf.
>  - the second patch is a bugfix to the powerpc hv-24x7 code which was
>    previously sent out, which is a good idea to have when testing these patches
>    on POWER8 hardware.
> 
>  - document perf sysfs and the changes to add parameterized events
>    - semi-notably: removes the growing list of specific POWER cpu events and
>      begins documenting them generically, much like the docs for
>      /sys/modules/MODULENAME do for modules.
>  - tools/perf changes to support parameterized events
>  - export some parameterized events from the powerpc pmus hv_24x7 and hv_gpci
> 
> Description of "event parameters" from the documentation patch:
> 
>     Event parameters are a basic way for partial events to be specified in
>     sysfs with per-event names given to the fields that need to be filled in
>     when using a particular event.
> 
>     It is intended for supporting cases where the single 'cpu' parameter is
>     insufficient. For example, POWER 8 has events for physical
>     sockets/cores/cpus that are accessible from with virtual machines. To
>     keep using the single 'cpu' parameter we'd need to perform a mapping
>     between Linux's cpus and the physical machine's cpus (in this case
>     Linux is running under a hypervisor). This isn't possible because
>     bindings between our cpus and physical cpus may not be fixed, and we
>     probably won't have a "cpu" on each physical cpu.
> 
> Description of the sysfs contents when events are parameterized (copied from an
> included patch):
> 
> 	Examples:
> 
> 		domain=0x1,offset=0x8,starting_index=phys_cpu
> 
> 	In the case of the last example, a value replacing "phys_cpu"
> 	would need to be provided by the user selecting the particular
> 	event. This is refered to as "event parameterization". All
> 	non-numerical values indicate an event parameter.
> 
> Notes on how perf-list displays parameterized events (and how to use them,
> again culled from an included patch):
> 
> 	PARAMETERIZED EVENTS
> 	--------------------
> 
> 	Some pmu events listed by 'perf-list' will be displayed with '?' in
> 	them. For example:
> 
> 	  hv_gpci/dtbp_ptitc,phys_processor_idx=?/
> 
> 	This means that when provided as an event, a value for
> 	phys_processor_idx must also be supplied. For example:
> 
> 	  perf stat -e 'hv_gpci/dtbp_ptitc,phys_processor_idx=0x2/' ...

hi,
is the reason for this to document this field for event
in "events/<event>" file?

Because once you have the field (phys_processor_idx) defined in
"formats/phys_processor_idx" you should be able to use it as in
your example:

   perf stat -e 'hv_gpci/dtbp_ptitc,phys_processor_idx=0x2/'

without any changes

thanks,
jirka
