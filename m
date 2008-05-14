Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1C6FCDDF3B
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 06:37:03 +1000 (EST)
Received: from cpe001d60ad7267-cm001225dbafb6.cpe.net.cable.rogers.com
	([99.236.100.208] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <rpjday@crashcourse.ca>)
	id 1JwMT1-0007NY-8Z
	for linuxppc-dev@ozlabs.org; Wed, 14 May 2008 15:16:47 -0400
Date: Wed, 14 May 2008 15:16:44 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
Subject: [PATCH] POWERPC: Remove ioctl.h content picked up from
	<asm-generic/ioctl.h>.
Message-ID: <alpine.LFD.1.10.0805141515190.22481@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Now that <asm-generic/ioctl.h> allows overriding of the most commonly
changed macros, take advantage of that.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  i *think* this results in an equivalent ioctl.h file, but feel free
to check it carefully, and tweak if necessary.

diff --git a/include/asm-powerpc/ioctl.h b/include/asm-powerpc/ioctl.h
index 8eb9984..57d6830 100644
--- a/include/asm-powerpc/ioctl.h
+++ b/include/asm-powerpc/ioctl.h
@@ -1,69 +1,13 @@
 #ifndef _ASM_POWERPC_IOCTL_H
 #define _ASM_POWERPC_IOCTL_H

-
-/*
- * this was copied from the alpha as it's a bit cleaner there.
- *                         -- Cort
- */
-
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
 #define _IOC_SIZEBITS	13
 #define _IOC_DIRBITS	3

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
 #define _IOC_NONE	1U
 #define _IOC_READ	2U
 #define _IOC_WRITE	4U

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
+#include <asm-generic/ioctl.h>

 #endif	/* _ASM_POWERPC_IOCTL_H */

========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
