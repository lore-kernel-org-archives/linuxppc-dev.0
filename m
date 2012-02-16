Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CAD2CB6FD8
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 22:16:26 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 16 Feb 2012 16:46:24 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1GBFrJZ1069120
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 16:45:53 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1GBFq11015006
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 16:45:53 +0530
Subject: [RFC PATCH v7 07/10] fadump: Introduce cleanup routine to invalidate
 /proc/vmcore.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 16 Feb 2012 16:45:00 +0530
Message-ID: <20120216111459.4733.83147.stgit@mars>
In-Reply-To: <20120216111050.4733.38034.stgit@mars>
References: <20120216111050.4733.38034.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Anton Blanchard <anton@samba.org>, Amerigo Wang <amwang@redhat.com>,
 Kexec-ml <kexec@lists.infradead.org>, Milton Miller <miltonm@bga.com>,
 Randy Dunlap <rdunlap@xenotime.net>, Paul Mackerras <paulus@samba.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
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
 fs/proc/vmcore.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index b0f450a..0d5071d 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -700,3 +700,26 @@ static int __init vmcore_init(void)
 	return 0;
 }
 module_init(vmcore_init)
+
+/* Cleanup function for vmcore module. */
+void vmcore_cleanup(void)
+{
+	struct list_head *pos, *next;
+
+	if (proc_vmcore) {
+		remove_proc_entry(proc_vmcore->name, proc_vmcore->parent);
+		proc_vmcore = NULL;
+	}
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
+	elfcorebuf = NULL;
+}
+EXPORT_SYMBOL_GPL(vmcore_cleanup);
