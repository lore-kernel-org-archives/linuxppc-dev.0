From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Geoff Keating <geoffk@cygnus.com>
Subject: Re: [RFC] IPC64 with glibc-2.2 and linux-2.4
Date: Tue, 26 Sep 2000 23:24:05 +0200
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_5GJIJHRP3E82QV5TWQW0"
Cc: drepper@cygnus.com, libc-alpha@sources.redhat.com,
        linuxppc-dev@lists.linuxppc.org
References: <Franz Sirl's message of "Sun, 24 Sep 2000 21:50:44 +0200"> <5.0.0.19.2.20000925110119.01fe1df0@mail.lauterbach.com> <200009252124.OAA25434@geoffk.org>
In-Reply-To: <200009252124.OAA25434@geoffk.org>
MIME-Version: 1.0
Message-Id: <00092623240500.22844@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--------------Boundary-00=_5GJIJHRP3E82QV5TWQW0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

On Mon, 25 Sep 2000, Geoff Keating wrote:
> > Date: Mon, 25 Sep 2000 11:10:45 +0200
> > From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
> > Cc: libc-alpha@sources.redhat.com, linuxppc-dev@lists.linuxppc.org
> >
> > Yeah, I know. But it's no problem for me to push this change into the
> > kernel after some people (including you :-)) have agreed to the principle
> > of the patch.
>
> I too agree with the principle of the patch.  There's no reason to
> limit this quantity to 16 bits.

OK, here is the final patch, if nobody objects I'll ask Ben to push the
kernel changes into bitkeeper.

Changes to previous version:
	- bumped ipc_perm.seq member to 32 bit
	- padded shmid_ds.shm_segsz to prepare for size_t expansion
	- added an unrelated LFS change for fcntl.h


> Did you test it?  There are four combinations to check:
>
> new application/new kernel
> old application/new kernel  (to test symbol versioning)
> new application/old kernel  (test translation of old structure to new)
> old application/old kernel  (this should Just Work if the above cases work)
> 			    (but of course you should still check it :-) )

Yeah, I did test all but the new/new combination myself (haven't had time to
recompile xf4 yet), but Jack tested it successfully.

Franz.


	* sysdeps/unix/sysv/linux/kernel-features.h: Add __ASSUME_IPC64, only define´
	it for powerpc for kernel >= 2.4.0.
	* sysdeps/unix/sysv/linux/msgctl.c: Test for __ASSUME_IPC64, not
	__ASSUME_32BITUIDS.
	* sysdeps/unix/sysv/linux/semctl.c: Likewise.
	* sysdeps/unix/sysv/linux/shmctl.c: Likewise.
	* sysdeps/unix/sysv/linux/powerpc/bits/ipc.h: Sync with kernel.
	* sysdeps/unix/sysv/linux/powerpc/bits/msq.h: New file.
	* sysdeps/unix/sysv/linux/powerpc/bits/sem.h: New file.
	* sysdeps/unix/sysv/linux/powerpc/bits/shm.h: New file.
	* sysdeps/unix/sysv/linux/powerpc/bits/fcntl.h: Add defines for LFS record
	locking.


--------------Boundary-00=_5GJIJHRP3E82QV5TWQW0
Content-Type: text/plain;
  name="glibc22-ipc.patch"
Content-Disposition: attachment; filename="glibc22-ipc.patch"
Content-Transfer-Encoding: 8bit

Index: sysdeps/unix/sysv/linux/kernel-features.h
===================================================================
RCS file: /cvs/glibc/libc/sysdeps/unix/sysv/linux/kernel-features.h,v
retrieving revision 1.20
diff -u -p -r1.20 kernel-features.h
--- sysdeps/unix/sysv/linux/kernel-features.h	2000/09/18 16:40:02	1.20
+++ sysdeps/unix/sysv/linux/kernel-features.h	2000/09/26 19:03:23
@@ -110,13 +110,21 @@
 # define __ASSUME_NEW_GETRLIMIT_SYSCALL	1
 #endif

-/* Linux 2.3.39 introduced 32bit UID/GIDs.  Some platforms had 32 bit
+/* Linux 2.3.39 introduced 32bit UID/GIDs and IPC64.  Some platforms had 32 bit
    type all along.  */
 #if __LINUX_KERNEL_VERSION >= 131879 || defined __powerpc__ || defined __mips__
 # define __ASSUME_32BITUIDS		1
