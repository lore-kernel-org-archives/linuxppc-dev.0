Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CD767B6F80
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Oct 2011 01:43:42 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: hjk@hansjkoch.de
Subject: [PATCH] UIO: Allow a UIO driver to override the default pgprot when
 we mmap
Date: Wed, 12 Oct 2011 09:43:36 -0500
Message-Id: <1318430616-20351-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For some devices the default behavior of pgprot_noncached is not
the correct flags for the address space.  Provide a means for the
kernel side UIO driver to override the flags without having to
implement its own full mmap callback.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/uio/uio.c          |    6 +++++-
 include/linux/uio_driver.h |    2 ++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index d2efe82..88f4444 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -656,7 +656,11 @@ static int uio_mmap_physical(struct vm_area_struct *vma)
 
 	vma->vm_flags |= VM_IO | VM_RESERVED;
 
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	if (idev->info->mem[mi].set_pgprot)
+		vma->vm_page_prot =
+			idev->info->mem[mi].set_pgprot(vma->vm_page_prot);
+	else
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
 	return remap_pfn_range(vma,
 			       vma->vm_start,
diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
index 665517c..4c618cd 100644
--- a/include/linux/uio_driver.h
+++ b/include/linux/uio_driver.h
@@ -28,6 +28,7 @@ struct uio_map;
  * @memtype:		type of memory addr points to
  * @internal_addr:	ioremap-ped version of addr, for driver internal use
  * @map:		for use by the UIO core only.
+ * @set_pgprot:		allow driver to override default(noncached) pgprot
  */
 struct uio_mem {
 	const char		*name;
@@ -36,6 +37,7 @@ struct uio_mem {
 	int			memtype;
 	void __iomem		*internal_addr;
 	struct uio_map		*map;
+	pgprot_t (*set_pgprot)(pgprot_t prot);
 };
 
 #define MAX_UIO_MAPS	5
-- 
1.7.3.4
