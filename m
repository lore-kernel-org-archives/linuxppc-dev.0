Return-Path: <paubert@iram.es>
Received: from torres.puc.rediris.es (unknown [IPv6:2001:720:418:ca00::9])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ED4D4B6EEB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 May 2012 03:06:28 +1000 (EST)
Date: Fri, 25 May 2012 18:45:51 +0200
From: Gabriel Paubert <paubert@iram.es>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: pread() and pwrite() system calls
Message-ID: <20120525164550.GA32406@visitor2.iram.es>
References: <AE90C24D6B3A694183C094C60CF0A2F6026B6F26@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B6F26@saturn3.aculab.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 25, 2012 at 02:29:06PM +0100, David Laight wrote:
> We have a system with linux 2.6.32 and the somewhat archaic
> uClibc 0.9.27 (but I'm not sure the current version is
> any better, and I think there are binary compatibility
> if we update).
> 
> I've just discovered that pread() is 'implemented'
> by using 3 lseek() system calls and read().
> (the same is true for the 64bit versions).
> 
> I thought that pread() was supposed to be atomic
> (so usable concurrently by multiple threads) which
> means that this implementation is completely broken.
> 
> I've not looked to see what glibc does.
> 
> I can see that part of the problem is the alignment
> of the 64bit value on the argument list of syscall()
> (when the register save area is cast to a sycall
> argument structure).
> But it also looks as though the uClibc syscall()
> stub can only pass 5 arguments in registers, and
> pread() (with an aligned 64bit offset) requires 6.
> 
> The ucLibc source seems to be predicated by __NR_pread,
> but if that were defined it would try to call
> __syscall_pread() and I can't find that anywhere.
> 
> A special pread/pwrite asm stub that just copies
> r7 to r0 could be used.
> 
> Would it be enough to do:
> syscall_pread_pwrite:
> 	mov 0,7
> 	sc
> 	blr
> and handle the -ve -> errno in C?

Huh? Won't fly, r0 is used for the system call number!

On the other hand, I believed PPC had no problems passing
up to 8 32 bit arguments in registers (r3 to r10), but
I may be confusing with the standard ABI for function calls.

Hmm, a quick look at kernel/entry_32.s shows that it should 
be able to use at least r3 to r8, which should be sufficient.

I think that it is an uClibc problem.

	Gabriel
