Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AAD11A0ED2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 20:55:12 +1100 (AEDT)
Date: Thu, 8 Jan 2015 10:54:34 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 0/4] Add support for parametrized events
Message-ID: <20150108095434.GA16059@krava.redhat.com>
References: <1420679633-28856-1-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420679633-28856-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, dev@codyps.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 07, 2015 at 05:13:49PM -0800, Sukadev Bhattiprolu wrote:
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
> 		domain=0x1,offset=0x8,core=?
> 
> 	In the case of the last example, a value replacing "?" would need
> 	to be provided by the user selecting the particular event. This is
> 	refered to as "event parameterization". All non-numerical values
> 	indicate an event parameter.
> 
> Notes on how perf-list displays parameterized events
> 
> 	PARAMETERIZED EVENTS
> 	--------------------
> 
> 	Some pmu events listed by 'perf list' will be displayed with '$xyz' in
> 	them. For example:
> 
> 	  hv_24x7/HPM_THREAD_NAP_CCYC__PHYS_CORE,core=?/
> 
> 	This means that when provided as an event, a value for ? must also
> 	be supplied. For example:
> 
> 	  perf stat  -e \
> 	  	'hv_24x7/HPM_THREAD_NAP_CCYC__PHYS_CORE,core=2' ...
> 
> Changelog[v7]
> 	[Jiri Olsa] Nit: Add braces for clarity.
> 	[Jiri Olsa] Add a check to make sure that sysfs entries have with
> 	parameters exactly match '=?'.

for the patchset:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
