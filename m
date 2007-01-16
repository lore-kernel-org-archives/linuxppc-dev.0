Return-Path: <eric@ebiederm.dsl.xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19268E1257
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:25:03 +1100 (EST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 31/59] sysctl: C99 convert the ctl_tables in
	arch/mips/au1000/common/power.c
Date: Tue, 16 Jan 2007 09:39:36 -0700
Message-Id: <11689656551180-git-send-email-ebiederm@xmission.com>
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
 arch/mips/au1000/common/power.c |   38 ++++++++++++++++++++++++++++++++------
 1 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/mips/au1000/common/power.c b/arch/mips/au1000/common/power.c
index b531ab7..31256b8 100644
--- a/arch/mips/au1000/common/power.c
+++ b/arch/mips/au1000/common/power.c
@@ -419,15 +419,41 @@ static int pm_do_freq(ctl_table * ctl, int write, struct file *file,
 
 
 static struct ctl_table pm_table[] = {
-	{CTL_UNNUMBERED, "suspend", NULL, 0, 0600, NULL, &pm_do_suspend},
-	{CTL_UNNUMBERED, "sleep", NULL, 0, 0600, NULL, &pm_do_sleep},
-	{CTL_UNNUMBERED, "freq", NULL, 0, 0600, NULL, &pm_do_freq},
-	{0}
+	{
+		.ctl_name 	= CTL_UNNUMBERED,
+		.procname	= "suspend",
+		.data		= NULL,
+		.maxlen		= 0,
+		.mode		= 0600,
+		.proc_handler	= &pm_do_suspend
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "sleep",
+		.data		= NULL,
+		.maxlen		= 0,
+		.mode		= 0600,
+		.proc_handler	= &pm_do_sleep
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "freq",
+		.data		= NULL,
+		.maxlen		= 0,
+		.mode		= 0600,
+		.proc_handler	= &pm_do_freq
+	},
+	{}
 };
 
 static struct ctl_table pm_dir_table[] = {
-	{CTL_UNNUMBERED, "pm", NULL, 0, 0555, pm_table},
-	{0}
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "pm",
+		.mode		= 0555,
+		.child		= pm_table
+	},
+	{}
 };
 
 /*
-- 
1.4.4.1.g278f
