Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-04.nyroc.rr.com (ms-smtp-04.nyroc.rr.com [24.24.2.58])
	by ozlabs.org (Postfix) with ESMTP id DA6F267B31
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 04:04:22 +1000 (EST)
Date: Wed, 10 May 2006 14:04:18 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Richard Henderson <rth@twiddle.net>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <20060510154702.GA28938@twiddle.net>
Message-ID: <Pine.LNX.4.58.0605101400530.20305@gandalf.stny.rr.com>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510154702.GA28938@twiddle.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	t@twiddle.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 10 May 2006, Richard Henderson wrote:

> On Wed, May 10, 2006 at 02:03:59PM +1000, Paul Mackerras wrote:
> > With this patch, 64-bit powerpc uses __thread for per-cpu variables.
>
> How do you plan to address the compiler optimizing
>
> 	__thread int foo;
> 	{
> 	  use(foo);
> 	  schedule();
> 	  use(foo);
> 	}
>
> into
>
> 	{
> 	  int *tmp = &foo;	// tls arithmetic here
> 	  use(*tmp);
> 	  schedule();
> 	  use(*tmp);
> 	}
>
> Across the schedule, we may have changed cpus, making the cached
> address invalid.
>

If you mean use(foo) is the same as per_cpu(foo), I can't see the compile
optimizing this:

+#define per_cpu(var, cpu)                                      \
+       (*(__typeof__(&per_cpu__##var))({                       \
+               void *__ptr;                                    \
+               asm("addi %0,%1,per_cpu__"#var"@tprel"          \
+                   : "=b" (__ptr)                              \
+                   : "b" (paca[(cpu)].thread_ptr));            \
+               __ptr;                                          \
+       }))


Anyway, per_cpu variables are usually used with preemption turned off and
no need to schedule.

-- Steve
