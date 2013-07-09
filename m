Return-Path: <vincent.weaver@maine.edu>
Received: from mail-vb0-f43.google.com (mail-vb0-f43.google.com
 [209.85.212.43])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 32DE12C02B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 00:59:56 +1000 (EST)
Received: by mail-vb0-f43.google.com with SMTP id e12so4493332vbg.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jul 2013 07:59:53 -0700 (PDT)
Date: Tue, 9 Jul 2013 11:05:30 -0400 (EDT)
From: Vince Weaver <vincent.weaver@maine.edu>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/2] perf tools: Make Power7 events available for perf
In-Reply-To: <20130709081434.GI25631@dyad.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.10.1307091059270.675@vincent-weaver-1.um.maine.edu>
References: <1372170933-4538-1-git-send-email-runzhen@linux.vnet.ibm.com>
 <1372170933-4538-3-git-send-email-runzhen@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1306251240440.25443@pianoman.cluster.toy>
 <20130704125218.GA21134@concordia>
 <20130704125700.GM18898@dyad.programming.kicks-ass.net>
 <20130709012952.GA7185@concordia>
 <alpine.DEB.2.10.1307082204550.26280@vincent-weaver-1.um.maine.edu>
 <20130709081434.GI25631@dyad.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: acme@redhat.com, Vince Weaver <vincent.weaver@maine.edu>,
 Will Deacon <will.deacon@arm.com>, Vince Weaver <vince@deater.net>,
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

On Tue, 9 Jul 2013, Peter Zijlstra wrote:

> On Mon, Jul 08, 2013 at 10:24:34PM -0400, Vince Weaver wrote:
> > 
> > So something like they have on ARM?
> > 
> > vince@pandaboard:/sys/bus/event_source/devices$ ls -l
> > lrwxrwxrwx 1 root root 0 Jul  8 21:57 ARMv7 Cortex-A9 -> ../../../devices/ARMv7 Cortex-A9
> > lrwxrwxrwx 1 root root 0 Jul  8 21:57 breakpoint -> ../../../devices/breakpoint
> > lrwxrwxrwx 1 root root 0 Jul  8 21:57 software -> ../../../devices/software
> > lrwxrwxrwx 1 root root 0 Jul  8 21:57 tracepoint -> ../../../devices/tracepoint
> 
> Right so what I remember of the ARM case is that their /proc/cpuinfo isn't
> sufficient to identify their PMU. And they don't have a cpuid like instruction
> at all.

libpfm4 uses the
   CPU part	: 0xc09
line in /proc/cpuinfo on ARM, and that's enough for the processors PAPI 
supports (Cortex A8/A9/A15 plus the 1176 on the raspberry-pi).  I'm 
guessing it wouldn't be enough if we wanted to support *all* ARMs with
PMUs.

And speaking of ARM, I should be railing at them for breaking the ABI too, 
with their (understandable yet still ABI breaking) decision to remove 
BogoMIPS from /proc/cpuinfo.  That change will impact PAPI as well as 
various other programs I maintain that have the misfortune of parsing that 
file.

Vince
