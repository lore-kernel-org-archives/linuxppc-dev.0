Message-ID: <387D067A.50942911@pop.agri.ch>
Date: Wed, 12 Jan 2000 23:55:55 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux -Dev <linuxppc-dev@lists.linuxppc.org>,
        Cort Dougan <cort@fsmlabs.com>, Paul Mackerras <paulus@linuxcare.com>,
        Martin Costabel <costabel@wanadoo.fr>,
        Peter Hunter <peter@fido.bfriars.ox.ac.uk>
Subject: 2.3.39 compiles & boot
Content-Type: multipart/mixed;
 boundary="------------B644D6E9EB992A5716E1BC5F"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------B644D6E9EB992A5716E1BC5F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi All,
may some of you are as far as I am, otherwise here is the diff I had to
do to get a 2.3.39-linus-tree to compile & boot with a Wallstreet I.
hope to ok otherwise let me please know.

Good night,

Andreas
-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail:  a.tobler@schweiz.ch
------------------------------------------------
--------------B644D6E9EB992A5716E1BC5F
Content-Type: image/x-xbitmap; x-mac-type="3F3F3F3F"; x-mac-creator="554E4958";
 name="2339ppc.diff"
Content-Description: Document
Content-Disposition: inline;
 filename="2339ppc.diff"
Content-Transfer-Encoding: 7bit

diff -u --recursive --new-file linux-2.3.39/include/asm-ppc/ipcbuf.h linux-2.3.39.orig/include/asm-ppc/ipcbuf.h
--- linux-2.3.39/include/asm-ppc/ipcbuf.h	Thu Jan  1 01:00:00 1970
+++ linux-2.3.39.orig/include/asm-ppc/ipcbuf.h	Wed Jan 12 09:56:05 2000
@@ -0,0 +1,29 @@
+#ifndef __PPC_IPCBUF_H__
+#define __PPC_IPCBUF_H__
+
+/*
+ * The user_ipc_perm structure for PPC architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 32-bit mode_t and seq
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct ipc64_perm
+{
+	__kernel_key_t		key;
+	__kernel_uid32_t	uid;
+	__kernel_gid32_t	gid;
+	__kernel_uid32_t	cuid;
+	__kernel_gid32_t	cgid;
+	__kernel_mode_t		mode;
+	unsigned short		__pad1;
+	unsigned short		seq;
+	unsigned short		__pad2;
+	unsigned long		__unused1;
+	unsigned long		__unused2;
+};
+
+#endif /* __PPCIPCBUF_H__ */
diff -u --recursive --new-file linux-2.3.39/include/asm-ppc/msgbuf.h linux-2.3.39.orig/include/asm-ppc/msgbuf.h
--- linux-2.3.39/include/asm-ppc/msgbuf.h	Thu Jan  1 01:00:00 1970
+++ linux-2.3.39.orig/include/asm-ppc/msgbuf.h	Wed Jan 12 21:06:18 2000
@@ -0,0 +1,31 @@
+#ifndef _PPC_MSGBUF_H
+#define _PPC_MSGBUF_H
+
+/* 
+ * The msqid64_ds structure for PPC architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 64-bit time_t to solve y2038 problem
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+	__kernel_time_t msg_stime;	/* last msgsnd time */
+	unsigned long	__unused1;
+	__kernel_time_t msg_rtime;	/* last msgrcv time */
+	unsigned long	__unused2;
+	__kernel_time_t msg_ctime;	/* last change time */
+	unsigned long	__unused3;
+	unsigned long  msg_cbytes;	/* current number of bytes on queue */
+	unsigned long  msg_qnum;	/* number of messages in queue */
+	unsigned long  msg_qbytes;	/* max number of bytes on queue */
+	__kernel_pid_t msg_lspid;	/* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid;	/* last receive pid */
+	unsigned long  __unused4;
+	unsigned long  __unused5;
+};
+
+#endif /* _PPC_MSGBUF_H */
diff -u --recursive --new-file linux-2.3.39/include/asm-ppc/posix_types.h linux-2.3.39.orig/include/asm-ppc/posix_types.h
--- linux-2.3.39/include/asm-ppc/posix_types.h	Wed Jan 12 23:20:47 2000
+++ linux-2.3.39.orig/include/asm-ppc/posix_types.h	Wed Jan 12 10:07:28 2000
@@ -24,6 +24,17 @@
 typedef int		__kernel_daddr_t;
 typedef char *		__kernel_caddr_t;
 typedef short             __kernel_ipc_pid_t;
+typedef unsigned short	__kernel_uid16_t;
+typedef unsigned short  __kernel_gid16_t;
+typedef unsigned int 	__kernel_uid32_t;
+typedef unsigned int  	__kernel_gid32_t;
+
+
+#ifdef __KERNEL__
+#define UID16_COMPAT_NEEDED
+typedef unsigned short	__kernel_old_uid_t;
+typedef unsigned short	__kernel_old_gid_t;
+#endif /* __KERNEL__ */
 
 #ifdef __GNUC__
 typedef long long	__kernel_loff_t;
