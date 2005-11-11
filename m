Return-Path: <tom_gall@vnet.ibm.com>
Date: Fri, 11 Nov 2005 16:11:00 -0600 (CST)
From: Tom Gall <tom_gall@vnet.ibm.com>
To: libc-alpha@sources.redhat.com
Message-ID: <Pine.LNX.4.64.0511111555580.6838@triton>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org, munroesj@us.ibm.com
Subject: [PATCH] glibc vDSO bits for ppc/ppc64 update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Greetings,

Enclosed is the next revision of the glibc vDSO implementation for 
ppc/ppc64 that goes hand in hand with benh's vDSO kernel work currently 
available at http://gate.crashing.org/~benh/ppc64-vdso-update.diff.

Implemented are:

__vdso_gettimeofdate
__vdso_clock_gettime
__vdso_clock_getres
__vdso_get_tbfreq

New to this patch as compared to the last posting is a rework for 
symbol lookup to use _dl_vdso_weakref which as a nice side effect
when vdso symbols aren't found anoying error messages are no longer
printed.

Additional hp_timer_t is now declared as unsigned long long int 
to match up with benh's get_tbfreq on 32 bit ppc. (ppc64 is already
64 bit)

Appreciate comments, questions and suggestions!

2005-11-11  Steven Munroe  <sjmunroe@us.ibm.com>
            Tom Gall <tom_gall@vnet.ibm.com>

	* elf/rtld.c (dl_main): Initialize l_local_scope for sysinfo_map.
	* sysdeps/powerpc/elf/libc-start.c: Move this.
	* sysdeps/unix/sysv/linux/powerpc/libc-start.c: To here.
	* sysdeps/powerpc/Versions: add __vdso_get_tbfreq symbol
	* sysdeps/unix/sysv/linux/powerpc/bits/libc-vdso.h: New file.
	* sysdeps/unix/sysv/linux/powerpc/clock_getres.c: New file.
	* sysdeps/unix/sysv/linux/powerpc/clock_gettime.c: New file.
	* sysdeps/unix/sysv/linux/powerpc/dl-vdso.c: New file.
	* sysdeps/unix/sysv/linux/powerpc/dl-vdso.h: New file.
	* sysdeps/unix/sysv/linux/powerpc/get_clockfreq.c: use vDSO / format
	* sysdeps/unix/sysv/linux/powerpc/gettimeofday.c: New file.
	* sysdeps/unix/sysv/linux/powerpc/Makefile: Add routines += dl-vdso.
	* sysdeps/powerpc/powerpc32/hp-timing.h: New file.

diff -uNr libc/elf/rtld.c libc-41-32/elf/rtld.c
--- libc/elf/rtld.c	2005-11-11 11:18:09.389605816 -0500
+++ libc-41-32/elf/rtld.c	2005-11-11 09:31:48.000000000 -0500
@@ -1296,6 +1296,13 @@
 	  elf_get_dynamic_info (l, dyn_temp);
 	  _dl_setup_hash (l);
 	  l->l_relocated = 1;
+	  /* Initialize l_local_scope to contain just this map. This allows 
+	     the use of dl_lookup_symbol_x to resolve symbols within the vdso.
+	     So we create a single entry list pointing to l_real as its only
+	     element */
+	  
+	  l->l_local_scope[0]->r_nlist = 1;
+	  l->l_local_scope[0]->r_list = &l->l_real;
 
 	  /* Now that we have the info handy, use the DSO image's soname
 	     so this object can be looked up by name.  Note that we do not
diff -uNr libc/sysdeps/powerpc/elf/libc-start.c libc-41-32/sysdeps/powerpc/elf/libc-start.c
--- libc/sysdeps/powerpc/elf/libc-start.c	2005-11-11 11:18:20.366667224 -0500
+++ libc-41-32/sysdeps/powerpc/elf/libc-start.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,99 +0,0 @@
-/* Copyright (C) 1998,2000,2001,2002,2003,2004 Free Software Foundation, Inc.
-   This file is part of the GNU C Library.
-
-   The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Lesser General Public
-   License as published by the Free Software Foundation; either
-   version 2.1 of the License, or (at your option) any later version.
-
-   The GNU C Library is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Lesser General Public License for more details.
-
-   You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
-   02111-1307 USA.  */
-
-#include <stdlib.h>
-#include <unistd.h>
-#include <ldsodefs.h>
-#include <bp-start.h>
-#include <bp-sym.h>
-
-extern int __cache_line_size;
-weak_extern (__cache_line_size)
-
-/* The main work is done in the generic function.  */
-#define LIBC_START_MAIN generic_start_main
-#define LIBC_START_DISABLE_INLINE
-#define LIBC_START_MAIN_AUXVEC_ARG
-#define MAIN_AUXVEC_ARG
-#include <sysdeps/generic/libc-start.c>
-
-
-struct startup_info
-{
-  void *__unbounded sda_base;
-  int (*main) (int, char **, char **, void *);
-  int (*init) (int, char **, char **, void *);
-  void (*fini) (void);
-};
-
-
-int
-/* GKM FIXME: GCC: this should get __BP_ prefix by virtue of the
-   BPs in the arglist of startup_info.main and startup_info.init. */
-BP_SYM (__libc_start_main) (int argc, char *__unbounded *__unbounded ubp_av,
-			    char *__unbounded *__unbounded ubp_ev,
-			    ElfW(auxv_t) *__unbounded auxvec,
-			    void (*rtld_fini) (void),
-			    struct startup_info *__unbounded stinfo,
-			    char *__unbounded *__unbounded stack_on_entry)
-{
-#if __BOUNDED_POINTERS__
-  char **argv;
-#else
-# define argv ubp_av
-#endif
-
-  /* the PPC SVR4 ABI says that the top thing on the stack will
-     be a NULL pointer, so if not we assume that we're being called
-     as a statically-linked program by Linux...	 */
-  if (*stack_on_entry != NULL)
-    {
-      char *__unbounded *__unbounded temp;
-      /* ...in which case, we have argc as the top thing on the
-	 stack, followed by argv (NULL-terminated), envp (likewise),
-	 and the auxilary vector.  */
-      /* 32/64-bit agnostic load from stack */
-      argc = *(long int *__unbounded) stack_on_entry;
-      ubp_av = stack_on_entry + 1;
-      ubp_ev = ubp_av + argc + 1;
-#ifdef HAVE_AUX_VECTOR
-      temp = ubp_ev;
-      while (*temp != NULL)
-        ++temp;
-      auxvec = (ElfW(auxv_t) *)++temp;
-#endif
-      rtld_fini = NULL;
-    }
-
-  /* Initialize the __cache_line_size variable from the aux vector.  */
-  for (ElfW(auxv_t) *av = auxvec; av->a_type != AT_NULL; ++av)
-    switch (av->a_type)
-      {
-      case AT_DCACHEBSIZE:
-        {
-          int *cls = & __cache_line_size;
-          if (cls != NULL)
-            *cls = av->a_un.a_val;
-        }
-        break;
-      }
-
-  return generic_start_main (stinfo->main, argc, ubp_av, auxvec,
-			     stinfo->init, stinfo->fini, rtld_fini,
-			     stack_on_entry);
-}
diff -uNr libc/sysdeps/powerpc/Versions libc-41-32/sysdeps/powerpc/Versions
--- libc/sysdeps/powerpc/Versions	2005-11-11 11:18:20.367667072 -0500
+++ libc-41-32/sysdeps/powerpc/Versions	2005-11-11 09:31:48.000000000 -0500
@@ -13,5 +13,6 @@
   GLIBC_PRIVATE {
     __novmx__libc_longjmp; __novmx__libc_siglongjmp;
     __vmx__libc_longjmp; __vmx__libc_siglongjmp;
+    __vdso_get_tbfreq;
   }
 }
