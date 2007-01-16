Return-Path: <eric@ebiederm.dsl.xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29D7E47C0F
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:28:00 +1100 (EST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 46/59] sysctl: C99 convert coda ctl_tables and remove binary
	sysctls.
Date: Tue, 16 Jan 2007 09:39:51 -0700
Message-Id: <11689656751225-git-send-email-ebiederm@xmission.com>
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

Will converting the coda sysctl initializers I discovered that
it is yet another user of sysctl that was stomping CTL_KERN.
So off with it's sys_sysctl support since it wasn't done
in a supportable way.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/coda/sysctl.c |   58 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
index 1c82e9a..df682e2 100644
--- a/fs/coda/sysctl.c
+++ b/fs/coda/sysctl.c
@@ -32,8 +32,6 @@
 
 static struct ctl_table_header *fs_table_header;
 
-#define FS_CODA         1       /* Coda file system */
-
 #define CODA_TIMEOUT    3       /* timeout on upcalls to become intrble */
 #define CODA_HARD       5       /* mount type "hard" or "soft" */
 #define CODA_VFS 	 6       /* vfs statistics */
@@ -184,17 +182,57 @@ static int coda_cache_inv_stats_get_info( char * buffer, char ** start,
 }
 
 static ctl_table coda_table[] = {
- 	{CODA_TIMEOUT, "timeout", &coda_timeout, sizeof(int), 0644, NULL, &proc_dointvec},
- 	{CODA_HARD, "hard", &coda_hard, sizeof(int), 0644, NULL, &proc_dointvec},
- 	{CODA_VFS, "vfs_stats", NULL, 0, 0644, NULL, &do_reset_coda_vfs_stats},
- 	{CODA_CACHE_INV, "cache_inv_stats", NULL, 0, 0644, NULL, &do_reset_coda_cache_inv_stats},
- 	{CODA_FAKE_STATFS, "fake_statfs", &coda_fake_statfs, sizeof(int), 0600, NULL, &proc_dointvec},
-	{ 0 }
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "timeout",
+		.data		= &coda_timeout,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "hard",
+		.data		= &coda_hard,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "vfs_stats",
+		.data		= NULL,
+		.maxlen		= 0,
+		.mode		= 0644,
+		.proc_handler	= &do_reset_coda_vfs_stats
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "cache_inv_stats",
+		.data		= NULL,
+		.maxlen		= 0,
+		.mode		= 0644,
+		.proc_handler	= &do_reset_coda_cache_inv_stats
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "fake_statfs",
+		.data		= &coda_fake_statfs,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= &proc_dointvec
+	},
+	{}
 };
 
 static ctl_table fs_table[] = {
-       {FS_CODA, "coda",    NULL, 0, 0555, coda_table},
-       {0}
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "coda",
+		.mode		= 0555,
+		.child		= coda_table
+	},
+	{}
 };
 
 
-- 
1.4.4.1.g278f
