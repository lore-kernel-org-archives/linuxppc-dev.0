Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 9 Mar 2005 12:03:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc64-dev <linuxppc64-dev@ozlabs.org>
Message-Id: <20050309120343.0c22eb0f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [RFC][PATCH] combining header files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I would just like to start a discussion about consolidating (some of) the
ppc and ppc64 header files.  As a starting point (am I am not saying that
this is the right way to go) the following patch replaces (semantically)
equivalent ppc64 headers files by just including the asm-ppc file.

We *could* use this method to make the journey incremental until there
are no nontrivial files left in asm-ppc64 ....

Diffstat looks like:
 asm-ppc/ipc.h         |    2
 asm-ppc64/ioctl.h     |   75 ---------------
 asm-ppc64/ioctls.h    |  115 ------------------------
 asm-ppc64/ipc.h       |   35 -------
 asm-ppc64/mman.h      |   53 -----------
 asm-ppc64/param.h     |   30 ------
 asm-ppc64/parport.h   |   19 ----
 asm-ppc64/poll.h      |   33 ------
 asm-ppc64/string.h    |   36 -------
 asm-ppc64/termbits.h  |  194 -----------------------------------------
 asm-ppc64/termios.h   |  236 --------------------------------------------------
 asm-ppc64/unaligned.h |   22 ----
 12 files changed, 12 insertions(+), 838 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus/include/asm-ppc/ipc.h linus-headers/include/asm-ppc/ipc.h
