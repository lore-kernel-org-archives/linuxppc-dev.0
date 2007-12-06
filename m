Return-Path: <lizf@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
	by ozlabs.org (Postfix) with ESMTP id A030BDDF67
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 20:36:21 +1100 (EST)
Message-ID: <4757C1DA.6060603@cn.fujitsu.com>
Date: Thu, 06 Dec 2007 17:33:14 +0800
From: Li Zefan <lizf@cn.fujitsu.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 1/3] POWERPC: don't cast a pointer to pointer of list_head
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The casting is safe only when the list_head member is the
first member of the structure.

Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>

---
 arch/ppc/syslib/ocp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/syslib/ocp.c b/arch/ppc/syslib/ocp.c
index 3f5be2c..d42d408 100644
--- a/arch/ppc/syslib/ocp.c
+++ b/arch/ppc/syslib/ocp.c
@@ -376,7 +376,7 @@ ocp_remove_one_device(unsigned int vendor, unsigned int function, int index)
 
 	down_write(&ocp_devices_sem);
 	dev = __ocp_find_device(vendor, function, index);
-	list_del((struct list_head *)dev);
+	list_del(&dev->link);
 	up_write(&ocp_devices_sem);
 
 	DBG(("ocp: ocp_remove_one_device(vendor: %x, function: %x, index: %d)... done.\n", vendor, function, index));
-- 
1.5.3.rc7
