Return-Path: <vincent.weaver@maine.edu>
Received: from mail-vb0-f53.google.com (mail-vb0-f53.google.com
 [209.85.212.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F2032C02B9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 12:19:07 +1000 (EST)
Received: by mail-vb0-f53.google.com with SMTP id p12so4008355vbe.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jul 2013 19:19:04 -0700 (PDT)
Date: Mon, 8 Jul 2013 22:24:34 -0400 (EDT)
From: Vince Weaver <vincent.weaver@maine.edu>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH v2 2/2] perf tools: Make Power7 events available for perf
In-Reply-To: <20130709012952.GA7185@concordia>
Message-ID: <alpine.DEB.2.10.1307082204550.26280@vincent-weaver-1.um.maine.edu>
References: <1372170933-4538-1-git-send-email-runzhen@linux.vnet.ibm.com>
 <1372170933-4538-3-git-send-email-runzhen@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1306251240440.25443@pianoman.cluster.toy>
 <20130704125218.GA21134@concordia>
 <20130704125700.GM18898@dyad.programming.kicks-ass.net>
 <20130709012952.GA7185@concordia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: vincent.weaver@maine.edu, Peter Zijlstra <peterz@infradead.org>,
 Vince Weaver <vince@deater.net>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, acme@redhat.com, paulus@samba.org,
 xiaoguangrong@linux.vnet.ibm.com, Runzhen Wang <runzhen@linux.vnet.ibm.com>,
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

> On Thu, Jul 04, 2013 at 02:57:00PM +0200, Peter Zijlstra wrote:
> > 
> > Right; I think Stephane and Jiri are in favour of creating a 'new' project that
> > includes just the event definitions in a plain text format and a little library
> > with parser to be used by all interested parties.
> 
> OK that would be great.
> 
> The part that seems to be missing to make that work is we have no way of
> matching the PMU that appears in /sys with a list of events.
> 
> Eg. on my system I have /sys/bus/event_source/devices/cpu - but there's
> nothing in there to identify that it's a Sandy Bridge.

So something like they have on ARM?

vince@pandaboard:/sys/bus/event_source/devices$ ls -l
lrwxrwxrwx 1 root root 0 Jul  8 21:57 ARMv7 Cortex-A9 -> ../../../devices/ARMv7 Cortex-A9
lrwxrwxrwx 1 root root 0 Jul  8 21:57 breakpoint -> ../../../devices/breakpoint
lrwxrwxrwx 1 root root 0 Jul  8 21:57 software -> ../../../devices/software
lrwxrwxrwx 1 root root 0 Jul  8 21:57 tracepoint -> ../../../devices/tracepoint

> For the cpu you can obviously just detect what processor you're on with
> cpuid or whatever, but it's a bit of a hack. And that really doesn't
> work for non-cpu PMUs.

why is it a hack to use cpuid?

People have done event lists in userspace for years.  Why must it be the 
kernel's job?

Vince Weaver
vincent.weaver@maine.edu
http://www.eece.maine.edu/~vweaver/
