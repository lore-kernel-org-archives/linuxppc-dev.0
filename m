Return-Path: <mmarek@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B4B91A0A4E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 23:49:34 +1000 (EST)
From: Michal Marek <mmarek@suse.cz>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/boot: Makefile cleanup
Date: Thu,  2 Oct 2014 15:49:15 +0200
Message-Id: <1412257755-4564-1-git-send-email-mmarek@suse.cz>
Cc: yamada.m@jp.panasonic.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The $(image-n) variable will never exist, because unset Kconfig options
are '' and not 'n'.

Signed-off-by: Michal Marek <mmarek@suse.cz>
---
 arch/powerpc/boot/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index ccc25ed..c456d07 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -317,7 +317,7 @@ endif
 # Allow extra targets to be added to the defconfig
 image-y	+= $(subst ",,$(CONFIG_EXTRA_TARGETS))
 
-initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-n) $(image-))
+initrd-  := $(patsubst zImage%, zImage.initrd%, $(image-))
 initrd-y := $(patsubst zImage%, zImage.initrd%, \
 		$(patsubst dtbImage%, dtbImage.initrd%, \
 		$(patsubst simpleImage%, simpleImage.initrd%, \
-- 
1.8.4.5
