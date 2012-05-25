Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 9B598B6F13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2012 23:29:56 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 14616-05 for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 25 May 2012 14:29:49 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: pread() and pwrite() system calls
Date: Fri, 25 May 2012 14:29:06 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6F26@saturn3.aculab.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a system with linux 2.6.32 and the somewhat archaic
uClibc 0.9.27 (but I'm not sure the current version is
any better, and I think there are binary compatibility
if we update).

I've just discovered that pread() is 'implemented'
by using 3 lseek() system calls and read().
(the same is true for the 64bit versions).

I thought that pread() was supposed to be atomic
(so usable concurrently by multiple threads) which
means that this implementation is completely broken.

I've not looked to see what glibc does.

I can see that part of the problem is the alignment
of the 64bit value on the argument list of syscall()
(when the register save area is cast to a sycall
argument structure).
But it also looks as though the uClibc syscall()
stub can only pass 5 arguments in registers, and
pread() (with an aligned 64bit offset) requires 6.

The ucLibc source seems to be predicated by __NR_pread,
but if that were defined it would try to call
__syscall_pread() and I can't find that anywhere.

A special pread/pwrite asm stub that just copies
r7 to r0 could be used.

Would it be enough to do:
syscall_pread_pwrite:
	mov 0,7
	sc
	blr
and handle the -ve -> errno in C?

I've seen other parts of linux pass structures to
avoid issues with excessive number of arguments.
Unlike things like NetBSD amd64 which will read
additional args off the user stack (and has per-system
call stubs in libc so doesn't lose one argument).
(I rearranged the NetBSD amd64 kernel trap frame
layout so all the args ended up adjacent...)

	David
