Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 47112B6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2012 18:29:51 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 10709-01 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 29 May 2012 09:29:40 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: pread() and pwrite() system calls
Date: Tue, 29 May 2012 09:28:55 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6F29@saturn3.aculab.com>
In-Reply-To: <20120525164550.GA32406@visitor2.iram.es>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Gabriel Paubert" <paubert@iram.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > A special pread/pwrite asm stub that just copies
> > r7 to r0 could be used.
> >=20
> > Would it be enough to do:
> > syscall_pread_pwrite:
> > 	mov 0,7
> > 	sc
> > 	blr
> > and handle the -ve -> errno in C?
>=20
> Huh? Won't fly, r0 is used for the system call number!

I was copying that from r7!
Actually I have a much better stub by copying the one
used for mmap().
The system call itself is fine.
Using the system call almost halved the time taken
for a 4-byte read.

> On the other hand, I believed PPC had no problems passing
> up to 8 32 bit arguments in registers (r3 to r10), but
> I may be confusing with the standard ABI for function calls.
>=20
> Hmm, a quick look at kernel/entry_32.s shows that it should=20
> be able to use at least r3 to r8, which should be sufficient.
>=20
> I think that it is an uClibc problem.

True, in that it isn't a kernel bug.
OTOH the kernel is likely to get blamed for non-atomic pread.
I've found the same user-space code in newlib as well.
glibc may be ok, some code I've found implies it only
uses the 'emulation' when the system call returns ENOSYS.

	David
