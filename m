Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4563E1A0C16
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 15:18:01 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 23 Apr 2015 10:47:57 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4FCC11258056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 10:49:52 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3N5Hsst57475326
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 10:47:54 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3N4rDgP016280
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 10:23:14 +0530
Date: Thu, 23 Apr 2015 10:47:32 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH RFC] powerpc/ftrace: add powerpc timebase as a trace
 clock source
Message-ID: <20150423051732.GB14738@naverao1-tp.in.ibm.com>
References: <1429614216-30538-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20150421092541.295dd72b@gandalf.local.home>
 <20150422051855.GE2327@naverao1-tp.ibm.com>
 <1429758884.4672.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1429758884.4672.4.camel@ellerman.id.au>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/04/23 01:14PM, Michael Ellerman wrote:
> On Wed, 2015-04-22 at 10:48 +0530, Naveen N. Rao wrote:
> > On 2015/04/21 09:25AM, Steven Rostedt wrote:
> > > On Tue, 21 Apr 2015 16:33:36 +0530
> > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > > 
> > > > Add a new powerpc-specific trace clock using the timebase register,
> > > > similar to x86-tsc. This gives us a fast, monotonic, cross-cpu clock
> > > > for trace entries and can be used to correlate events across cpus as
> > > > well as across hypervisor and guest (assuming it is not a migrated guest
> > > > with a non-zero tb_offset).
> > > > 
> > > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > > ---
> > > > I have followed the approach used by x86-tsc here, but we could get rid of
> > > > trace_clock.c if we directly use get_tb() with perhaps the notrace annotation.
> > > > Would that be preferable?
> > > > 
> > > 
> > > Probably. But all clocks used by tracing should be marked by notrace.
> > > Don't just wrap it with a notrace. But looking at the code, it seems
> > > that get_tb() is a static inline, which wont work as a pointer. Seems
> > > you still need the indirect function call.
> > > 
> > > Note, all "inline" functions are notrace by default, so you do not need
> > > to add any notrace annotation to an inlined function.
> > 
> > Steve,
> > Thanks for the clarification - the current approach is better in that 
> > case.
> > 
> > Paul, Mike,
> > Can you please let me know your thoughts on this?
> 
> What is the value in adding a powerpc specific clock, which requires educating
> people to use it, vs just using the global clock?

Hi Michael,
There are two reasons:
- One, using the timebase register gives us a very fast (just one 
  instruction) hardware clock source for trace entries compared to the 
  global clock.
- Two, using the timebase values allows us to correlate trace events 
  across hypervisor and guest, which is not possible using the other 
  trace clocks. [With migrated guests, there could be a non-zero 
  tb_offset which we may also want to make available to userspace in 
  some manner. Any suggestions?]

This will show up as an additional trace clock and can be selected if 
one wishes to use it. As an example:

