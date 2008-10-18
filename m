Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id 2DDABDDE1E
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 16:12:11 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so807122rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 22:12:10 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc: Add cuImage.initrd.% target
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org
Date: Fri, 17 Oct 2008 23:12:07 -0600
Message-ID: <20081018051207.16279.16018.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This target is needed to build cuImages with an embedded ramdisk image.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/boot/Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index aac1406..d83c642 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -319,6 +319,9 @@ $(obj)/zImage.iseries: vmlinux
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,uboot)
 
+$(obj)/cuImage.initrd.%: vmlinux $(obj)/%.dtb $(wrapperbits)
+	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb,$(obj)/ramdisk.image.gz)
+
 $(obj)/cuImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 	$(call if_changed,wrap,cuboot-$*,,$(obj)/$*.dtb)
 
