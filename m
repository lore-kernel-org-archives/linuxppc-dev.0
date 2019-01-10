Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2886FC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 17:27:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B3520675
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 17:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B3520675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bCcX5RyDzDqwp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 04:27:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=212.227.17.24; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bCX95tnYzDqrs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 04:23:53 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M1YlB-1gj0Y53QqZ-00392C; Thu, 10 Jan 2019 18:22:27 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] sparc64: add custom adjtimex/clock_adjtime functions
Date: Thu, 10 Jan 2019 18:22:09 +0100
Message-Id: <20190110172216.313063-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110172216.313063-1-arnd@arndb.de>
References: <20190110172216.313063-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:skl8YoXVM1Bc5+8dLW6QPXqjNzPwSft+J3Z9tp7jCI69k8uS5A3
 j2I7TeRnybSEJFb6PQqZMoHbkDUXGvJXuyjHR2Ns9/VqVsM53sRR/AGT1uOL060++7vH3Gn
 pdvEn42TyE862JeQv55VlSNDDQZu2+Rs4tekg9xSH98Ed2SMBgImuPzGqpDEcUMvk/slUwe
 IqxgXElAXtPcMsm2Z+jzg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:soy2U2+eGws=:RffHu7RnBAIh8UUMhJt9sf
 oh7+KdNv8MWAzk+8RiKwVaFuw1j27FQR6i/QGMPfjh1un1huoAVqvcJCwFkJojv4YhsblpVoH
 pqH7zN+S3yHM+IQNXHSCG54Ne99zeW9yEa119FWPKFn7kT3yLvmakrwBKMbhk1xsiSIFsQmIp
 4owhosQ/sDqE34Mgy4rwOeRZzxf2ggahK2zlaaFmTpw0dXr8dbFg6+rtPrQoB5UZ+xQvo2K4Z
 J+lvUC1VnbLun5F2LbntlwAHBBN4iG6ecpV5gTjvU7MEWpZRYVSLKL7Tt6yQMHTCgGZFX6V7e
 TLSdHmttbQW/o4zOJdy3zKbSDw/f83to6b0fAv/rtdsEkboe6IGCjzwkBxtvwk6jssjkdOXPV
 o0CRInNscWizL/Y/HrEFlPNW9Md0f3WdTx/XtDj7I1ZekBLzcQtEvZ6bcHJQJayf52UsMAieS
 WHL0Zpo6DK5DqB4+Vo5c0+iZii0cCkxEGtH2Lr/339n7YTQQ/cFRjr1iaaXGC2KHtiFJB+WZS
 yRiIQxVi+iRUDazPiJbPgeS4LEUMcRwNh2BAth096SqMadNXmr3XQg9PAp8MsIG9JcPDKBSjL
 2BCQwqRhWbP5NFNtWSRv6OMZTdtpRIad7HFNdBdOrTyoWfKOs5UyaIErMXw/bVOjW7jw/444v
 BGAIHlIZNgzj/tRWT1N+OPGQjjSJR6vU4+DjIz6tgJwspulmhZTX6vsywIBEXX9W8ud1vInH6
 9W6w+bRLaMSp48mg9WVDKzifCT7lW0L0rkB7aQ==
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
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, deller@gmx.de,
 x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
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

sparc64 is the only architecture on Linux that has a 'timeval'
definition with a 32-bit tv_usec but a 64-bit tv_sec. This causes
problems for sparc32 compat mode when we convert it to use the
new __kernel_timex type that has the same layout as all other
64-bit architectures.

To avoid adding sparc64 specific code into the generic adjtimex
implementation, this adds a wrapper in the sparc64 system call handling
that converts the sparc64 'timex' into the new '__kernel_timex'.

At this point, the two structures are defined to be identical,
but that will change in the next step once we convert sparc32.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/kernel/sys_sparc_64.c       | 59 +++++++++++++++++++++++++-
 arch/sparc/kernel/syscalls/syscall.tbl |  6 ++-
 include/linux/timex.h                  |  2 +
 kernel/time/posix-timers.c             | 24 +++++------
 4 files changed, 76 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 1c079e7bab09..37de18a11207 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -28,8 +28,9 @@
 #include <linux/random.h>
 #include <linux/export.h>
 #include <linux/context_tracking.h>
-
+#include <linux/timex.h>
 #include <linux/uaccess.h>
+
 #include <asm/utrap.h>
 #include <asm/unistd.h>
 
@@ -544,6 +545,62 @@ SYSCALL_DEFINE2(getdomainname, char __user *, name, int, len)
 	return err;
 }
 
