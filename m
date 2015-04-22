Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C970B1A02D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 15:19:16 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 22 Apr 2015 10:49:13 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6F2123940053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 10:49:11 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3M5JAQt40173748
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 10:49:11 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3M5JA8p031546
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 10:49:10 +0530
Date: Wed, 22 Apr 2015 10:48:55 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] powerpc/ftrace: add powerpc timebase as a trace
 clock source
Message-ID: <20150422051855.GE2327@naverao1-tp.ibm.com>
References: <1429614216-30538-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20150421092541.295dd72b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150421092541.295dd72b@gandalf.local.home>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/04/21 09:25AM, Steven Rostedt wrote:
> On Tue, 21 Apr 2015 16:33:36 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > Add a new powerpc-specific trace clock using the timebase register,
> > similar to x86-tsc. This gives us a fast, monotonic, cross-cpu clock
> > for trace entries and can be used to correlate events across cpus as
> > well as across hypervisor and guest (assuming it is not a migrated guest
> > with a non-zero tb_offset).
> > 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> > I have followed the approach used by x86-tsc here, but we could get rid of
> > trace_clock.c if we directly use get_tb() with perhaps the notrace annotation.
> > Would that be preferable?
> > 
> 
> Probably. But all clocks used by tracing should be marked by notrace.
> Don't just wrap it with a notrace. But looking at the code, it seems
> that get_tb() is a static inline, which wont work as a pointer. Seems
> you still need the indirect function call.
> 
> Note, all "inline" functions are notrace by default, so you do not need
> to add any notrace annotation to an inlined function.

Steve,
Thanks for the clarification - the current approach is better in that 
case.

Paul, Mike,
Can you please let me know your thoughts on this?


- Naveen
