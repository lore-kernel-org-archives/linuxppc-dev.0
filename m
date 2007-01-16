Return-Path: <eric@ebiederm.dsl.xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D468747940
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:27:36 +1100 (EST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 29/59] sysctl: C99 convert arch/ia64/kernel/perfmon and remove
	ABI breakage
Date: Tue, 16 Jan 2007 09:39:34 -0700
Message-Id: <1168965650735-git-send-email-ebiederm@xmission.com>
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

This convers the sysctl ctl_tables to use C99 initializers.
While I was looking at it I discovered it was using a portion of
the sysctl binary addresses space under CTL_KERN KERN_OSTYPE
which was completely inappropriate.  So I completely removed
all of the sysctl binary names, to remove and avoid the ABI conflict.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/ia64/kernel/perfmon.c |   56 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index aa94f60..8c679ab 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -521,19 +521,57 @@ pfm_sysctl_t pfm_sysctl;
 EXPORT_SYMBOL(pfm_sysctl);
 
 static ctl_table pfm_ctl_table[]={
-	{1, "debug", &pfm_sysctl.debug, sizeof(int), 0666, NULL, &proc_dointvec, NULL,},
-	{2, "debug_ovfl", &pfm_sysctl.debug_ovfl, sizeof(int), 0666, NULL, &proc_dointvec, NULL,},
-	{3, "fastctxsw", &pfm_sysctl.fastctxsw, sizeof(int), 0600, NULL, &proc_dointvec, NULL,},
-	{4, "expert_mode", &pfm_sysctl.expert_mode, sizeof(int), 0600, NULL, &proc_dointvec, NULL,},
-	{ 0, },
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "debug",
+		.data		= &pfm_sysctl.debug,
+		.maxlen		= sizeof(int),
+		.mode		= 0666,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "debug_ovfl",
+		.data		= &pfm_sysctl.debug_ovfl,
+		.maxlen		= sizeof(int),
+		.mode		= 0666,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "fastctxsw",
+		.data		= &pfm_sysctl.fastctxsw,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	=  &proc_dointvec,
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "expert_mode",
+		.data		= &pfm_sysctl.expert_mode,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= &proc_dointvec,
+	},
+	{}
 };
 static ctl_table pfm_sysctl_dir[] = {
-	{1, "perfmon", NULL, 0, 0755, pfm_ctl_table, },
- 	{0,},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "perfmon",
+		.mode		= 0755,
+		.child		= pfm_ctl_table,
+	},
+ 	{}
 };
 static ctl_table pfm_sysctl_root[] = {
-	{1, "kernel", NULL, 0, 0755, pfm_sysctl_dir, },
- 	{0,},
+	{
+		.ctl_name	= CTL_KERN,
+		.procname	= "kernel",
+		.mode		= 0755,
+		.child		= pfm_sysctl_dir,
+	},
+ 	{}
 };
 static struct ctl_table_header *pfm_sysctl_header;
 
-- 
1.4.4.1.g278f
