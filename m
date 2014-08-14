Return-Path: <tony@bakeyournoodle.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C983D1A0074
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 17:05:05 +1000 (EST)
Date: Thu, 14 Aug 2014 17:05:04 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/boot: Don't install zImage.* from make install
Message-ID: <20140814070502.GB12669@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

in commit 29f1aff2c (powerpc: Copy bootable images in the default
install script) we changed to copying all the built boot targets based
on the assumption that it's backwards compatible.  It turns out that
debian devived installkernel scripts will barf if not given exactly 4
args.

This change reverts make install to just install the vmlinux (we can
change the dfault in a seperate patch) and introduces a new make
zInstall which works with a more flexible installkernel script.

Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/boot/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index ccc25ed..8a5bc1c 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -389,7 +389,12 @@ $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
 $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
 	@rm -f $@; ln $< $@
 
+# Only install the vmlinux
 install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
+	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)"
+
+# Install the vmlinux and other built boot targets.
+zInstall: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
 	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $^
 
 # anything not in $(targets)
-- 
1.9.3



Yours Tony
