Return-Path: <anton@ozlabs.org>
Date: Wed, 25 Aug 2010 11:51:12 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Check end of stack canary at oops time
Message-ID: <20100825015112.GF28360@kryten>
References: <20100824231528.GC28360@kryten>
	<1282699778.21145.54.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1282699778.21145.54.camel@concordia>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi,

> The check for init is just because we haven't set the magic value for
> init's stack right? But we could.

Yeah, it's similar to what x86 are doing now:


commit 0e7810be30f66e9f430c4ce2cd3b14634211690f
Author: Jan Beulich <JBeulich@novell.com>
Date:   Fri Nov 20 14:00:14 2009 +0000

    x86: Suppress stack overrun message for init_task
    
    init_task doesn't get its stack end location set to
    STACK_END_MAGIC, and hence the message is confusing
    rather than helpful in this case.


Adding it directly to init_task would be nice but I suspect we'd
either have to make assumptions about end_of_stack in our code or move the
canary into the thread_info (so we can statically allocate it via
INIT_THREAD_INFO()) or do it at runtime somewhere, hopefully early enough that
we couldn't take an oops.

Anton
