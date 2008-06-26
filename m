Return-Path: <monstr@seznam.cz>
Received: from monstr.eu (238.225.broadband7.iol.cz [88.102.225.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4EB31DE926
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 22:39:57 +1000 (EST)
From: monstr@seznam.cz
To: linux-kernel@vger.kernel.org
Subject: [PATCH 33/60] microblaze_v4: includes SHM*, msgbuf
Date: Thu, 26 Jun 2008 14:30:02 +0200
Message-Id: <1214483429-32360-34-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-33-git-send-email-monstr@seznam.cz>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-2-git-send-email-monstr@seznam.cz>
	<1214483429-32360-3-git-send-email-monstr@seznam.cz>
	<1214483429-32360-4-git-send-email-monstr@seznam.cz>
	<1214483429-32360-5-git-send-email-monstr@seznam.cz>
	<1214483429-32360-6-git-send-email-monstr@seznam.cz>
	<1214483429-32360-7-git-send-email-monstr@seznam.cz>
	<1214483429-32360-8-git-send-email-monstr@seznam.cz>
	<1214483429-32360-9-git-send-email-monstr@seznam.cz>
	<1214483429-32360-10-git-send-email-monstr@seznam.cz>
	<1214483429-32360-11-git-send-email-monstr@seznam.cz>
	<1214483429-32360-12-git-send-email-monstr@seznam.cz>
	<1214483429-32360-13-git-send-email-monstr@seznam.cz>
	<1214483429-32360-14-git-send-email-monstr@seznam.cz>
	<1214483429-32360-15-git-send-email-monstr@seznam.cz>
	<1214483429-32360-16-git-send-email-monstr@seznam.cz>
	<1214483429-32360-17-git-send-email-monstr@seznam.cz>
	<1214483429-32360-18-git-send-email-monstr@seznam.cz>
	<1214483429-32360-19-git-send-email-monstr@seznam.cz>
	<1214483429-32360-20-git-send-email-monstr@seznam.cz>
	<1214483429-32360-21-git-send-email-monstr@seznam.cz>
	<1214483429-32360-22-git-send-email-monstr@seznam.cz>
	<1214483429-32360-23-git-send-email-monstr@seznam.cz>
	<1214483429-32360-24-git-send-email-monstr@seznam.cz>
	<1214483429-32360-25-git-send-email-monstr@seznam.cz>
	<1214483429-32360-26-git-send-email-monstr@seznam.cz>
	<1214483429-32360-27-git-send-email-monstr@seznam.cz>
	<1214483429-32360-28-git-send-email-monstr@seznam.cz>
	<1214483429-32360-29-git-send-email-monstr@seznam.cz>
	<1214483429-32360-30-git-send-email-monstr@seznam.cz>
	<1214483429-32360-31-git-send-email-monstr@seznam.cz>
	<1214483429-32360-32-git-send-email-monstr@seznam.cz>
	<1214483429-32360-33-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	drepper@redhat.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com, John.Linn@xilinx.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michal Simek <monstr@monstr.eu>


Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 include/asm-microblaze/msgbuf.h   |   39 ++++++++++++++++++++++++++++
 include/asm-microblaze/shmbuf.h   |   50 +++++++++++++++++++++++++++++++++++++
 include/asm-microblaze/shmparam.h |   14 ++++++++++
 3 files changed, 103 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-microblaze/msgbuf.h
 create mode 100644 include/asm-microblaze/shmbuf.h
 create mode 100644 include/asm-microblaze/shmparam.h

diff --git a/include/asm-microblaze/msgbuf.h b/include/asm-microblaze/msgbuf.h
new file mode 100644
index 0000000..8172bc9
--- /dev/null
+++ b/include/asm-microblaze/msgbuf.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_MSGBUF_H
+#define _ASM_MICROBLAZE_MSGBUF_H
+
+/*
+ * The msqid64_ds structure for microblaze architecture.
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
+	__kernel_time_t msg_stime; /* last msgsnd time */
+	unsigned long __unused1;
+	__kernel_time_t msg_rtime; /* last msgrcv time */
+	unsigned long __unused2;
+	__kernel_time_t msg_ctime; /* last change time */
+	unsigned long __unused3;
+	unsigned long msg_cbytes; /* current number of bytes on queue */
+	unsigned long msg_qnum; /* number of messages in queue */
+	unsigned long msg_qbytes; /* max number of bytes on queue */
+	__kernel_pid_t msg_lspid; /* pid of last msgsnd */
+	__kernel_pid_t msg_lrpid; /* last receive pid */
+	unsigned long __unused4;
+	unsigned long __unused5;
+};
+
+#endif /* _ASM_MICROBLAZE_MSGBUF_H */
diff --git a/include/asm-microblaze/shmbuf.h b/include/asm-microblaze/shmbuf.h
new file mode 100644
index 0000000..a460e36
--- /dev/null
+++ b/include/asm-microblaze/shmbuf.h
@@ -0,0 +1,50 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_SHMBUF_H
+#define _ASM_MICROBLAZE_SHMBUF_H
+
+/*
+ * The shmid64_ds structure for microblaze architecture.
+ * Note extra padding because this structure is passed back and forth
+ * between kernel and user space.
+ *
+ * Pad space is left for:
+ * - 64-bit time_t to solve y2038 problem
+ * - 2 miscellaneous 32-bit values
+ */
+
+struct shmid64_ds {
+	struct ipc64_perm	shm_perm; /* operation perms */
+	size_t			shm_segsz; /* size of segment (bytes) */
+	__kernel_time_t		shm_atime; /* last attach time */
+	unsigned long		__unused1;
+	__kernel_time_t		shm_dtime; /* last detach time */
+	unsigned long		__unused2;
+	__kernel_time_t		shm_ctime; /* last change time */
+	unsigned long		__unused3;
+	__kernel_pid_t		shm_cpid; /* pid of creator */
+	__kernel_pid_t		shm_lpid; /* pid of last operator */
+	unsigned long		shm_nattch; /* no. of current attaches */
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
+#endif /* _ASM_MICROBLAZE_SHMBUF_H */
diff --git a/include/asm-microblaze/shmparam.h b/include/asm-microblaze/shmparam.h
new file mode 100644
index 0000000..719bbed
--- /dev/null
+++ b/include/asm-microblaze/shmparam.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (C) 2006 Atmark Techno, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#ifndef _ASM_MICROBLAZE_SHMPARAM_H
+#define _ASM_MICROBLAZE_SHMPARAM_H
+
+#define SHMLBA	PAGE_SIZE /* attach addr a multiple of this */
+
+#endif /* _ASM_MICROBLAZE_SHMPARAM_H */
-- 
1.5.4.GIT
