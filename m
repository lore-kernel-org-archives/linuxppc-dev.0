Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0335CC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:54:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719D72086D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719D72086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h6Vp2zJNzDqj1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 03:54:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=212.227.17.24; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h5mM3QhSzDr2r
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 03:21:23 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mgek6-1hRG4c1P9I-00h8xD; Fri, 18 Jan 2019 17:19:22 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 05/29] alpha: update syscall macro definitions
Date: Fri, 18 Jan 2019 17:18:11 +0100
Message-Id: <20190118161835.2259170-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IpgN/6x+9YH/ZpCIWY3gRrzUVcyfh4VSAjoJYgiS81Mqfx29mGc
 tms7FOV7IARrkPsfsZf9kthkrdSPhcU5Fk+5diaWJlZCnlKoqrcwQ86I0j+wmrBl558MOJP
 W0E7G8LXcyYeqCWEzJ3PmhdsIUaSud+lGO6LI3qmNkMGAFOLvqYAhqIAfIjooAUgxtqYgGq
 Y0vbQZeedS4Hsd6uRlDsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J1Y3L6SJOuo=:VItzOi0LywpnZmdssIsomL
 T2mnwdZYNpu57GUfSTWNptIZxnNK/YWq19yEt/TrIv1Ufo/7Qhmg87+EMdNkzUG7sHHWU6si4
 e6Uoc+Se5BpQ0e4+vrNpKWZ8KXDTxR84D6WVcgAb3FljBZbE9GyTnTRHNHrRIb0qu3SrTyBWu
 EA7cwltkjUvGb/5OSgUGQEpnPwg2MKZgT1hw25LxxHQFO7W6GgpjUd/ZCE9OnxJgtpTZHEWRD
 8Ty1u/5QO7fkXZQKTIGyqVcXlcNHnonCrkxxNAEiC0EF109yuPFIk/hWsjOAZxkxPD6LZw2CD
 LacdpafGZODtV4hOyeceUKO/V10j+2KpzQg7SGxpqOqxV/6KBQ/1ebDjShdMD2/1zA9VA8gnR
 N3+D48GZa+rXF4UAVWrRs5Rt9+PpmCYGyInuAvwrROOEEdR2PJPYnSDLsUhsLZ13dmR5Il8ot
 9SCWdA4V9RdZ/ugKRltpE+xu+QgrrbocjKgnYA9bbmTUxf2oisicIwxN8MzU2HacKf6qdspxx
 lVIZckAolEYlxaff02IrxkyRNj6qpE+arrYmPN8zYfkV6iworlPh/mQg0GIz6YRr+rQPq44gl
 Wy9i94kb7ciQMeR72WziFVdG66VUSma7hmvqDIgG5Jp9RiYwyOwP6s38kgL4HKDj6vkN4TLU2
 Mh33nR8OVfsKyv776jVob6d/0HDDLFmnbjNvLp2xLJ9V4XJbzDO0uzQrJtj/yaeDsUhY6cz7/
 cJ+KbS1MKRzIIHBL9w1MraFpaGTOU56HmRiQrw==
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, jcmvbkbc@gmail.com,
 deepa.kernel@gmail.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, deller@gmx.de, x86@kernel.org,
 linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 firoz.khan@linaro.org, mattst88@gmail.com, fenghua.yu@intel.com,
 Arnd Bergmann <arnd@arndb.de>, heiko.carstens@de.ibm.com,
 linux-fsdevel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 monstr@monstr.eu, tony.luck@intel.com, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-mips@vger.kernel.org, paul.burton@mips.com,
 ebiederm@xmission.com, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Other architectures commonly use __NR_umount2 for sys_umount,
only ia64 and alpha use __NR_umount here. In order to synchronize
the generated tables, use umount2 like everyone else, and add back
the old name from asm/unistd.h for compatibility.

For shmat, alpha uses the osf_shmat name, we can do the same thing
here, which means we don't have to add an entry in the __IGNORE
list now that shmat is mandatory everywhere

alarm, creat, pause, time, and utime are optional everywhere
these days, no need to list them here any more.

I considered also adding the regular versions of the get*id system
calls that have different names and calling conventions on alpha,
which would further help unify the syscall ABI, but for now
I decided against that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/unistd.h        | 6 ------
 arch/alpha/include/uapi/asm/unistd.h   | 5 +++++
 arch/alpha/kernel/syscalls/syscall.tbl | 4 ++--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index 21b706a5b772..564ba87bdc38 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -22,18 +22,12 @@
 /*
  * Ignore legacy syscalls that we don't use.
  */
-#define __IGNORE_alarm
-#define __IGNORE_creat
 #define __IGNORE_getegid
 #define __IGNORE_geteuid
 #define __IGNORE_getgid
 #define __IGNORE_getpid
 #define __IGNORE_getppid
 #define __IGNORE_getuid
-#define __IGNORE_pause
-#define __IGNORE_time
-#define __IGNORE_utime
-#define __IGNORE_umount2
 
 /* Alpha doesn't have protection keys. */
 #define __IGNORE_pkey_mprotect
diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index 9ba724f116f1..4507071f995f 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -2,6 +2,11 @@
 #ifndef _UAPI_ALPHA_UNISTD_H
 #define _UAPI_ALPHA_UNISTD_H
 
+/* These are traditionally the names linux-alpha uses for
+ * the two otherwise generic system calls */
+#define __NR_umount	__NR_umount2
+#define __NR_osf_shmat	__NR_shmat
+
 #include <asm/unistd_32.h>
 
 #endif /* _UAPI_ALPHA_UNISTD_H */
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index e09558edae73..f920b65e8c49 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -29,7 +29,7 @@
 19	common	lseek				sys_lseek
 20	common	getxpid				sys_getxpid
 21	common	osf_mount			sys_osf_mount
-22	common	umount				sys_umount
+22	common	umount2				sys_umount
 23	common	setuid				sys_setuid
 24	common	getxuid				sys_getxuid
 25	common	exec_with_loader		sys_ni_syscall
@@ -183,7 +183,7 @@
 206	common	semop				sys_semop
 207	common	osf_utsname			sys_osf_utsname
 208	common	lchown				sys_lchown
-209	common	osf_shmat			sys_shmat
+209	common	shmat				sys_shmat
 210	common	shmctl				sys_shmctl
 211	common	shmdt				sys_shmdt
 212	common	shmget				sys_shmget
-- 
2.20.0

