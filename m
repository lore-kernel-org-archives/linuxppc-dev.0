From: Paul Mackerras <paulus@linuxcare.com>
To: Andreas Tobler <toa@pop.agri.ch>,
        Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.3.39 compiles & boot
Date: Thu, 13 Jan 2000 13:56:01 +1100
Content-Type: text/plain
References: <387D067A.50942911@pop.agri.ch>
MIME-Version: 1.0
Message-Id: <00011313582505.00484@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 13 Jan 2000, Andreas Tobler wrote:

> may some of you are as far as I am, otherwise here is the diff I had to
> do to get a 2.3.39-linus-tree to compile & boot with a Wallstreet I.
> hope to ok otherwise let me please know.

I think this patch is not quite the best way to do it.  We already had
32-bit uids so we don't need the compatibility crap.  Here is a patch that
fixes the compile (alternatively my linux-pmac-devel rsync tree has a
2.3.39 tree that compiles and works).

Paul.

diff -ur official/arch/ppc/kernel/head_4xx.S linux/arch/ppc/kernel/head_4xx.S
--- official/arch/ppc/kernel/head_4xx.S	Tue Jan 11 18:19:25 2000
+++ linux/arch/ppc/kernel/head_4xx.S	Thu Jan 13 10:58:48 2000
@@ -474,7 +474,7 @@
 	
 _GLOBAL(abort)
 	mfspr	r13,SPRN_DBCR
-	oris	r13,r13,DBCR_RST(SYSTEM)@h
+	oris	r13,r13,DBCR_RST(DBCR_RST_SYSTEM)@h
 	mtspr	SPRN_DBCR,r13
 
 
