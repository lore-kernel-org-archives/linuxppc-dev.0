Return-Path: <vatsa@codeaurora.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "wolverine01.qualcomm.com",
 Issuer "VeriSign Class 3 Secure Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C0CCD2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2013 14:08:57 +1100 (EST)
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: Russell King <linux@arm.linux.org.uk>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Stephen Boyd <sboyd@codeaurora.org>, linux-arm-kernel@lists.infradead.org,
 Mike Frysinger <vapier@gentoo.org>,
 uclinux-dist-devel@blackfin.uclinux.org,
 Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux-s390@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
 linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, mhocko@suse.cz, srivatsa.bhat@linux.vnet.ibm.com
Subject: [PATCH 2/2] Revert "nohz: Fix idle ticks in cpu summary line of
 /proc/stat" (commit 7386cdbf2f57ea8cff3c9fde93f206e58b9fe13f).
Date: Thu,  3 Jan 2013 18:58:57 -0800
Message-Id: <1357268337-8025-1-git-send-email-vatsa@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, Srivatsa Vaddagiri <vatsa@codeaurora.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With offline cpus no longer beeing seen in nohz mode (ts->idle_active=0), we
don't need the check for cpu_online() introduced in commit 7386cdbf. Offline
cpu's idle time as last recorded in its ts->idle_sleeptime will be reported
(thus excluding its offline time as part of idle time statistics).

Cc: mhocko@suse.cz
Cc: srivatsa.bhat@linux.vnet.ibm.com
Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
---
 fs/proc/stat.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index e296572..64c3b31 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -45,13 +45,10 @@ static cputime64_t get_iowait_time(int cpu)
 
 static u64 get_idle_time(int cpu)
 {
-	u64 idle, idle_time = -1ULL;
-
-	if (cpu_online(cpu))
-		idle_time = get_cpu_idle_time_us(cpu, NULL);
+	u64 idle, idle_time = get_cpu_idle_time_us(cpu, NULL);
 
 	if (idle_time == -1ULL)
-		/* !NO_HZ or cpu offline so we can rely on cpustat.idle */
+		/* !NO_HZ so we can rely on cpustat.idle */
 		idle = kcpustat_cpu(cpu).cpustat[CPUTIME_IDLE];
 	else
 		idle = usecs_to_cputime64(idle_time);
@@ -61,13 +58,10 @@ static u64 get_idle_time(int cpu)
 
 static u64 get_iowait_time(int cpu)
 {
-	u64 iowait, iowait_time = -1ULL;
-
-	if (cpu_online(cpu))
-		iowait_time = get_cpu_iowait_time_us(cpu, NULL);
+	u64 iowait, iowait_time = get_cpu_iowait_time_us(cpu, NULL);
 
 	if (iowait_time == -1ULL)
-		/* !NO_HZ or cpu offline so we can rely on cpustat.iowait */
+		/* !NO_HZ so we can rely on cpustat.iowait */
 		iowait = kcpustat_cpu(cpu).cpustat[CPUTIME_IOWAIT];
 	else
 		iowait = usecs_to_cputime64(iowait_time);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