diff -uNr libc/sysdeps/unix/sysv/linux/powerpc/bits/libc-vdso.h libc-41-32/sysdeps/unix/sysv/linux/powerpc/bits/libc-vdso.h
--- libc/sysdeps/unix/sysv/linux/powerpc/bits/libc-vdso.h	1969-12-31 19:00:00.000000000 -0500
+++ libc-41-32/sysdeps/unix/sysv/linux/powerpc/bits/libc-vdso.h	2005-11-11 09:31:48.000000000 -0500
@@ -0,0 +1,36 @@
+/* Resolved function pointers to VDSO functions.
+   Copyright (C) 2005 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+
+#ifndef _LIBC_VDSO_H
+#define _LIBC_VDSO_H
+
+#ifdef SHARED
+
+typedef int (* __vdso_gettimeofday_t)(void *, void *);
+
+typedef int (* __vdso_clock_gettime_t)(clockid_t, struct timespec *);
+
+typedef int (* __vdso_clock_getres_t)(struct timeval*, void*);
+
+typedef hp_timing_t (* __vdso_get_tbfreq_t)(void);
+
+#endif
+
+#endif /* _LIBC_VDSO_H */
diff -uNr libc/sysdeps/unix/sysv/linux/powerpc/clock_getres.c libc-41-32/sysdeps/unix/sysv/linux/powerpc/clock_getres.c
--- libc/sysdeps/unix/sysv/linux/powerpc/clock_getres.c	1969-12-31 19:00:00.000000000 -0500
+++ libc-41-32/sysdeps/unix/sysv/linux/powerpc/clock_getres.c	2005-11-11 09:31:48.000000000 -0500
@@ -0,0 +1,197 @@
+/* clock_getres -- Get the resolution of a POSIX clockid_t.  Linux version.
+   Copyright (C) 2003, 2004 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <sysdep.h>
+#include <errno.h>
+#include <time.h>
+#include <sysdeps/unix/sysv/linux/kernel-posix-cpu-timers.h>
+#include <sysdeps/unix/sysv/linux/kernel-features.h>
+
+#undef __clock_getres
+#include <bits/libc-vdso.h>
+
+
+#define SYSCALL_GETRES_MONOTONIC \
+#ifdef SHARED                    \
+  if (__vdso_clock_getres== NULL)\
+    retval = INLINE_SYSCALL (clock_getres, 2, clock_id, res); \
+  else \
+    return (__vdso_clock_getres) (clock_id, tp); \
+  break
+
+#define SYSCALL_GETRES_REALTIME \
+  retval = INLINE_SYSCALL (clock_getres, 2, clock_id, res); \
+  break
+
+#ifdef __ASSUME_POSIX_TIMERS
+
+/* This means the REALTIME and MONOTONIC clock are definitely
+   supported in the kernel.  */
+# define SYSDEP_GETRES							      \
+  SYSDEP_GETRES_CPUTIME						      \
+  case CLOCK_REALTIME:							      \
+    SYSCALL_GETRES_REALTIME                                                  \
+  case CLOCK_MONOTONIC:						      \
+    SYSCALL_GETRES_MONOTONIC
+
+# define __libc_missing_posix_timers 0
+#elif defined __NR_clock_getres
+/* Is the syscall known to exist?  */
+extern int __libc_missing_posix_timers attribute_hidden;
+
+static inline int
+maybe_syscall_getres (clockid_t clock_id, struct timespec *res)
+{
+  int e = EINVAL;
+
+  if (!__libc_missing_posix_timers)
+    {
+      INTERNAL_SYSCALL_DECL (err);
+      int r = INTERNAL_SYSCALL (clock_getres, err, 2, clock_id, res);
+      if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+	return 0;
+
+      e = INTERNAL_SYSCALL_ERRNO (r, err);
+      if (e == ENOSYS)
+	{
+	  __libc_missing_posix_timers = 1;
+	  e = EINVAL;
+	}
+    }
+
+  return e;
+}
+
+/* The REALTIME and MONOTONIC clock might be available.  Try the
+   syscall first.  */
+# define SYSDEP_GETRES							      \
+  SYSDEP_GETRES_CPUTIME						      \
+  case CLOCK_REALTIME:							      \
+  case CLOCK_MONOTONIC:						      \
+    retval = maybe_syscall_getres (clock_id, res);			      \
+    if (retval == 0)							      \
+      break;								      \
+    /* Fallback code.  */						      \
+    if (retval == EINVAL && clock_id == CLOCK_REALTIME)		      \
+      retval = realtime_getres (res);					      \
+    else								      \
+      {								      \
+	__set_errno (retval);						      \
+	retval = -1;							      \
+      }								      \
+    break;
+#endif
+
+#ifdef __NR_clock_getres
+/* We handled the REALTIME clock here.  */
+# define HANDLED_REALTIME	1
+# define HANDLED_CPUTIME	1
+
+# if __ASSUME_POSIX_CPU_TIMERS > 0
+
+#  define SYSDEP_GETRES_CPU SYSCALL_GETRES
+#  define SYSDEP_GETRES_CPUTIME	/* Default catches them too.  */
+
+# else
+
+extern int __libc_missing_posix_cpu_timers attribute_hidden;
+
+static int
+maybe_syscall_getres_cpu (clockid_t clock_id, struct timespec *res)
+{
+  int e = EINVAL;
+
+  if (!__libc_missing_posix_cpu_timers)
+    {
+      INTERNAL_SYSCALL_DECL (err);
+      int r = INTERNAL_SYSCALL (clock_getres, err, 2, clock_id, res);
+      if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+	return 0;
+
+      e = INTERNAL_SYSCALL_ERRNO (r, err);
+# ifndef __ASSUME_POSIX_TIMERS
+      if (e == ENOSYS)
+	{
+	  __libc_missing_posix_timers = 1;
+	  __libc_missing_posix_cpu_timers = 1;
+	  e = EINVAL;
+	}
+      else
+# endif
+	{
+	  if (e == EINVAL)
+	    {
+	      /* Check whether the kernel supports CPU clocks at all.
+		 If not, record it for the future.  */
+	      r = INTERNAL_SYSCALL (clock_getres, err, 2,
+				    MAKE_PROCESS_CPUCLOCK (0, CPUCLOCK_SCHED),
+				    NULL);
+	      if (INTERNAL_SYSCALL_ERROR_P (r, err))
+		__libc_missing_posix_cpu_timers = 1;
+	    }
+	}
+    }
+
+  return e;
+}
+
+#  define SYSDEP_GETRES_CPU						      \
+  retval = maybe_syscall_getres_cpu (clock_id, res);			      \
+  if (retval == 0)							      \
+    break;								      \
+  if (retval != EINVAL || !__libc_missing_posix_cpu_timers)		      \
+    {									      \
+      __set_errno (retval);						      \
+      retval = -1;							      \
+      break;								      \
+    }									      \
+  retval = -1 /* Otherwise continue on to the HP_TIMING version.  */;
+
+static inline int
+maybe_syscall_getres_cputime (clockid_t clock_id, struct timespec *res)
+{
+  return maybe_syscall_getres_cpu
+    (clock_id == CLOCK_THREAD_CPUTIME_ID
+     ? MAKE_THREAD_CPUCLOCK (0, CPUCLOCK_SCHED)
+     : MAKE_PROCESS_CPUCLOCK (0, CPUCLOCK_SCHED),
+     res);
+}
+
+#  define SYSDEP_GETRES_CPUTIME					      \
+    case CLOCK_PROCESS_CPUTIME_ID:					      \
+    case CLOCK_THREAD_CPUTIME_ID:					      \
+      retval = maybe_syscall_getres_cputime (clock_id, res);		      \
+      if (retval == 0)							      \
+	break;								      \
+      if (retval != EINVAL || !__libc_missing_posix_cpu_timers)	      \
+	{								      \
+	  __set_errno (retval);						      \
+	  retval = -1;							      \
+	  break;							      \
+	}								      \
+      retval = hp_timing_getres (res);					      \
+      break;
+#  if !HP_TIMING_AVAIL
+#   define hp_timing_getres(res) (__set_errno (EINVAL), -1)
+#  endif
+
+# endif
+#endif
+
+#include <sysdeps/posix/clock_getres.c>
diff -uNr libc/sysdeps/unix/sysv/linux/powerpc/clock_gettime.c libc-41-32/sysdeps/unix/sysv/linux/powerpc/clock_gettime.c
--- libc/sysdeps/unix/sysv/linux/powerpc/clock_gettime.c	1969-12-31 19:00:00.000000000 -0500
+++ libc-41-32/sysdeps/unix/sysv/linux/powerpc/clock_gettime.c	2005-11-11 09:31:48.000000000 -0500
@@ -0,0 +1,196 @@
+/* clock_gettime -- Get current time from a POSIX clockid_t.  Linux version.
+   Copyright (C) 2003, 2004 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <sysdep.h>
+#include <errno.h>
+#include <time.h>
+#include <sysdeps/unix/sysv/linux/kernel-posix-cpu-timers.h>
+#include <sysdeps/unix/sysv/linux/kernel-features.h>
+
+#undef __clock_gettime
+#include <bits/libc-vdso.h>
+
+#define SYSCALL_GETTIME_CLOCK_MONOTONIC \
+#ifdef SHARED                           \
+  if (__vdso_clock_gettime== NULL)      \
+    retval = INLINE_SYSCALL (clock_gettime, 2, clock_id, tp); \
+  else \
+    return (__vdso_clock_gettime) (clock_id, tp); \
+  break
+
+#define SYSCALL_GETTIME_CLOCK_REALTIME \
+  retval = INLINE_SYSCALL (clock_gettime, 2, clock_id, tp); \
+  break
+
+#ifdef __ASSUME_POSIX_TIMERS
+
+/* This means the REALTIME and MONOTONIC clock are definitely
+   supported in the kernel.  */
+# define SYSDEP_GETTIME						      \
+  SYSDEP_GETTIME_CPUTIME						      \
+  case CLOCK_REALTIME:							      \
+    SYSCALL_GETTIME_CLOCK_REALTIME                                           \
+  case CLOCK_MONOTONIC:						      \
+    SYSCALL_GETTIME_CLOCK_MONOTONIC
+
+# define __libc_missing_posix_timers 0
+#elif defined __NR_clock_gettime
+/* Is the syscall known to exist?  */
+int __libc_missing_posix_timers attribute_hidden;
+
+static inline int
+maybe_syscall_gettime (clockid_t clock_id, struct timespec *tp)
+{
+  int e = EINVAL;
+
+  if (!__libc_missing_posix_timers)
+    {
+      INTERNAL_SYSCALL_DECL (err);
+      int r = INTERNAL_SYSCALL (clock_gettime, err, 2, clock_id, tp);
+      if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+	return 0;
+
+      e = INTERNAL_SYSCALL_ERRNO (r, err);
+      if (e == ENOSYS)
+	{
+	  __libc_missing_posix_timers = 1;
+	  e = EINVAL;
+	}
+    }
+
+  return e;
+}
+
+/* The REALTIME and MONOTONIC clock might be available.  Try the
+   syscall first.  */
+# define SYSDEP_GETTIME						      \
+  SYSDEP_GETTIME_CPUTIME						      \
+  case CLOCK_REALTIME:							      \
+  case CLOCK_MONOTONIC:						      \
+    retval = maybe_syscall_gettime (clock_id, tp);			      \
+    if (retval == 0)							      \
+      break;								      \
+    /* Fallback code.  */						      \
+    if (retval == EINVAL && clock_id == CLOCK_REALTIME)		      \
+      retval = realtime_gettime (tp);					      \
+    else 								      \
+      {								      \
+	__set_errno (retval);						      \
+	retval = -1;							      \
+      }								      \
+    break;
+#endif
+
+#ifdef __NR_clock_gettime
+/* We handled the REALTIME clock here.  */
+# define HANDLED_REALTIME	1
+# define HANDLED_CPUTIME	1
+
+# if __ASSUME_POSIX_CPU_TIMERS > 0
+
+#  define SYSDEP_GETTIME_CPU SYSCALL_GETTIME
+#  define SYSDEP_GETTIME_CPUTIME	/* Default catches them too.  */
+
+# else
+
+int __libc_missing_posix_cpu_timers attribute_hidden;
+
+static int
+maybe_syscall_gettime_cpu (clockid_t clock_id, struct timespec *tp)
+{
+  int e = EINVAL;
+
+  if (!__libc_missing_posix_cpu_timers)
+    {
+      INTERNAL_SYSCALL_DECL (err);
+      int r = INTERNAL_SYSCALL (clock_gettime, err, 2, clock_id, tp);
+      if (!INTERNAL_SYSCALL_ERROR_P (r, err))
+	return 0;
+
+      e = INTERNAL_SYSCALL_ERRNO (r, err);
+# ifndef __ASSUME_POSIX_TIMERS
+      if (e == ENOSYS)
+	{
+	  __libc_missing_posix_timers = 1;
+	  __libc_missing_posix_cpu_timers = 1;
+	  e = EINVAL;
+	}
+      else
+# endif
+	{
+	  if (e == EINVAL)
+	    {
+	      /* Check whether the kernel supports CPU clocks at all.
+		 If not, record it for the future.  */
+	      r = INTERNAL_SYSCALL (clock_getres, err, 2,
+				    MAKE_PROCESS_CPUCLOCK (0, CPUCLOCK_SCHED),
+				    NULL);
+	      if (INTERNAL_SYSCALL_ERROR_P (r, err))
+		__libc_missing_posix_cpu_timers = 1;
+	    }
+	}
+    }
+
+  return e;
+}
+
+#  define SYSDEP_GETTIME_CPU						      \
+  retval = maybe_syscall_gettime_cpu (clock_id, tp);			      \
+  if (retval == 0)							      \
+    break;								      \
+  if (retval != EINVAL || !__libc_missing_posix_cpu_timers)		      \
+    {									      \
+      __set_errno (retval);						      \
+      retval = -1;							      \
+      break;								      \
+    }									      \
+  retval = -1 /* Otherwise continue on to the HP_TIMING version.  */;
+
+static inline int
+maybe_syscall_gettime_cputime (clockid_t clock_id, struct timespec *tp)
+{
+  return maybe_syscall_gettime_cpu
+    (clock_id == CLOCK_THREAD_CPUTIME_ID
+     ? MAKE_THREAD_CPUCLOCK (0, CPUCLOCK_SCHED)
+     : MAKE_PROCESS_CPUCLOCK (0, CPUCLOCK_SCHED),
+     tp);
+}
+
+#  define SYSDEP_GETTIME_CPUTIME					      \
+    case CLOCK_PROCESS_CPUTIME_ID:					      \
+    case CLOCK_THREAD_CPUTIME_ID:					      \
+      retval = maybe_syscall_gettime_cputime (clock_id, tp);		      \
+      if (retval == 0)							      \
+	break;								      \
+      if (retval != EINVAL || !__libc_missing_posix_cpu_timers)	      \
+	{								      \
+	  __set_errno (retval);						      \
+	  retval = -1;							      \
+	  break;							      \
+	}								      \
+      retval = hp_timing_gettime (clock_id, tp);			      \
+      break;
+#  if !HP_TIMING_AVAIL
+#   define hp_timing_gettime(clock_id, tp) (__set_errno (EINVAL), -1)
+#  endif
+
+# endif
+#endif
+
+#include <sysdeps/unix/clock_gettime.c>
diff -uNr libc/sysdeps/unix/sysv/linux/powerpc/dl-vdso.c libc-41-32/sysdeps/unix/sysv/linux/powerpc/dl-vdso.c
--- libc/sysdeps/unix/sysv/linux/powerpc/dl-vdso.c	1969-12-31 19:00:00.000000000 -0500
+++ libc-41-32/sysdeps/unix/sysv/linux/powerpc/dl-vdso.c	2005-11-11 11:09:33.054571056 -0500
@@ -0,0 +1,128 @@
+/* VDSO symbol handling in the ELF dynamic linker.
+   Copyright (C) 2005 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include "config.h"
+#include <dl-hash.h>
+#include <ldsodefs.h>
+
+/* This function attempts to resolve a symbol in the VDSO map but
+   simply returns NULL if it is not there.  This is intended for the
+   syscall replacement case where the runtime can fail-safe back to
+   the syscall.  For example if we are running on an older kernel
+   that does not implement the specific function yet.  */
+
+void *internal_function
+_dl_vdso_weakref (const char *name)
+{
+  const ElfW (Sym) * ref = NULL;
+  struct link_map *map = GLRO (dl_sysinfo_map);
+  void *value = NULL;
+  lookup_t result;
+
+  if (map != NULL)
+    {
+      /* This is a tricky because by default _dl_lookup_symbol_x will fail
+         and exit if the symbol is not found.  Specifying a "skip_map" is
+         one case where _dl_loopup_symbol_x will do what we want,  but the
+         l_local_scope in the dl_sysinfo_map will not to give the desired
+         result.  So we create a dummy scope and link-map struct to be
+         the "skip_map".  As the dummy.l_real points back to the real VDSO
+         map, do_lookup_x can find the symbol if it is there.  */
+      struct r_scope_elem *symbol_scope[2];
+      struct link_map *scope_list[2];
+      struct r_scope_elem dummy_scope;
+      struct link_map dummy;
+
+      symbol_scope[0] = &dummy_scope;
+      symbol_scope[1] = NULL;
+      symbol_scope[0]->r_nlist = 2;
+      symbol_scope[0]->r_list = &scope_list[0];
+      scope_list[0] = map->l_local_scope[0]->r_list[0];
+      scope_list[1] = &dummy;
+      dummy.l_real = map->l_real;
+
+      /* Search the scope of the given vdso map.  */
+      result = GLRO (dl_lookup_symbol_x) (name, map, &ref,
+					  symbol_scope, NULL, 0, 0, &dummy);
+
+      if (ref != NULL)
+	{
+	  value = DL_SYMBOL_ADDRESS (result, ref);
+	}
+    }
+
+  return value;
+}
+
+
+void *internal_function
+_dl_vdso_sym (const char *name)
+{
+  const ElfW (Sym) * ref = NULL;
+  struct link_map *map = GLRO (dl_sysinfo_map);
+  void *value = NULL;
+  lookup_t result;
+
+  if (map != NULL)
+    {
+      /* Search the scope of the given vdso map.  */
+      result = GLRO (dl_lookup_symbol_x) (name, map, &ref,
+					  map->l_local_scope,
+					  NULL, 0, 0, NULL);
+
+      if (ref != NULL)
+	{
+	  value = DL_SYMBOL_ADDRESS (result, ref);
+	}
+    }
+
+  return value;
+}
+
+void *internal_function
+_dl_vdso_vsym (const char *name, const char *version)
+{
+  const ElfW (Sym) * ref = NULL;
+  struct link_map *map = GLRO (dl_sysinfo_map);
+  void *value = NULL;
+  struct r_found_version vers;
+  lookup_t result;
+
+  if (map != NULL)
+    {
+      /* Compute hash value to the version string.  */
+      vers.name = version;
+      vers.hidden = 1;
+      vers.hash = _dl_elf_hash (version);
+      /* We don't have a specific file where the symbol can be found.  */
+      vers.filename = NULL;
+
+      /* Search the scope of the vdso map.  */
+      result = GLRO (dl_lookup_symbol_x) (name, map, &ref,
+					  map->l_local_scope,
+					  &vers, 0, 0, NULL);
+
+      if (ref != NULL)
+	{
+	  value = DL_SYMBOL_ADDRESS (result, ref);
+
+	}
+    }
+  return value;
+}
diff -uNr libc/sysdeps/unix/sysv/linux/powerpc/dl-vdso.h libc-41-32/sysdeps/unix/sysv/linux/powerpc/dl-vdso.h
--- libc/sysdeps/unix/sysv/linux/powerpc/dl-vdso.h	1969-12-31 19:00:00.000000000 -0500
+++ libc-41-32/sysdeps/unix/sysv/linux/powerpc/dl-vdso.h	2005-11-11 09:31:48.000000000 -0500
@@ -0,0 +1,33 @@
+/* Run-time dynamic linker data structures for loaded ELF shared objects.
+   Copyright (C) 2005 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#ifndef	_DL_VDSO_H
+#define _DL_VDSO_H
+
+/* Functions for resolving symbols in the VDSO link map.  */
+     extern void *_dl_vdso_weakref (const char *name)
+     internal_function attribute_hidden;
+
+     extern void *_dl_vdso_sym (const char *name)
+     internal_function attribute_hidden;
+
+     extern void *_dl_vdso_vsym (const char *name, const char *version)
+     internal_function attribute_hidden;
+
+#endif /* ldsodefs.h */
diff -uNr libc/sysdeps/unix/sysv/linux/powerpc/get_clockfreq.c libc-41-32/sysdeps/unix/sysv/linux/powerpc/get_clockfreq.c
--- libc/sysdeps/unix/sysv/linux/powerpc/get_clockfreq.c	2005-11-11 11:18:22.804563648 -0500
+++ libc-41-32/sysdeps/unix/sysv/linux/powerpc/get_clockfreq.c	2005-11-11 09:31:48.000000000 -0500
@@ -22,7 +22,11 @@
 #include <string.h>
 #include <unistd.h>
 #include <libc-internal.h>
