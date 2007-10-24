Return-Path: <ddaney@avtrex.com>
Received: from smtp1.dnsmadeeasy.com (smtp1.dnsmadeeasy.com [205.234.170.144])
	by ozlabs.org (Postfix) with ESMTP id 89996DDF22
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Oct 2007 07:06:57 +1000 (EST)
Message-ID: <471FAC48.1070008@avtrex.com>
Date: Wed, 24 Oct 2007 13:34:16 -0700
From: David Daney <ddaney@avtrex.com>
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
Subject: Re: Apparent kernel bug with GDB on ppc405
References: <20071024194640.GB19691@waste.org>
In-Reply-To: <20071024194640.GB19691@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Matt Mackall wrote:
> I'm trying to debug a trivial statically-linked hello world program on
> a Xilinx PPC 405 and I'm seeing the following behavior:
> 
> With direct gdb on target, I can set a breakpoint at main, run, and
> the breakpoint is triggered.
> 
> With gdbserver and gdb with "target remote localhost:1234", the above
> still works.
> 
> With gdb on target redirected to a PC and tunneled back
> to the target, everything still works.
> 
> With gdb on a PC, execution continues past the breakpoint. Comparing
> the gdb protocol streams here and and on the previous (working) case
> are identical up to the point of hitting the breakpoint (which never
> happens in the latter case).
> 
> Raising the load on the PC to 4 and running gdb under nice -n 19 makes
> things work again. So this begins to look like a kernel cache or
> timing bug rather than a problem with the PC tool. It appears that the
> breakpoint written to the executable at continue time is not visible
> to the CPU at execute time.
> 
> My first suspicion was a dcache/icache coherency issue in
> copy_to_user_page, so I added flush_dcache_icache_page(page) here to
> no avail. On closer inspection, it looks like both icache and dcache
> are already being flushed by flush_icache_user_range().
> 

First of all I have never used a similar configuration so this may be 
totally off base.  But...

If the icache is virtually indexed, then I think there are only two ways 
to invalidate it.  The first is from the context of the debugged process 
where the page is mapped at the location the target program will see it. 
   If you try to invalidate from the context of the debugger, the page 
will most likely not be mapped at the virtual address of the target 
program so you might have to invalidate the *entire* icache.

David Daney