--- linus/include/asm-ppc/ipc.h	2003-09-24 10:56:02.000000000 +1000
+++ linus-headers/include/asm-ppc/ipc.h	2005-03-09 11:54:36.000000000 +1100
@@ -4,7 +4,7 @@
 /*
  * These are used to wrap system calls on PowerPC.
  *
- * See arch/ppc/kernel/syscalls.c for ugly details..
+ * See arch/ppc{,64}/kernel/syscalls.c for ugly details..
  */
 struct ipc_kludge {
 	struct msgbuf __user *msgp;
diff -ruNp linus/include/asm-ppc64/ioctl.h linus-headers/include/asm-ppc64/ioctl.h
--- linus/include/asm-ppc64/ioctl.h	2003-12-31 09:39:13.000000000 +1100
+++ linus-headers/include/asm-ppc64/ioctl.h	2005-03-09 01:10:54.000000000 +1100
@@ -1,74 +1 @@
-#ifndef _PPC64_IOCTL_H
-#define _PPC64_IOCTL_H
-
-
-/*
- * This was copied from the alpha as it's a bit cleaner there.
- *                         -- Cort
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
-#define _IOC_SIZEBITS	13
-#define _IOC_DIRBITS	3
-
-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits _IOC_NONE could be 0, but OSF/1 gives it a bit.
- * And this turns out useful to catch old ioctl numbers in header
- * files for us.
- */
-#define _IOC_NONE	1U
-#define _IOC_READ	2U
-#define _IOC_WRITE	4U
-
-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* provoke compile error for invalid uses of size argument */
-extern unsigned int __invalid_size_argument_for_IOC;
-#define _IOC_TYPECHECK(t) \
-       ((sizeof(t) == sizeof(t[1]) && \
-         sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
-         sizeof(t) : __invalid_size_argument_for_IOC)
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOR_BAD(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW_BAD(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR_BAD(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-/* used to decode them.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* various drivers, such as the pcmcia stuff, need these... */
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
-#endif /* _PPC64_IOCTL_H */
+#include <asm-ppc/ioctl.h>
diff -ruNp linus/include/asm-ppc64/ioctls.h linus-headers/include/asm-ppc64/ioctls.h
--- linus/include/asm-ppc64/ioctls.h	2003-04-03 08:55:29.000000000 +1000
+++ linus-headers/include/asm-ppc64/ioctls.h	2005-03-09 01:13:05.000000000 +1100
@@ -1,114 +1 @@
-#ifndef _ASM_PPC64_IOCTLS_H
-#define _ASM_PPC64_IOCTLS_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <asm/ioctl.h>
-
-#define FIOCLEX		_IO('f', 1)
-#define FIONCLEX	_IO('f', 2)
-#define FIOASYNC	_IOW('f', 125, int)
-#define FIONBIO		_IOW('f', 126, int)
-#define FIONREAD	_IOR('f', 127, int)
-#define TIOCINQ		FIONREAD
-#define FIOQSIZE        _IOR('f', 128, loff_t)
-
-#define TIOCGETP	_IOR('t', 8, struct sgttyb)
-#define TIOCSETP	_IOW('t', 9, struct sgttyb)
-#define TIOCSETN	_IOW('t', 10, struct sgttyb)	/* TIOCSETP wo flush */
-
-#define TIOCSETC	_IOW('t', 17, struct tchars)
-#define TIOCGETC	_IOR('t', 18, struct tchars)
-#define TCGETS		_IOR('t', 19, struct termios)
-#define TCSETS		_IOW('t', 20, struct termios)
-#define TCSETSW		_IOW('t', 21, struct termios)
-#define TCSETSF		_IOW('t', 22, struct termios)
-
-#define TCGETA		_IOR('t', 23, struct termio)
-#define TCSETA		_IOW('t', 24, struct termio)
-#define TCSETAW		_IOW('t', 25, struct termio)
-#define TCSETAF		_IOW('t', 28, struct termio)
-
-#define TCSBRK		_IO('t', 29)
-#define TCXONC		_IO('t', 30)
-#define TCFLSH		_IO('t', 31)
-
-#define TIOCSWINSZ	_IOW('t', 103, struct winsize)
-#define TIOCGWINSZ	_IOR('t', 104, struct winsize)
-#define	TIOCSTART	_IO('t', 110)		/* start output, like ^Q */
-#define	TIOCSTOP	_IO('t', 111)		/* stop output, like ^S */
-#define TIOCOUTQ        _IOR('t', 115, int)     /* output queue size */
-
-#define TIOCGLTC	_IOR('t', 116, struct ltchars)
-#define TIOCSLTC	_IOW('t', 117, struct ltchars)
-#define TIOCSPGRP	_IOW('t', 118, int)
-#define TIOCGPGRP	_IOR('t', 119, int)
-
-#define TIOCEXCL	0x540C
-#define TIOCNXCL	0x540D
-#define TIOCSCTTY	0x540E
-
-#define TIOCSTI		0x5412
-#define TIOCMGET	0x5415
-#define TIOCMBIS	0x5416
-#define TIOCMBIC	0x5417
-#define TIOCMSET	0x5418
-# define TIOCM_LE	0x001
-# define TIOCM_DTR	0x002
-# define TIOCM_RTS	0x004
-# define TIOCM_ST	0x008
-# define TIOCM_SR	0x010
-# define TIOCM_CTS	0x020
-# define TIOCM_CAR	0x040
-# define TIOCM_RNG	0x080
-# define TIOCM_DSR	0x100
-# define TIOCM_CD	TIOCM_CAR
-# define TIOCM_RI	TIOCM_RNG
-
-#define TIOCGSOFTCAR	0x5419
-#define TIOCSSOFTCAR	0x541A
-#define TIOCLINUX	0x541C
-#define TIOCCONS	0x541D
-#define TIOCGSERIAL	0x541E
-#define TIOCSSERIAL	0x541F
-#define TIOCPKT		0x5420
-# define TIOCPKT_DATA		 0
-# define TIOCPKT_FLUSHREAD	 1
-# define TIOCPKT_FLUSHWRITE	 2
-# define TIOCPKT_STOP		 4
-# define TIOCPKT_START		 8
-# define TIOCPKT_NOSTOP		16
-# define TIOCPKT_DOSTOP		32
-
-
-#define TIOCNOTTY	0x5422
-#define TIOCSETD	0x5423
-#define TIOCGETD	0x5424
-#define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TIOCSBRK	0x5427  /* BSD compatibility */
-#define TIOCCBRK	0x5428  /* BSD compatibility */
-#define TIOCGSID	0x5429  /* Return the session ID of FD */
-#define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
-#define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
-
-#define TIOCSERCONFIG	0x5453
-#define TIOCSERGWILD	0x5454
-#define TIOCSERSWILD	0x5455
-#define TIOCGLCKTRMIOS	0x5456
-#define TIOCSLCKTRMIOS	0x5457
-#define TIOCSERGSTRUCT	0x5458 /* For debugging only */
-#define TIOCSERGETLSR   0x5459 /* Get line status register */
-  /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
-# define TIOCSER_TEMT    0x01	/* Transmitter physically empty */
-#define TIOCSERGETMULTI 0x545A /* Get multiport config  */
-#define TIOCSERSETMULTI 0x545B /* Set multiport config */
-
-#define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
-#define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
-
-#endif /* _ASM_PPC64_IOCTLS_H */
+#include <asm-ppc/ioctls.h>
diff -ruNp linus/include/asm-ppc64/ipc.h linus-headers/include/asm-ppc64/ipc.h
--- linus/include/asm-ppc64/ipc.h	2004-05-30 11:50:26.000000000 +1000
+++ linus-headers/include/asm-ppc64/ipc.h	2005-03-09 01:15:40.000000000 +1100
@@ -1,34 +1 @@
-#ifndef __PPC64_IPC_H__
-#define __PPC64_IPC_H__
-
-/* 
- * These are used to wrap system calls on PowerPC.
- *
- * See arch/ppc64/kernel/syscalls.c for ugly details..
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-struct ipc_kludge {
-	struct msgbuf __user *msgp;
-	long msgtyp;
-};
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define SEMTIMEDOP	 4
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-#define IPCCALL(version,op)	((version)<<16 | (op))
-
-#endif /* __PPC64_IPC_H__ */
+#include <asm-ppc/ipc.h>
diff -ruNp linus/include/asm-ppc64/mman.h linus-headers/include/asm-ppc64/mman.h
--- linus/include/asm-ppc64/mman.h	2003-09-26 07:54:24.000000000 +1000
+++ linus-headers/include/asm-ppc64/mman.h	2005-03-09 01:25:14.000000000 +1100
@@ -1,52 +1 @@
-#ifndef __PPC64_MMAN_H__
-#define __PPC64_MMAN_H__
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#define PROT_READ	0x1		/* page can be read */
-#define PROT_WRITE	0x2		/* page can be written */
-#define PROT_EXEC	0x4		/* page can be executed */
-#define PROT_SEM	0x8		/* page may be used for atomic ops */
-#define PROT_NONE	0x0		/* page can not be accessed */
-#define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
-#define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
-
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_TYPE	0x0f		/* Mask for type of mapping */
-#define MAP_FIXED	0x10		/* Interpret addr exactly */
-#define MAP_ANONYMOUS	0x20		/* don't use a file */
-#define MAP_RENAME      MAP_ANONYMOUS   /* In SunOS terminology */
-#define MAP_NORESERVE   0x40            /* don't reserve swap pages */
-#define MAP_LOCKED	0x80
-
-#define MAP_GROWSDOWN	0x0100		/* stack-like segment */
-#define MAP_DENYWRITE	0x0800		/* ETXTBSY */
-#define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
-
-#define MS_ASYNC	1		/* sync memory asynchronously */
-#define MS_INVALIDATE	2		/* invalidate the caches */
-#define MS_SYNC		4		/* synchronous memory sync */
-
-#define MCL_CURRENT     0x2000          /* lock all currently mapped pages */
-#define MCL_FUTURE      0x4000          /* lock all additions to address space */
-
-#define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define MAP_NONBLOCK	0x10000		/* do not block on IO */
-
-#define MADV_NORMAL	0x0		/* default page-in behavior */
-#define MADV_RANDOM	0x1		/* page-in minimum required */
-#define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
-#define MADV_WILLNEED	0x3		/* pre-fault pages */
-#define MADV_DONTNEED	0x4		/* discard these pages */
-
-/* compatibility flags */
-#define MAP_ANON	MAP_ANONYMOUS
-#define MAP_FILE	0
-
-#endif /* __PPC64_MMAN_H__ */
+#include <asm-ppc/mman.h>
diff -ruNp linus/include/asm-ppc64/param.h linus-headers/include/asm-ppc64/param.h
--- linus/include/asm-ppc64/param.h	2004-02-23 12:05:19.000000000 +1100
+++ linus-headers/include/asm-ppc64/param.h	2005-03-09 01:38:01.000000000 +1100
@@ -1,29 +1 @@
-#ifndef _ASM_PPC64_PARAM_H
-#define _ASM_PPC64_PARAM_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifdef __KERNEL__
-# define HZ		1000		/* Internal kernel timer frequency */
-# define USER_HZ	100		/* .. some user interfaces are in "ticks" */
-# define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
-#endif
-
-#ifndef HZ
-#define HZ 100
-#endif
-
-#define EXEC_PAGESIZE	4096
-
-#ifndef NOGROUP
-#define NOGROUP		(-1)
-#endif
-
-#define MAXHOSTNAMELEN	64	/* max length of hostname */
-
-#endif /* _ASM_PPC64_PARAM_H */
+#include <asm-ppc/param.h>
diff -ruNp linus/include/asm-ppc64/parport.h linus-headers/include/asm-ppc64/parport.h
--- linus/include/asm-ppc64/parport.h	2002-02-14 23:14:36.000000000 +1100
+++ linus-headers/include/asm-ppc64/parport.h	2005-03-09 01:40:11.000000000 +1100
@@ -1,18 +1 @@
-/*
- * parport.h: platform-specific PC-style parport initialisation
- *
- * Copyright (C) 1999, 2000  Tim Waugh <tim@cyberelk.demon.co.uk>
- *
- * This file should only be included by drivers/parport/parport_pc.c.
- */
-
-#ifndef _ASM_PPC64_PARPORT_H
-#define _ASM_PPC64_PARPORT_H
-
-static int __devinit parport_pc_find_isa_ports (int autoirq, int autodma);
-static int __devinit parport_pc_find_nonpci_ports (int autoirq, int autodma)
-{
-	return parport_pc_find_isa_ports (autoirq, autodma);
-}
-
-#endif /* !(_ASM_PPC_PARPORT_H) */
+#include <asm-ppc/parport.h>
diff -ruNp linus/include/asm-ppc64/poll.h linus-headers/include/asm-ppc64/poll.h
--- linus/include/asm-ppc64/poll.h	2002-11-01 05:18:30.000000000 +1100
+++ linus-headers/include/asm-ppc64/poll.h	2005-03-09 01:45:19.000000000 +1100
@@ -1,32 +1 @@
-#ifndef __PPC64_POLL_H
-#define __PPC64_POLL_H
-
-/*
- * Copyright (C) 2001 PPC64 Team, IBM Corp
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#define POLLIN		0x0001
-#define POLLPRI		0x0002
-#define POLLOUT		0x0004
-#define POLLERR		0x0008
-#define POLLHUP		0x0010
-#define POLLNVAL	0x0020
-#define POLLRDNORM	0x0040
-#define POLLRDBAND	0x0080
-#define POLLWRNORM	0x0100
-#define POLLWRBAND	0x0200
-#define POLLMSG		0x0400
-#define POLLREMOVE	0x1000
-
-struct pollfd {
-	int fd;
-	short events;
-	short revents;
-};
-
-#endif /* __PPC64_POLL_H */
+#include <asm-ppc/poll.h>
diff -ruNp linus/include/asm-ppc64/string.h linus-headers/include/asm-ppc64/string.h
--- linus/include/asm-ppc64/string.h	2005-01-29 06:05:47.000000000 +1100
+++ linus-headers/include/asm-ppc64/string.h	2005-03-09 02:01:45.000000000 +1100
@@ -1,35 +1 @@
-#ifndef _PPC64_STRING_H_
-#define _PPC64_STRING_H_
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#define __HAVE_ARCH_STRCPY
-#define __HAVE_ARCH_STRNCPY
-#define __HAVE_ARCH_STRLEN
-#define __HAVE_ARCH_STRCMP
-#define __HAVE_ARCH_STRCAT
-#define __HAVE_ARCH_MEMSET
-#define __HAVE_ARCH_MEMCPY
-#define __HAVE_ARCH_MEMMOVE
-#define __HAVE_ARCH_MEMCMP
-#define __HAVE_ARCH_MEMCHR
-
-extern int strcasecmp(const char *, const char *);
-extern int strncasecmp(const char *, const char *, int);
-extern char * strcpy(char *,const char *);
-extern char * strncpy(char *,const char *, __kernel_size_t);
-extern __kernel_size_t strlen(const char *);
-extern int strcmp(const char *,const char *);
-extern char * strcat(char *, const char *);
-extern void * memset(void *,int,__kernel_size_t);
-extern void * memcpy(void *,const void *,__kernel_size_t);
-extern void * memmove(void *,const void *,__kernel_size_t);
-extern int memcmp(const void *,const void *,__kernel_size_t);
-extern void * memchr(const void *,int,__kernel_size_t);
-
-#endif /* _PPC64_STRING_H_ */
+#include <asm-ppc/string.h>
diff -ruNp linus/include/asm-ppc64/termbits.h linus-headers/include/asm-ppc64/termbits.h
--- linus/include/asm-ppc64/termbits.h	2004-05-11 07:53:05.000000000 +1000
+++ linus-headers/include/asm-ppc64/termbits.h	2005-03-09 02:04:35.000000000 +1100
@@ -1,193 +1 @@
-#ifndef _PPC64_TERMBITS_H
-#define _PPC64_TERMBITS_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/posix_types.h>
-
-typedef unsigned char	cc_t;
-typedef unsigned int	speed_t;
-typedef unsigned int	tcflag_t;
-
-/*
- * termios type and macro definitions.  Be careful about adding stuff
- * to this file since it's used in GNU libc and there are strict rules
- * concerning namespace pollution.
- */
-
-#define NCCS 19
-struct termios {
-	tcflag_t c_iflag;		/* input mode flags */
-	tcflag_t c_oflag;		/* output mode flags */
-	tcflag_t c_cflag;		/* control mode flags */
-	tcflag_t c_lflag;		/* local mode flags */
-	cc_t c_cc[NCCS];		/* control characters */
-	cc_t c_line;			/* line discipline (== c_cc[19]) */
-	speed_t c_ispeed;		/* input speed */
-	speed_t c_ospeed;		/* output speed */
-};
-
-/* c_cc characters */
-#define VINTR 	         0
-#define VQUIT 	         1
-#define VERASE 	         2
-#define VKILL	         3
-#define VEOF	         4
-#define VMIN	         5
-#define VEOL	         6
-#define VTIME	         7
-#define VEOL2	         8
-#define VSWTC	         9
-#define VWERASE 	10
-#define VREPRINT	11
-#define VSUSP 		12
-#define VSTART		13
-#define VSTOP		14
-#define VLNEXT		15
-#define VDISCARD	16
-
-/* c_iflag bits */
-#define IGNBRK	0000001
-#define BRKINT	0000002
-#define IGNPAR	0000004
-#define PARMRK	0000010
-#define INPCK	0000020
-#define ISTRIP	0000040
-#define INLCR	0000100
-#define IGNCR	0000200
-#define ICRNL	0000400
-#define IXON	0001000
-#define IXOFF	0002000
-#define IXANY	0004000
-#define IUCLC	0010000
-#define IMAXBEL	0020000
-#define	IUTF8	0040000
-
-/* c_oflag bits */
-#define OPOST	0000001
-#define ONLCR	0000002
-#define OLCUC	0000004
-
-#define OCRNL	0000010
-#define ONOCR	0000020
-#define ONLRET	0000040
-
-#define OFILL	00000100
-#define OFDEL	00000200
-#define NLDLY	00001400
-#define   NL0	00000000
-#define   NL1	00000400
-#define   NL2	00001000
-#define   NL3	00001400
-#define TABDLY	00006000
-#define   TAB0	00000000
-#define   TAB1	00002000
-#define   TAB2	00004000
-#define   TAB3	00006000
-#define   XTABS	00006000	/* required by POSIX to == TAB3 */
-#define CRDLY	00030000
-#define   CR0	00000000
-#define   CR1	00010000
-#define   CR2	00020000
-#define   CR3	00030000
-#define FFDLY	00040000
-#define   FF0	00000000
-#define   FF1	00040000
-#define BSDLY	00100000
-#define   BS0	00000000
-#define   BS1	00100000
-#define VTDLY	00200000
-#define   VT0	00000000
-#define   VT1	00200000
-
-/* c_cflag bit meaning */
-#define CBAUD	0000377
-#define  B0	0000000		/* hang up */
-#define  B50	0000001
-#define  B75	0000002
-#define  B110	0000003
-#define  B134	0000004
-#define  B150	0000005
-#define  B200	0000006
-#define  B300	0000007
-#define  B600	0000010
-#define  B1200	0000011
-#define  B1800	0000012
-#define  B2400	0000013
-#define  B4800	0000014
-#define  B9600	0000015
-#define  B19200	0000016
-#define  B38400	0000017
-#define  EXTA   B19200
-#define  EXTB   B38400
-#define  CBAUDEX 0000000
-#define  B57600   00020
-#define  B115200  00021
-#define  B230400  00022
-#define  B460800  00023
-#define  B500000  00024
-#define  B576000  00025
-#define  B921600  00026
-#define B1000000  00027
-#define B1152000  00030
-#define B1500000  00031
-#define B2000000  00032
-#define B2500000  00033
-#define B3000000  00034
-#define B3500000  00035
-#define B4000000  00036
-
-#define CSIZE	00001400
-#define   CS5	00000000
-#define   CS6	00000400
-#define   CS7	00001000
-#define   CS8	00001400
-
-#define CSTOPB	00002000
-#define CREAD	00004000
-#define PARENB	00010000
-#define PARODD	00020000
-#define HUPCL	00040000
-
-#define CLOCAL	00100000
-#define CRTSCTS	  020000000000		/* flow control */
-
-/* c_lflag bits */
-#define ISIG	0x00000080
-#define ICANON	0x00000100
-#define XCASE	0x00004000
-#define ECHO	0x00000008
-#define ECHOE	0x00000002
-#define ECHOK	0x00000004
-#define ECHONL	0x00000010
-#define NOFLSH	0x80000000
-#define TOSTOP	0x00400000
-#define ECHOCTL	0x00000040
-#define ECHOPRT	0x00000020
-#define ECHOKE	0x00000001
-#define FLUSHO	0x00800000
-#define PENDIN	0x20000000
-#define IEXTEN	0x00000400
-
-/* Values for the ACTION argument to `tcflow'.  */
-#define	TCOOFF		0
-#define	TCOON		1
-#define	TCIOFF		2
-#define	TCION		3
-
-/* Values for the QUEUE_SELECTOR argument to `tcflush'.  */
-#define	TCIFLUSH	0
-#define	TCOFLUSH	1
-#define	TCIOFLUSH	2
-
-/* Values for the OPTIONAL_ACTIONS argument to `tcsetattr'.  */
-#define	TCSANOW		0
-#define	TCSADRAIN	1
-#define	TCSAFLUSH	2
-
-#endif /* _PPC64_TERMBITS_H */
+#include <asm-ppc/termbits.h>
diff -ruNp linus/include/asm-ppc64/termios.h linus-headers/include/asm-ppc64/termios.h
--- linus/include/asm-ppc64/termios.h	2003-04-03 08:55:29.000000000 +1000
+++ linus-headers/include/asm-ppc64/termios.h	2005-03-09 02:13:20.000000000 +1100
@@ -1,235 +1 @@
-#ifndef _PPC64_TERMIOS_H
-#define _PPC64_TERMIOS_H
-
-/*
- * Liberally adapted from alpha/termios.h.  In particular, the c_cc[]
- * fields have been reordered so that termio & termios share the
- * common subset in the same order (for brain dead programs that don't
- * know or care about the differences).
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <asm/ioctls.h>
-#include <asm/termbits.h>
-
-struct sgttyb {
-	char	sg_ispeed;
-	char	sg_ospeed;
-	char	sg_erase;
-	char	sg_kill;
-	short	sg_flags;
-};
-
-struct tchars {
-	char	t_intrc;
-	char	t_quitc;
-	char	t_startc;
-	char	t_stopc;
-	char	t_eofc;
-	char	t_brkc;
-};
-
-struct ltchars {
-	char	t_suspc;
-	char	t_dsuspc;
-	char	t_rprntc;
-	char	t_flushc;
-	char	t_werasc;
-	char	t_lnextc;
-};
-
-struct winsize {
-	unsigned short ws_row;
-	unsigned short ws_col;
-	unsigned short ws_xpixel;
-	unsigned short ws_ypixel;
-};
-
-#define NCC 10
-struct termio {
-	unsigned short c_iflag;		/* input mode flags */
-	unsigned short c_oflag;		/* output mode flags */
-	unsigned short c_cflag;		/* control mode flags */
-	unsigned short c_lflag;		/* local mode flags */
-	unsigned char c_line;		/* line discipline */
-	unsigned char c_cc[NCC];	/* control characters */
-};
-
-/* c_cc characters */
-#define _VINTR	0
-#define _VQUIT	1
-#define _VERASE	2
-#define _VKILL	3
-#define _VEOF	4
-#define _VMIN	5
-#define _VEOL	6
-#define _VTIME	7
-#define _VEOL2	8
-#define _VSWTC	9
-
-/* line disciplines */
-#define N_TTY		0
-#define N_SLIP		1
-#define N_MOUSE		2
-#define N_PPP		3
-#define N_STRIP		4
-#define N_AX25		5
-#define N_X25		6	/* X.25 async */
-#define N_6PACK		7
-#define N_MASC		8	/* Reserved for Mobitex module <kaz@cafe.net> */
-#define N_R3964		9	/* Reserved for Simatic R3964 module */
-#define N_PROFIBUS_FDL	10	/* Reserved for Profibus <Dave@mvhi.com> */
-#define N_IRDA		11	/* Linux IrDa - http://www.cs.uit.no/~dagb/irda/irda.html */
-#define N_SMSBLOCK	12	/* SMS block mode - for talking to GSM data cards about SMS messages */
-#define N_HDLC		13	/* synchronous HDLC */
-#define N_SYNC_PPP	14
-
-#ifdef __KERNEL__
-/*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z  ^Q  ^S  ^V  ^U  */
-#define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\021\023\026\025" 
-#endif
-
-#define FIOCLEX		_IO('f', 1)
-#define FIONCLEX	_IO('f', 2)
-#define FIOASYNC	_IOW('f', 125, int)
-#define FIONBIO		_IOW('f', 126, int)
-#define FIONREAD	_IOR('f', 127, int)
-#define TIOCINQ		FIONREAD
-
-#define TIOCGETP	_IOR('t', 8, struct sgttyb)
-#define TIOCSETP	_IOW('t', 9, struct sgttyb)
-#define TIOCSETN	_IOW('t', 10, struct sgttyb)	/* TIOCSETP wo flush */
-
-#define TIOCSETC	_IOW('t', 17, struct tchars)
-#define TIOCGETC	_IOR('t', 18, struct tchars)
-#define TCGETS		_IOR('t', 19, struct termios)
-#define TCSETS		_IOW('t', 20, struct termios)
-#define TCSETSW		_IOW('t', 21, struct termios)
-#define TCSETSF		_IOW('t', 22, struct termios)
-
-#define TCGETA		_IOR('t', 23, struct termio)
-#define TCSETA		_IOW('t', 24, struct termio)
-#define TCSETAW		_IOW('t', 25, struct termio)
-#define TCSETAF		_IOW('t', 28, struct termio)
-
-#define TCSBRK		_IO('t', 29)
-#define TCXONC		_IO('t', 30)
-#define TCFLSH		_IO('t', 31)
-
-#define TIOCSWINSZ	_IOW('t', 103, struct winsize)
-#define TIOCGWINSZ	_IOR('t', 104, struct winsize)
-#define	TIOCSTART	_IO('t', 110)		/* start output, like ^Q */
-#define	TIOCSTOP	_IO('t', 111)		/* stop output, like ^S */
-#define TIOCOUTQ        _IOR('t', 115, int)     /* output queue size */
-
-#define TIOCGLTC	_IOR('t', 116, struct ltchars)
-#define TIOCSLTC	_IOW('t', 117, struct ltchars)
-#define TIOCSPGRP	_IOW('t', 118, int)
-#define TIOCGPGRP	_IOR('t', 119, int)
-
-#define TIOCEXCL	0x540C
-#define TIOCNXCL	0x540D
-#define TIOCSCTTY	0x540E
-
-#define TIOCSTI		0x5412
-#define TIOCMGET	0x5415
-#define TIOCMBIS	0x5416
-#define TIOCMBIC	0x5417
-#define TIOCMSET	0x5418
-#define TIOCGSOFTCAR	0x5419
-#define TIOCSSOFTCAR	0x541A
-#define TIOCLINUX	0x541C
-#define TIOCCONS	0x541D
-#define TIOCGSERIAL	0x541E
-#define TIOCSSERIAL	0x541F
-#define TIOCPKT		0x5420
-
-#define TIOCNOTTY	0x5422
-#define TIOCSETD	0x5423
-#define TIOCGETD	0x5424
-#define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-
-#define TIOCSERCONFIG	0x5453
-#define TIOCSERGWILD	0x5454
-#define TIOCSERSWILD	0x5455
-#define TIOCGLCKTRMIOS	0x5456
-#define TIOCSLCKTRMIOS	0x5457
-#define TIOCSERGSTRUCT	0x5458 /* For debugging only */
-#define TIOCSERGETLSR   0x5459 /* Get line status register */
-#define TIOCSERGETMULTI 0x545A /* Get multiport config  */
-#define TIOCSERSETMULTI 0x545B /* Set multiport config */
-
-#define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
-#define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
-
-/* Used for packet mode */
-#define TIOCPKT_DATA		 0
-#define TIOCPKT_FLUSHREAD	 1
-#define TIOCPKT_FLUSHWRITE	 2
-#define TIOCPKT_STOP		 4
-#define TIOCPKT_START		 8
-#define TIOCPKT_NOSTOP		16
-#define TIOCPKT_DOSTOP		32
-
-/* modem lines */
-#define TIOCM_LE	0x001
-#define TIOCM_DTR	0x002
-#define TIOCM_RTS	0x004
-#define TIOCM_ST	0x008
-#define TIOCM_SR	0x010
-#define TIOCM_CTS	0x020
-#define TIOCM_CAR	0x040
-#define TIOCM_RNG	0x080
-#define TIOCM_DSR	0x100
-#define TIOCM_CD	TIOCM_CAR
-#define TIOCM_RI	TIOCM_RNG
-#define TIOCM_OUT1	0x2000
-#define TIOCM_OUT2	0x4000
-#define TIOCM_LOOP	0x8000
-
-/* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
-#define TIOCSER_TEMT    0x01	/* Transmitter physically empty */
-
-#ifdef __KERNEL__
-
-/*
- * Translate a "termio" structure into a "termios". Ugh.
- */
-#define SET_LOW_TERMIOS_BITS(termios, termio, x) { \
-	unsigned short __tmp; \
-	get_user(__tmp,&(termio)->x); \
-	(termios)->x = (0xffff0000 & (termios)->x) | __tmp; \
-}
-
-#define user_termio_to_kernel_termios(termios, termio) \
-({ \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_iflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_oflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_cflag); \
-	SET_LOW_TERMIOS_BITS(termios, termio, c_lflag); \
-	copy_from_user((termios)->c_cc, (termio)->c_cc, NCC); \
-})
-
-/*
- * Translate a "termios" structure into a "termio". Ugh.
- */
-#define kernel_termios_to_user_termio(termio, termios) \
-({ \
-	put_user((termios)->c_iflag, &(termio)->c_iflag); \
-	put_user((termios)->c_oflag, &(termio)->c_oflag); \
-	put_user((termios)->c_cflag, &(termio)->c_cflag); \
-	put_user((termios)->c_lflag, &(termio)->c_lflag); \
-	put_user((termios)->c_line,  &(termio)->c_line); \
-	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
-})
-
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
-
-#endif	/* __KERNEL__ */
-
-#endif	/* _PPC64_TERMIOS_H */
+#include <asm-ppc/termios.h>
diff -ruNp linus/include/asm-ppc64/unaligned.h linus-headers/include/asm-ppc64/unaligned.h
--- linus/include/asm-ppc64/unaligned.h	2002-02-14 23:14:36.000000000 +1100
+++ linus-headers/include/asm-ppc64/unaligned.h	2005-03-09 02:16:30.000000000 +1100
@@ -1,21 +1 @@
-#ifndef __PPC64_UNALIGNED_H
-#define __PPC64_UNALIGNED_H
-
-/*
- * The PowerPC can do unaligned accesses itself in big endian mode. 
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#define get_unaligned(ptr) (*(ptr))
-
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
-
-#endif /* __PPC64_UNALIGNED_H */
+#include <asm-ppc/unaligned.h>
