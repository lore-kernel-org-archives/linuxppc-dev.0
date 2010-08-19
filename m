Return-Path: <msm@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 1873BB6EF1
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 14:57:14 +1000 (EST)
From: Matthew McClintock <msm@freescale.com>
To: kexec@lists.infradead.org
Subject: [PATCH v2 1/3] Ramdisk address was not copied correctly on kexec'ed
	kernel
Date: Wed, 18 Aug 2010 23:56:49 -0500
Message-ID: <1282193811-23098-2-git-send-email-msm@freescale.com>
In-Reply-To: <20100819042023.GC13965@verge.net.au>
References: <20100819042023.GC13965@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain
Cc: muvarov@gmail.com, linuxppc-dev@ozlabs.org,
	Kumar Gala <kumar.gala@freescale.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	Matthew McClintock <msm@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 kexec/arch/ppc/fixup_dtb.c |    2 +-
 kexec/arch/ppc/kexec-ppc.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/ppc/fixup_dtb.c b/kexec/arch/ppc/fixup_dtb.c
index 26c23a3..09f9ac1 100644
--- a/kexec/arch/ppc/fixup_dtb.c
+++ b/kexec/arch/ppc/fixup_dtb.c
@@ -311,7 +311,7 @@ static void fixup_initrd(char *blob_buf)
 				return;
 		}
 
-		tmp = ramdisk_base + ramdisk_size + 1;
+		tmp = ramdisk_base + ramdisk_size;
 		err = fdt_setprop(blob_buf, nodeoffset,
 			"linux,initrd-end", &tmp, sizeof(tmp));
 		if (err < 0) {
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index c36c7b3..ab76d6f 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -481,7 +481,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 
 			if ((initrd_end - initrd_start) != 0 ) {
 				initrd_base = initrd_start;
-				initrd_size = initrd_end - initrd_start + 1;
+				initrd_size = initrd_end - initrd_start;
 			}
 
 			if (reuse_initrd) {
-- 
1.6.0.6
