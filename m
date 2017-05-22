Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWKKZ3FH6zDqLK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 10:29:21 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id n23so16044954pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 17:29:21 -0700 (PDT)
Date: Mon, 22 May 2017 10:29:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Subject: Re: [RFC][PATCH] powerpc/64s: stop using r14 register
Message-ID: <20170522102905.32a5645f@roar.ozlabs.ibm.com>
In-Reply-To: <1495404559.3092.140.camel@au1.ibm.com>
References: <20170521140011.17548-1-npiggin@gmail.com>
 <1495404559.3092.140.camel@au1.ibm.com>
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

On Mon, 22 May 2017 08:09:19 +1000
Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:

> On Mon, 2017-05-22 at 00:00 +1000, Nicholas Piggin wrote:
> > I'd like to take over the r14 register for use as a per-cpu kernel
> > register similar to the way r13 is used for the paca.  
> 
> Why not use r13 instead ? We don't need to access the PACA that often
> from C code, I thought we could flip them...

It ended up being a bit too tricky to do it that way. We can't get
directly to per-CPU data from the per-cpu data offset in exception
entry code for a number of reasons. So we end up having to load the
paca first.

I looked at swapping r13 from paca to per-cpu offset at the same
time the stack is set up, so paca is used for early save areas then
per-cpu is used in C code. In practice it ended up getting too
tricky and fragile dealing with nested interrupts, machine checks,
etc.

I think it's something we might slowly work towards (consolidating
back to one fixed register), but as things are it didn't work well.

It's easy to drop the fixed r14 in future if we can. None of the
incidental asm users of r14 were complicating them by moving them
to another register.

Thanks,
Nick
