Return-Path: <mgreer@mvista.com>
Date: Tue, 30 Aug 2005 18:39:53 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Message-ID: <20050831013953.GA5456@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Subject: Remove progress msgs from MMU_init()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With that patch this time...Argh...
--

This dates back to a discussion in May.  This patch addresses point 1)
in the email below by ripping out the progress msgs from MMU_init().
This would allow us to get rid of all the xxx_set_bat() routines in the
various platform files.

Does anyone object to this patch?

Mark

http://ozlabs.org/pipermail/linuxppc-dev/2005-May/019120.html

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mmu_init.patch"

diff --git a/arch/ppc/mm/init.c b/arch/ppc/mm/init.c
--- a/arch/ppc/mm/init.c
+++ b/arch/ppc/mm/init.c
@@ -237,9 +237,6 @@ void MMU_setup(void)
  */
 void __init MMU_init(void)
 {
-	if (ppc_md.progress)
-		ppc_md.progress("MMU:enter", 0x111);
-
 	/* parse args from command line */
 	MMU_setup();
 
@@ -272,13 +269,9 @@ void __init MMU_init(void)
 	set_phys_avail(total_lowmem);
 
 	/* Initialize the MMU hardware */
-	if (ppc_md.progress)
-		ppc_md.progress("MMU:hw init", 0x300);
 	MMU_init_hw();
 
 	/* Map in all of RAM starting at KERNELBASE */
-	if (ppc_md.progress)
-		ppc_md.progress("MMU:mapin", 0x301);
 	mapin_ram();
 
 #ifdef CONFIG_HIGHMEM
@@ -289,17 +282,12 @@ void __init MMU_init(void)
 	ioremap_bot = ioremap_base;
 
 	/* Map in I/O resources */
-	if (ppc_md.progress)
-		ppc_md.progress("MMU:setio", 0x302);
 	if (ppc_md.setup_io_mappings)
 		ppc_md.setup_io_mappings();
 
 	/* Initialize the context management stuff */
 	mmu_context_init();
 
-	if (ppc_md.progress)
-		ppc_md.progress("MMU:exit", 0x211);
-
 #ifdef CONFIG_BOOTX_TEXT
 	/* By default, we are no longer mapped */
        	boot_text_mapped = 0;

--XsQoSWH+UP9D9v3l--
