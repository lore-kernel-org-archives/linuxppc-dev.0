Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3E04E68126
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 15:48:35 +1000 (EST)
Received: from oak (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id B0CB1368024
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Aug 2005 15:48:34 +1000 (EST)
Date: Mon, 29 Aug 2005 14:08:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050829140811.793e9fe6.sfr@canb.auug.org.au>
In-Reply-To: <20050829140656.5b9e751f.sfr@canb.auug.org.au>
References: <20050829130133.519391c6.sfr@canb.auug.org.au>
	<20050829131550.39e97cf3.sfr@canb.auug.org.au>
	<20050829140656.5b9e751f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Resent-Message-Id: <20050829154832.10be92e5.sfr@canb.auug.org.au>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-dev@samba.org
Subject: [PATCH 3/3] Move all the very similar files to asm-powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

They differed in either simple comments or in the protecting ifdefs.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 include/asm-powerpc/errno.h     |   11 ++++
 include/asm-powerpc/ioctl.h     |   69 ++++++++++++++++++++++++
 include/asm-powerpc/ioctls.h    |  107 +++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/local.h     |    1 
 include/asm-powerpc/namei.h     |   20 +++++++
 include/asm-powerpc/percpu.h    |    1 
 include/asm-powerpc/poll.h      |   23 ++++++++
 include/asm-powerpc/resource.h  |    1 
 include/asm-powerpc/shmparam.h  |    6 ++
 include/asm-powerpc/string.h    |   32 +++++++++++
 include/asm-powerpc/unaligned.h |   18 ++++++
 include/asm-ppc/errno.h         |   11 ----
 include/asm-ppc/ioctl.h         |   69 ------------------------
 include/asm-ppc/ioctls.h        |  107 -------------------------------------
 include/asm-ppc/local.h         |    6 --
 include/asm-ppc/namei.h         |   20 -------
 include/asm-ppc/percpu.h        |    6 --
 include/asm-ppc/poll.h          |   23 --------
 include/asm-ppc/resource.h      |    6 --
 include/asm-ppc/shmparam.h      |    6 --
 include/asm-ppc/string.h        |   32 -----------
 include/asm-ppc/unaligned.h     |   18 ------
 include/asm-ppc64/errno.h       |   18 ------
 include/asm-ppc64/ioctl.h       |   74 -------------------------
 include/asm-ppc64/ioctls.h      |  114 ---------------------------------------
 include/asm-ppc64/local.h       |    1 
 include/asm-ppc64/namei.h       |   23 --------
 include/asm-ppc64/percpu.h      |    6 --
 include/asm-ppc64/poll.h        |   32 -----------
 include/asm-ppc64/resource.h    |    6 --
 include/asm-ppc64/shmparam.h    |   13 ----
 include/asm-ppc64/string.h      |   35 ------------
 include/asm-ppc64/unaligned.h   |   21 -------
 33 files changed, 289 insertions(+), 647 deletions(-)
 create mode 100644 include/asm-powerpc/errno.h
 create mode 100644 include/asm-powerpc/ioctl.h
 create mode 100644 include/asm-powerpc/ioctls.h
 create mode 100644 include/asm-powerpc/local.h
 create mode 100644 include/asm-powerpc/namei.h
 create mode 100644 include/asm-powerpc/percpu.h
 create mode 100644 include/asm-powerpc/poll.h
 create mode 100644 include/asm-powerpc/resource.h
 create mode 100644 include/asm-powerpc/shmparam.h
 create mode 100644 include/asm-powerpc/string.h
 create mode 100644 include/asm-powerpc/unaligned.h
 delete mode 100644 include/asm-ppc/errno.h
 delete mode 100644 include/asm-ppc/ioctl.h
 delete mode 100644 include/asm-ppc/ioctls.h
 delete mode 100644 include/asm-ppc/local.h
 delete mode 100644 include/asm-ppc/namei.h
 delete mode 100644 include/asm-ppc/percpu.h
 delete mode 100644 include/asm-ppc/poll.h
 delete mode 100644 include/asm-ppc/resource.h
 delete mode 100644 include/asm-ppc/shmparam.h
 delete mode 100644 include/asm-ppc/string.h
 delete mode 100644 include/asm-ppc/unaligned.h
 delete mode 100644 include/asm-ppc64/errno.h
 delete mode 100644 include/asm-ppc64/ioctl.h
 delete mode 100644 include/asm-ppc64/ioctls.h
 delete mode 100644 include/asm-ppc64/local.h
 delete mode 100644 include/asm-ppc64/namei.h
 delete mode 100644 include/asm-ppc64/percpu.h
 delete mode 100644 include/asm-ppc64/poll.h
 delete mode 100644 include/asm-ppc64/resource.h
 delete mode 100644 include/asm-ppc64/shmparam.h
 delete mode 100644 include/asm-ppc64/string.h
 delete mode 100644 include/asm-ppc64/unaligned.h

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

bd136b653c5aac766e14dc5c655ab6ae3053d76d
diff --git a/include/asm-powerpc/errno.h b/include/asm-powerpc/errno.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/errno.h
@@ -0,0 +1,11 @@
+#ifndef _PPC_ERRNO_H
+#define _PPC_ERRNO_H
+
+#include <asm-generic/errno.h>
+
+#undef	EDEADLOCK
+#define	EDEADLOCK	58	/* File locking deadlock error */
+
+#define _LAST_ERRNO	516
+
+#endif
diff --git a/include/asm-powerpc/ioctl.h b/include/asm-powerpc/ioctl.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/ioctl.h
@@ -0,0 +1,69 @@
+#ifndef _PPC_IOCTL_H
+#define _PPC_IOCTL_H
+
+
+/*
+ * this was copied from the alpha as it's a bit cleaner there.
+ *                         -- Cort
+ */
+
+#define _IOC_NRBITS	8
+#define _IOC_TYPEBITS	8
+#define _IOC_SIZEBITS	13
+#define _IOC_DIRBITS	3
+
+#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
+#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
+#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
+#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
+
+#define _IOC_NRSHIFT	0
+#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
+#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
+#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
+
+/*
+ * Direction bits _IOC_NONE could be 0, but OSF/1 gives it a bit.
+ * And this turns out useful to catch old ioctl numbers in header
+ * files for us.
+ */
+#define _IOC_NONE	1U
+#define _IOC_READ	2U
+#define _IOC_WRITE	4U
+
+#define _IOC(dir,type,nr,size) \
+	(((dir)  << _IOC_DIRSHIFT) | \
+	 ((type) << _IOC_TYPESHIFT) | \
+	 ((nr)   << _IOC_NRSHIFT) | \
+	 ((size) << _IOC_SIZESHIFT))
+
+/* provoke compile error for invalid uses of size argument */
+extern unsigned int __invalid_size_argument_for_IOC;
+#define _IOC_TYPECHECK(t) \
+	((sizeof(t) == sizeof(t[1]) && \
+	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
+	  sizeof(t) : __invalid_size_argument_for_IOC)
+
+/* used to create numbers */
+#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
+#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
+#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
+#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
+#define _IOR_BAD(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
+#define _IOW_BAD(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IOWR_BAD(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+
+/* used to decode them.. */
+#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
+#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
+#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
+#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
+
+/* various drivers, such as the pcmcia stuff, need these... */
+#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
+#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
+#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
+#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
+#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
+
+#endif
diff --git a/include/asm-powerpc/ioctls.h b/include/asm-powerpc/ioctls.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/ioctls.h
@@ -0,0 +1,107 @@
+#ifndef _ASM_PPC_IOCTLS_H
+#define _ASM_PPC_IOCTLS_H
+
+#include <asm/ioctl.h>
+
+#define FIOCLEX		_IO('f', 1)
+#define FIONCLEX	_IO('f', 2)
+#define FIOASYNC	_IOW('f', 125, int)
+#define FIONBIO		_IOW('f', 126, int)
+#define FIONREAD	_IOR('f', 127, int)
+#define TIOCINQ		FIONREAD
+#define FIOQSIZE	_IOR('f', 128, loff_t)
+
+#define TIOCGETP	_IOR('t', 8, struct sgttyb)
+#define TIOCSETP	_IOW('t', 9, struct sgttyb)
+#define TIOCSETN	_IOW('t', 10, struct sgttyb)	/* TIOCSETP wo flush */
+
+#define TIOCSETC	_IOW('t', 17, struct tchars)
+#define TIOCGETC	_IOR('t', 18, struct tchars)
+#define TCGETS		_IOR('t', 19, struct termios)
+#define TCSETS		_IOW('t', 20, struct termios)
+#define TCSETSW		_IOW('t', 21, struct termios)
+#define TCSETSF		_IOW('t', 22, struct termios)
+
+#define TCGETA		_IOR('t', 23, struct termio)
+#define TCSETA		_IOW('t', 24, struct termio)
+#define TCSETAW		_IOW('t', 25, struct termio)
+#define TCSETAF		_IOW('t', 28, struct termio)
+
+#define TCSBRK		_IO('t', 29)
+#define TCXONC		_IO('t', 30)
+#define TCFLSH		_IO('t', 31)
+
+#define TIOCSWINSZ	_IOW('t', 103, struct winsize)
+#define TIOCGWINSZ	_IOR('t', 104, struct winsize)
+#define	TIOCSTART	_IO('t', 110)		/* start output, like ^Q */
+#define	TIOCSTOP	_IO('t', 111)		/* stop output, like ^S */
+#define TIOCOUTQ        _IOR('t', 115, int)     /* output queue size */
+
+#define TIOCGLTC	_IOR('t', 116, struct ltchars)
+#define TIOCSLTC	_IOW('t', 117, struct ltchars)
+#define TIOCSPGRP	_IOW('t', 118, int)
+#define TIOCGPGRP	_IOR('t', 119, int)
+
+#define TIOCEXCL	0x540C
+#define TIOCNXCL	0x540D
+#define TIOCSCTTY	0x540E
+
+#define TIOCSTI		0x5412
+#define TIOCMGET	0x5415
+#define TIOCMBIS	0x5416
+#define TIOCMBIC	0x5417
+#define TIOCMSET	0x5418
+# define TIOCM_LE	0x001
+# define TIOCM_DTR	0x002
+# define TIOCM_RTS	0x004
+# define TIOCM_ST	0x008
+# define TIOCM_SR	0x010
+# define TIOCM_CTS	0x020
+# define TIOCM_CAR	0x040
+# define TIOCM_RNG	0x080
+# define TIOCM_DSR	0x100
+# define TIOCM_CD	TIOCM_CAR
+# define TIOCM_RI	TIOCM_RNG
+
+#define TIOCGSOFTCAR	0x5419
+#define TIOCSSOFTCAR	0x541A
+#define TIOCLINUX	0x541C
+#define TIOCCONS	0x541D
+#define TIOCGSERIAL	0x541E
+#define TIOCSSERIAL	0x541F
+#define TIOCPKT		0x5420
+# define TIOCPKT_DATA		 0
+# define TIOCPKT_FLUSHREAD	 1
+# define TIOCPKT_FLUSHWRITE	 2
+# define TIOCPKT_STOP		 4
+# define TIOCPKT_START		 8
+# define TIOCPKT_NOSTOP		16
+# define TIOCPKT_DOSTOP		32
+
+
+#define TIOCNOTTY	0x5422
+#define TIOCSETD	0x5423
+#define TIOCGETD	0x5424
+#define TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
+#define TIOCSBRK	0x5427  /* BSD compatibility */
+#define TIOCCBRK	0x5428  /* BSD compatibility */
+#define TIOCGSID	0x5429  /* Return the session ID of FD */
+#define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
+#define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
+
+#define TIOCSERCONFIG	0x5453
+#define TIOCSERGWILD	0x5454
+#define TIOCSERSWILD	0x5455
+#define TIOCGLCKTRMIOS	0x5456
+#define TIOCSLCKTRMIOS	0x5457
+#define TIOCSERGSTRUCT	0x5458 /* For debugging only */
+#define TIOCSERGETLSR   0x5459 /* Get line status register */
+  /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
+# define TIOCSER_TEMT    0x01	/* Transmitter physically empty */
+#define TIOCSERGETMULTI 0x545A /* Get multiport config  */
+#define TIOCSERSETMULTI 0x545B /* Set multiport config */
+
+#define TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
+#define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
+
+#endif /* _ASM_PPC_IOCTLS_H */
diff --git a/include/asm-powerpc/local.h b/include/asm-powerpc/local.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/local.h
@@ -0,0 +1 @@
+#include <asm-generic/local.h>
diff --git a/include/asm-powerpc/namei.h b/include/asm-powerpc/namei.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/namei.h
@@ -0,0 +1,20 @@
+/*
+ * include/asm-ppc/namei.h
+ * Adapted from include/asm-alpha/namei.h
+ *
+ * Included from fs/namei.c
+ */
+
+#ifdef __KERNEL__
+#ifndef __PPC_NAMEI_H
+#define __PPC_NAMEI_H
+
+/* This dummy routine maybe changed to something useful
+ * for /usr/gnemul/ emulation stuff.
+ * Look at asm-sparc/namei.h for details.
+ */
+
+#define __emul_prefix() NULL
+
+#endif /* __PPC_NAMEI_H */
+#endif /* __KERNEL__ */
diff --git a/include/asm-powerpc/percpu.h b/include/asm-powerpc/percpu.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/percpu.h
@@ -0,0 +1 @@
+#include <asm-generic/percpu.h>
diff --git a/include/asm-powerpc/poll.h b/include/asm-powerpc/poll.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/poll.h
@@ -0,0 +1,23 @@
+#ifndef __PPC_POLL_H
+#define __PPC_POLL_H
+
+#define POLLIN		0x0001
+#define POLLPRI		0x0002
+#define POLLOUT		0x0004
+#define POLLERR		0x0008
+#define POLLHUP		0x0010
+#define POLLNVAL	0x0020
+#define POLLRDNORM	0x0040
+#define POLLRDBAND	0x0080
+#define POLLWRNORM	0x0100
+#define POLLWRBAND	0x0200
+#define POLLMSG		0x0400
+#define POLLREMOVE	0x1000
+
+struct pollfd {
+	int fd;
+	short events;
+	short revents;
+};
+
+#endif
diff --git a/include/asm-powerpc/resource.h b/include/asm-powerpc/resource.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/resource.h
@@ -0,0 +1 @@
+#include <asm-generic/resource.h>
diff --git a/include/asm-powerpc/shmparam.h b/include/asm-powerpc/shmparam.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/shmparam.h
@@ -0,0 +1,6 @@
+#ifndef _PPC_SHMPARAM_H
+#define _PPC_SHMPARAM_H
+
+#define	SHMLBA PAGE_SIZE		 /* attach addr a multiple of this */
+
+#endif /* _PPC_SHMPARAM_H */
diff --git a/include/asm-powerpc/string.h b/include/asm-powerpc/string.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/string.h
@@ -0,0 +1,32 @@
+#ifndef _PPC_STRING_H_
+#define _PPC_STRING_H_
+
+#ifdef __KERNEL__
+
+#define __HAVE_ARCH_STRCPY
+#define __HAVE_ARCH_STRNCPY
+#define __HAVE_ARCH_STRLEN
+#define __HAVE_ARCH_STRCMP
+#define __HAVE_ARCH_STRCAT
+#define __HAVE_ARCH_MEMSET
+#define __HAVE_ARCH_MEMCPY
+#define __HAVE_ARCH_MEMMOVE
+#define __HAVE_ARCH_MEMCMP
+#define __HAVE_ARCH_MEMCHR
+
+extern int strcasecmp(const char *, const char *);
+extern int strncasecmp(const char *, const char *, int);
+extern char * strcpy(char *,const char *);
+extern char * strncpy(char *,const char *, __kernel_size_t);
+extern __kernel_size_t strlen(const char *);
+extern int strcmp(const char *,const char *);
+extern char * strcat(char *, const char *);
+extern void * memset(void *,int,__kernel_size_t);
+extern void * memcpy(void *,const void *,__kernel_size_t);
+extern void * memmove(void *,const void *,__kernel_size_t);
+extern int memcmp(const void *,const void *,__kernel_size_t);
+extern void * memchr(const void *,int,__kernel_size_t);
+
+#endif /* __KERNEL__ */
+
+#endif
diff --git a/include/asm-powerpc/unaligned.h b/include/asm-powerpc/unaligned.h
new file mode 100644
--- /dev/null
+++ b/include/asm-powerpc/unaligned.h
@@ -0,0 +1,18 @@
+#ifdef __KERNEL__
+#ifndef __PPC_UNALIGNED_H
+#define __PPC_UNALIGNED_H
+
+/*
+ * The PowerPC can do unaligned accesses itself in big endian mode.
+ *
+ * The strange macros are there to make sure these can't
+ * be misused in a way that makes them not work on other
+ * architectures where unaligned accesses aren't as simple.
+ */
+
+#define get_unaligned(ptr) (*(ptr))
+
+#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+
+#endif
+#endif /* __KERNEL__ */
diff --git a/include/asm-ppc/errno.h b/include/asm-ppc/errno.h
deleted file mode 100644
--- a/include/asm-ppc/errno.h
+++ /dev/null
@@ -1,11 +0,0 @@
-#ifndef _PPC_ERRNO_H
-#define _PPC_ERRNO_H
-
-#include <asm-generic/errno.h>
-
-#undef	EDEADLOCK
-#define	EDEADLOCK	58	/* File locking deadlock error */
-
-#define _LAST_ERRNO	516
-
-#endif
diff --git a/include/asm-ppc/ioctl.h b/include/asm-ppc/ioctl.h
deleted file mode 100644
--- a/include/asm-ppc/ioctl.h
+++ /dev/null
@@ -1,69 +0,0 @@
-#ifndef _PPC_IOCTL_H
-#define _PPC_IOCTL_H
-
-
-/*
- * this was copied from the alpha as it's a bit cleaner there.
- *                         -- Cort
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
-	((sizeof(t) == sizeof(t[1]) && \
-	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
-	  sizeof(t) : __invalid_size_argument_for_IOC)
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
-#endif
diff --git a/include/asm-ppc/ioctls.h b/include/asm-ppc/ioctls.h
deleted file mode 100644
--- a/include/asm-ppc/ioctls.h
+++ /dev/null
@@ -1,107 +0,0 @@
-#ifndef _ASM_PPC_IOCTLS_H
-#define _ASM_PPC_IOCTLS_H
-
-#include <asm/ioctl.h>
-
-#define FIOCLEX		_IO('f', 1)
-#define FIONCLEX	_IO('f', 2)
-#define FIOASYNC	_IOW('f', 125, int)
-#define FIONBIO		_IOW('f', 126, int)
-#define FIONREAD	_IOR('f', 127, int)
-#define TIOCINQ		FIONREAD
-#define FIOQSIZE	_IOR('f', 128, loff_t)
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
-#endif /* _ASM_PPC_IOCTLS_H */
diff --git a/include/asm-ppc/local.h b/include/asm-ppc/local.h
deleted file mode 100644
--- a/include/asm-ppc/local.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __PPC_LOCAL_H
-#define __PPC_LOCAL_H
-
-#include <asm-generic/local.h>
-
-#endif /* __PPC_LOCAL_H */
diff --git a/include/asm-ppc/namei.h b/include/asm-ppc/namei.h
deleted file mode 100644
--- a/include/asm-ppc/namei.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * include/asm-ppc/namei.h
- * Adapted from include/asm-alpha/namei.h
- *
- * Included from fs/namei.c
- */
-
-#ifdef __KERNEL__
-#ifndef __PPC_NAMEI_H
-#define __PPC_NAMEI_H
-
-/* This dummy routine maybe changed to something useful
- * for /usr/gnemul/ emulation stuff.
- * Look at asm-sparc/namei.h for details.
- */
-
-#define __emul_prefix() NULL
-
-#endif /* __PPC_NAMEI_H */
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc/percpu.h b/include/asm-ppc/percpu.h
deleted file mode 100644
--- a/include/asm-ppc/percpu.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ARCH_PPC_PERCPU__
-#define __ARCH_PPC_PERCPU__
-
-#include <asm-generic/percpu.h>
-
-#endif /* __ARCH_PPC_PERCPU__ */
diff --git a/include/asm-ppc/poll.h b/include/asm-ppc/poll.h
deleted file mode 100644
--- a/include/asm-ppc/poll.h
+++ /dev/null
@@ -1,23 +0,0 @@
-#ifndef __PPC_POLL_H
-#define __PPC_POLL_H
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
-#endif
diff --git a/include/asm-ppc/resource.h b/include/asm-ppc/resource.h
deleted file mode 100644
--- a/include/asm-ppc/resource.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _PPC_RESOURCE_H
-#define _PPC_RESOURCE_H
-
-#include <asm-generic/resource.h>
-
-#endif
diff --git a/include/asm-ppc/shmparam.h b/include/asm-ppc/shmparam.h
deleted file mode 100644
--- a/include/asm-ppc/shmparam.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _PPC_SHMPARAM_H
-#define _PPC_SHMPARAM_H
-
-#define	SHMLBA PAGE_SIZE		 /* attach addr a multiple of this */
-
-#endif /* _PPC_SHMPARAM_H */
diff --git a/include/asm-ppc/string.h b/include/asm-ppc/string.h
deleted file mode 100644
--- a/include/asm-ppc/string.h
+++ /dev/null
@@ -1,32 +0,0 @@
-#ifndef _PPC_STRING_H_
-#define _PPC_STRING_H_
-
-#ifdef __KERNEL__
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
-#endif /* __KERNEL__ */
-
-#endif
diff --git a/include/asm-ppc/unaligned.h b/include/asm-ppc/unaligned.h
deleted file mode 100644
--- a/include/asm-ppc/unaligned.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifdef __KERNEL__
-#ifndef __PPC_UNALIGNED_H
-#define __PPC_UNALIGNED_H
-
-/*
- * The PowerPC can do unaligned accesses itself in big endian mode.
- *
- * The strange macros are there to make sure these can't
- * be misused in a way that makes them not work on other
- * architectures where unaligned accesses aren't as simple.
- */
-
-#define get_unaligned(ptr) (*(ptr))
-
-#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
-
-#endif
-#endif /* __KERNEL__ */
diff --git a/include/asm-ppc64/errno.h b/include/asm-ppc64/errno.h
deleted file mode 100644
--- a/include/asm-ppc64/errno.h
+++ /dev/null
@@ -1,18 +0,0 @@
-#ifndef _PPC64_ERRNO_H
-#define _PPC64_ERRNO_H
-
-/* 
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <asm-generic/errno.h>
-
-#undef	EDEADLOCK
-#define	EDEADLOCK	58	/* File locking deadlock error */
-
-#define _LAST_ERRNO	516
-
-#endif
diff --git a/include/asm-ppc64/ioctl.h b/include/asm-ppc64/ioctl.h
deleted file mode 100644
--- a/include/asm-ppc64/ioctl.h
+++ /dev/null
@@ -1,74 +0,0 @@
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
diff --git a/include/asm-ppc64/ioctls.h b/include/asm-ppc64/ioctls.h
deleted file mode 100644
--- a/include/asm-ppc64/ioctls.h
+++ /dev/null
@@ -1,114 +0,0 @@
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
diff --git a/include/asm-ppc64/local.h b/include/asm-ppc64/local.h
deleted file mode 100644
--- a/include/asm-ppc64/local.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/local.h>
diff --git a/include/asm-ppc64/namei.h b/include/asm-ppc64/namei.h
deleted file mode 100644
--- a/include/asm-ppc64/namei.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* 
- * linux/include/asm-ppc/namei.h
- * Adapted from linux/include/asm-alpha/namei.h
- *
- * Included from linux/fs/namei.c
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifndef __PPC64_NAMEI_H
-#define __PPC64_NAMEI_H
-
-/* This dummy routine maybe changed to something useful
- * for /usr/gnemul/ emulation stuff.
- * Look at asm-sparc/namei.h for details.
- */
-
-#define __emul_prefix() NULL
-
-#endif /* __PPC64_NAMEI_H */
diff --git a/include/asm-ppc64/percpu.h b/include/asm-ppc64/percpu.h
deleted file mode 100644
--- a/include/asm-ppc64/percpu.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ARCH_PPC64_PERCPU__
-#define __ARCH_PPC64_PERCPU__
-
-#include <asm-generic/percpu.h>
-
-#endif /* __ARCH_PPC64_PERCPU__ */
diff --git a/include/asm-ppc64/poll.h b/include/asm-ppc64/poll.h
deleted file mode 100644
--- a/include/asm-ppc64/poll.h
+++ /dev/null
@@ -1,32 +0,0 @@
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
diff --git a/include/asm-ppc64/resource.h b/include/asm-ppc64/resource.h
deleted file mode 100644
--- a/include/asm-ppc64/resource.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _PPC64_RESOURCE_H
-#define _PPC64_RESOURCE_H
-
-#include <asm-generic/resource.h>
-
-#endif /* _PPC64_RESOURCE_H */
diff --git a/include/asm-ppc64/shmparam.h b/include/asm-ppc64/shmparam.h
deleted file mode 100644
--- a/include/asm-ppc64/shmparam.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef _PPC64_SHMPARAM_H
-#define _PPC64_SHMPARAM_H
-
-/*
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#define	SHMLBA PAGE_SIZE		 /* attach addr a multiple of this */
-
-#endif /* _PPC64_SHMPARAM_H */
diff --git a/include/asm-ppc64/string.h b/include/asm-ppc64/string.h
deleted file mode 100644
--- a/include/asm-ppc64/string.h
+++ /dev/null
@@ -1,35 +0,0 @@
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
diff --git a/include/asm-ppc64/unaligned.h b/include/asm-ppc64/unaligned.h
deleted file mode 100644
--- a/include/asm-ppc64/unaligned.h
+++ /dev/null
@@ -1,21 +0,0 @@
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
