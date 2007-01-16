Return-Path: <eric@ebiederm.dsl.xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A86CB47FC4
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:28:27 +1100 (EST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 28/59] sysctl: C99 Convert arch/ia64/sn/kernel/xpc_main.c
Date: Tue, 16 Jan 2007 09:39:33 -0700
Message-Id: <11689656481444-git-send-email-ebiederm@xmission.com>
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
 arch/ia64/sn/kernel/xpc_main.c |   86 +++++++++++++++++----------------------
 1 files changed, 38 insertions(+), 48 deletions(-)

diff --git a/arch/ia64/sn/kernel/xpc_main.c b/arch/ia64/sn/kernel/xpc_main.c
index 24adb75..e04f7b5 100644
--- a/arch/ia64/sn/kernel/xpc_main.c
+++ b/arch/ia64/sn/kernel/xpc_main.c
@@ -101,67 +101,57 @@ static int xpc_disengage_request_max_timelimit = 120;
 
 static ctl_table xpc_sys_xpc_hb_dir[] = {
 	{
-		CTL_UNNUMBERED,
-		"hb_interval",
-		&xpc_hb_interval,
-		sizeof(int),
-		0644,
-		NULL,
-		&proc_dointvec_minmax,
-		&sysctl_intvec,
-		NULL,
-		&xpc_hb_min_interval,
-		&xpc_hb_max_interval
+		.ctl_name 	= CTL_UNNUMBERED,
+		.procname	= "hb_interval",
+		.data		= &xpc_hb_interval,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &xpc_hb_min_interval,
+		.extra2		= &xpc_hb_max_interval
 	},
 	{
-		CTL_UNNUMBERED,
-		"hb_check_interval",
-		&xpc_hb_check_interval,
-		sizeof(int),
-		0644,
-		NULL,
-		&proc_dointvec_minmax,
-		&sysctl_intvec,
-		NULL,
-		&xpc_hb_check_min_interval,
-		&xpc_hb_check_max_interval
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "hb_check_interval",
+		.data		= &xpc_hb_check_interval,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &xpc_hb_check_min_interval,
+		.extra2		= &xpc_hb_check_max_interval
 	},
-	{0}
+	{}
 };
 static ctl_table xpc_sys_xpc_dir[] = {
 	{
-		CTL_UNNUMBERED,
-		"hb",
-		NULL,
-		0,
-		0555,
-		xpc_sys_xpc_hb_dir
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "hb",
+		.mode		= 0555,
+		.child		= xpc_sys_xpc_hb_dir
 	},
 	{
-		CTL_UNNUMBERED,
-		"disengage_request_timelimit",
-		&xpc_disengage_request_timelimit,
-		sizeof(int),
-		0644,
-		NULL,
-		&proc_dointvec_minmax,
-		&sysctl_intvec,
-		NULL,
-		&xpc_disengage_request_min_timelimit,
-		&xpc_disengage_request_max_timelimit
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "disengage_request_timelimit",
+		.data		= &xpc_disengage_request_timelimit,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &xpc_disengage_request_min_timelimit,
+		.extra2		= &xpc_disengage_request_max_timelimit
 	},
-	{0}
+	{}
 };
 static ctl_table xpc_sys_dir[] = {
 	{
-		CTL_UNNUMBERED,
-		"xpc",
-		NULL,
-		0,
-		0555,
-		xpc_sys_xpc_dir
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "xpc",
+		.mode		= 0555,
+		.child		= xpc_sys_xpc_dir
 	},
-	{0}
+	{}
 };
 static struct ctl_table_header *xpc_sysctl;
 
-- 
1.4.4.1.g278f
