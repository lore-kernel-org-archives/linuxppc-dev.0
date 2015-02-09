Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x232.google.com (mail-wi0-x232.google.com
 [IPv6:2a00:1450:400c:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 31E971A0414
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 00:26:05 +1100 (AEDT)
Received: by mail-wi0-f178.google.com with SMTP id hm9so6004514wib.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2015 05:26:01 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 9 Feb 2015 14:25:57 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/3] perf/e6500: Make event translations available in sysfs
Message-ID: <20150209132557.GA8099@gmail.com>
References: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
 <1423262636-12053-2-git-send-email-tom.huynh@freescale.com>
 <20150209100242.GM23123@twins.programming.kicks-ass.net>
 <20150209100738.GA5461@gmail.com>
 <20150209121132.GB3952@krava.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150209121132.GB3952@krava.redhat.com>
Cc: Tom Huynh <tom.huynh@freescale.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, acme@kernel.org,
 Andi Kleen <andi@firstfloor.org>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, mingo@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Jiri Olsa <jolsa@redhat.com> wrote:

> On Mon, Feb 09, 2015 at 11:07:38AM +0100, Ingo Molnar wrote:
> > 
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Fri, Feb 06, 2015 at 04:43:54PM -0600, Tom Huynh wrote:
> > > >  arch/powerpc/perf/e6500-events-list.h         | 289 ++++++++++++++++++++++++++
> > > 
> > > That's a lot of events to stuff in the kernel, would a 
> > > userspace list not be more convenient?
> > > 
> > > ISTR there being various discussions on providing support 
> > > for that in tools/perf, Jiri?
> > 
> > As long as it's in a single well organized place in tools/, 
> > I'd be fine with that solution as well.
> > 
> > What doesn't work very well is disjunct, disorganized, 
> > inconsistent event descriptions all across the tooling and 
> > platform landscape - putting static tables into sysfs is a 
> > marked improvement over that, despite its memory usage.
> 
> the last version is in here:
> http://marc.info/?l=linux-kernel&m=140676269017820&w=2
> 
> AFAIK Andi is setting up the download area as discussed 
> in the thread and should repost at some point

I'll NAK any external 'download area' (and I told that Andi 
before): tools/perf/event-tables/ or so is a good enough 
'download area' with fast enough update cycles.

If any 'update' of event descriptions is needed it can 
happen through the distro package mechanism, or via a 
simple 'git pull' if it's compiled directly.

Lets not overengineer this with any dependence on an 
external site and with a separate update mechanism - lets 
just get the tables into tools/ and see it from there...

Thanks,

	Ingo
