Return-Path: <jwboyer@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 3C841DDF61
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 00:01:29 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so218385qwb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Sep 2008 07:01:27 -0700 (PDT)
Date: Tue, 9 Sep 2008 10:00:28 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH] powerpc: Holly board needs dtbImage target
Message-ID: <20080909140028.GA15005@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

One of the changes in the bootwrapper makefile introduced the dtbImage targets
for boards that need a simple zImage with a DTB embedded in them.  When this
was done, it broke booting on the Holly board as the zImage.holly wrapper did
not get the DTB embedded properly.

This patch changes the target for the Holly board to a dtbImage so that the
wrapper includes the vmlinux, wrapper bits, and DTB.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 717a3bc..65d1a84 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -195,7 +195,7 @@ image-$(CONFIG_PPC_CELLEB)		+= zImage.pseries
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
-image-$(CONFIG_PPC_HOLLY)		+= zImage.holly
+image-$(CONFIG_PPC_HOLLY)		+= dtbImage.holly
 image-$(CONFIG_PPC_PRPMC2800)		+= dtbImage.prpmc2800
 image-$(CONFIG_PPC_ISERIES)		+= zImage.iseries
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
-- 
1.5.5.1
