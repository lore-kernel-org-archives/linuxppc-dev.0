Return-Path: <hkallweit1@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ss0zS1m1rzDrPG
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Oct 2016 09:14:11 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id 123so8280982wmb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Oct 2016 15:14:11 -0700 (PDT)
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: Commit 1b7898ee276b "powerpc/boot: Use the pre-boot decompression
 API" breaks boot
To: Oliver O'Halloran <oohall@gmail.com>
References: <8db8ecac-4022-7df9-4e81-3d490c50821d@gmail.com>
 <CAOSf1CFVX8j+kyp3SRhRz_gyPiQ3R9x=_nJyq9fr31NyGi3hhg@mail.gmail.com>
 <c19153b9-7554-0280-6d97-750c9e62b3be@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Message-ID: <80c9c42c-45d3-9f24-b3e1-5a5042686b1b@gmail.com>
Date: Sun, 9 Oct 2016 00:13:46 +0200
MIME-Version: 1.0
In-Reply-To: <c19153b9-7554-0280-6d97-750c9e62b3be@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 07.10.2016 um 21:26 schrieb Heiner Kallweit:
> Am 07.10.2016 um 07:51 schrieb Oliver O'Halloran:
>> Hi, Heiner
>>
>> Could you send me a copy of the kernel .config (or which defconfig)
>> that you're using, the name of the HW platform that you're using and
>> if possible the kernel image itself?
>>
>> Thanks,
>> Oliver
>>
> Thanks for the quick reply. Attached are .config and cuImage.
> HW is a TP-Link TL-WDR4900 WiFi router (P1014-based) running OpenWRT.
> 
> Rgds, Heiner
> 
After further checking I think I found the issue. The old gunzip code
handled uncompressed data transparently whilst the new one bails out
if it doesn't find a proper gzip header.
And in my case the actual kernel image is uncompressed.
With the following patch the system boots fine again (at least for me).

Rgds, Heiner

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index f7a184b..9796491 100644
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
@@ -67,6 +74,12 @@ static struct addr_range prep_kernel(void)
 					"device tree\n\r");
 	}
 
+	if (uncompressed_image) {
+		memcpy(addr, vmlinuz_addr + ei.elfoffset, ei.loadsize);
+		printf("%ld bytes of uncompressed data copied\n\r", ei.loadsize);
+		goto out;
+	}
+
 	/* Finally, decompress the kernel */
 	printf("Decompressing (0x%p <- 0x%p:0x%p)...\n\r", addr,
 	       vmlinuz_addr, vmlinuz_addr+vmlinuz_size);
@@ -82,7 +95,7 @@ static struct addr_range prep_kernel(void)
 			 len, ei.loadsize);
 
 	printf("Done! Decompressed 0x%lx bytes\n\r", len);
-
+out:
 	flush_cache(addr, ei.loadsize);
 
 	return (struct addr_range){addr, ei.memsize};
-- 
2.10.0
