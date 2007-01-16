Return-Path: <eric@ebiederm.dsl.xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0833DEA17
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:24:22 +1100 (EST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 4/59] sysctl: sunrpc Don't unnecessarily set ctl_table->de
Date: Tue, 16 Jan 2007 09:39:09 -0700
Message-Id: <11689656151751-git-send-email-ebiederm@xmission.com>
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

We don't need this to prevent module unload races so remove
the unnecessary code.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 net/sunrpc/sysctl.c   |    8 +-------
 net/sunrpc/xprtsock.c |    7 +------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index 3852689..6a82ed2 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -35,14 +35,8 @@ static ctl_table		sunrpc_table[];
 void
 rpc_register_sysctl(void)
 {
-	if (!sunrpc_table_header) {
+	if (!sunrpc_table_header)
 		sunrpc_table_header = register_sysctl_table(sunrpc_table, 0);
-#ifdef CONFIG_PROC_FS
-		if (sunrpc_table[0].de)
-			sunrpc_table[0].de->owner = THIS_MODULE;
-#endif
-	}
-			
 }
 
 void
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 98d1af9..51964cf 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1629,13 +1629,8 @@ struct rpc_xprt *xs_setup_tcp(struct sockaddr *addr, size_t addrlen, struct rpc_
 int init_socket_xprt(void)
 {
 #ifdef RPC_DEBUG
-	if (!sunrpc_table_header) {
+	if (!sunrpc_table_header)
 		sunrpc_table_header = register_sysctl_table(sunrpc_table, 0);
-#ifdef CONFIG_PROC_FS
-		if (sunrpc_table[0].de)
-			sunrpc_table[0].de->owner = THIS_MODULE;
-#endif
-	}
 #endif
 
 	return 0;
-- 
1.4.4.1.g278f
