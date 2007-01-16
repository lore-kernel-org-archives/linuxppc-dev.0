Return-Path: <eric@ebiederm.dsl.xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 341FDE06AF
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:23:29 +1100 (EST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 20/59] sysctl: cdrom Don't set de->owner
Date: Tue, 16 Jan 2007 09:39:25 -0700
Message-Id: <11689656373737-git-send-email-ebiederm@xmission.com>
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

There is no need for open files in /proc/sys/XXX to hold
a reference count on the module that provides the file
to prevent module unload races.  While there is code active
in the module p->used in the sysctl_table_header is incremented,
preventing the sysctl from being unregisted.  Once the
sysctl is unregistered it cannot be found.  Open files
are also not a problem as they revalidate the sysctl information
and bump p->used before accessing module code.

So setting de->owner is unnecessary, makes for a bad example
and gets in my way of removing ctl_table->de.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/cdrom/cdrom.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index f0a6801..14f72c4 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3554,8 +3554,6 @@ static void cdrom_sysctl_register(void)
 		return;
 
 	cdrom_sysctl_header = register_sysctl_table(cdrom_root_table, 0);
-	if (cdrom_root_table->ctl_name && cdrom_root_table->child->de)
-		cdrom_root_table->child->de->owner = THIS_MODULE;
 
 	/* set the defaults */
 	cdrom_sysctl_settings.autoclose = autoclose;
-- 
1.4.4.1.g278f
