Return-Path: <eric@ebiederm.dsl.xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7EF9DDE0E1
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:19:35 +1100 (EST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 41/59] sysctl: C99 convert ctl_tables in arch/x86_64/mm/init.c
Date: Tue, 16 Jan 2007 09:39:46 -0700
Message-Id: <11689656673646-git-send-email-ebiederm@xmission.com>
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
 arch/x86_64/mm/init.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86_64/mm/init.c b/arch/x86_64/mm/init.c
index 65aa66c..a04535d 100644
--- a/arch/x86_64/mm/init.c
+++ b/arch/x86_64/mm/init.c
@@ -711,15 +711,25 @@ int kern_addr_valid(unsigned long addr)
 extern int exception_trace, page_fault_trace;
 
 static ctl_table debug_table2[] = {
-	{ 99, "exception-trace", &exception_trace, sizeof(int), 0644, NULL,
-	  proc_dointvec },
-	{ 0, }
+	{
+		.ctl_name	= 99,
+		.procname	= "exception-trace",
+		.data		= &exception_trace,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec
+	},
+	{}
 }; 
 
 static ctl_table debug_root_table2[] = { 
-	{ .ctl_name = CTL_DEBUG, .procname = "debug", .mode = 0555, 
-	   .child = debug_table2 }, 
-	{ 0 }, 
+	{
+		.ctl_name = CTL_DEBUG,
+		.procname = "debug",
+		.mode = 0555,
+		.child = debug_table2
+	}, 
+	{}
 }; 
 
 static __init int x8664_sysctl_init(void)
-- 
1.4.4.1.g278f