diff -ur official/include/asm-ppc/ipcbuf.h linux/include/asm-ppc/ipcbuf.h
--- official/include/asm-ppc/ipcbuf.h	Thu Jan  1 10:00:00 1970
+++ linux/include/asm-ppc/ipcbuf.h	Wed Jan 12 12:25:19 2000
@@ -0,0 +1,11 @@
+#ifndef __PPC_IPCBUF_H__
+#define __PPC_IPCBUF_H__
+
+/*
+ * The ipc64_perm structure for the PPC is identical to kern_ipc_perm
+ * as we have always had 32-bit UIDs and GIDs in the kernel.
+ */
+
+#define ipc64_perm	kern_ipc_perm
+
+#endif /* __PPC_IPCBUF_H__ */
diff -ur official/include/asm-ppc/msgbuf.h linux/include/asm-ppc/msgbuf.h
--- official/include/asm-ppc/msgbuf.h	Thu Jan  1 10:00:00 1970
+++ linux/include/asm-ppc/msgbuf.h	Wed Jan 12 14:15:01 2000
@@ -0,0 +1,26 @@
+#ifndef _PPC_MSGBUF_H
+#define _PPC_MSGBUF_H
+
+/* 
+ * The msqid64_ds structure for the PPC architecture.
+ */
+
+struct msqid64_ds {
+	struct ipc64_perm msg_perm;
+	unsigned int	__unused0;
+	unsigned int	__unused1;
+	__kernel_time_t msg_stime;	/* last msgsnd time */
+	unsigned int	__unused2;
+	__kernel_time_t msg_rtime;	/* last msgrcv time */
+	unsigned int	__unused3;
+	__kernel_time_t msg_ctime;	/* last change time */
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
diff -ur official/include/asm-ppc/posix_types.h linux/include/asm-ppc/posix_types.h
--- official/include/asm-ppc/posix_types.h	Fri Apr 30 05:39:01 1999
+++ linux/include/asm-ppc/posix_types.h	Wed Jan 12 13:31:44 2000
@@ -24,6 +24,15 @@
 typedef int		__kernel_daddr_t;
 typedef char *		__kernel_caddr_t;
 typedef short             __kernel_ipc_pid_t;
+typedef unsigned int	__kernel_uid16_t;
+typedef unsigned int	__kernel_gid16_t;
+typedef unsigned int	__kernel_uid32_t;
+typedef unsigned int	__kernel_gid32_t;
+
+#ifdef __KERNEL__
+typedef unsigned int	__kernel_old_uid_t;
+typedef unsigned int	__kernel_old_gid_t;
+#endif /* __KERNEL__ */
 
 #ifdef __GNUC__
 typedef long long	__kernel_loff_t;
diff -ur official/include/asm-ppc/processor.h linux/include/asm-ppc/processor.h
--- official/include/asm-ppc/processor.h	Tue Jan 11 18:19:33 2000
+++ linux/include/asm-ppc/processor.h	Wed Jan 12 13:40:37 2000
@@ -99,10 +99,10 @@
 #define	  DBCR_EDM	0x80000000
 #define	  DBCR_IDM	0x40000000
 #define	  DBCR_RST(x)	(((x) & 0x3) << 28)
-#define	    NONE       	0
-#define	    CORE       	1
-#define	    CHIP       	2
-#define	    SYSTEM	3
+#define	    DBCR_RST_NONE       	0
+#define	    DBCR_RST_CORE       	1
+#define	    DBCR_RST_CHIP       	2
+#define	    DBCR_RST_SYSTEM		3
 #define	  DBCR_IC	0x08000000	/* Instruction Completion Debug Evnt */
 #define	  DBCR_BT	0x04000000	/* Branch Taken Debug Event */
 #define	  DBCR_EDE	0x02000000	/* Exception Debug Event */
diff -ur official/include/asm-ppc/sembuf.h linux/include/asm-ppc/sembuf.h
--- official/include/asm-ppc/sembuf.h	Thu Jan  1 10:00:00 1970
+++ linux/include/asm-ppc/sembuf.h	Wed Jan 12 14:15:22 2000
@@ -0,0 +1,20 @@
+#ifndef _PPC_SEMBUF_H
+#define _PPC_SEMBUF_H
+
+/* 
+ * The semid64_ds structure for PPC architecture.
+ */
+
+struct semid64_ds {
+	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
+	unsigned int	__unused0;
+	unsigned int	__unused1;
+	__kernel_time_t	sem_otime;		/* last semop time */
+	unsigned int	__unused2;
+	__kernel_time_t	sem_ctime;		/* last change time */
+	unsigned long	sem_nsems;		/* no. of semaphores in array */
+	unsigned long	__unused3;
+	unsigned long	__unused4;
+};
+
+#endif /* _PPC_SEMBUF_H */
diff -ur official/include/asm-ppc/shmbuf.h linux/include/asm-ppc/shmbuf.h
--- official/include/asm-ppc/shmbuf.h	Thu Jan  1 10:00:00 1970
+++ linux/include/asm-ppc/shmbuf.h	Wed Jan 12 14:15:29 2000
@@ -0,0 +1,37 @@
+#ifndef _PPC_SHMBUF_H
+#define _PPC_SHMBUF_H
+
+/* 
+ * The shmid64_ds structure for PPC architecture.
+ */
+
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm;	/* operation perms */
+	unsigned int		__unused0;
+	size_t			shm_segsz;	/* size of segment (bytes) */
+	unsigned long		__unused1;
+	__kernel_time_t		shm_atime;	/* last attach time */
+	unsigned long		__unused2;
+	__kernel_time_t		shm_dtime;	/* last detach time */
+	unsigned long		__unused3;
+	__kernel_time_t		shm_ctime;	/* last change time */
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
diff -ur official/include/asm-ppc/stat.h linux/include/asm-ppc/stat.h
--- official/include/asm-ppc/stat.h	Tue Dec 21 14:20:03 1999
+++ linux/include/asm-ppc/stat.h	Wed Jan 12 13:31:49 2000
@@ -38,39 +38,29 @@
 	unsigned long  	__unused5;
 };
 
