Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0110.outbound.protection.outlook.com [157.56.111.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D21E1A02F6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 08:39:53 +1100 (AEDT)
Date: Fri, 27 Mar 2015 16:34:24 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Tom Huynh <tommy.xhuynh@gmail.com>
Subject: Re: [PATCH 1/3] perf/e6500: Make event translations available in sysfs
Message-ID: <20150327163424.92d22b2e685a1f0bc4a7c651@freescale.com>
In-Reply-To: <20150216161045.GA32564@rivendell>
References: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
 <1423262636-12053-2-git-send-email-tom.huynh@freescale.com>
 <20150209100242.GM23123@twins.programming.kicks-ass.net>
 <20150209100738.GA5461@gmail.com>	<20150209121132.GB3952@krava.redhat.com>
 <20150209132557.GA8099@gmail.com>	<20150209204019.GA13991@two.firstfloor.org>
 <20150216161045.GA32564@rivendell>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Tom Huynh <tom.huynh@freescale.com>, mingo@redhat.com,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 acme@kernel.org, linux-kernel@vger.kernel.org,
 Andi Kleen <andi@firstfloor.org>, paulus@samba.org, Jiri
 Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

crickets.

How do we make progress in this area?

(a) can we assume Andi's json format is acceptable?  We would like
to know this so we don't have to reformat our data more than once.

(b) Would an acceptable interim resolution the 'download area'
problem be to take Andi's "perf: Add support for full Intel event
lists v8" and change the 'download' to refer to
tools/perf/event-tables/?

(c) If not, given we don't know how to get us out of the current
status quo, can this patchseries still be applied, given the
original complaint was the size of our events-list.h (whereas
power7-events-list.h is almost twice the size)?  If not, patch 3/3
in this series is still valid, no matter what, and it should still
be applied (let us know if we need to resubmit).

Thanks,

Kim


On Mon, 16 Feb 2015 10:10:45 -0600
Tom Huynh <tommy.xhuynh@gmail.com> wrote:

> On Mon, Feb 09, 2015 at 09:40:19PM +0100, Andi Kleen wrote:
> > > I'll NAK any external 'download area' (and I told that Andi 
> > > before): tools/perf/event-tables/ or so is a good enough 
> > > 'download area' with fast enough update cycles.
> > 
> > The proposal was to put it on kernel.org, similar to how
> > external firmware blobs are distributed. CPU event lists
> > are data sheets, so are like firmware. They do not
> > follow the normal kernel code licenses. They are not 
> > source code. They cannot be reviewed in the normal way.
>  
> Could you provide more details about the license and review 
> concern? How are the event list files different from hardware-
> specific information (e.g. reg mapping) in header files?
> 
> > > If any 'update' of event descriptions is needed it can 
> > > happen through the distro package mechanism, or via a 
> > > simple 'git pull' if it's compiled directly.
> > > 
> > > Lets not overengineer this with any dependence on an 
> > > external site and with a separate update mechanism - lets 
> > > just get the tables into tools/ and see it from there...
> > 
> > That experiment has been already done for oprofile,
> > didn't work very well.
> 
> Please excuse my ignorance, could you say exactly what didn't
> work well for oprofile?
> 
> Ingo's suggestion seems good to me because these event files 
> will be transparent to the users, and it's just more 
> convenient not having to go to a website to look for 
> the event file that matches the machine to download.
> The distro package or the perf make mechanism can put these
> files into the appropriate directory. The users who are not
> perf developers won't need to know about these files.
> 
> - Tom