+# ifndef __powerpc__
+#  define __ASSUME_IPC64		1
+# endif
 # ifdef __sparc__
 #  define __ASSUME_SETRESUID_SYSCALL	1
 # endif
+#endif
+
+/* Linux 2.4.0 on PPC introduced a correct IPC64.  */
+#if __LINUX_KERNEL_VERSION >= 132096 && defined __powerpc__
+# define __ASSUME_IPC64			1
 #endif

 /* We can use the LDTs for threading with Linux 2.3.99 and newer.  */
Index: sysdeps/unix/sysv/linux/msgctl.c
===================================================================
RCS file: /cvs/glibc/libc/sysdeps/unix/sysv/linux/msgctl.c,v
retrieving revision 1.7
diff -u -p -r1.7 msgctl.c
--- sysdeps/unix/sysv/linux/msgctl.c	2000/07/27 06:13:08	1.7
+++ sysdeps/unix/sysv/linux/msgctl.c	2000/09/26 19:03:24
@@ -65,7 +65,7 @@ compat_symbol (libc, __old_msgctl, msgct
 int
 __new_msgctl (int msqid, int cmd, struct msqid_ds *buf)
 {
-#if __ASSUME_32BITUIDS > 0
+#if __ASSUME_IPC64 > 0
   return INLINE_SYSCALL (ipc, 5, IPCOP_msgctl,
 			 msqid, cmd | __IPC_64, 0, CHECK_1 (buf));
 #else
Index: sysdeps/unix/sysv/linux/semctl.c
===================================================================
RCS file: /cvs/glibc/libc/sysdeps/unix/sysv/linux/semctl.c,v
retrieving revision 1.10
diff -u -p -r1.10 semctl.c
--- sysdeps/unix/sysv/linux/semctl.c	2000/07/27 06:13:08	1.10
+++ sysdeps/unix/sysv/linux/semctl.c	2000/09/26 19:03:24
@@ -93,7 +93,7 @@ __new_semctl (int semid, int semnum, int

   va_end (ap);

-#if __ASSUME_32BITUIDS > 0
+#if __ASSUME_IPC64 > 0
   return INLINE_SYSCALL (ipc, 5, IPCOP_semctl, semid, semnum, cmd | __IPC_64,
 			 CHECK_SEMCTL (&arg, semid, cmd | __IPC_64));
 #else
Index: sysdeps/unix/sysv/linux/shmctl.c
===================================================================
RCS file: /cvs/glibc/libc/sysdeps/unix/sysv/linux/shmctl.c,v
retrieving revision 1.9
diff -u -p -r1.9 shmctl.c
--- sysdeps/unix/sysv/linux/shmctl.c	2000/08/17 07:37:01	1.9
+++ sysdeps/unix/sysv/linux/shmctl.c	2000/09/26 19:03:24
@@ -73,7 +73,7 @@ compat_symbol (libc, __old_shmctl, shmct
 int
 __new_shmctl (int shmid, int cmd, struct shmid_ds *buf)
 {
-#if __ASSUME_32BITUIDS > 0
+#if __ASSUME_IPC64 > 0
   return INLINE_SYSCALL (ipc, 5, IPCOP_shmctl, shmid, cmd | __IPC_64, 0, CHECK_1 (buf));
 #else
   switch (cmd) {
Index: sysdeps/unix/sysv/linux/powerpc/bits/fcntl.h
===================================================================
RCS file: /cvs/glibc/libc/sysdeps/unix/sysv/linux/powerpc/bits/fcntl.h,v
retrieving revision 1.1
diff -u -p -r1.1 fcntl.h
--- sysdeps/unix/sysv/linux/powerpc/bits/fcntl.h	2000/09/01 07:13:37	1.1
+++ sysdeps/unix/sysv/linux/powerpc/bits/fcntl.h	2000/09/26 19:03:25
@@ -78,10 +78,9 @@
 # define F_SETLKW	F_SETLKW64 /* Set record locking info (blocking).  */
 #endif

-/* XXX missing */
-#define F_GETLK64	5	/* Get record locking info.  */
-#define F_SETLK64	6	/* Set record locking info (non-blocking).  */
-#define F_SETLKW64	7	/* Set record locking info (blocking).  */
+#define F_GETLK64	12	/* Get record locking info.  */
+#define F_SETLK64	13	/* Set record locking info (non-blocking).  */
+#define F_SETLKW64	14	/* Set record locking info (blocking).  */

 #if defined __USE_BSD || defined __USE_XOPEN2K
 # define F_SETOWN	8	/* Get owner of socket (receiver of SIGIO).  */
Index: sysdeps/unix/sysv/linux/powerpc/bits/ipc.h
===================================================================
RCS file: /cvs/glibc/libc/sysdeps/unix/sysv/linux/powerpc/bits/ipc.h,v
retrieving revision 1.4
diff -u -p -r1.4 ipc.h
--- sysdeps/unix/sysv/linux/powerpc/bits/ipc.h	2000/05/23 08:43:01	1.4
+++ sysdeps/unix/sysv/linux/powerpc/bits/ipc.h	2000/09/26 19:03:25
@@ -48,7 +48,10 @@ struct ipc_perm
     __uid_t cuid;		/* Creator's user ID.  */
     __gid_t cgid;		/* Creator's group ID.  */
     __mode_t mode;		/* Read/write permission.  */
-    unsigned short int __seq;	/* Sequence number.  */
+    unsigned long __seq;	/* Sequence number.  */
+    unsigned int __pad1;
+    unsigned long long __unused1;
+    unsigned long long __unused2;
   };


--- /dev/null	Tue May  5 22:32:27 1998
+++ sysdeps/unix/sysv/linux/powerpc/bits/msq.h	Tue Sep 26 20:40:24 2000
@@ -0,0 +1,77 @@
+/* Copyright (C) 1995, 1996, 1997, 2000 Free Software Foundation, Inc.
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
+#ifndef _SYS_MSG_H
+# error "Never use <bits/msq.h> directly; include <sys/msg.h> instead."
+#endif
+
+#include <bits/types.h>
+
+/* Define options for message queue functions.  */
+#define MSG_NOERROR	010000	/* no error if message is too big */
+#ifdef __USE_GNU
+# define MSG_EXCEPT	020000	/* recv any msg except of specified type */
+#endif
+
+/* Types used in the structure definition.  */
+typedef unsigned long int msgqnum_t;
+typedef unsigned long int msglen_t;
+
+
+/* Structure of record for one message inside the kernel.
+   The type `struct msg' is opaque.  */
+struct msqid_ds
+{
+  struct ipc_perm msg_perm;	/* structure describing operation permission */
+  unsigned int __unused1;
+  __time_t msg_stime;		/* time of last msgsnd command */
+  unsigned int __unused2;
+  __time_t msg_rtime;		/* time of last msgrcv command */
+  unsigned int __unused3;
+  __time_t msg_ctime;		/* time of last change */
+  unsigned long __msg_cbytes; /* current number of bytes on queue */
+  msgqnum_t msg_qnum;		/* number of messages currently on queue */
+  msglen_t msg_qbytes;		/* max number of bytes allowed on queue */
+  __pid_t msg_lspid;		/* pid of last msgsnd() */
+  __pid_t msg_lrpid;		/* pid of last msgrcv() */
+  unsigned long __unused4;
+  unsigned long __unused5;
+};
+
+#ifdef __USE_MISC
+
+# define msg_cbytes	__msg_cbytes
+
+/* ipcs ctl commands */
+# define MSG_STAT 11
+# define MSG_INFO 12
+
+/* buffer for msgctl calls IPC_INFO, MSG_INFO */
+struct msginfo
+  {
+    int msgpool;
+    int msgmap;
+    int msgmax;
+    int msgmnb;
+    int msgmni;
+    int msgssz;
+    int msgtql;
+    unsigned short int msgseg;
+  };
+
+#endif /* __USE_MISC */
--- /dev/null	Tue May  5 22:32:27 1998
+++ sysdeps/unix/sysv/linux/powerpc/bits/sem.h	Tue Sep 26 20:40:24 2000
@@ -0,0 +1,87 @@
+/* Copyright (C) 1995, 1996, 1997, 1998, 2000 Free Software Foundation, Inc.
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
+#ifndef _SYS_SEM_H
+# error "Never include <bits/sem.h> directly; use <sys/sem.h> instead."
+#endif
+
+#include <sys/types.h>
+
+/* Flags for `semop'.  */
+#define SEM_UNDO	0x1000		/* undo the operation on exit */
+
+/* Commands for `semctl'.  */
+#define GETPID		11		/* get sempid */
+#define GETVAL		12		/* get semval */
+#define GETALL		13		/* get all semval's */
+#define GETNCNT		14		/* get semncnt */
+#define GETZCNT		15		/* get semzcnt */
+#define SETVAL		16		/* set semval */
+#define SETALL		17		/* set all semval's */
+
+
+/* Data structure describing a set of semaphores.  */
+struct semid_ds
+{
+  struct ipc_perm sem_perm;		/* operation permission struct */
+  unsigned int __unused1;
+  __time_t sem_otime;			/* last semop() time */
+  unsigned int __unused2;
+  __time_t sem_ctime;			/* last time changed by semctl() */
+  unsigned long int sem_nsems;		/* number of semaphores in set */
+  unsigned long __unused3;
+  unsigned long __unused4;
+};
+
+/* The user should define a union like the following to use it for arguments
+   for `semctl'.
+
+   union semun
+   {
+     int val;				<= value for SETVAL
+     struct semid_ds *buf;		<= buffer for IPC_STAT & IPC_SET
+     unsigned short int *array;		<= array for GETALL & SETALL
+     struct seminfo *__buf;		<= buffer for IPC_INFO
+   };
+
+   Previous versions of this file used to define this union but this is
+   incorrect.  One can test the macro _SEM_SEMUN_UNDEFINED to see whether
+   one must define the union or not.  */
+#define _SEM_SEMUN_UNDEFINED	1
+
+#ifdef __USE_MISC
+
+/* ipcs ctl cmds */
+# define SEM_STAT 18
+# define SEM_INFO 19
+
+struct  seminfo
+{
+  int semmap;
+  int semmni;
+  int semmns;
+  int semmnu;
+  int semmsl;
+  int semopm;
+  int semume;
+  int semusz;
+  int semvmx;
+  int semaem;
+};
+
+#endif /* __USE_MISC */
--- /dev/null	Tue May  5 22:32:27 1998
+++ sysdeps/unix/sysv/linux/powerpc/bits/shm.h	Tue Sep 26 20:43:17 2000
@@ -0,0 +1,94 @@
+/* Copyright (C) 1995, 1996, 1997, 2000 Free Software Foundation, Inc.
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
+#ifndef _SYS_SHM_H
+# error "Never include <bits/shm.h> directly; use <sys/shm.h> instead."
+#endif
+
+#include <bits/types.h>
+
+/* Permission flag for shmget.  */
+#define SHM_R		0400		/* or S_IRUGO from <linux/stat.h> */
+#define SHM_W		0200		/* or S_IWUGO from <linux/stat.h> */
+
+/* Flags for `shmat'.  */
+#define SHM_RDONLY	010000		/* attach read-only else read-write */
+#define SHM_RND		020000		/* round attach address to SHMLBA */
+#define SHM_REMAP	040000		/* take-over region on attach */
+
+/* Commands for `shmctl'.  */
+#define SHM_LOCK	11		/* lock segment (root only) */
+#define SHM_UNLOCK	12		/* unlock segment (root only) */
+
+
+/* Type to count number of attaches.  */
+typedef unsigned long int shmatt_t;
+
+/* Data structure describing a set of semaphores.  */
+struct shmid_ds
+  {
+    struct ipc_perm shm_perm;		/* operation permission struct */
+    unsigned int __unused1;
+    __time_t shm_atime;			/* time of last shmat() */
+    unsigned int __unused2;
+    __time_t shm_dtime;			/* time of last shmdt() */
+    unsigned int __unused3;
+    __time_t shm_ctime;			/* time of last change by shmctl() */
+    unsigned int __unused4;
+    size_t shm_segsz;			/* size of segment in bytes */
+    __pid_t shm_cpid;			/* pid of creator */
+    __pid_t shm_lpid;			/* pid of last shmop */
+    shmatt_t shm_nattch;		/* number of current attaches */
+    unsigned long __unused5;
+    unsigned long __unused6;
+  };
+
+#ifdef __USE_MISC
+
+/* ipcs ctl commands */
+# define SHM_STAT 	13
+# define SHM_INFO 	14
+
+/* shm_mode upper byte flags */
+# define SHM_DEST	01000	/* segment will be destroyed on last detach */
+# define SHM_LOCKED	02000   /* segment will not be swapped */
+
+struct	shminfo
+  {
+    unsigned long int shmmax;
+    unsigned long int shmmin;
+    unsigned long int shmmni;
+    unsigned long int shmseg;
+    unsigned long int shmall;
+    unsigned long int __unused1;
+    unsigned long int __unused2;
+    unsigned long int __unused3;
+    unsigned long int __unused4;
+  };
+
+struct shm_info
+  {
+    int used_ids;
+    unsigned long int shm_tot;	/* total allocated shm */
+    unsigned long int shm_rss;	/* total resident shm */
+    unsigned long int shm_swp;	/* total swapped shm */
+    unsigned long int swap_attempts;
+    unsigned long int swap_successes;
+  };
+
+#endif /* __USE_MISC */

--------------Boundary-00=_5GJIJHRP3E82QV5TWQW0
Content-Type: text/plain;
  name="kernel24-ipc-2.patch"
Content-Disposition: attachment; filename="kernel24-ipc-2.patch"
Content-Transfer-Encoding: 8bit

===== include/asm-ppc/ipcbuf.h 1.1 vs edited =====
--- 1.1/include/asm-ppc/ipcbuf.h	Wed Jan 19 03:00:31 2000
+++ edited/include/asm-ppc/ipcbuf.h	Tue Sep 26 19:40:42 2000
@@ -2,10 +2,28 @@
 #define __PPC_IPCBUF_H__

 /*
- * The ipc64_perm structure for the PPC is identical to kern_ipc_perm
- * as we have always had 32-bit UIDs and GIDs in the kernel.
+ * The ipc64_perm structure for PPC architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 1 32-bit value to fill up for 8-byte alignment
+ * - 2 miscellaneous 64-bit values (so that this structure matches
+ *                                  PPC64 ipc64_perm)
  */
-
-#define ipc64_perm	kern_ipc_perm
+
+struct ipc64_perm
+{
+	__kernel_key_t		key;
+	__kernel_uid_t		uid;
+	__kernel_gid_t		gid;
+	__kernel_uid_t		cuid;
+	__kernel_gid_t		cgid;
+	__kernel_mode_t		mode;
+	unsigned long		seq;
+	unsigned int		__pad2;
+	unsigned long long	__unused1;
+	unsigned long long	__unused2;
+};

 #endif /* __PPC_IPCBUF_H__ */
===== include/asm-ppc/msgbuf.h 1.1 vs edited =====
--- 1.1/include/asm-ppc/msgbuf.h	Wed Jan 19 03:00:31 2000
+++ edited/include/asm-ppc/msgbuf.h	Fri Sep 22 23:27:16 2000
@@ -7,7 +7,6 @@

 struct msqid64_ds {
 	struct ipc64_perm msg_perm;
-	unsigned int	__unused0;
 	unsigned int	__unused1;
 	__kernel_time_t msg_stime;	/* last msgsnd time */
 	unsigned int	__unused2;
===== include/asm-ppc/sembuf.h 1.1 vs edited =====
--- 1.1/include/asm-ppc/sembuf.h	Wed Jan 19 03:00:31 2000
+++ edited/include/asm-ppc/sembuf.h	Sun Sep 24 11:19:56 2000
@@ -7,7 +7,6 @@

 struct semid64_ds {
 	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
-	unsigned int	__unused0;
 	unsigned int	__unused1;
 	__kernel_time_t	sem_otime;		/* last semop time */
 	unsigned int	__unused2;
===== include/asm-ppc/shmbuf.h 1.1 vs edited =====
--- 1.1/include/asm-ppc/shmbuf.h	Wed Jan 19 03:00:31 2000
+++ edited/include/asm-ppc/shmbuf.h	Tue Sep 26 20:26:16 2000
@@ -7,19 +7,19 @@

 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	unsigned int		__unused0;
-	size_t			shm_segsz;	/* size of segment (bytes) */
-	unsigned long		__unused1;
+	unsigned int		__unused1;
 	__kernel_time_t		shm_atime;	/* last attach time */
-	unsigned long		__unused2;
+	unsigned int		__unused2;
 	__kernel_time_t		shm_dtime;	/* last detach time */
-	unsigned long		__unused3;
+	unsigned int		__unused3;
 	__kernel_time_t		shm_ctime;	/* last change time */
+	unsigned int		__unused4;
+	size_t			shm_segsz;	/* size of segment (bytes) */
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
 	unsigned long		shm_nattch;	/* no. of current attaches */
-	unsigned long		__unused4;
 	unsigned long		__unused5;
+	unsigned long		__unused6;
 };

 struct shminfo64 {

--------------Boundary-00=_5GJIJHRP3E82QV5TWQW0--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
