Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-ea0-x231.google.com (mail-ea0-x231.google.com
 [IPv6:2a00:1450:4013:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A22F12C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 18:34:43 +1000 (EST)
Received: by mail-ea0-f177.google.com with SMTP id j14so4697365eak.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 01:34:38 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 10 Jul 2013 10:34:35 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH v2 2/2] perf tools: Make Power7 events available for perf
Message-ID: <20130710083435.GA24070@gmail.com>
References: <1372170933-4538-1-git-send-email-runzhen@linux.vnet.ibm.com>
 <1372170933-4538-3-git-send-email-runzhen@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1306251240440.25443@pianoman.cluster.toy>
 <20130704125218.GA21134@concordia>
 <20130704125700.GM18898@dyad.programming.kicks-ass.net>
 <20130709012952.GA7185@concordia>
 <alpine.DEB.2.10.1307082204550.26280@vincent-weaver-1.um.maine.edu>
 <20130709081434.GI25631@dyad.programming.kicks-ass.net>
 <20130710030926.GD7491@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130710030926.GD7491@concordia>
Cc: Vince Weaver <vincent.weaver@maine.edu>,
 Peter Zijlstra <peterz@infradead.org>, Vince Weaver <vince@deater.net>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 acme@redhat.com, paulus@samba.org, xiaoguangrong@linux.vnet.ibm.com,
 Runzhen Wang <runzhen@linux.vnet.ibm.com>, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Michael Ellerman <michael@ellerman.id.au> wrote:

> On Tue, Jul 09, 2013 at 10:14:34AM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 08, 2013 at 10:24:34PM -0400, Vince Weaver wrote:
> > > 
> > > So something like they have on ARM?
> > > 
> > > vince@pandaboard:/sys/bus/event_source/devices$ ls -l
> > > lrwxrwxrwx 1 root root 0 Jul  8 21:57 ARMv7 Cortex-A9 -> ../../../devices/ARMv7 Cortex-A9
> > > lrwxrwxrwx 1 root root 0 Jul  8 21:57 breakpoint -> ../../../devices/breakpoint
> > > lrwxrwxrwx 1 root root 0 Jul  8 21:57 software -> ../../../devices/software
> > > lrwxrwxrwx 1 root root 0 Jul  8 21:57 tracepoint -> ../../../devices/tracepoint
> > 
> > Right so what I remember of the ARM case is that their /proc/cpuinfo isn't
> > sufficient to identify their PMU. And they don't have a cpuid like instruction
> > at all.
> > 
> > > > For the cpu you can obviously just detect what processor you're on with
> > > > cpuid or whatever, but it's a bit of a hack. And that really doesn't
> > > > work for non-cpu PMUs.
> > > 
> > > why is it a hack to use cpuid?
> > 
> > I agree, for x86 cpuid is perfectly fine, as would /proc/cpuinfo be, I suspect
> > that just the model number is sufficient in most cases, even for uncore stuff.
>  
> What about things on PCI? Other strange buses?
> 
> As long as everything's in /sys then it should be _possible_ for 
> userspace to work out what's what, but it's going to end up with a bunch 
> of detection logic and heuristics in the library.
> 
> At which point you've just rewritten libpfm4.

Exactly - PMUs enumerated in /sys should be self-identifying, it's a 
hardware topology after all ...

Anytime userspace is forced to look into /proc, or into weird places in 
/sys it's a FAIL really.

perf ABIs want to be self-identifying and self-sufficient, anytime 
userspace is forced to look elsewhere it adds another source of fragility.

And duplication with something that is 'already in /proc' is not a problem 
_at all_, these are computers that provide us different views into the 
same physical reality with dozens of different abstractions, so 
duplication of information is natural and _good_.

Thanks,

	Ingo
