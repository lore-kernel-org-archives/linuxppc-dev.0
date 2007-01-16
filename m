Return-Path: <eric@ebiederm.dsl.xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19D53E192C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:26:37 +1100 (EST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 52/59] sysctl: Create sys/fs/binfmt_misc as an ordinary sysctl
	entry
Date: Tue, 16 Jan 2007 09:39:57 -0700
Message-Id: <11689656932416-git-send-email-ebiederm@xmission.com>
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

binfmt_misc has a mount point in the middle of the sysctl and
that mount point is created as a proc_generic directory.

Doing it that way gets in the way of cleaning up the sysctl
proc support as it continues the existence of a horrible hack.
So instead simply create the directory as an ordinary sysctl
directory.   At least that removes the magic special case.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/root.c  |    4 ----
 kernel/sysctl.c |   13 +++++++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 64d242b..8059e92 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -74,10 +74,6 @@ void __init proc_root_init(void)
 #ifdef CONFIG_SYSCTL
 	proc_sys_root = proc_mkdir("sys", NULL);
 #endif
-#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
-	proc_mkdir("sys/fs", NULL);
-	proc_mkdir("sys/fs/binfmt_misc", NULL);
-#endif
 	proc_root_fs = proc_mkdir("fs", NULL);
 	proc_root_driver = proc_mkdir("driver", NULL);
 	proc_mkdir("fs/nfsd", NULL); /* somewhere for the nfsd filesystem to be mounted */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6e2e608..8da6647 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -142,6 +142,7 @@ static struct ctl_table_header root_table_header =
 static ctl_table kern_table[];
 static ctl_table vm_table[];
 static ctl_table fs_table[];
+static ctl_table binfmt_misc_table[];
 static ctl_table debug_table[];
 static ctl_table dev_table[];
 extern ctl_table random_table[];
@@ -1001,6 +1002,18 @@ static ctl_table fs_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "binfmt_misc",
+		.mode		= 0555,
+		.child		= binfmt_misc_table,
+	},
+#endif
+	{ .ctl_name = 0 }
+};
+
+static ctl_table binfmt_misc_table[] = {
 	{ .ctl_name = 0 }
 };
 
-- 
1.4.4.1.g278f
