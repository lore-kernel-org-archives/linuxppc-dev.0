Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wgcB61RctzDqKc
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Jun 2017 22:06:37 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id v18so3489660pgb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Jun 2017 05:06:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH] selftests/powerpc: context_switch use private futexes with
 threads
Date: Sun,  4 Jun 2017 22:06:22 +1000
Message-Id: <20170604120622.19778-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reduces overhead of mutex locking and increases context switch
rate significantly (which helps to measure and profile the context
switch path).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../selftests/powerpc/benchmarks/context_switch.c  | 53 ++++++++++++++--------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/context_switch.c b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
index 778f5fbfd784..f4241339edd2 100644
--- a/tools/testing/selftests/powerpc/benchmarks/context_switch.c
+++ b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
@@ -258,9 +258,14 @@ static unsigned long xchg(unsigned long *p, unsigned long val)
 	return __atomic_exchange_n(p, val, __ATOMIC_SEQ_CST);
 }
 
+static int processes;
+
 static int mutex_lock(unsigned long *m)
 {
 	int c;
+	int flags = FUTEX_WAIT;
+	if (!processes)
+		flags |= FUTEX_PRIVATE_FLAG;
 
 	c = cmpxchg(m, 0, 1);
 	if (!c)
@@ -270,7 +275,7 @@ static int mutex_lock(unsigned long *m)
 		c = xchg(m, 2);
 
 	while (c) {
-		sys_futex(m, FUTEX_WAIT, 2, NULL, NULL, 0);
+		sys_futex(m, flags, 2, NULL, NULL, 0);
 		c = xchg(m, 2);
 	}
 
@@ -279,12 +284,16 @@ static int mutex_lock(unsigned long *m)
 
 static int mutex_unlock(unsigned long *m)
 {
+	int flags = FUTEX_WAKE;
+	if (!processes)
+		flags |= FUTEX_PRIVATE_FLAG;
+
 	if (*m == 2)
 		*m = 0;
 	else if (xchg(m, 0) == 1)
 		return 0;
 
-	sys_futex(m, FUTEX_WAKE, 1, NULL, NULL, 0);
+	sys_futex(m, flags, 1, NULL, NULL, 0);
 
 	return 0;
 }
@@ -293,26 +302,32 @@ static unsigned long *m1, *m2;
 
 static void futex_setup(int cpu1, int cpu2)
 {
-	int shmid;
-	void *shmaddr;
+	if (!processes) {
+		static unsigned long _m1, _m2;
+		m1 = &_m1;
+		m2 = &_m2;
+	} else {
+		int shmid;
+		void *shmaddr;
 
-	shmid = shmget(IPC_PRIVATE, getpagesize(), SHM_R | SHM_W);
-	if (shmid < 0) {
-		perror("shmget");
-		exit(1);
-	}
+		shmid = shmget(IPC_PRIVATE, getpagesize(), SHM_R | SHM_W);
+		if (shmid < 0) {
+			perror("shmget");
+			exit(1);
+		}
 
-	shmaddr = shmat(shmid, NULL, 0);
-	if (shmaddr == (char *)-1) {
-		perror("shmat");
-		shmctl(shmid, IPC_RMID, NULL);
-		exit(1);
-	}
+		shmaddr = shmat(shmid, NULL, 0);
+		if (shmaddr == (char *)-1) {
+			perror("shmat");
+			shmctl(shmid, IPC_RMID, NULL);
+			exit(1);
+		}
 
-	shmctl(shmid, IPC_RMID, NULL);
+		shmctl(shmid, IPC_RMID, NULL);
 
-	m1 = shmaddr;
-	m2 = shmaddr + sizeof(*m1);
+		m1 = shmaddr;
+		m2 = shmaddr + sizeof(*m1);
+	}
 
 	*m1 = 0;
 	*m2 = 0;
@@ -352,8 +367,6 @@ static struct actions futex_actions = {
 	.thread2 = futex_thread2,
 };
 
-static int processes;
-
 static struct option options[] = {
 	{ "test", required_argument, 0, 't' },
 	{ "process", no_argument, &processes, 1 },
-- 
2.11.0