+SYSCALL_DEFINE1(sparc_adjtimex, struct timex __user *, txc_p)
+{
+	struct timex txc;		/* Local copy of parameter */
+	struct timex *kt = (void *)&txc;
+	int ret;
+
+	/* Copy the user data space into the kernel copy
+	 * structure. But bear in mind that the structures
+	 * may change
+	 */
+	if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
+		return -EFAULT;
+
+	/*
+	 * override for sparc64 specific timeval type: tv_usec
+	 * is 32 bit wide instead of 64-bit in __kernel_timex
+	 */
+	kt->time.tv_usec = txc.time.tv_usec;
+	ret = do_adjtimex(kt);
+	txc.time.tv_usec = kt->time.tv_usec;
+
+	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
+}
+
+SYSCALL_DEFINE2(sparc_clock_adjtime, const clockid_t, which_clock,struct timex __user *, txc_p)
+{
+	struct timex txc;		/* Local copy of parameter */
+	struct timex *kt = (void *)&txc;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_POSIX_TIMERS)) {
+		pr_err_once("process %d (%s) attempted a POSIX timer syscall "
+		    "while CONFIG_POSIX_TIMERS is not set\n",
+		    current->pid, current->comm);
+
+		return -ENOSYS;
+	}
+
+	/* Copy the user data space into the kernel copy
+	 * structure. But bear in mind that the structures
+	 * may change
+	 */
+	if (copy_from_user(&txc, txc_p, sizeof(struct timex)))
+		return -EFAULT;
+
+	/*
+	 * override for sparc64 specific timeval type: tv_usec
+	 * is 32 bit wide instead of 64-bit in __kernel_timex
+	 */
+	kt->time.tv_usec = txc.time.tv_usec;
+	ret = do_clock_adjtime(which_clock, kt);
+	txc.time.tv_usec = kt->time.tv_usec;
+
+	return copy_to_user(txc_p, &txc, sizeof(struct timex)) ? -EFAULT : ret;
+}
+
 SYSCALL_DEFINE5(utrap_install, utrap_entry_t, type,
 		utrap_handler_t, new_p, utrap_handler_t, new_d,
 		utrap_handler_t __user *, old_p,
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 24ebef675184..e70110375399 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -258,7 +258,8 @@
 216	64	sigreturn		sys_nis_syscall
 217	common	clone			sys_clone
 218	common	ioprio_get		sys_ioprio_get
-219	common	adjtimex		sys_adjtimex			compat_sys_adjtimex
+219	32	adjtimex		sys_adjtimex			compat_sys_adjtimex
+219	64	adjtimex		sys_sparc_adjtimex
 220	32	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
 220	64	sigprocmask		sys_nis_syscall
 221	common	create_module		sys_ni_syscall
@@ -377,7 +378,8 @@
 331	common	prlimit64		sys_prlimit64
 332	common	name_to_handle_at	sys_name_to_handle_at
 333	common	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
-334	common	clock_adjtime		sys_clock_adjtime		compat_sys_clock_adjtime
+334	32	clock_adjtime		sys_clock_adjtime		compat_sys_clock_adjtime
+334	64	clock_adjtime		sys_sparc_clock_adjtime
 335	common	syncfs			sys_syncfs
 336	common	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
 337	common	setns			sys_setns
diff --git a/include/linux/timex.h b/include/linux/timex.h
index 7f40e9e42ecc..a15e6aeb8d49 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -159,6 +159,8 @@ extern unsigned long tick_nsec;		/* SHIFTED_HZ period (nsec) */
 #define NTP_INTERVAL_LENGTH (NSEC_PER_SEC/NTP_INTERVAL_FREQ)
 
 extern int do_adjtimex(struct timex *);
+extern int do_clock_adjtime(const clockid_t which_clock, struct timex * ktx);
+
 extern void hardpps(const struct timespec64 *, const struct timespec64 *);
 
 int read_current_timer(unsigned long *timer_val);
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 8955f32f2a36..8f7f1dd95940 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1047,22 +1047,28 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
 	return error;
 }
 
-SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_clock,
-		struct timex __user *, utx)
+int do_clock_adjtime(const clockid_t which_clock, struct timex * ktx)
 {
 	const struct k_clock *kc = clockid_to_kclock(which_clock);
-	struct timex ktx;
-	int err;
 
 	if (!kc)
 		return -EINVAL;
 	if (!kc->clock_adj)
 		return -EOPNOTSUPP;
 
+	return kc->clock_adj(which_clock, ktx);
+}
+
+SYSCALL_DEFINE2(clock_adjtime, const clockid_t, which_clock,
+		struct timex __user *, utx)
+{
+	struct timex ktx;
+	int err;
+
 	if (copy_from_user(&ktx, utx, sizeof(ktx)))
 		return -EFAULT;
 
-	err = kc->clock_adj(which_clock, &ktx);
+	err = do_clock_adjtime(which_clock, &ktx);
 
 	if (err >= 0 && copy_to_user(utx, &ktx, sizeof(ktx)))
 		return -EFAULT;
@@ -1126,20 +1132,14 @@ COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
 COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
 		       struct old_timex32 __user *, utp)
 {
-	const struct k_clock *kc = clockid_to_kclock(which_clock);
 	struct timex ktx;
 	int err;
 
-	if (!kc)
-		return -EINVAL;
-	if (!kc->clock_adj)
-		return -EOPNOTSUPP;
-
 	err = get_old_timex32(&ktx, utp);
 	if (err)
 		return err;
 
-	err = kc->clock_adj(which_clock, &ktx);
+	err = do_clock_adjtime(which_clock, &ktx);
 
 	if (err >= 0)
 		err = put_old_timex32(utp, &ktx);
-- 
2.20.0