diff -u --recursive --new-file linux-2.3.39/include/asm-ppc/sembuf.h linux-2.3.39.orig/include/asm-ppc/sembuf.h
--- linux-2.3.39/include/asm-ppc/sembuf.h	Thu Jan  1 01:00:00 1970
+++ linux-2.3.39.orig/include/asm-ppc/sembuf.h	Wed Jan 12 09:56:53 2000
@@ -0,0 +1,25 @@
+#ifndef _PPC_SEMBUF_H
+#define _PPC_SEMBUF_H
+
+/* 
+ * The semid64_ds structure for PPC architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 64-bit time_t to solve y2038 problem
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct semid64_ds {
+	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
+	__kernel_time_t	sem_otime;		/* last semop time */
+	unsigned long	__unused1;
+	__kernel_time_t	sem_ctime;		/* last change time */
+	unsigned long	__unused2;
+	unsigned long	sem_nsems;		/* no. of semaphores in array */
+	unsigned long	__unused3;
+	unsigned long	__unused4;
+};
+
+#endif /* _PPC_SEMBUF_H */
diff -u --recursive --new-file linux-2.3.39/include/asm-ppc/shmbuf.h linux-2.3.39.orig/include/asm-ppc/shmbuf.h
--- linux-2.3.39/include/asm-ppc/shmbuf.h	Thu Jan  1 01:00:00 1970
+++ linux-2.3.39.orig/include/asm-ppc/shmbuf.h	Wed Jan 12 20:59:06 2000
@@ -0,0 +1,42 @@
+#ifndef _PPC_SHMBUF_H
+#define _PPC_SHMBUF_H
+
+/* 
+ * The shmid64_ds structure for PPC architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 64-bit time_t to solve y2038 problem
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_time_t		shm_atime;	/* last attach time */
+	unsigned long		__unused1;
+	__kernel_time_t		shm_dtime;	/* last detach time */
+	unsigned long		__unused2;
+	__kernel_time_t		shm_ctime;	/* last change time */
+	unsigned long		__unused3;
+	__kernel_pid_t		shm_cpid;	/* pid of creator */
+	__kernel_pid_t		shm_lpid;	/* pid of last operator */
+	unsigned long		shm_nattch;	/* no. of current attaches */
+	unsigned long		__unused4;
+	unsigned long		__unused5;
+};
+
+struct shminfo64 {
+	unsigned long	shmmax;
+	unsigned long	shmmin;
+	unsigned long	shmmni;
+	unsigned long	shmseg;
+	unsigned long	shmall;
+	unsigned long	__unused1;
+	unsigned long	__unused2;
+	unsigned long	__unused3;
+	unsigned long	__unused4;
+};
+
+#endif /* _PPC_SHMBUF_H */
diff -u --recursive --new-file linux-2.3.39/include/asm-ppc/siginfo.h linux-2.3.39.orig/include/asm-ppc/siginfo.h
--- linux-2.3.39/include/asm-ppc/siginfo.h	Wed Jan 12 23:20:47 2000
+++ linux-2.3.39.orig/include/asm-ppc/siginfo.h	Wed Jan 12 20:51:29 2000
@@ -1,10 +1,10 @@
 #ifndef _PPC_SIGINFO_H
 #define _PPC_SIGINFO_H
 
-/* Copied from i386 from alpha. */
-
 #include <linux/types.h>
 
+/* This is copied from asm-alpha/siginfo.h.  */
+
 typedef union sigval {
 	int sival_int;
 	void *sival_ptr;
@@ -24,7 +24,8 @@
 		/* kill() */
 		struct {
 			pid_t _pid;		/* sender's pid */
-			uid_t _uid;		/* sender's uid */
+			old_uid_t _uid;		/* backwards compatibility */
+			uid_t _uid32;		/* sender's uid */
 		} _kill;
 
 		/* POSIX.1b timers */
@@ -36,17 +37,19 @@
 		/* POSIX.1b signals */
 		struct {
 			pid_t _pid;		/* sender's pid */
-			uid_t _uid;		/* sender's uid */
+			old_uid_t _uid;		/* backwards compatibility */
 			sigval_t _sigval;
+			uid_t _uid32;		/* sender's uid */
 		} _rt;
 
 		/* SIGCHLD */
 		struct {
 			pid_t _pid;		/* which child */
-			uid_t _uid;		/* sender's uid */
+			old_uid_t _uid;		/* backwards compatibility */
 			int _status;		/* exit code */
 			clock_t _utime;
 			clock_t _stime;
+			uid_t _uid32;		/* sender's uid */
 		} _sigchld;
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
@@ -62,11 +65,18 @@
 	} _sifields;
 } siginfo_t;
 
+#define UID16_SIGINFO_COMPAT_NEEDED
+
 /*
  * How these fields are to be accessed.
  */
 #define si_pid		_sifields._kill._pid
+#ifdef __KERNEL__
+#define si_uid		_sifields._kill._uid32
+#define si_uid16	_sifields._kill._uid
+#else
 #define si_uid		_sifields._kill._uid
+#endif /* __KERNEL__ */
 #define si_status	_sifields._sigchld._status
 #define si_utime	_sifields._sigchld._utime
 #define si_stime	_sifields._sigchld._stime
@@ -149,7 +159,7 @@
 #define CLD_TRAPPED	4	/* traced child has trapped */
 #define CLD_STOPPED	5	/* child has stopped */
 #define CLD_CONTINUED	6	/* stopped child has continued */
-#define NSIGCHLD
+#define NSIGCHLD	
 
 /*
  * SIGPOLL si_codes

--------------B644D6E9EB992A5716E1BC5F--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
