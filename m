Return-Path: <eric@ebiederm.dsl.xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 92FFA4813F
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:28:40 +1100 (EST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 59/59] sysctl: Remove the proc_dir_entry member for the sysctl
	tables.
Date: Tue, 16 Jan 2007 09:40:04 -0700
Message-Id: <11689657081820-git-send-email-ebiederm@xmission.com>
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

It isn't needed anymore, all of the users are gone, and all of the
ctl_table initializers have been converted to use explicit names
of the fields they are initializing.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/sysctl.h |    1 -
 net/decnet/dn_dev.c    |    5 -----
 net/ipv4/devinet.c     |    5 -----
 net/ipv6/addrconf.c    |    5 -----
 4 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 20c23b5..8c2fab5 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -1025,7 +1025,6 @@ struct ctl_table
 	ctl_table *child;
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	ctl_handler *strategy;		/* Callback function for all r/w */
-	struct proc_dir_entry *de;	/* /proc control block */
 	void *extra1;
 	void *extra2;
 };
diff --git a/net/decnet/dn_dev.c b/net/decnet/dn_dev.c
index baaa02e..324eb47 100644
--- a/net/decnet/dn_dev.c
+++ b/net/decnet/dn_dev.c
@@ -261,7 +261,6 @@ static void dn_dev_sysctl_register(struct net_device *dev, struct dn_dev_parms *
 	for(i = 0; i < ARRAY_SIZE(t->dn_dev_vars) - 1; i++) {
 		long offset = (long)t->dn_dev_vars[i].data;
 		t->dn_dev_vars[i].data = ((char *)parms) + offset;
-		t->dn_dev_vars[i].de = NULL;
 	}
 
 	if (dev) {
@@ -273,13 +272,9 @@ static void dn_dev_sysctl_register(struct net_device *dev, struct dn_dev_parms *
 	}
 
 	t->dn_dev_dev[0].child = t->dn_dev_vars;
-	t->dn_dev_dev[0].de = NULL;
 	t->dn_dev_conf_dir[0].child = t->dn_dev_dev;
-	t->dn_dev_conf_dir[0].de = NULL;
 	t->dn_dev_proto_dir[0].child = t->dn_dev_conf_dir;
-	t->dn_dev_proto_dir[0].de = NULL;
 	t->dn_dev_root_dir[0].child = t->dn_dev_proto_dir;
-	t->dn_dev_root_dir[0].de = NULL;
 	t->dn_dev_vars[0].extra1 = (void *)dev;
 
 	t->sysctl_header = register_sysctl_table(t->dn_dev_root_dir);
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index b731a0c..8cfcc78 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1573,7 +1573,6 @@ static void devinet_sysctl_register(struct in_device *in_dev,
 		return;
 	for (i = 0; i < ARRAY_SIZE(t->devinet_vars) - 1; i++) {
 		t->devinet_vars[i].data += (char *)p - (char *)&ipv4_devconf;
-		t->devinet_vars[i].de = NULL;
 	}
 
 	if (dev) {
@@ -1595,13 +1594,9 @@ static void devinet_sysctl_register(struct in_device *in_dev,
 
 	t->devinet_dev[0].procname    = dev_name;
 	t->devinet_dev[0].child	      = t->devinet_vars;
-	t->devinet_dev[0].de	      = NULL;
 	t->devinet_conf_dir[0].child  = t->devinet_dev;
-	t->devinet_conf_dir[0].de     = NULL;
 	t->devinet_proto_dir[0].child = t->devinet_conf_dir;
-	t->devinet_proto_dir[0].de    = NULL;
 	t->devinet_root_dir[0].child  = t->devinet_proto_dir;
-	t->devinet_root_dir[0].de     = NULL;
 
 	t->sysctl_header = register_sysctl_table(t->devinet_root_dir);
 	if (!t->sysctl_header)
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 791aaba..6aded83 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3973,7 +3973,6 @@ static void addrconf_sysctl_register(struct inet6_dev *idev, struct ipv6_devconf
 		return;
 	for (i=0; t->addrconf_vars[i].data; i++) {
 		t->addrconf_vars[i].data += (char*)p - (char*)&ipv6_devconf;
-		t->addrconf_vars[i].de = NULL;
 		t->addrconf_vars[i].extra1 = idev; /* embedded; no ref */
 	}
 	if (dev) {
@@ -3996,13 +3995,9 @@ static void addrconf_sysctl_register(struct inet6_dev *idev, struct ipv6_devconf
 	t->addrconf_dev[0].procname = dev_name;
 
 	t->addrconf_dev[0].child = t->addrconf_vars;
-	t->addrconf_dev[0].de = NULL;
 	t->addrconf_conf_dir[0].child = t->addrconf_dev;
-	t->addrconf_conf_dir[0].de = NULL;
 	t->addrconf_proto_dir[0].child = t->addrconf_conf_dir;
-	t->addrconf_proto_dir[0].de = NULL;
 	t->addrconf_root_dir[0].child = t->addrconf_proto_dir;
-	t->addrconf_root_dir[0].de = NULL;
 
 	t->sysctl_header = register_sysctl_table(t->addrconf_root_dir);
 	if (t->sysctl_header == NULL)
-- 
1.4.4.1.g278f
