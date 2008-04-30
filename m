Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53056DDFEE
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 05:28:04 +1000 (EST)
Subject: patch
	devres-support-addresses-greater-than-an-unsigned-long-via-dev_ioremap.patch
	added to gregkh-2.6 tree
To: galak@kernel.crashing.org, akpm@osdl.org, gregkh@suse.de,
	greg@kroah.com, htejun@gmail.com, jbarnes@virtuousgeek.org,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
From: <gregkh@suse.de>
Date: Wed, 30 Apr 2008 11:42:53 -0700
In-Reply-To: <Pine.LNX.4.64.0804291025140.25102@blarg.am.freescale.net>
Message-ID: <1209580973764@kroah.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: devres: support addresses greater than an unsigned long via dev_ioremap

to my gregkh-2.6 tree.  Its filename is

     devres-support-addresses-greater-than-an-unsigned-long-via-dev_ioremap.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From galak@kernel.crashing.org  Wed Apr 30 11:27:51 2008
From: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 29 Apr 2008 10:25:48 -0500 (CDT)
Subject: devres: support addresses greater than an unsigned long via dev_ioremap
To: Greg KH <greg@kroah.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>, "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>, lkml Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
Message-ID: <Pine.LNX.4.64.0804291025140.25102@blarg.am.freescale.net>


Use a resource_size_t instead of unsigned long since some arch's are
capable of having ioremap deal with addresses greater than the size of a
unsigned long.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Cc: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/linux/io.h |    4 ++--
 lib/devres.c       |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -58,9 +58,9 @@ static inline void devm_ioport_unmap(str
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
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -20,7 +20,7 @@ static int devm_ioremap_match(struct dev
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


Patches currently in gregkh-2.6 which might be from galak@kernel.crashing.org are

driver-core/devres-support-addresses-greater-than-an-unsigned-long-via-dev_ioremap.patch
