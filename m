Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5678B1A0221
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 15:34:22 +1000 (EST)
Message-ID: <1403588053.4587.160.camel@pasglop>
Subject: Re: [PATCH] powerpc: Fix build warning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 24 Jun 2014 15:34:13 +1000
In-Reply-To: <53A90718.4050401@roeck-us.net>
References: <1402677499-28289-1-git-send-email-linux@roeck-us.net>
 <1403584501.4587.153.camel@pasglop> <53A90718.4050401@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-06-23 at 22:05 -0700, Guenter Roeck wrote:
> On 06/23/2014 09:35 PM, Benjamin Herrenschmidt wrote:
> > On Fri, 2014-06-13 at 09:38 -0700, Guenter Roeck wrote:
> >> If compiled with W=1, the following warning is seen in powerpc builds.
> >>
> >> arch/powerpc/kernel/smp.c:750:18: warning:
> >> 	type qualifiers ignored on function return type
> >> static const int powerpc_smt_flags(void)
> >>                   ^
> >>
> >> This is caused by a function returning 'const int', which doesn't
> >> make sense to gcc. Drop 'const' to fix the problem.
> >
> > This breaks the 64-bit build:
> >
> > arch/powerpc/kernel/smp.c:764:2: error: initialization from incompatible pointer type [-Werror]
> > arch/powerpc/kernel/smp.c:764:2: error: (near initialization for 'powerpc_topology[0].sd_flags') [-Werror]
> >
> > It appears that the generic definition in sched.h has this function
> > defined as const int, so that needs to be fixed too along with all
> > instances in all archs.
> >
> 
> https://lkml.org/lkml/2014/6/12/743

Won't the patch above break powerpc then ? IE. The functions signature
won't match anymore ... /me thinks you probably need to fix them all
at once.

Cheers,
Ben.
