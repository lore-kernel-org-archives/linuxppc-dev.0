Return-Path: <eric@ebiederm.dsl.xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5967E0E33
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:24:24 +1100 (EST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 47/59] sysctl: C99 convert ctl_tables in NTFS and remove
	sys_sysctl support
Date: Tue, 16 Jan 2007 09:39:52 -0700
Message-Id: <11689656793474-git-send-email-ebiederm@xmission.com>
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

Putting ntfs-debug under FS_NRINODE was not a kosher thing to do
so don't give it any binary number.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/ntfs/sysctl.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs/sysctl.c b/fs/ntfs/sysctl.c
index 1c23138..bc217de 100644
--- a/fs/ntfs/sysctl.c
+++ b/fs/ntfs/sysctl.c
@@ -33,20 +33,28 @@
 #include "sysctl.h"
 #include "debug.h"
 
-#define FS_NTFS	1
-
 /* Definition of the ntfs sysctl. */
 static ctl_table ntfs_sysctls[] = {
-	{ FS_NTFS, "ntfs-debug",		/* Binary and text IDs. */
-	  &debug_msgs,sizeof(debug_msgs),	/* Data pointer and size. */
-	  0644,	NULL, &proc_dointvec },		/* Mode, child, proc handler. */
-	{ 0 }
+	{
+		.ctl_name	= CTL_UNUMBERED,	/* Binary and text IDs. */
+		.procname	= "ntfs-debug",
+		.data		= &debug_msgs,		/* Data pointer and size. */
+		.maxlen		= sizeof(debug_msgs),
+		.mode		= 0644,			/* Mode, proc handler. */
+		.proc_handler	= &proc_dointvec
+	},
+	{}
 };
 
 /* Define the parent directory /proc/sys/fs. */
 static ctl_table sysctls_root[] = {
-	{ CTL_FS, "fs", NULL, 0, 0555, ntfs_sysctls },
-	{ 0 }
+	{
+		.ctl_name	= CTL_FS,
+		.procname	= "fs",
+		.mode		= 0555,
+		.child		= ntfs_sysctls
+	},
+	{}
 };
 
 /* Storage for the sysctls header. */
-- 
1.4.4.1.g278f
