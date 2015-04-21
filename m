Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0090.hostedemail.com
 [216.40.44.90])
 by lists.ozlabs.org (Postfix) with ESMTP id ED6F61A03AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 23:25:45 +1000 (AEST)
Date: Tue, 21 Apr 2015 09:25:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC] powerpc/ftrace: add powerpc timebase as a trace
 clock source
Message-ID: <20150421092541.295dd72b@gandalf.local.home>
In-Reply-To: <1429614216-30538-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
References: <1429614216-30538-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Apr 2015 16:33:36 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Add a new powerpc-specific trace clock using the timebase register,
> similar to x86-tsc. This gives us a fast, monotonic, cross-cpu clock
> for trace entries and can be used to correlate events across cpus as
> well as across hypervisor and guest (assuming it is not a migrated guest
> with a non-zero tb_offset).
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> I have followed the approach used by x86-tsc here, but we could get rid of
> trace_clock.c if we directly use get_tb() with perhaps the notrace annotation.
> Would that be preferable?
> 

Probably. But all clocks used by tracing should be marked by notrace.
Don't just wrap it with a notrace. But looking at the code, it seems
that get_tb() is a static inline, which wont work as a pointer. Seems
you still need the indirect function call.

Note, all "inline" functions are notrace by default, so you do not need
to add any notrace annotation to an inlined function.

-- Steve
