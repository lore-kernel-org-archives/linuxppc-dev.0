Return-Path: <vincent.weaver@maine.edu>
Received: from mail-ve0-f180.google.com (mail-ve0-f180.google.com
 [209.85.128.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A124E2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 01:15:12 +1000 (EST)
Received: by mail-ve0-f180.google.com with SMTP id pa12so4690946veb.39
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jul 2013 08:15:09 -0700 (PDT)
Date: Tue, 9 Jul 2013 11:20:50 -0400 (EDT)
From: Vince Weaver <vincent.weaver@maine.edu>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH v2 2/2] perf tools: Make Power7 events available for perf
In-Reply-To: <20130709033402.GA8543@concordia>
Message-ID: <alpine.DEB.2.10.1307091113010.675@vincent-weaver-1.um.maine.edu>
References: <1372170933-4538-1-git-send-email-runzhen@linux.vnet.ibm.com>
 <1372170933-4538-3-git-send-email-runzhen@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1306251240440.25443@pianoman.cluster.toy>
 <20130704125218.GA21134@concordia>
 <20130704125700.GM18898@dyad.programming.kicks-ass.net>
 <20130709012952.GA7185@concordia>
 <alpine.DEB.2.10.1307082204550.26280@vincent-weaver-1.um.maine.edu>
 <20130709033402.GA8543@concordia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, xiaoguangrong@linux.vnet.ibm.com,
 acme@redhat.com, paulus@samba.org, Runzhen Wang <runzhen@linux.vnet.ibm.com>,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 9 Jul 2013, Michael Ellerman wrote:

> On Mon, Jul 08, 2013 at 10:24:34PM -0400, Vince Weaver wrote:
> > why is it a hack to use cpuid?
> 
> Because you're assuming that the PMU the kernel has exposed is for the
> cpu you happen to be executing on.
> 
> But the real issue is with PMUs that are not in the CPU - there is no
> easy way for userspace to detect them and determine which event list it
> should be consulting.

what kind of devices are you talking about?  If they have 
kernel/perf_event support then they'd be putting a directory entry
with a unique name into /sys/bus/event_source/devices/, right?

> This whole thread is about making the event list not the kernel's job?

Yes.  This has been debated forever here; I'm firmly in the "event lists 
should be entirely in userspace" camp but that's not the majority 
position.

Hopefully everyone agrees though that including 100k+ of event lists in 
the kernel is a bit silly, especially as only a subset of people would ever 
use them.

There's the other issue that event lists are known to change due to bugs 
and whatnot (Intel likes to change things up every few months and silently 
change the event lists in their documentation).  It's a lot easier 
patching and distributing a new user-space event library [hours to days] 
then trying to get event list changes into the kernel, backported to 
stable, and then out into vendor kernels, and then on updated machines 
[weeks to never].

> The part that _is_ the kernels job is detecting the hardware and
> providing an API to access it. What I'm saying is that the kernel API
> should include some sort of identifier so that userspace can reliably
> determine the event list to use.

I'm just curious if you have a specific piece of hardware in mind that 
won't fit the current model or if this is a theoretical concern.

Vince
