Return-Path: <sjmunroe@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F33C67A3A
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Nov 2006 09:57:04 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA1Mv05h019251
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 17:57:00 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA1Mv0ah240550
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 17:57:00 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA1Mv0AC024247
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 17:57:00 -0500
In-Reply-To: <1162420552.25682.471.camel@localhost.localdomain>
Subject: Re: glibc-2.5 test suite hangs/crashes the machine
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF1858F563.F89FF725-ON86257219.007D5B13-86257219.007E0EB5@us.ibm.com>
From: Steve Munroe <sjmunroe@us.ibm.com>
Date: Wed, 1 Nov 2006 16:56:53 -0600
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Jeff Bailey <jbailey@ubuntu.com>,
	Fabio Massimo Di Nitto <fabbione@ubuntu.com>,
	Paul Mackerras <paulus@samba.org>, Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 11/01/2006
04:35:52 PM:

>
> > The tst-robustpi# test are exercising the new PTHREAD_MUXTEX_ROBUST
api,
> > with PTHREAD_PRIO_INHERIT attribute.
> >
> > The fuxtex word seems to include the waiters TID, I don't know if the
> > kernel cares about this or not.
>
> Ok, well, we have seen a few issues so far with these. 2 are kernel
> issues, but one might not be:
>
>  - kernels 2.6.15 .. .17 at least it seems wire the robust futex
> syscalls on powerpc without properly implementing the support, which can
> cause hangs in process exit. Do you have any way to "blacklist" kernels
> in glibc ?
>
>From libc/sysdeps/unix/sysv/linux/kernel-features.h

/* Support for inter-process robust mutexes was added in 2.6.17.  */
#if __LINUX_KERNEL_VERSION >= 0x020611
# define __ASSUME_SET_ROBUST_LIST       1
#endif

/* Support for PI futexes was added in 2.6.18.  */
#if __LINUX_KERNEL_VERSION >= 0x020612
# define __ASSUME_FUTEX_LOCK_PI 1
#endif

So I need to delay __ASSUME_SET_ROBUST_LIST to 2.6.18 for __powerpc__ ?

What about __ASSUME_FUTEX_LOCK_PI ?

>  - kernel 2.6.18 and current git until yesterday (fix got in today) has
> a bug if you manage to pass a wrong futex with a non-aligned atomic
> value, it will possibly oops the kernel. With the fix, it will return an
> error.
>
> Now what seems to be a glibc issue:
>
>  - I've had the tst-robustpi# tests (in fact the very first one, I
> haven't tested the others) die on me with a SIGBUS caused by glibc
> trying to do a lwarx/starx. on an odd address.
>
Rayn reminded me of a bug where the new robust code did not account for the
fact that the TID was not at the same place as i386. I think Ryan has a
patch.

Steven J. Munroe
Linux on Power Toolchain Architect
IBM Corporation, Linux Technology Center
