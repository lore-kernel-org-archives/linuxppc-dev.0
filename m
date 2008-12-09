Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6F86DDF63
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Dec 2008 14:35:07 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	mB93Z3AT012053
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Dec 2008 20:35:03 -0700 (MST)
From: Trent Piepho <tpiepho@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] powerpc: booke: Allow larger CAM sizes than 256 MB
Date: Mon,  8 Dec 2008 19:34:59 -0800
Message-Id: <1228793699-23110-5-git-send-email-tpiepho@freescale.com>
In-Reply-To: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
References: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
Cc: Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The code that maps kernel low memory would only use page sizes up to 256
MB.  On E500v2 pages up to 4 GB are supported.

However, a page must be aligned to a multiple of the page's size.  I.e.
256 MB pages must aligned to a 256 MB boundary.  This was enforced by a
requirement that the physical and virtual addresses of the start of lowmem
be aligned to 256 MB.  Clearly requiring 1GB or 4GB alignment to allow
pages of that size isn't acceptable.

To solve this, I simply have adjust_total_lowmem() take alignment into
account when it decides what size pages to use.  Give it PAGE_OFFSET =
0x7000_0000, PHYSICAL_START = 0x3000_0000, and 2GB of RAM, and it will map
pages like this:
PA 0x3000_0000 VA 0x7000_0000 Size 256 MB
PA 0x4000_0000 VA 0x8000_0000 Size 1 GB
PA 0x8000_0000 VA 0xC000_0000 Size 256 MB
PA 0x9000_0000 VA 0xD000_0000 Size 256 MB
PA 0xA000_0000 VA 0xE000_0000 Size 256 MB

Because the lowmem mapping code now takes alignment into account,
PHYSICAL_ALIGN can be lowered from 256 MB to 64 MB.  Even lower might be
possible.  The lowmem code will work down to 4 kB but it's possible some of
the boot code will fail before then.  Poor alignment will force small pages
to be used, which combined with the limited number of TLB1 pages available,
will result in very little memory getting mapped.  So alignments less than
64 MB probably aren't very useful anyway.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
---
 arch/powerpc/Kconfig            |    2 +-
 arch/powerpc/mm/fsl_booke_mmu.c |   14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2bb645c..a7b6b8f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -776,7 +776,7 @@ config PHYSICAL_START
 
 config PHYSICAL_ALIGN
 	hex
-	default "0x10000000" if FSL_BOOKE
+	default "0x04000000" if FSL_BOOKE
 	help
 	  This value puts the alignment restrictions on physical address
 	  where kernel is loaded and run from. Kernel is compiled for an
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 73aa9b7..0b9ba6b 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -183,9 +183,14 @@ void __init
 adjust_total_lowmem(void)
 {
 	phys_addr_t ram;
-	unsigned int max_cam = 28;	/* 2^28 = 256 Mb */
+	unsigned int max_cam = (mfspr(SPRN_TLB1CFG) >> 16) & 0xff;
 	char buf[ARRAY_SIZE(cam) * 5 + 1], *p = buf;
 	int i;
+	unsigned long virt = PAGE_OFFSET & 0xffffffffUL;
+	unsigned long phys = memstart_addr & 0xffffffffUL;
+
+	/* Convert (4^max) kB to (2^max) bytes */
+	max_cam = max_cam * 2 + 10;
 
 	/* adjust lowmem size to __max_low_memory */
 	ram = min((phys_addr_t)__max_low_memory, (phys_addr_t)total_lowmem);
@@ -194,11 +199,18 @@ adjust_total_lowmem(void)
 	__max_low_memory = 0;
 	for (i = 0; ram && i < ARRAY_SIZE(cam); i++) {
 		unsigned int camsize = __ilog2(ram) & ~1U;
+		unsigned int align = __ffs(virt | phys) & ~1U;
+
+		if (camsize > align)
+			camsize = align;
 		if (camsize > max_cam)
 			camsize = max_cam;
+
 		cam[i] = 1UL << camsize;
 		ram -= cam[i];
 		__max_low_memory += cam[i];
+		virt += cam[i];
+		phys += cam[i];
 
 		p += sprintf(p, "%lu/", cam[i] >> 20);
 	}
-- 
1.5.4.1
