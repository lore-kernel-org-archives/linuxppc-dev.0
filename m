Return-Path: <vatsa@in.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37CF267A6F
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2006 16:34:23 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k376YFSf026512
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2006 02:34:15 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k376Y5uK231656
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2006 02:34:05 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k376Y5B1013103
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2006 02:34:05 -0400
Date: Fri, 7 Apr 2006 12:02:08 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: anton@samba.org, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 3/4] tickless idle cpus: sysctl support
Message-ID: <20060407063208.GC22416@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, sri_vatsa_v@yahoo.com
Reply-To: vatsa@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

During initial phase, it is useful to have sysctl control to turn on/off
tickless idle CPU feature at run time. Patch below, against
2.6.17-rc1-mm1, provides that support for all architectures.

Signed-off-by: Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.17-rc1-root/kernel/sysctl.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff -puN kernel/sysctl.c~sysctl kernel/sysctl.c
--- linux-2.6.17-rc1/kernel/sysctl.c~sysctl	2006-04-07 11:29:28.000000000 +0530
+++ linux-2.6.17-rc1-root/kernel/sysctl.c	2006-04-07 11:29:28.000000000 +0530
@@ -554,6 +554,16 @@ static ctl_table kern_table[] = {
 		.extra1		= &minolduid,
 		.extra2		= &maxolduid,
 	},
+#ifdef CONFIG_NO_IDLE_HZ
+	{
+		.ctl_name       = KERN_HZ_TIMER,
+		.procname       = "hz_timer",
+		.data           = &sysctl_hz_timer,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = &proc_dointvec,
+	},
+#endif
 #ifdef CONFIG_S390
 #ifdef CONFIG_MATHEMU
 	{
@@ -565,16 +575,6 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_NO_IDLE_HZ
-	{
-		.ctl_name       = KERN_HZ_TIMER,
-		.procname       = "hz_timer",
-		.data           = &sysctl_hz_timer,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = &proc_dointvec,
-	},
-#endif
 	{
 		.ctl_name	= KERN_S390_USER_DEBUG_LOGGING,
 		.procname	= "userprocess_debug",

_
-- 
Regards,
vatsa
