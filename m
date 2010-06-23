Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 110E9B7203
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:16 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA4JB0006330
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:19 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA4Enf1478828
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:14 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA4Cnx017093
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:14 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 07/40] compat: have generic is_compat_task for !CONFIG_COMPAT
Date: Wed, 23 Jun 2010 20:02:48 +1000
Message-Id: <1277287401-28571-8-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
Cc: Josh Stone <jistone@redhat.com>, Carsten Otte <cotte@de.ibm.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Stefan Weinhuber <wein@de.ibm.com>, linux-s390@vger.kernel.org,
	Stefan Haberland <stefan.haberland@de.ibm.com>,
	Sebastian Ott <sebott@linux.vnet.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Ian Munsie <imunsie@au1.ibm.com>,
	Swen Schillig <swen@vnet.ibm.com>, Jiri Kosina <jkosina@suse.cz>,
	Jason Baron <jbaron@redhat.com>,
	Christof Schmitt <christof.schmitt@de.ibm.com>,
	James Bottomley <James.Bottomley@suse.de>,
	Tejun Heo <tj@kernel.org>, linux390@de.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

add generic is_compat_task()

Signed-off-by: Jason Baron <jbaron@redhat.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/s390/include/asm/compat.h  |    7 -------
 arch/s390/kernel/ptrace.c       |    2 +-
 arch/s390/kernel/setup.c        |    2 +-
 arch/s390/mm/mmap.c             |    2 +-
 drivers/s390/block/dasd_eckd.c  |    2 +-
 drivers/s390/block/dasd_ioctl.c |    1 +
 drivers/s390/char/fs3270.c      |    1 +
 drivers/s390/char/vmcp.c        |    1 +
 drivers/s390/cio/chsc_sch.c     |    1 +
 drivers/s390/scsi/zfcp_cfdc.c   |    1 +
 include/linux/compat.h          |    8 ++++++++
 11 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index 104f200..4e094c0 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -172,13 +172,6 @@ static inline int is_compat_task(void)
 	return test_thread_flag(TIF_31BIT);
 }
 
-#else
-
-static inline int is_compat_task(void)
-{
-	return 0;
-}
-
 #endif
 
 static inline void __user *compat_alloc_user_space(long len)
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 83339d3..7090810 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -36,8 +36,8 @@
 #include <linux/regset.h>
 #include <linux/tracehook.h>
 #include <linux/seccomp.h>
+#include <linux/compat.h>
 #include <trace/syscall.h>
-#include <asm/compat.h>
 #include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index c8e8e13..b88844d 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -42,7 +42,7 @@
 #include <linux/reboot.h>
 #include <linux/topology.h>
 #include <linux/ftrace.h>
-
+#include <linux/compat.h>
 #include <asm/ipl.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 869efba..b7669c5 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -27,8 +27,8 @@
 #include <linux/personality.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/compat.h>
 #include <asm/pgalloc.h>
-#include <asm/compat.h>
 
 /*
  * Top of mmap area (just below the process stack).
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index ab84da5..5d71e84 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -14,6 +14,7 @@
 
 #include <linux/stddef.h>
 #include <linux/kernel.h>
+#include <linux/compat.h>
 #include <linux/slab.h>
 #include <linux/hdreg.h>	/* HDIO_GETGEO			    */
 #include <linux/bio.h>
@@ -23,7 +24,6 @@
 #include <asm/debug.h>
 #include <asm/idals.h>
 #include <asm/ebcdic.h>
-#include <asm/compat.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/cio.h>
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 1557214..58ffed7 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -18,6 +18,7 @@
 #include <linux/blkpg.h>
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
+#include <linux/compat.h>
 #include <asm/compat.h>
 #include <asm/ccwdev.h>
 #include <asm/cmb.h>
diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
index 857dfcb..784bf5b 100644
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/smp_lock.h>
+#include <linux/compat.h>
 
 #include <asm/compat.h>
 #include <asm/ccwdev.h>
diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index 04e532e..68205c9 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
+#include <linux/compat.h>
 #include <asm/compat.h>
 #include <asm/cpcmd.h>
 #include <asm/debug.h>
diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index a83877c..2b5bb6b 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -9,6 +9,7 @@
 
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
 #include <linux/miscdevice.h>
diff --git a/drivers/s390/scsi/zfcp_cfdc.c b/drivers/s390/scsi/zfcp_cfdc.c
index 1a2db0a..73a7ef3 100644
--- a/drivers/s390/scsi/zfcp_cfdc.c
+++ b/drivers/s390/scsi/zfcp_cfdc.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/miscdevice.h>
+#include <linux/compat.h>
 #include <asm/compat.h>
 #include <asm/ccwdev.h>
 #include "zfcp_def.h"
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 168f7da..ab638e9 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -360,5 +360,13 @@ extern ssize_t compat_rw_copy_check_uvector(int type,
 		const struct compat_iovec __user *uvector, unsigned long nr_segs,
 		unsigned long fast_segs, struct iovec *fast_pointer,
 		struct iovec **ret_pointer);
+
+#else /* CONFIG_COMPAT */
+
+static inline int is_compat_task(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
-- 
1.7.1
