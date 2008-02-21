Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id DAC70DE20C
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2008 06:20:58 +1100 (EST)
Received: from pd4mr3so.prod.shaw.ca
	(pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JWL00KD8SEWL150@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 21 Feb 2008 12:20:56 -0700 (MST)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd4mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JWL00JU6SEWLFB0@pd4mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Thu, 21 Feb 2008 12:20:57 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JWL00AY5SEVTQ90@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 21 Feb 2008 12:20:55 -0700 (MST)
Date: Thu, 21 Feb 2008 12:19:56 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] add target for building .dtb files
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Message-id: <20080221191955.10139.10496.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

---

Josh, is this what your were looking for?

Cheers,
g.
---

 arch/powerpc/Makefile      |    2 +-
 arch/powerpc/boot/Makefile |    4 ++++
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index ab5cfe8..dd80825 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -164,7 +164,7 @@ boot := arch/$(ARCH)/boot
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
-bootwrapper_install:
+bootwrapper_install %.dtb:
 	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
 define archhelp
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index d57a67d..fb29f10 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -311,6 +311,10 @@ $(obj)/treeImage.initrd.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
 $(obj)/treeImage.%: vmlinux $(dtstree)/%.dts $(wrapperbits)
 	$(call if_changed,wrap,treeboot-$*,$(dtstree)/$*.dts)
 
+# Rule to build device tree blobs
+$(obj)/%.dtb: $(dtstree)/%.dts $(obj)/dtc
+	$(obj)/dtc -O dtb -o $(obj)/$*.dtb -b 0 $(dtstree)/$*.dts
+
 # If there isn't a platform selected then just strip the vmlinux.
 ifeq (,$(image-y))
 image-y := vmlinux.strip
