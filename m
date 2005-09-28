Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 66E8A683F0
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Sep 2005 09:31:19 +1000 (EST)
Date: Thu, 29 Sep 2005 00:31:14 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Message-ID: <20050928233114.GJ7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32 ld.script fix for building on ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	In arch/ppc/boot/ld.script we need OUTPUT_ARCH(powerpc:common) for
the same reasons why we need it in vmlinux.lds.S; when we build on ppc64
box, we need to be explicit about the target.
	See http://linus.bkbits.net:8080/linux-2.5/cset@1.1784.8.10 for
the corresponding fix in vmlinux.lds.S.
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-uml-kconfig/arch/ppc/boot/ld.script RC14-rc2-git6-ppc-arch/arch/ppc/boot/ld.script
--- RC14-rc2-git6-uml-kconfig/arch/ppc/boot/ld.script	2005-08-28 23:09:40.000000000 -0400
+++ RC14-rc2-git6-ppc-arch/arch/ppc/boot/ld.script	2005-09-28 13:02:21.000000000 -0400
@@ -1,4 +1,4 @@
-OUTPUT_ARCH(powerpc)
+OUTPUT_ARCH(powerpc:common)
 SECTIONS
 {
   /* Read-only sections, merged into text segment: */
