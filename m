Return-Path: <hkallweit1@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svNVf6sWqzDsxJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 06:00:58 +1100 (AEDT)
Received: by mail-lf0-x242.google.com with SMTP id b75so8454796lfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 12:00:58 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] powerpc/boot: fix boot on systems with uncompressed kernel
 image
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Message-ID: <4a99340c-b773-51e4-0466-3d9a72ac83b2@gmail.com>
Date: Wed, 12 Oct 2016 21:00:43 +0200
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

This commit broke boot on systems with an uncompressed kernel image,
namely systems using a cuImage. On such systems the compressed boot
image (boot wrapper, uncompressed kernel image, ..) is decompressed
by u-boot already, therefore the boot wrapper code sees an
uncompressed kernel image.

The old decompression code silently assumed an uncompressed kernel
image if it found no valid gzip signature, whilst the new code
bailed out in this case.

Fix this by re-introducing such a fallback if no valid compressed
image is found.

Fixes: 1b7898ee276b ("Use the pre-boot decompression API")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/powerpc/boot/main.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index f7a184b..57d42d1 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -32,9 +32,16 @@ static struct addr_range prep_kernel(void)
 	void *addr = 0;
 	struct elf_info ei;
 	long len;
+	int uncompressed_image = 0;
 
-	partial_decompress(vmlinuz_addr, vmlinuz_size,
+	len = partial_decompress(vmlinuz_addr, vmlinuz_size,
 		elfheader, sizeof(elfheader), 0);
+	/* assume uncompressed data if -1 is returned */
+	if (len == -1) {
+		uncompressed_image = 1;
+		memcpy(elfheader, vmlinuz_addr, sizeof(elfheader));
+		printf("No valid compressed data found, assume uncompressed data\n\r");
+	}
 
 	if (!parse_elf64(elfheader, &ei) && !parse_elf32(elfheader, &ei))
 		fatal("Error: not a valid PPC32 or PPC64 ELF file!\n\r");
@@ -67,6 +74,13 @@ static struct addr_range prep_kernel(void)
 					"device tree\n\r");
 	}
 
+	if (uncompressed_image) {
+		memcpy(addr, vmlinuz_addr + ei.elfoffset, ei.loadsize);
+		printf("0x%lx bytes of uncompressed data copied\n\r",
+		       ei.loadsize);
+		goto out;
+	}
+
 	/* Finally, decompress the kernel */
 	printf("Decompressing (0x%p <- 0x%p:0x%p)...\n\r", addr,
 	       vmlinuz_addr, vmlinuz_addr+vmlinuz_size);
@@ -82,7 +96,7 @@ static struct addr_range prep_kernel(void)
 			 len, ei.loadsize);
 
 	printf("Done! Decompressed 0x%lx bytes\n\r", len);
-
+out:
 	flush_cache(addr, ei.loadsize);
 
 	return (struct addr_range){addr, ei.memsize};
-- 
2.10.0
