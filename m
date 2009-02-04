Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 87E40DDF06
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 02:36:45 +1100 (EST)
Date: Wed, 4 Feb 2009 18:36:43 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: =?utf8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 3/3] tracing: Tracers that use CALLER_ADDR macros
	should select FRAME_POINTER
Message-ID: <20090204153643.GA16681@oksana.dev.rtsoft.ru>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150840.GC30027@oksana.dev.rtsoft.ru>
	<c62985530902040726x34aeee7fr3b2937d898d3061e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <c62985530902040726x34aeee7fr3b2937d898d3061e@mail.gmail.com>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 04, 2009 at 04:26:15PM +0100, Frédéric Weisbecker wrote:
[...]
> > @@ -136,6 +138,7 @@ config SCHED_TRACER
> >        select TRACING
> >        select CONTEXT_SWITCH_TRACER
> >        select TRACER_MAX_TRACE
> > +       select FRAME_POINTER
> >        help
> >          This tracer tracks the latency of the highest priority task
> >          to be scheduled in, starting from the point it has woken up.
> > --
> 
> 
> Looks right.
> 
> BTW, how behaves builtin_return_address in case of !FRAME_POINTERS ?
> I guess it would only work with the first caller builtin_return_address(0)

It depends on the architecture. On PowerPC we always have frame pointers,
thus __builtin_return_address(1..) will always work. On x86 it won't work
that way.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
