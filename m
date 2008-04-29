Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D2900DE311
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 01:31:02 +1000 (EST)
Date: Tue, 29 Apr 2008 10:25:48 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Subject: [PATCH][RESEND] devres: support addresses greater than an unsigned
	long via dev_ioremap
In-Reply-To: <20080429152331.GC11329@kroah.com>
Message-ID: <Pine.LNX.4.64.0804291025140.25102@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0804290122210.10928@blarg.am.freescale.net>
	<4816C094.6030601@gmail.com> <4816C214.60806@pobox.com>
	<C415A4D5-CE5A-4E48-B5D5-0B9A6C7A5CA6@kernel.crashing.org>
	<20080429152331.GC11329@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, Tejun Heo <htejun@gmail.com>,
	lkml Mailing List <linux-kernel@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use a resource_size_t instead of unsigned long since some arch's are
capable of having ioremap deal with addresses greater than the size of a
unsigned long.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

For GregKH to actually get the patch.

- k

 include/linux/io.h |    4 ++--
 lib/devres.c       |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/io.h b/include/linux/io.h
index e3b2dda..831f57c 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -58,9 +58,9 @@ static inline void devm_ioport_unmap(struct device *dev, void __iomem *addr)
 }
 #endif

-void __iomem * devm_ioremap(struct device *dev, unsigned long offset,
+void __iomem * devm_ioremap(struct device *dev, resource_size_t offset,
 			    unsigned long size);
-void __iomem * devm_ioremap_nocache(struct device *dev, unsigned long offset,
+void __iomem * devm_ioremap_nocache(struct device *dev, resource_size_t offset,
 				    unsigned long size);
 void devm_iounmap(struct device *dev, void __iomem *addr);
 int check_signature(const volatile void __iomem *io_addr,
diff --git a/lib/devres.c b/lib/devres.c
index edc27a5..26c87c4 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -20,7 +20,7 @@ static int devm_ioremap_match(struct device *dev, void *res, void *match_data)
  *
  * Managed ioremap().  Map is automatically unmapped on driver detach.
  */
-void __iomem *devm_ioremap(struct device *dev, unsigned long offset,
+void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
 			   unsigned long size)
 {
 	void __iomem **ptr, *addr;
@@ -49,7 +49,7 @@ EXPORT_SYMBOL(devm_ioremap);
  * Managed ioremap_nocache().  Map is automatically unmapped on driver
  * detach.
  */
-void __iomem *devm_ioremap_nocache(struct device *dev, unsigned long offset,
+void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
 				   unsigned long size)
 {
 	void __iomem **ptr, *addr;
-- 
1.5.4.1
