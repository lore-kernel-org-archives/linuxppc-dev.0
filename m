Return-Path: <eric@ebiederm.dsl.xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8B60547619
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:27:11 +1100 (EST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 37/59] sysctl: C99 convert arch/sh64/kernel/traps.c and remove
	ABI breakage.
Date: Tue, 16 Jan 2007 09:39:42 -0700
Message-Id: <11689656622749-git-send-email-ebiederm@xmission.com>
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

While doing the C99 conversion I notices that the top level sh64
directory was using the binary number for CTL_KERN.  That is a
no-no so I removed the support for the sysctl binary interface
only leaving sysctl /proc support.

At least the sysctl tables were placed at the end of
the list so user space did not see this mistake.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/sh64/kernel/traps.c |   49 +++++++++++++++++++++++++++++++++++----------
 1 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/arch/sh64/kernel/traps.c b/arch/sh64/kernel/traps.c
index 224b7f5..02cca74 100644
--- a/arch/sh64/kernel/traps.c
+++ b/arch/sh64/kernel/traps.c
@@ -910,25 +910,52 @@ static int misaligned_fixup(struct pt_regs *regs)
 }
 
 static ctl_table unaligned_table[] = {
-	{1, "kernel_reports", &kernel_mode_unaligned_fixup_count,
-		sizeof(int), 0644, NULL, &proc_dointvec},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "kernel_reports",
+		.data		= &kernel_mode_unaligned_fixup_count,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
 #if defined(CONFIG_SH64_USER_MISALIGNED_FIXUP)
-	{2, "user_reports", &user_mode_unaligned_fixup_count,
-		sizeof(int), 0644, NULL, &proc_dointvec},
-	{3, "user_enable", &user_mode_unaligned_fixup_enable,
-		sizeof(int), 0644, NULL, &proc_dointvec},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "user_reports",
+		.data		= &user_mode_unaligned_fixup_count,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "user_enable",
+		.data		= &user_mode_unaligned_fixup_enable,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec},
 #endif
-	{0}
+	{}
 };
 
 static ctl_table unaligned_root[] = {
-	{1, "unaligned_fixup", NULL, 0, 0555, unaligned_table},
-	{0}
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "unaligned_fixup",
+		.mode		= 0555,
+		unaligned_table
+	},
+	{}
 };
 
 static ctl_table sh64_root[] = {
-	{1, "sh64", NULL, 0, 0555, unaligned_root},
-	{0}
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "sh64",
+		.mode		= 0555,
+		.child		= unaligned_root
+	},
+	{}
 };
 static struct ctl_table_header *sysctl_header;
 static int __init init_sysctl(void)
-- 
1.4.4.1.g278f