-/* This matches struct stat64 in glibc2.1, hence the absolutely
- * insane amounts of padding around dev_t's.
+/* This matches struct stat64 in glibc2.1.
  */
 struct stat64 {
-	unsigned short	st_dev;
-	unsigned char	__pad0[10];
-
-	unsigned long	st_ino;
-	unsigned int	st_mode;
-	unsigned int	st_nlink;
-
-	unsigned long	st_uid;
-	unsigned long	st_gid;
-
-	unsigned short	st_rdev;
-	unsigned char	__pad3[10];
-
-	long long	st_size;
-	unsigned long	st_blksize;
-
-	unsigned long	st_blocks;	/* Number 512-byte blocks allocated. */
-	unsigned long	__pad4;		/* future possible st_blocks high bits */
-
-	unsigned long	st_atime;
-	unsigned long	__pad5;
-
-	unsigned long	st_mtime;
-	unsigned long	__pad6;
-
-	unsigned long	st_ctime;
-	unsigned long	__pad7;		/* will be high 32 bits of ctime someday */
-
-	unsigned long	__unused1;
-	unsigned long	__unused2;
+	unsigned long long st_dev; 	/* Device.  */
+	unsigned short int __pad1;
+	unsigned long st_ino;		/* File serial number.  */
+	unsigned int st_mode;		/* File mode.  */
+	unsigned int st_nlink;		/* Link count.  */
+	unsigned int st_uid;		/* User ID of the file's owner.  */
+	unsigned int st_gid;		/* Group ID of the file's group. */
+	unsigned long long st_rdev; 	/* Device number, if device.  */
+	unsigned short int __pad2;
+	long long st_size;		/* Size of file, in bytes.  */
+	long st_blksize;		/* Optimal block size for I/O.  */
+
+	long long st_blocks;		/* Number 512-byte blocks allocated. */
+	long st_atime;			/* Time of last access.  */
+	unsigned long int __unused1;
+	long st_mtime;			/* Time of last modification.  */
+	unsigned long int __unused2;
+	long st_ctime;			/* Time of last status change.  */
+	unsigned long int __unused3;
+	unsigned long int __unused4;
+	unsigned long int __unused5;
 };
 #endif
diff -ur official/include/linux/highuid.h linux/include/linux/highuid.h
--- official/include/linux/highuid.h	Tue Jan 11 18:19:33 2000
+++ linux/include/linux/highuid.h	Wed Jan 12 13:34:37 2000
@@ -72,6 +72,9 @@
 #define SET_STAT_GID(stat, gid)		(stat).st_gid = gid
 
 #define high2lowuid(x)		(x)
+#define high2lowgid(x)		(x)
+#define low2highuid(x)		(x)
+#define low2highgid(x)		(x)
 
 #endif /* UID16_COMPAT_NEEDED */
 
diff -ur official/kernel/sys.c linux/kernel/sys.c
--- official/kernel/sys.c	Tue Jan 11 18:19:34 2000
+++ linux/kernel/sys.c	Wed Jan 12 13:32:45 2000
@@ -17,6 +17,7 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
+#ifdef UID16_COMPAT_NEEDED
 /*
  * this is where the system-wide overflow UID and GID are defined, for
  * architectures that now have 32-bit UID/GID but didn't in the past
@@ -24,6 +25,7 @@
 
 int overflowuid = DEFAULT_OVERFLOWUID;
 int overflowgid = DEFAULT_OVERFLOWGID;
+#endif /* UID16_COMPAT_NEEDED */
 
 /*
  * the same as above, but for filesystems which can only store a 16-bit
diff -ur official/kernel/sysctl.c linux/kernel/sysctl.c
--- official/kernel/sysctl.c	Tue Jan 11 18:19:34 2000
+++ linux/kernel/sysctl.c	Wed Jan 12 13:33:24 2000
@@ -247,12 +247,14 @@
 	{KERN_MAX_THREADS, "threads-max", &max_threads, sizeof(int),
 	 0644, NULL, &proc_dointvec},
 	{KERN_RANDOM, "random", NULL, 0, 0555, random_table},
+#ifdef UID16_COMPAT_NEEDED
 	{KERN_OVERFLOWUID, "overflowuid", &overflowuid, sizeof(int), 0644, NULL,
 	 &proc_dointvec_minmax, &sysctl_intvec, NULL,
 	 &minolduid, &maxolduid},
 	{KERN_OVERFLOWGID, "overflowgid", &overflowgid, sizeof(int), 0644, NULL,
 	 &proc_dointvec_minmax, &sysctl_intvec, NULL,
 	 &minolduid, &maxolduid},
+#endif /* UID16_COMPAT_NEEDED */
 	{0}
 };
 

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
