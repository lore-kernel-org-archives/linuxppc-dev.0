Return-Path: <eric@ebiederm.dsl.xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35BE9DFCD1
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:19:42 +1100 (EST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 49/59] sysctl: Move init_irq_proc into init/main where it
	belongs
Date: Tue, 16 Jan 2007 09:39:54 -0700
Message-Id: <1168965684147-git-send-email-ebiederm@xmission.com>
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Cc: linux-mips@linux-mips.org, linux-parport@lists.infradead.org,
	heiko.carstens@de.ibm.com, ak@suse.de, linuxppc-dev@ozlabs.org,
	paulus@samba.org, aharkes@cs.cmu.edu, schwidefsky@de.ibm.com,
	tim@cyberelk.net, rtc-linux@googlegroups.com,
	linux-scsi@vger.kernel.org, kurt.hackel@oracle.com,
	coda@cs.cmu.edu, vojtech@suse.cz,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	James.Bottomley@SteelEye.com, clemens@ladisch.de,
	xfs@oss.sgi.com, xfs-masters@oss.sgi.com, andrea@suse.de,
	openipmi-developer@lists.sourceforge.net,
	linux-390@vm.marist.edu, codalist@TELEMANN.coda.cs.cmu.edu,
	a.zummo@towertech.it, tony.luck@intel.com,
	linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
	aia21@cantab.net, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, lethal@linux-sh.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	containers@lists.osdl.org, linux390@de.ibm.com, philb@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 init/main.c     |    3 +++
 kernel/sysctl.c |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index 8b4a7d7..8af5c6e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -691,6 +691,9 @@ static void __init do_basic_setup(void)
 #ifdef CONFIG_SYSCTL
 	sysctl_init();
 #endif
+#ifdef CONFIG_PROC_FS
+	init_irq_proc();
+#endif
 
 	do_initcalls();
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 600b333..7420761 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1172,8 +1172,6 @@ static ctl_table dev_table[] = {
 	{ .ctl_name = 0 }
 };
 
-extern void init_irq_proc (void);
-
 static DEFINE_SPINLOCK(sysctl_lock);
 
 /* called under sysctl_lock */
@@ -1219,7 +1217,6 @@ void __init sysctl_init(void)
 {
 #ifdef CONFIG_PROC_SYSCTL
 	register_proc_table(root_table, proc_sys_root, &root_table_header);
-	init_irq_proc();
 #endif
 }
 
-- 
1.4.4.1.g278f
