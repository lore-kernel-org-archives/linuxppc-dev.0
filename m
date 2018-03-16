Return-Path: <srs1=dc9a=kernel.org==p2sp=gg=goodmis.org=rostedt@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [103.22.144.68])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402p6Z4vsgzF189
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 01:40:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 402p6R61z8z8tQL
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 01:40:47 +1100 (AEDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 402p6G75FTz9sQs
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2018 01:40:34 +1100 (AEDT)
Date: Fri, 16 Mar 2018 10:40:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [RFC PATCH 1/2] ftrace: Allow arches to opt-out of static ftrace
Message-ID: <20180316104030.0df39af7@gandalf.local.home>
In-Reply-To: <20180316134633.10584-1-mpe@ellerman.id.au>
References: <20180316134633.10584-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 17 Mar 2018 00:46:32 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> There is a small but non-zero amount of code required by arches to
> suppory non-dynamic (static) ftrace, and more importantly there is the
> added work of testing both configurations.
> 
> There are also almost no down sides to dynamic ftrace once it's well
> tested, other than a small increase in code/data size.
> 
> So give arches the option to opt-out of supporting static ftrace.
> 
> This is implemented as a DYNAMIC_FTRACE_CHOICE option, which controls
> whether DYNAMIC_FTRACE is presented as a user-selectable option or if
> it is just enabled based on its dependencies being enabled (because
> it's already default y).
> 
> Then the CHOICE option depends on an arch *not* selecting
> HAVE_DYNAMIC_FTRACE_ONLY. This would be more natural in reverse, as a
> HAVE_STATIC_FTRACE option, but that would require updating every arch.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Why not just add in arch/powerpc/Kconfig:

config PPC
	[..]
	select DYNAMIC_FTRACE			if FUNCTION_TRACER

?

It seems to work for me.

-- Steve
