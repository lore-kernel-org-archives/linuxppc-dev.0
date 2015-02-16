Return-Path: <tom.huynh@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0108.outbound.protection.outlook.com [157.56.110.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B87741A0F26
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 03:12:40 +1100 (AEDT)
Date: Mon, 16 Feb 2015 10:10:45 -0600
From: Tom Huynh <tommy.xhuynh@gmail.com>
To: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 1/3] perf/e6500: Make event translations available in sysfs
Message-ID: <20150216161045.GA32564@rivendell>
References: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
 <1423262636-12053-2-git-send-email-tom.huynh@freescale.com>
 <20150209100242.GM23123@twins.programming.kicks-ass.net>
 <20150209100738.GA5461@gmail.com> <20150209121132.GB3952@krava.redhat.com>
 <20150209132557.GA8099@gmail.com> <20150209204019.GA13991@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20150209204019.GA13991@two.firstfloor.org>
Cc: Tom Huynh <tom.huynh@freescale.com>, Peter
 Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, acme@kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, paulus@samba.org,
 Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 09, 2015 at 09:40:19PM +0100, Andi Kleen wrote:
> > I'll NAK any external 'download area' (and I told that Andi 
> > before): tools/perf/event-tables/ or so is a good enough 
> > 'download area' with fast enough update cycles.
> 
> The proposal was to put it on kernel.org, similar to how
> external firmware blobs are distributed. CPU event lists
> are data sheets, so are like firmware. They do not
> follow the normal kernel code licenses. They are not 
> source code. They cannot be reviewed in the normal way.
 
Could you provide more details about the license and review 
concern? How are the event list files different from hardware-
specific information (e.g. reg mapping) in header files?

> > If any 'update' of event descriptions is needed it can 
> > happen through the distro package mechanism, or via a 
> > simple 'git pull' if it's compiled directly.
> > 
> > Lets not overengineer this with any dependence on an 
> > external site and with a separate update mechanism - lets 
> > just get the tables into tools/ and see it from there...
> 
> That experiment has been already done for oprofile,
> didn't work very well.

Please excuse my ignorance, could you say exactly what didn't
work well for oprofile?

Ingo's suggestion seems good to me because these event files 
will be transparent to the users, and it's just more 
convenient not having to go to a website to look for 
the event file that matches the machine to download.
The distro package or the perf make mechanism can put these
files into the appropriate directory. The users who are not
perf developers won't need to know about these files.

- Tom
