Return-Path: <eric@ebiederm.dsl.xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D8447E1AF9
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:26:51 +1100 (EST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 27/59] sysctl: sn Remove sysctl ABI BREAKAGE
Date: Tue, 16 Jan 2007 09:39:32 -0700
Message-Id: <1168965647511-git-send-email-ebiederm@xmission.com>
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

By not using the enumeration in sysctl.h (or even understanding it)
the SN platform placed their arch specific xpc directory on top of
CTL_KERN and only because they didn't have 4 entries in their xpc
directory got lucky and didn't break glibc.

This is totally irresponsible.  So this patch entirely removes
sys_sysctl support from their sysctl code.  Hopefully they
don't have ascii name conflicts as well.

And now that they have no ABI numbers add them to the end
instead of the sysctl list instead of the head so nothing
else will be overridden.

Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/ia64/sn/kernel/xpc_main.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/sn/kernel/xpc_main.c b/arch/ia64/sn/kernel/xpc_main.c
index 7a387d2..24adb75 100644
--- a/arch/ia64/sn/kernel/xpc_main.c
+++ b/arch/ia64/sn/kernel/xpc_main.c
@@ -101,7 +101,7 @@ static int xpc_disengage_request_max_timelimit = 120;
 
 static ctl_table xpc_sys_xpc_hb_dir[] = {
 	{
-		1,
+		CTL_UNNUMBERED,
 		"hb_interval",
 		&xpc_hb_interval,
 		sizeof(int),
@@ -114,7 +114,7 @@ static ctl_table xpc_sys_xpc_hb_dir[] = {
 		&xpc_hb_max_interval
 	},
 	{
-		2,
+		CTL_UNNUMBERED,
 		"hb_check_interval",
 		&xpc_hb_check_interval,
 		sizeof(int),
@@ -130,7 +130,7 @@ static ctl_table xpc_sys_xpc_hb_dir[] = {
 };
 static ctl_table xpc_sys_xpc_dir[] = {
 	{
-		1,
+		CTL_UNNUMBERED,
 		"hb",
 		NULL,
 		0,
@@ -138,7 +138,7 @@ static ctl_table xpc_sys_xpc_dir[] = {
 		xpc_sys_xpc_hb_dir
 	},
 	{
-		2,
+		CTL_UNNUMBERED,
 		"disengage_request_timelimit",
 		&xpc_disengage_request_timelimit,
 		sizeof(int),
@@ -154,7 +154,7 @@ static ctl_table xpc_sys_xpc_dir[] = {
 };
 static ctl_table xpc_sys_dir[] = {
 	{
-		1,
+		CTL_UNNUMBERED,
 		"xpc",
 		NULL,
 		0,
@@ -1251,7 +1251,7 @@ xpc_init(void)
 	snprintf(xpc_part->bus_id, BUS_ID_SIZE, "part");
 	snprintf(xpc_chan->bus_id, BUS_ID_SIZE, "chan");
 
-	xpc_sysctl = register_sysctl_table(xpc_sys_dir, 1);
+	xpc_sysctl = register_sysctl_table(xpc_sys_dir, 0);
 
 	/*
 	 * The first few fields of each entry of xpc_partitions[] need to
-- 
1.4.4.1.g278f