[root@rhel7-img ~]# cd /sys/kernel/debug/tracing
[root@rhel7-img tracing]# cat trace_clock
[local] global counter uptime perf mono ppc-tb
[root@rhel7-img tracing]# head -30 trace
# tracer: nop
#
# entries-in-buffer/entries-written: 534/534   #P:4
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
           tuned-1080  [003] ....  1108.294606: sys_select -> 0x0
           tuned-1080  [003] ....  1108.294655: sys_select(n: 0, inp: 0, outp: 0, exp: 0, tvp: 3fff9b7fcdf0)
            bash-2732  [001] ....  1108.336317: sys_write -> 0x6
            bash-2732  [001] ....  1108.336321: sys_dup2(oldfd: a, newfd: 1)
            bash-2732  [001] ....  1108.336323: sys_dup2 -> 0x1
            bash-2732  [001] ....  1108.336327: sys_fcntl(fd: a, cmd: 1, arg: 0)
            bash-2732  [001] ....  1108.336328: sys_fcntl -> 0x1
            bash-2732  [001] ....  1108.336330: sys_close(fd: a)
            bash-2732  [001] ....  1108.336330: sys_close -> 0x0
            bash-2732  [001] ....  1108.336340: sys_rt_sigprocmask(how: 0, nset: 0, oset: 10146e48, sigsetsize: 8)
            bash-2732  [001] ....  1108.336341: sys_rt_sigprocmask -> 0x0
            bash-2732  [001] ....  1108.336342: sys_rt_sigaction(sig: 2, act: 3fffc17d8e20, oact: 3fffc17d8d80, sigsetsize: 8)
            bash-2732  [001] ....  1108.336343: sys_rt_sigaction -> 0x0
            bash-2732  [001] ....  1108.336352: sys_rt_sigprocmask(how: 0, nset: 0, oset: 10146e48, sigsetsize: 8)
            bash-2732  [001] ....  1108.336352: sys_rt_sigprocmask -> 0x0
            bash-2732  [001] ....  1108.336476: sys_write(fd: 1, buf: 3fff7f370000, count: 2d)
            bash-2732  [001] ....  1108.336484: sys_write -> 0x2d
            bash-2732  [001] ....  1108.336512: sys_rt_sigprocmask(how: 0, nset: 3fffc17d7c40, oset: 3fffc17d7cc0, sigsetsize: 8)
            bash-2732  [001] ....  1108.336513: sys_rt_sigprocmask -> 0x0
[root@rhel7-img tracing]# echo ppc-tb > trace_clock
[root@rhel7-img tracing]# cat trace_clock
local global counter uptime perf mono [ppc-tb]
[root@rhel7-img tracing]# echo 0 > trace
[root@rhel7-img tracing]# head -30 trace
# tracer: nop
#
# entries-in-buffer/entries-written: 396/396   #P:4
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
            bash-2732  [002] .... 34405585249004: sys_write -> 0x7
            bash-2732  [002] .... 34405585251162: sys_dup2(oldfd: a, newfd: 1)
            bash-2732  [002] .... 34405585252104: sys_dup2 -> 0x1
            bash-2732  [002] .... 34405585253774: sys_fcntl(fd: a, cmd: 1, arg: 0)
            bash-2732  [002] .... 34405585254385: sys_fcntl -> 0x1
            bash-2732  [002] .... 34405585255051: sys_close(fd: a)
            bash-2732  [002] .... 34405585255589: sys_close -> 0x0
            bash-2732  [002] .... 34405585260898: sys_rt_sigprocmask(how: 0, nset: 0, oset: 10146e48, sigsetsize: 8)
            bash-2732  [002] .... 34405585261482: sys_rt_sigprocmask -> 0x0
            bash-2732  [002] .... 34405585262339: sys_rt_sigaction(sig: 2, act: 3fffc17d8e20, oact: 3fffc17d8d80, sigsetsize: 8)
            bash-2732  [002] .... 34405585262927: sys_rt_sigaction -> 0x0
            bash-2732  [002] .... 34405585267215: sys_rt_sigprocmask(how: 0, nset: 0, oset: 10146e48, sigsetsize: 8)
            bash-2732  [002] .... 34405585267690: sys_rt_sigprocmask -> 0x0
            bash-2732  [002] .... 34405585345924: sys_write(fd: 1, buf: 3fff7f370000, count: 2d)
            bash-2732  [002] .n.. 34405585350359: sys_write -> 0x2d
            bash-2732  [002] .... 34405585428096: sys_rt_sigprocmask(how: 0, nset: 3fffc17d7c40, oset: 3fffc17d7cc0, sigsetsize: 8)
            bash-2732  [002] .... 34405585447011: sys_rt_sigprocmask -> 0x0
            bash-2732  [002] .... 34405585447956: sys_ioctl(fd: ff, cmd: 80047476, arg: 3fffc17d7c08)
            bash-2732  [002] .... 34405585449451: sys_ioctl -> 0x0


- Naveen
