Return-Path: <liyiadam@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qq4Z1NdvzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 18:46:21 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id m9-v6so22392636qtb.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 01:46:21 -0700 (PDT)
From: Yi Li <liyiadam@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Yi Li <liyiadam@gmail.com>
Subject: [PATCH] kbuild: rpm-pkg: Disable vmlinux.bz2 for ppc64 and ppc64le
Date: Tue, 22 May 2018 16:45:57 +0800
Message-Id: <1526978757-130391-1-git-send-email-liyiadam@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

petitboot bootloader cannot load vmlinux.bz2.

Signed-off-by: Yi Li <liyiadam@gmail.com>
---
 scripts/package/mkspec | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index e05646d..e4146ec 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -93,8 +93,10 @@ $M	make %{?_smp_mflags} INSTALL_MOD_PATH=%{buildroot} KBUILD_SRC= modules_instal
 	make %{?_smp_mflags} INSTALL_HDR_PATH=%{buildroot}/usr KBUILD_SRC= headers_install
 	cp System.map %{buildroot}/boot/System.map-$KERNELRELEASE
 	cp .config %{buildroot}/boot/config-$KERNELRELEASE
+	%ifnarch ppc64 ppc64le
 	bzip2 -9 --keep vmlinux
 	mv vmlinux.bz2 %{buildroot}/boot/vmlinux-$KERNELRELEASE.bz2
+	%endif
 $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/build
 $S$M	rm -f %{buildroot}/lib/modules/$KERNELRELEASE/source
 $S$M	mkdir -p %{buildroot}/usr/src/kernels/$KERNELRELEASE
-- 
1.8.3.1
