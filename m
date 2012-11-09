Return-Path: <Shan.Hai@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 26B412C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2012 12:58:36 +1100 (EST)
Date: Fri, 9 Nov 2012 09:57:49 +0800
From: Shan Hai <shan.hai@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH 0/1] powerpc/vdso: remove redundant locking in
 update_vsyscall_tz()
Message-ID: <20121109015718.GA6124@debian.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2B/JsCI69OhZNC5r"
Cc: john.stultz@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

The locking in update_vsyscall_tz() is not only unnecessary because the vdso
code copies the data unproteced in __kernel_gettimeofday() but also
introduces a hard to reproduce race condition between update_vsyscall()
and update_vsyscall_tz(), which causes user space process to loop
forever in vdso code.

The following patch removes the locking from update_vsyscall_tz().

---
 arch/powerpc/kernel/time.c |    5 -----
 1 file changed, 5 deletions(-)

Thanks
Shan Hai

--2B/JsCI69OhZNC5r
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment;
	filename="0001-powerpc-vdso-remove-redundant-locking-in-update_vsys.patch"

>From 167eac293b07e0ee201ffe5043ec442d52495a48 Mon Sep 17 00:00:00 2001
From: Shan Hai <shan.hai@windriver.com>
Date: Mon, 5 Nov 2012 18:24:22 +0800
Subject: [PATCH 1/1] powerpc/vdso: remove redundant locking in
 update_vsyscall_tz()

Locking is not only unnecessary because the vdso code copies the data
unprotected in __kernel_gettimeofday() but also erroneous because updating
the tb_update_count is not atomic and introduces a hard to reproduce race
condition between update_vsyscall() and update_vsyscall_tz(), which further
causes user space process to loop forever in vdso code.

The below scenario describes the race condition,
x==0	Boot CPU			other CPU
	proc_P: x==0
	    timer interrupt
		update_vsyscall
x==1		    x++;sync		settimeofday
					    update_vsyscall_tz
x==2						x++;sync
x==3		    sync;x++
						sync;x++
	proc_P: x==3 (loops until x becomes even)

Because the ++ operator would be implemented as three instructions and not
atomic on powerpc.

A similar change was made for x86 in commit 6c260d58634
("x86: vdso: Remove bogus locking in update_vsyscall_tz")

Signed-off-by: Shan Hai <shan.hai@windriver.com>
---
 arch/powerpc/kernel/time.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 03b29a6..426141f 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -859,13 +859,8 @@ void update_vsyscall(struct timespec *wall_time, struct timespec *wtm,
 
 void update_vsyscall_tz(void)
 {
-	/* Make userspace gettimeofday spin until we're done. */
-	++vdso_data->tb_update_count;
-	smp_mb();
 	vdso_data->tz_minuteswest = sys_tz.tz_minuteswest;
 	vdso_data->tz_dsttime = sys_tz.tz_dsttime;
-	smp_mb();
-	++vdso_data->tb_update_count;
 }
 
 static void __init clocksource_init(void)
-- 
1.7.10.4


--2B/JsCI69OhZNC5r--
