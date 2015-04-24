Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B7EF1A0D6C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 18:09:16 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 24 Apr 2015 18:09:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9E4CF3578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 18:09:08 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3O890P644433462
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 18:09:08 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3O88YjK026322
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 18:08:35 +1000
Date: Fri, 24 Apr 2015 13:37:49 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] powerpc/ftrace: add powerpc timebase as a trace clock
 source
Message-ID: <20150424080749.GB32293@naverao1-tp.in.ibm.com>
References: <1429771504-32688-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20150423091003.168efa55@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150423091003.168efa55@gandalf.local.home>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/04/23 09:10AM, Steven Rostedt wrote:
> On Thu, 23 Apr 2015 12:15:04 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > diff --git a/arch/powerpc/include/asm/trace_clock.h b/arch/powerpc/include/asm/trace_clock.h
> > new file mode 100644
> > index 0000000..0b0d094
> > --- /dev/null
> > +++ b/arch/powerpc/include/asm/trace_clock.h
> > @@ -0,0 +1,27 @@
> > +/*
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License, version 2, as
> > + * published by the Free Software Foundation.
> > + *
> > + * Copyright (C) 2015 Naveen N. Rao, IBM Corporation
> > + */
> > +
> > +#ifndef _ASM_PPC_TRACE_CLOCK_H
> > +#define _ASM_PPC_TRACE_CLOCK_H
> > +
> > +#include <linux/compiler.h>
> > +#include <linux/types.h>
> > +
> > +#ifdef CONFIG_TRACE_CLOCK
> 
> You don't need this #if statement. What else is using this besides
> kernel/trace/trace.c, which selects TRACE_CLOCK if it is compiled.
> 
> If you were trying to match x86, where it has:
> 
> #ifdef CONFIG_X86_TSC
> 
> where you have CONFIG_TRACE_CLOCK. We needed the #ifdef because you
> can compile the x86 kernel without TSC support, and we did not want to
> export a tsc tracing clock if one did not exist.
> 
> And the only place that I see that even includes this header in ppc, is
> also only compiled if CONFIG_TRACE_CLOCK is selected.

Ah yes, agreed. I have removed it and seeing as CONFIG_TRACE_CLOCK is 
really for the generic clocks, I have moved the dependency on 
arch/powerpc/kernel/trace_clock.o to CONFIG_TRACING since that is what 
gates kernel/trace/trace.o

> 
> I'm fine with the change, just nuke the unnecessary #ifdef.

Thanks for the review!
- Naveen
 
