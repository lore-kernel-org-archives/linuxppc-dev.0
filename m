From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: Please Help!, Need to test glibc 2.1.3 with these additional patches under 2.3 kernels
Date: Wed, 16 Feb 2000 08:18:57 -0500
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00021608270801.00938@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

glibc 2.1.3 is just about to go *final*

BUT...If we want glibc 2.1.3 to compile out of the box under PPC under 2.3.XX
kernels and actually work we really need people running 2.3.XX kernels to grab
the source from glibc cvs and apply the following patch and test this thing
asap and report some results.

please note, glibc 2.1.3 is now very *stable* under 2.2.X kernels with lots of
bug fixes and things.

The key issue here is finding out whether glibc 2.1.3 will compile and run
under 2.3.XX kernels.

If you are willing to help, please let me know and give this a try.

They will *not* hold up the release just for us, so your help and feedback would
be greatly appreciated.

Thanks,

Kevin




----------  Forwarded Message  ----------
Subject: Re: Time for glibc 2.1.3?
Date: 16 Feb 2000 13:48:23 +0100
From: Andreas Jaeger <aj@suse.de>


>>>>> Joel Klecker writes:

Joel> At 06:50 -0800 2000-02-15, Ulrich Drepper wrote:
>> Andreas Jaeger <aj@suse.de> writes:
>>
>>> what kind of showstoppers to we have for glibc 2.1.3?  What are your
>>> plans for releasing 2.1.3?
>>>
>>> I don't see any showstoppers for now.
>>
>> Geoff said there are big problems with PPC.

Joel> I've only encountered mmap64 and syscalls.list issues, but that works fine after
Joel> applying from the mainline Geoff's changes in those areas.

I'm appending a complete patch (ftruncate64 and truncate64 need
updating from glibc 2.2 also) which includes Joel's patch.

Ulrich, please apply this to 2.1.3.

This is should solve all problems with Linux 2.3.

Could one of the powerpc users double check that this patch works fine
with Linux 2.3 and send some feedback?

Thanks,
Andreas

2000-01-27  Geoff Keating  <geoffk@cygnus.com>

	* sysdeps/unix/sysv/linux/powerpc/ftruncate64.c: New file.
	* sysdeps/unix/sysv/linux/powerpc/mmap64.c: New file.
	* sysdeps/unix/sysv/linux/powerpc/syscalls.list: Add
	s_fstat64, s_ftruncate64, s_lstat64, s_mmap2, s_stat64,
	s_truncate64.
	* sysdeps/unix/sysv/linux/powerpc/truncate64.c: New file.

============================================================
Index: sysdeps/unix/sysv/linux/powerpc/syscalls.list
--- sysdeps/unix/sysv/linux/powerpc/syscalls.list	1999/12/02 08:25:29	1.13.2.3
+++ sysdeps/unix/sysv/linux/powerpc/syscalls.list	2000/02/16 12:43:22
@@ -12,12 +12,16 @@
 rt_sigqueueinfo	-	rt_sigqueueinfo	3	__syscall_rt_sigqueueinfo
 rt_sigsuspend	-	rt_sigsuspend	2	__syscall_rt_sigsuspend
 rt_sigtimedwait	-	rt_sigtimedwait	4	__syscall_rt_sigtimedwait
+s_fstat64	fxstat64 fstat64	2	__syscall_fstat64
+s_ftruncate64	ftruncate64 ftruncate64	3	__syscall_ftruncate64
 s_getcwd	getcwd	getcwd		2	__syscall_getcwd
 s_getdents	getdents getdents	3	__syscall_getdents
 s_getpriority	getpriority getpriority	2	__syscall_getpriority
 s_getresgid	getresgid getresgid	3	__syscall_getresgid
 s_getresuid	getresuid getresuid	3	__syscall_getresuid
 s_getrlimit	getrlimit getrlimit	2	__syscall_getrlimit
+s_lstat64	lxstat64 lstat64	2	__syscall_lstat64
+s_mmap2		mmap64	mmap2		6	__syscall_mmap2
 s_poll		poll	poll		3	__syscall_poll
 s_pread64	pread64	pread		5	__syscall_pread
 s_ptrace	ptrace	ptrace		4	__syscall_ptrace
@@ -28,8 +32,9 @@
 s_sigpending	sigpending sigpending	1	__syscall_sigpending
 s_sigprocmask	sigprocmask sigprocmask	3	__syscall_sigprocmask
 s_sigsuspend	sigsuspend sigsuspend	3	__syscall_sigsuspend
+s_stat64	xstat64 stat64		2	__syscall_stat64
 s_sysctl	sysctl	_sysctl		1	__syscall__sysctl
-s_ugetrlimit	getrlimit ugetrlimit	2	__syscall_ugetrlimit
+s_truncate64	truncate64 truncate64	3	__syscall_truncate64
 s_ustat		ustat	ustat		2	__syscall_ustat
 s_vfork		vfork	vfork		0	__syscall_vfork
 sys_fstat	fxstat	fstat		2	__syscall_fstat
