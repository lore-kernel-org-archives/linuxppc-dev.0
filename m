Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EEA61A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 16:59:19 +1000 (AEST)
Message-ID: <1431068357.9673.9.camel@ellerman.id.au>
Subject: Re: [PATCH 1/6] dump_stack: Support adding to the dump stack arch
 description
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 08 May 2015 16:59:17 +1000
In-Reply-To: <20150505141647.a1529e46f5ba42645264769c@linux-foundation.org>
References: <1430824337-15339-1-git-send-email-mpe@ellerman.id.au>
 <20150505141647.a1529e46f5ba42645264769c@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: tj@kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-05-05 at 14:16 -0700, Andrew Morton wrote:
> On Tue,  5 May 2015 21:12:12 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > Arch code can set a "dump stack arch description string" which is
> > displayed with oops output to describe the hardware platform.
> > +
> > +	len = strnlen(dump_stack_arch_desc_str, sizeof(dump_stack_arch_desc_str));
> > +	pos = len;
> > +
> > +	if (len)
> > +		pos++;
> > +
> > +	if (pos >= sizeof(dump_stack_arch_desc_str))
> > +		return; /* Ran out of space */
> > +
> > +	p = &dump_stack_arch_desc_str[pos];
> > +
> > +	va_start(args, fmt);
> > +	vsnprintf(p, sizeof(dump_stack_arch_desc_str) - pos, fmt, args);
> > +	va_end(args);
> 
> This code is almost race-free.  A (documented) smp_wmb() in here would
> make that 100%?
> 
> > +	if (len)
> > +		dump_stack_arch_desc_str[len] = ' ';
> > +}

On second thoughts I don't think it would.

It would order the stores in vsnprintf() vs the store of the space. The idea
being you never see a partially printed string. But for that to actually work
you need a barrier on the read side, and where do you put it?

The cpu printing the buffer could speculate the load of the tail of the buffer,
seeing something half printed from vsnprintf(), and then load the head of the
buffer and see the space, unless you order those loads.

So I don't think we can prevent a crashing cpu seeing a semi-printed buffer
without a lock, and we don't want to add a lock.

The other issue would be that a reader could miss the trailing NULL from the
vsnprintf() but see the space, meaning it would wander off the end of the
buffer. But the buffer's in BSS to start with, and we're careful not to print
off the end of it, so it should always be NULL terminated.

cheers