+#include <bits/libc-vdso.h>
 
+#ifdef SHARED
+extern __vdso_get_tbfreq_t __vdso_get_tbfreq;
+#endif
 
 hp_timing_t
 __get_clockfreq (void)
@@ -38,68 +42,78 @@
   if (timebase_freq != 0)
     return timebase_freq;
 
-  int fd = open ("/proc/cpuinfo", O_RDONLY);
-  if (__builtin_expect (fd != -1, 1))
+  /* if we can use the vDSO to obtain the timebase even better */
+#ifdef SHARED
+  if (__vdso_get_tbfreq != NULL)
     {
-      /* The timebase will be in the 1st 1024 bytes for systems with up
-         to 8 processors.  If the first read returns less then 1024
-	 bytes read,  we have the whole cpuinfo and can start the scan.
-	 Otherwise we will have to read more to insure we have the
-	 timebase value in the scan.  */
-      char buf[1024];
-      ssize_t n;
-
-      n = read (fd, buf, sizeof (buf));
-      if (n == sizeof (buf))
-	{
-	  /* We are here because the 1st read returned exactly sizeof
-	     (buf) bytes.  This implies that we are not at EOF and may
-	     not have read the timebase value yet.  So we need to read
-	     more bytes until we know we have EOF.  We copy the lower
-	     half of buf to the upper half and read sizeof (buf)/2
-	     bytes into the lower half of buf and repeat until we
-	     reach EOF.  We can assume that the timebase will be in
-	     the last 512 bytes of cpuinfo, so two 512 byte half_bufs
-	     will be sufficient to contain the timebase and will
-	     handle the case where the timebase spans the half_buf
-	     boundry.  */
-	  const ssize_t half_buf = sizeof (buf) / 2;
-	  while (n >= half_buf)
-	    {
-	      memcpy (buf, buf + half_buf, half_buf);
-	      n = read (fd, buf + half_buf, half_buf);
-	    }
-	  if (n >= 0)
-	    n += half_buf;
-	}
-
-      if (__builtin_expect (n, 1) > 0)
-	{
-	  char *mhz = memmem (buf, n, "timebase", 7);
-
-	  if (__builtin_expect (mhz != NULL, 1))
-	    {
-	      char *endp = buf + n;
-
-	      /* Search for the beginning of the string.  */
-	      while (mhz < endp && (*mhz < '0' || *mhz > '9') && *mhz != '\n')
-		++mhz;
-
-	      while (mhz < endp && *mhz != '\n')
-		{
-		  if (*mhz >= '0' && *mhz <= '9')
-		    {
-		      result *= 10;
-		      result += *mhz - '0';
-		    }
+    timebase_freq=(__vdso_get_tbfreq)();
+    }  
+  else
+#endif
+    {
+    int fd = open ("/proc/cpuinfo", O_RDONLY);
 
+    if (__builtin_expect (fd != -1, 1))
+      {
+        /* The timebase will be in the 1st 1024 bytes for systems with up
+           to 8 processors.  If the first read returns less then 1024
+	   bytes read,  we have the whole cpuinfo and can start the scan.
+	   Otherwise we will have to read more to insure we have the
+	   timebase value in the scan.  */
+        char buf[1024];
+        ssize_t n;
+
+        n = read (fd, buf, sizeof (buf));
+        if (n == sizeof (buf))
+	  {
+	    /* We are here because the 1st read returned exactly sizeof
+	       (buf) bytes.  This implies that we are not at EOF and may
+	       not have read the timebase value yet.  So we need to read
+	       more bytes until we know we have EOF.  We copy the lower
+	       half of buf to the upper half and read sizeof (buf)/2
+	       bytes into the lower half of buf and repeat until we
+	       reach EOF.  We can assume that the timebase will be in
+	       the last 512 bytes of cpuinfo, so two 512 byte half_bufs
+	       will be sufficient to contain the timebase and will
+	       handle the case where the timebase spans the half_buf
+	       boundry.  */
+	    const ssize_t half_buf = sizeof (buf) / 2;
+	    while (n >= half_buf)
+	      {
+	        memcpy (buf, buf + half_buf, half_buf);
+	        n = read (fd, buf + half_buf, half_buf);
+	      }
+	    if (n >= 0)
+	      n += half_buf;
+	  }
+
+        if (__builtin_expect (n, 1) > 0)
+	  {
+	    char *mhz = memmem (buf, n, "timebase", 7);
+
+	    if (__builtin_expect (mhz != NULL, 1))
+	      {
+  	        char *endp = buf + n;
+ 
+	        /* Search for the beginning of the string.  */
+	        while (mhz < endp && (*mhz < '0' || *mhz > '9') && *mhz != '\n')
 		  ++mhz;
-		}
-	    }
-	  timebase_freq = result;
-	}
-      close (fd);
-    }
 
+	        while (mhz < endp && *mhz != '\n')
+		  {
+		    if (*mhz >= '0' && *mhz <= '9')
+		      {
+		        result *= 10;
+		        result += *mhz - '0';
+		      }
+
+		    ++mhz;
+		  }
+	      }
+	    timebase_freq = result;
+	  }
+        close (fd);
+      }
+  }
   return timebase_freq;
 }
