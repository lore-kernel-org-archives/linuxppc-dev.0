Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E91A110C81E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jul 2011 04:08:03 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p6DI83Ko018212
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2011 04:08:03 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6DI83Uh557072
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2011 04:08:03 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p6DI82Jc023126
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2011 04:08:03 +1000
Subject: [RFC PATCH 07/10] fadump: Introduce cleanup routine to invalidate
	/proc/vmcore.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 13 Jul 2011 23:38:00 +0530
Message-ID: <20110713180751.6210.64850.stgit@mars.in.ibm.com>
In-Reply-To: <20110713180252.6210.34810.stgit@mars.in.ibm.com>
References: <20110713180252.6210.34810.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Michael Ellerman <michael@ellerman.id.au>,
	Anton Blanchard <anton@samba.org>, Milton Miller <miltonm@bga.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

With the firmware-assisted dump support we don't require a reboot when we
are in second kernel after crash. The second kernel after crash is a normal
kernel boot and has knowledge about entire system RAM with the page tables
initialized for entire system RAM. Hence once the dump is saved to disk, we
can just release the reserved memory area for general use and continue
with second kernel as production kernel.

Hence when we release the reserved memory that contains dump data, the
'/proc/vmcore' will not be valid anymore. Hence this patch introduces
a cleanup routine that invalidates and removes the /proc/vmcore file. This
routine will be invoked before we release the reserved dump memory area.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 fs/proc/vmcore.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index cd99bf5..1aa3d7b 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -699,3 +699,23 @@ static int __init vmcore_init(void)
 	return 0;
 }
 module_init(vmcore_init)
+
+/* Cleanup function for vmcore module. */
+void vmcore_cleanup(void)
+{
+	struct list_head *pos, *next;
+
+	if (proc_vmcore)
+		remove_proc_entry(proc_vmcore->name, proc_vmcore->parent);
+
+	/* clear the vmcore list. */
+	list_for_each_safe(pos, next, &vmcore_list) {
+		struct vmcore *m;
+
+		m = list_entry(pos, struct vmcore, list);
+		list_del(&m->list);
+		kfree(m);
+	}
+	kfree(elfcorebuf);
+}
+EXPORT_SYMBOL_GPL(vmcore_cleanup);