============================================================
Index: sysdeps/unix/sysv/linux/powerpc/truncate64.c
--- sysdeps/unix/sysv/linux/powerpc/truncate64.c	created
+++ sysdeps/unix/sysv/linux/powerpc/truncate64.c	Wed Feb 16 13:24:48 2000	1.1
@@ -0,0 +1,63 @@
+/* Copyright (C) 1997, 1998, 1999, 2000 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Library General Public License as
+   published by the Free Software Foundation; either version 2 of the
+   License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Library General Public License for more details.
+
+   You should have received a copy of the GNU Library General Public
+   License along with the GNU C Library; see the file COPYING.LIB.  If not,
+   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+   Boston, MA 02111-1307, USA.  */
+
+#include <sys/types.h>
+#include <errno.h>
+#include <unistd.h>
+
+#include <sysdep.h>
+#include <sys/syscall.h>
+
+
+#ifdef __NR_truncate64
+/* The variable is shared between all wrappers around *truncate64 calls.  */
+int __have_no_truncate64;
+
+extern int __syscall_truncate64 (const char *path, off64_t length);
+
+
+/* Truncate the file FD refers to to LENGTH bytes.  */
+int
+truncate64 (path, length)
+     const char *path;
+     off64_t length;
+{
+  if (! __have_no_truncate64)
+    {
+      int saved_errno = errno;
+      int result = __syscall_truncate64 (path, length);
+
+      if (result != -1 || errno != ENOSYS)
+	return result;
+
+      __set_errno (saved_errno);
+      __have_no_truncate64 = 1;
+    }
+
+  if ((off_t) length != length)
+    {
+      __set_errno (EINVAL);
+      return -1;
+    }
+  return truncate (path, (off_t) length);
+}
+
+#else
+/* Use the generic implementation.  */
+# include <sysdeps/generic/truncate64.c>
+#endif
============================================================
Index: sysdeps/unix/sysv/linux/powerpc/ftruncate64.c
--- sysdeps/unix/sysv/linux/powerpc/ftruncate64.c	created
+++ sysdeps/unix/sysv/linux/powerpc/ftruncate64.c	Wed Feb 16 13:29:40 2000	1.1
@@ -0,0 +1,63 @@
+/* Copyright (C) 1997, 1998, 1999, 2000 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Library General Public License as
+   published by the Free Software Foundation; either version 2 of the
+   License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Library General Public License for more details.
+
+   You should have received a copy of the GNU Library General Public
+   License along with the GNU C Library; see the file COPYING.LIB.  If not,
+   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+   Boston, MA 02111-1307, USA.  */
+
+#include <sys/types.h>
+#include <errno.h>
+#include <unistd.h>
+
+#include <sysdep.h>
+#include <sys/syscall.h>
+
+
+#ifdef __NR_ftruncate64
+/* The variable is shared between all wrappers around *truncate64 calls.  */
+extern int __have_no_truncate64;
+
+extern int __syscall_ftruncate64 (int fd, off64_t length);
+
+
+/* Truncate the file FD refers to to LENGTH bytes.  */
+int
+ftruncate64 (fd, length)
+     int fd;
+     off64_t length;
+{
+  if (! __have_no_truncate64)
+    {
+      int saved_errno = errno;
+      int result = __syscall_ftruncate64 (fd, length);
+
+      if (result != -1 || errno != ENOSYS)
+	return result;
+
+      __set_errno (saved_errno);
+      __have_no_truncate64 = 1;
+    }
+
+  if ((off_t) length != length)
+    {
+      __set_errno (EINVAL);
+      return -1;
+    }
+  return __ftruncate (fd, (off_t) length);
+}
+
+#else
+/* Use the generic implementation.  */
+# include <sysdeps/generic/ftruncate64.c>
+#endif
============================================================
Index: sysdeps/unix/sysv/linux/powerpc/mmap64.c
--- sysdeps/unix/sysv/linux/powerpc/mmap64.c	created
+++ sysdeps/unix/sysv/linux/powerpc/mmap64.c	Wed Feb 16 13:40:47 2000	1.1
@@ -0,0 +1,63 @@
+/* Copyright (C) 1999, 2000 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+   Contributed by Jakub Jelinek <jakub@redhat.com>, 1999.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Library General Public License as
+   published by the Free Software Foundation; either version 2 of the
+   License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Library General Public License for more details.
+
+   You should have received a copy of the GNU Library General Public
+   License along with the GNU C Library; see the file COPYING.LIB.  If not,
+   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+   Boston, MA 02111-1307, USA.  */
+
+#include <errno.h>
+#include <unistd.h>
+
+#include <sysdep.h>
+#include <sys/syscall.h>
+
+#include <sys/mman.h>
+
+#include <asm/page.h>
+
+#ifdef __NR_mmap2
+extern int __syscall_mmap2(__ptr_t, size_t, int, int, int, off_t);
+static int have_no_mmap2;
+#endif
+
+__ptr_t
+__mmap64 (__ptr_t addr, size_t len, int prot, int flags, int fd, off64_t offset)
+{
+#ifdef __NR_mmap2
+  if (! have_no_mmap2 && ! (offset & PAGE_MASK))
+    {
+      int saved_errno = errno;
+
+      /* This will be always 12, no matter what page size is.  */
+      __ptr_t result = INLINE_SYSCALL (mmap2, 6, addr, len, prot, flags,
+				   fd, (off_t) (offset >> PAGE_SHIFT));
+
+      if (result != (__ptr_t) -1 || errno != ENOSYS)
+	return result;
+
+      __set_errno (saved_errno);
+      have_no_mmap2 = 1;
+    }
+#endif
+  if (offset != (off_t) offset || (offset + len) != (off_t) (offset + len))
+    {
+      __set_errno (EINVAL);
+      return MAP_FAILED;
+    }
+
+  return __mmap (addr, len, prot, flags, fd, (off_t) offset);
+}
+
+weak_alias (__mmap64, mmap64)

--
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.rhein-neckar.de
-------------------------------------------------------

--

--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