diff -uNr libc/sysdeps/unix/sysv/linux/powerpc/gettimeofday.c libc-41-32/sysdeps/unix/sysv/linux/powerpc/gettimeofday.c
--- libc/sysdeps/unix/sysv/linux/powerpc/gettimeofday.c	1969-12-31 19:00:00.000000000 -0500
+++ libc-41-32/sysdeps/unix/sysv/linux/powerpc/gettimeofday.c	2005-11-11 09:31:48.000000000 -0500
@@ -0,0 +1,54 @@
+/* Copyright (C) 2005 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <sysdep.h>
+#include <bp-checks.h>
+#include <stddef.h>
+#include <sys/time.h>
+#include <time.h>
+#include <hp-timing.h>
+
+#undef __gettimeofday
+#include <bits/libc-vdso.h>
+
+/* Get the current time of day and timezone information,
+   putting it into *TV and *TZ.  If TZ is NULL, *TZ is not filled.
+   Returns 0 on success, -1 on errors.  */
+
+#ifdef SHARED
+extern __vdso_gettimeofday_t __vdso_gettimeofday;
+#endif
+
+int
+__gettimeofday (tv, tz)
+     struct timeval *tv;
+     struct timezone *tz;
+{
+#ifdef SHARED
+  if (__vdso_gettimeofday == NULL)
+#endif
+    return INLINE_SYSCALL (gettimeofday, 2, CHECK_1 (tv), CHECK_1 (tz));
+#ifdef SHARED
+  else
+    { 
+      return (*__vdso_gettimeofday) (tv, tz);
+    }
+#endif
+}
+
+INTDEF (__gettimeofday) weak_alias (__gettimeofday, gettimeofday)
diff -uNr libc/sysdeps/unix/sysv/linux/powerpc/libc-start.c libc-41-32/sysdeps/unix/sysv/linux/powerpc/libc-start.c
--- libc/sysdeps/unix/sysv/linux/powerpc/libc-start.c	1969-12-31 19:00:00.000000000 -0500
+++ libc-41-32/sysdeps/unix/sysv/linux/powerpc/libc-start.c	2005-11-11 09:31:48.000000000 -0500
@@ -0,0 +1,201 @@
+/* Copyright (C) 1998,2000,2001,2002,2003,2004,2005 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <ldsodefs.h>
+#include <bp-start.h>
+#include <bp-sym.h>
+
+extern int __cache_line_size;
+weak_extern (__cache_line_size)
+/* The main work is done in the generic function.  */
+#define LIBC_START_MAIN generic_start_main
+#define LIBC_START_DISABLE_INLINE
+#define LIBC_START_MAIN_AUXVEC_ARG
+#define MAIN_AUXVEC_ARG
+#define INIT_MAIN_ARGS
+#include <sysdeps/generic/libc-start.c>
+     struct startup_info
+     {
+       void *__unbounded sda_base;
+       int (*main) (int, char **, char **, void *);
+       int (*init) (int, char **, char **, void *);
+       void (*fini) (void);
+     };
+
+
+#ifdef SHARED
+#include <sys/time.h>
+#include <dl-vdso.h>
+#undef __gettimeofday
+#undef __clock_gettime
+#undef __clock_getres
+#include <bits/libc-vdso.h>
+
+     __vdso_gettimeofday_t __vdso_gettimeofday;
+     __vdso_clock_gettime_t __vdso_clock_gettime;
+     __vdso_clock_getres_t __vdso_clock_getres;
+     __vdso_get_tbfreq_t __vdso_get_tbfreq;
+
+#if __WORDSIZE == 64
+     typedef struct
+     {
+       void *func;
+       void *toc_ptr;
+       void *extra;
+     } _ppc_func_desciptor;
+
+     static struct
+     {
+       _ppc_func_desciptor fd_gettimeofday;
+       _ppc_func_desciptor fd_clock_gettime;
+       _ppc_func_desciptor fd_clock_getres;
+       _ppc_func_desciptor fd_get_tbfreq;
+     } __vdso_descriptor;
+#endif
+
+     static inline void _libc_vdso_platform_setup (void)
+{
+  void *vdso_ref = NULL;
+
+  __vdso_gettimeofday = NULL;
+  __vdso_clock_gettime = NULL;
+  __vdso_clock_getres = NULL;
+  __vdso_get_tbfreq = NULL;
+
+  vdso_ref = _dl_vdso_weakref ("__kernel_gettimeofday");
+
+#if __WORDSIZE == 64
+  if (vdso_ref != NULL)
+    {
+      __vdso_descriptor.fd_gettimeofday.func = vdso_ref;
+      __vdso_descriptor.fd_gettimeofday.toc_ptr = NULL;
+      __vdso_descriptor.fd_gettimeofday.extra = NULL;
+      __vdso_gettimeofday = (__vdso_gettimeofday_t)
+	   & __vdso_descriptor.fd_gettimeofday;
+    }
+#else
+  __vdso_gettimeofday = (__vdso_gettimeofday_t) vdso_ref;
+#endif
+
+  vdso_ref = _dl_vdso_weakref ("__kernel_clock_gettime");
+
+#if __WORDSIZE == 64
+  if (vdso_ref != NULL)
+    {
+      __vdso_descriptor.fd_clock_gettime.func = vdso_ref;
+      __vdso_descriptor.fd_clock_gettime.toc_ptr = NULL;
+      __vdso_descriptor.fd_clock_gettime.extra = NULL;
+      __vdso_clock_gettime = (__vdso_clock_gettime_t)
+	   & __vdso_descriptor.fd_clock_gettime;
+    }
+#else
+  __vdso_clock_gettime = (__vdso_clock_gettime_t) vdso_ref;
+#endif
+
+  vdso_ref = _dl_vdso_weakref ("__kernel_clock_getres");
+
+#if __WORDSIZE == 64
+  if (vdso_ref != NULL)
+    {
+      __vdso_descriptor.fd_clock_getres.func = vdso_ref;
+      __vdso_descriptor.fd_clock_getres.toc_ptr = NULL;
+      __vdso_descriptor.fd_clock_getres.extra = NULL;
+      __vdso_clock_getres = (__vdso_clock_getres_t)
+	   & __vdso_descriptor.fd_clock_getres;
+    }
+#else
+  __vdso_clock_getres = (__vdso_clock_getres_t) vdso_ref;
+#endif
+
+  vdso_ref = _dl_vdso_weakref ("__kernel_vdso_get_tbfreq");
+
+#if __WORDSIZE == 64
+  if (vdso_ref != NULL)
+    {
+      __vdso_descriptor.fd_clock_getres.func = vdso_ref;
+      __vdso_descriptor.fd_clock_getres.toc_ptr = NULL;
+      __vdso_descriptor.fd_clock_getres.extra = NULL;
+      __vdso_get_tbfreq = (__vdso_get_tbfreq_t)
+	   & __vdso_descriptor.fd_get_tbfreq;
+    }
+#else
+  __vdso_get_tbfreq = (__vdso_get_tbfreq_t) vdso_ref;
+#endif
+}
+#endif
+
+int
+/* GKM FIXME: GCC: this should get __BP_ prefix by virtue of the
+   BPs in the arglist of startup_info.main and startup_info.init. */
+  BP_SYM (__libc_start_main) (int argc, char *__unbounded * __unbounded ubp_av,
+			      char *__unbounded * __unbounded ubp_ev,
+			      ElfW (auxv_t) * __unbounded auxvec,
+			      void (*rtld_fini) (void),
+			      struct startup_info * __unbounded stinfo,
+			      char *__unbounded * __unbounded stack_on_entry)
+{
+#if __BOUNDED_POINTERS__
+  char **argv;
+#else
+# define argv ubp_av
+#endif
+
+  /* the PPC SVR4 ABI says that the top thing on the stack will
+     be a NULL pointer, so if not we assume that we're being called
+     as a statically-linked program by Linux...  */
+  if (*stack_on_entry != NULL)
+    {
+      char *__unbounded * __unbounded temp;
+      /* ...in which case, we have argc as the top thing on the
+         stack, followed by argv (NULL-terminated), envp (likewise),
+         and the auxilary vector.  */
+      /* 32/64-bit agnostic load from stack */
+      argc = *(long int *__unbounded) stack_on_entry;
+      ubp_av = stack_on_entry + 1;
+      ubp_ev = ubp_av + argc + 1;
+#ifdef HAVE_AUX_VECTOR
+      temp = ubp_ev;
+      while (*temp != NULL)
+	++temp;
+      auxvec = (ElfW (auxv_t) *)++ temp;
+#endif
+      rtld_fini = NULL;
+    }
+
+  /* Initialize the __cache_line_size variable from the aux vector.  */
+  for (ElfW (auxv_t) * av = auxvec; av->a_type != AT_NULL; ++av)
+    switch (av->a_type)
+      {
+      case AT_DCACHEBSIZE:
+	{
+	  int *cls = &__cache_line_size;
+	  if (cls != NULL)
+	    *cls = av->a_un.a_val;
+	}
+	break;
+      }
+#ifdef SHARED
+  /* Resolve and initialize function pointers for VDSO functions.  */
+  _libc_vdso_platform_setup ();
+#endif
+  return generic_start_main (stinfo->main, argc, ubp_av, auxvec,
+			     stinfo->init, stinfo->fini, rtld_fini,
+			     stack_on_entry);
+}
diff -uNr libc/sysdeps/unix/sysv/linux/powerpc/Makefile libc-41-32/sysdeps/unix/sysv/linux/powerpc/Makefile
--- libc/sysdeps/unix/sysv/linux/powerpc/Makefile	2005-11-11 11:18:22.776567904 -0500
+++ libc-41-32/sysdeps/unix/sysv/linux/powerpc/Makefile	2005-11-11 09:31:48.000000000 -0500
@@ -2,3 +2,8 @@
 ifeq ($(subdir),rt)
 librt-routines += rt-sysdep
 endif
