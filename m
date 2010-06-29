Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ABC82B6EEC
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 11:19:00 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5T1GOjR010845
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 11:16:24 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5T1IxN51183902
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 11:18:59 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5T1IwMx005447
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 11:18:59 +1000
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH 01/40] ftrace syscalls: don't add events for unmapped
	syscalls
From: Ian Munsie <imunsie@au1.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
In-reply-to: <1277305339.9181.33.camel@gandalf.stny.rr.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-2-git-send-email-imunsie@au1.ibm.com>
	<1277305339.9181.33.camel@gandalf.stny.rr.com>
Date: Tue, 29 Jun 2010 11:18:38 +1000
Message-Id: <1277773447-sup-8783@au1.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Steven Rostedt's message of Thu Jun 24 01:02:19 +1000 2010:
> > diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> > index 34e3580..82246ce 100644
> > --- a/kernel/trace/trace_syscalls.c
> > +++ b/kernel/trace/trace_syscalls.c
> > @@ -431,6 +431,14 @@ void unreg_event_syscall_exit(struct ftrace_event_call *call)
> >  int init_syscall_trace(struct ftrace_event_call *call)
> >  {
> >      int id;
> > +    int num;
> > +
> > +    num = ((struct syscall_metadata *)call->data)->syscall_nr;
> > +    if (num < 0 || num >= NR_syscalls) {
> > +        pr_debug("syscall %s metadata not mapped, disabling ftrace event\n",
> > +                ((struct syscall_metadata *)call->data)->name);
> > +        return -ENOSYS;
> > +    }
> 
> Perhaps this should be:
> 
>     if (WARN_ON_ONCE(num < 0 || num >= NR_syscalls)
>         return -ENOSYS;
> 
> -- Steve


Hi Steven,

I don't think this should produce a warning - it signifies that a
syscall defined in the code has not successfully matched a syscall at
boot.

That may signify the matching failed, but it may just as likely signify
that the syscall isn't used on that arch (for instance, if an arch uses
an arch specific implementation in favour of a generic implementation,
or doesn't implement a particular syscall at all that is defined in the
generic code).

The problem case is actually the other way around - when a syscall
number from an arch's syscall table has not successfully mapped to some
syscall meta-data. Patch #37 prints out those cases with KERN_DEBUG so
booting a kernel with loglevel=8 can track them down.

This pr_debug may still be useful, for example to help locate unused
syscalls which can be removed if no arch uses them.

Cheers,
-Ian
