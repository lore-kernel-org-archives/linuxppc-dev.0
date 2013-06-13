Return-Path: <michael@ellerman.id.au>
Message-ID: <1371133862.23094.15.camel@concordia>
Subject: Re: [PATCH] powerpc: Fix stack overflow crash in resume_kernel when
 ftracing
From: Michael Ellerman <michael@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 14 Jun 2013 00:31:02 +1000
In-Reply-To: <1371127506.9844.275.camel@gandalf.local.home>
References: <1371121496-16095-1-git-send-email-michael@ellerman.id.au>
 <1371127506.9844.275.camel@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-06-13 at 08:45 -0400, Steven Rostedt wrote:
> On Thu, 2013-06-13 at 21:04 +1000, Michael Ellerman wrote:
> 
> > Although that should be sufficient to fix the bug, we also mark the
> > runlatch routines as notrace. They are called very early in the
> > exception entry and we are asking for trouble tracing them. They are
> > also fairly uninteresting and tracing them just adds unnecessary
> > overhead.
> 
> Note, I usually lean towards tracing everything that can be traced, and
> only adding notrace to things that will actually cause a crash. If you
> don't like them to be traced, you can always do:

Yeah fair enough. In this case I think we don't want to trace it.
Although it doesn't cause a crash right now (at least after part 1 of
this patch), it's being called at a time when things are fragile, and
it's possible we could get bitten again some other way if the
surrounding code changes.


> echo '*__ppc64_runlatch_*'
> > /sys/kernel/debug/tracing/set_ftrace_notrace
> 
> and that will keep them from being traced. You can also add it to the
> kernel command line with: ftrace_notrace=*__ppc64_runlatch_* which will
> also disable them on boot up.
> 
> Also trace-cmd has:
> 
> trace-cmd record -p function_graph -n '*__ppc64_runlatch_*'
> 
> that will do the same thing.
> 
> Hmm, I should add a way to disable things that are usually considered
> noise. Perhaps add something like:
> 
> 
> FTRACE_DEFAULT_OFF(__ppc64_runlatch_on);
> 
> That adds the function to a different section that places it into
> another file that keeps it from being traced, but can be enabled when
> you want it to.

Yeah that would be cool.

Personally I'm just using shell scripts that poke the files in sysfs,
and I'm often running on different boxes, so the more that just works
without extra config by me the better.

cheers