+
+ifeq ($(subdir),misc)
+routines += dl-vdso
+endif
+
--- /dev/null	2005-08-19 11:20:54.270914304 -0400
+++ libc-34-32/sysdeps/powerpc/powerpc32/hp-timing.h	2005-11-11 15:44:16.817619528 -0500
@@ -0,0 +1,83 @@
+/* High precision, low overhead timing functions.  Generic version.
+   Copyright (C) 1998, 2000 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+   Contributed by Ulrich Drepper <drepper@cygnus.com>, 1998.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#ifndef _HP_TIMING_H
+#define _HP_TIMING_H	1
+
+
+/* There are no generic definitions for the times.  We could write something
+   using the `gettimeofday' system call where available but the overhead of
+   the system call might be too high.
+
+   In case a platform supports timers in the hardware the following macros
+   and types must be defined:
+
+   - HP_TIMING_AVAIL: test for availability.
+
+   - HP_TIMING_INLINE: this macro is non-zero if the functionality is not
+     implemented using function calls but instead uses some inlined code
+     which might simply consist of a few assembler instructions.  We have to
+     know this since we might want to use the macros here in places where we
+     cannot make function calls.
+
+   - hp_timing_t: This is the type for variables used to store the time
+     values.
+
+   - HP_TIMING_ZERO: clear `hp_timing_t' object.
+
+   - HP_TIMING_NOW: place timestamp for current time in variable given as
+     parameter.
+
+   - HP_TIMING_DIFF_INIT: do whatever is necessary to be able to use the
+     HP_TIMING_DIFF macro.
+
+   - HP_TIMING_DIFF: compute difference between two times and store it
+     in a third.  Source and destination might overlap.
+
+   - HP_TIMING_ACCUM: add time difference to another variable.  This might
+     be a bit more complicated to implement for some platforms as the
+     operation should be thread-safe and 64bit arithmetic on 32bit platforms
+     is not.
+
+   - HP_TIMING_ACCUM_NT: this is the variant for situations where we know
+     there are no threads involved.
+
+   - HP_TIMING_PRINT: write decimal representation of the timing value into
+     the given string.  This operation need not be inline even though
+     HP_TIMING_INLINE is specified.
+
+*/
+
+/* Provide dummy definitions.  */
+#define HP_TIMING_AVAIL		(0)
+#define HP_TIMING_INLINE	(0)
+typedef unsigned long long int hp_timing_t;
+#define HP_TIMING_ZERO(Var)
+#define HP_TIMING_NOW(var)
+#define HP_TIMING_DIFF_INIT()
+#define HP_TIMING_DIFF(Diff, Start, End)
+#define HP_TIMING_ACCUM(Sum, Diff)
+#define HP_TIMING_ACCUM_NT(Sum, Diff)
+#define HP_TIMING_PRINT(Buf, Len, Val)
+
+/* Since this implementation is not available we tell the user about it.  */
+#define HP_TIMING_NONAVAIL	1
+
+#endif	/* hp-timing.h */
