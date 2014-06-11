Return-Path: <mmarek@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32F571A03CB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 01:40:58 +1000 (EST)
From: Michal Marek <mmarek@suse.cz>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc: Avoid circular dependency with zImage.%
Date: Wed, 11 Jun 2014 17:40:43 +0200
Message-Id: <1402501243-28213-1-git-send-email-mmarek@suse.cz>
In-Reply-To: <53984D4F.6040808@linux.vnet.ibm.com>
References: <53984D4F.6040808@linux.vnet.ibm.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The rule to create the final images uses a zImage.% pattern.
Unfortunately, this also matches the names of the zImage.*.lds linker
scripts, which appear as a dependency of the final images. This somehow
worked when $(srctree) used to be an absolute path, but now the pattern
matches too much. List only the images from $(image-y) as the target of
the rule, to avoid the circular dependency.

Signed-off-by: Michal Marek <mmarek@suse.cz>
---
v2:
  - Filter out duplicates in the target list
  - fix the platform argument to cmd_wrap

 arch/powerpc/boot/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 426dce7..ccc25ed 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -333,8 +333,8 @@ $(addprefix $(obj)/, $(initrd-y)): $(obj)/ramdisk.image.gz
 $(obj)/zImage.initrd.%: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,$*,,,$(obj)/ramdisk.image.gz)
 
-$(obj)/zImage.%: vmlinux $(wrapperbits)
-	$(call if_changed,wrap,$*)
+$(addprefix $(obj)/, $(sort $(filter zImage.%, $(image-y)))): vmlinux $(wrapperbits)
+	$(call if_changed,wrap,$(subst $(obj)/zImage.,,$@))
 
 # dtbImage% - a dtbImage is a zImage with an embedded device tree blob
 $(obj)/dtbImage.initrd.%: vmlinux $(wrapperbits) $(obj)/%.dtb
-- 
1.9.2
