Return-Path: <jdl@jdl.com>
From: jdl@freescale.com
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Date: Sat, 10 Sep 2005 07:52:11 -0500
Message-Id: <E1EE4q3-0004hi-RD@jdl.com>
Sender: Jon Loeliger <jdl@jdl.com>
Subject: Re: PATCH ppc Merge asm-ppc*/posix_types.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Fri, 09 Sep 2005 16:43:52 -0500 jdl at freescale.com wrote:
> >
> > +#ifdef __powerpc64__
> > +typedef unsigned long	__kernel_nlink_t;
> > +typedef int             __kernel_ipc_pid_t;
> > +typedef unsigned long	__kernel_size_t;
> > +typedef long		__kernel_ssize_t;
> > +typedef unsigned long	__kernel_old_dev_t;
> > +#else
> > +typedef unsigned short	__kernel_nlink_t;
> > +typedef short		__kernel_ipc_pid_t;
> > +typedef unsigned int	__kernel_size_t;
> > +typedef int		__kernel_ssize_t;
> > +typedef unsigned int	__kernel_old_dev_t;
> > +#endif
> 
> On 32 bit, int == long, so the last three could be removed from the ifdef
> by making them {unsigned }long ...

Yeah, I tried that too.  In the ppc32 tree, it just starts looking
nasty all over the place:

      CC      drivers/pci/pci-driver.o
    fs/proc/base.c: In function `seccomp_write':
    fs/proc/base.c:932: warning: comparison of distinct pointer types lacks a cast
    net/sunrpc/svcsock.c: In function `svc_sendto':
    net/sunrpc/svcsock.c:424: warning: unsigned int format, size_t arg (arg 4)
    net/sunrpc/svcsock.c: In function `svc_recvfrom':
    net/sunrpc/svcsock.c:477: warning: unsigned int format, size_t arg (arg 4)

Lots of others just like it:

      CC      lib/klist.o
    net/core/dev.c: In function `dev_ifsioc':
    net/core/dev.c:2293: warning: comparison of distinct pointer types lacks a cast
    net/core/dev.c:2304: warning: comparison of distinct pointer types lacks a cast

Pick your favorite subsystem! :-)

I opted to maintain current breakage rather than try to
fix anything and introduce new breakage. :-)

I think that the approach we're taking here of placing
the related-but-differing-by-a-__powerpc64__ concepts as
close to each other as possible is a good one.  In particular
it calls attention to it, and causes people to wonder "Why
is _that_ there?  Why don't we just combine it like so..."
And we probably should.  It is just biting off more than
we likely should at this step.  Later, yes.

jdl

PS -Sorry about breaking threading; different MUA here.
