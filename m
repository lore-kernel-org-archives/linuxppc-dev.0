Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BDB4A2C02A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 18:15:25 +1000 (EST)
Date: Tue, 9 Jul 2013 10:14:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH v2 2/2] perf tools: Make Power7 events available for perf
Message-ID: <20130709081434.GI25631@dyad.programming.kicks-ass.net>
References: <1372170933-4538-1-git-send-email-runzhen@linux.vnet.ibm.com>
 <1372170933-4538-3-git-send-email-runzhen@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1306251240440.25443@pianoman.cluster.toy>
 <20130704125218.GA21134@concordia>
 <20130704125700.GM18898@dyad.programming.kicks-ass.net>
 <20130709012952.GA7185@concordia>
 <alpine.DEB.2.10.1307082204550.26280@vincent-weaver-1.um.maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1307082204550.26280@vincent-weaver-1.um.maine.edu>
Cc: acme@redhat.com, Vince Weaver <vince@deater.net>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 paulus@samba.org, xiaoguangrong@linux.vnet.ibm.com,
 Runzhen Wang <runzhen@linux.vnet.ibm.com>, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 08, 2013 at 10:24:34PM -0400, Vince Weaver wrote:
> 
> So something like they have on ARM?
> 
> vince@pandaboard:/sys/bus/event_source/devices$ ls -l
> lrwxrwxrwx 1 root root 0 Jul  8 21:57 ARMv7 Cortex-A9 -> ../../../devices/ARMv7 Cortex-A9
> lrwxrwxrwx 1 root root 0 Jul  8 21:57 breakpoint -> ../../../devices/breakpoint
> lrwxrwxrwx 1 root root 0 Jul  8 21:57 software -> ../../../devices/software
> lrwxrwxrwx 1 root root 0 Jul  8 21:57 tracepoint -> ../../../devices/tracepoint

Right so what I remember of the ARM case is that their /proc/cpuinfo isn't
sufficient to identify their PMU. And they don't have a cpuid like instruction
at all.

> > For the cpu you can obviously just detect what processor you're on with
> > cpuid or whatever, but it's a bit of a hack. And that really doesn't
> > work for non-cpu PMUs.
> 
> why is it a hack to use cpuid?

I agree, for x86 cpuid is perfectly fine, as would /proc/cpuinfo be, I suspect
that just the model number is sufficient in most cases, even for uncore stuff.
