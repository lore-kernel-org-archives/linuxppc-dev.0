Return-Path: <jochen@scram.de>
Message-ID: <46D5A715.7090802@scram.de>
Date: Wed, 29 Aug 2007 19:04:21 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
Subject: [PATCH] Fix CPM1 uart console
Content-Type: multipart/mixed; boundary="------------080708010403060404070909"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080708010403060404070909
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The powerpc version of commproc.c doesn't export cpm_dpram_phys due to
a typo. The ppc version of cpm_dpram_addr returns a usable virtual address
mapped to a physical address at the same location. cpm_dpram_phys returns
complete garbage as it tries to calculate an offset based on an otherwise
unused virtual adress returned by ioremap.

This patch fixes the typo for powerpc and removes the unnecessary ioremap
and corresponding virtual address for ppc.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/powerpc/sysdev/commproc.c |    2 +-
 arch/ppc/8xx_io/commproc.c     |    4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

--------------080708010403060404070909
Content-Type: text/x-patch;
 name="60d3d5feb1e51a5c0d839c4b7b2b683b82b43fee.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="60d3d5feb1e51a5c0d839c4b7b2b683b82b43fee.diff"

diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index 4f67b89..dd5417a 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -395,4 +395,4 @@ uint cpm_dpram_phys(u8* addr)
 {
 	return (dpram_pbase + (uint)(addr - dpram_vbase));
 }
-EXPORT_SYMBOL(cpm_dpram_addr);
+EXPORT_SYMBOL(cpm_dpram_phys);
diff --git a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
index 7088428..593b939 100644
--- a/arch/ppc/8xx_io/commproc.c
+++ b/arch/ppc/8xx_io/commproc.c
@@ -379,14 +379,12 @@ static rh_block_t cpm_boot_dpmem_rh_block[16];
 static rh_info_t cpm_dpmem_info;
 
 #define CPM_DPMEM_ALIGNMENT	8
-static u8* dpram_vbase;
 static uint dpram_pbase;
 
 void m8xx_cpm_dpinit(void)
 {
 	spin_lock_init(&cpm_dpmem_lock);
 
-	dpram_vbase = immr_map_size(im_cpm.cp_dpmem, CPM_DATAONLY_BASE + CPM_DATAONLY_SIZE);
 	dpram_pbase = (uint)&((immap_t *)IMAP_ADDR)->im_cpm.cp_dpmem;
 
 	/* Initialize the info header */
@@ -465,6 +463,6 @@ EXPORT_SYMBOL(cpm_dpram_addr);
 
 uint cpm_dpram_phys(u8* addr)
 {
-	return (dpram_pbase + (uint)(addr - dpram_vbase));
+	return (uint)addr;
 }
 EXPORT_SYMBOL(cpm_dpram_phys);


--------------080708010403060404070909--
