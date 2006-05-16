Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17513.50957.847622.644000@cargo.ozlabs.ibm.com>
Date: Tue, 16 May 2006 22:35:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc.git 'merge' branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do a pull from the "merge" branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

Two more small bug-fixes for powerpc.  I have put the full commit
messages and patches below.

Thanks,
Paul.

commit 3de620e8394406fd01f450b8c6e3e74464e81a78
Author: Anton Blanchard <anton@samba.org>
Date:   Wed May 10 13:05:54 2006 +1000

    [PATCH] powerpc: fix kernel version display on pseries boxes
    
    We are displaying the wrong thing on the operator panel (2x40
    character LCD).  This got broken in commit cebb21b5, when UTS_RELEASE
    got changed to system_utsname.version.
    
    Signed-off-by: Anton Blanchard <anton@samba.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 5eb55ef..5f79f01 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -255,7 +255,7 @@ static int __init pSeries_init_panel(voi
 {
 	/* Manually leave the kernel version on the panel. */
 	ppc_md.progress("Linux ppc64\n", 0);
-	ppc_md.progress(system_utsname.version, 0);
+	ppc_md.progress(system_utsname.release, 0);
 
 	return 0;
 }

commit cb6b2eb9bcf2f61e84dc0b55ef7e3d4923842313
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Mon May 15 15:46:03 2006 +1000

    [PATCH] Fix pSeries identification in prom_init.c
    
    The OF trampoline code prom_init.c still needs to identify IBM pSeries
    (PAPR) machines in order to run some platform specific code on them like
    instanciating the TCE tables. The code doing that detection was changed
    recently in 2.6.17 early stages but was done slightly incorrectly. It
    should be testing for an exact match of "chrp" and it currently tests
    for anything that begins with "chrp". That means it will incorrectly
    match with platforms using Maple-like device-trees and have open
    firmware. This fixes it by using strcmp instead of strncmp to match what
    the actual platform detection code does.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 078fb55..2d80653 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1636,7 +1636,7 @@ #ifdef CONFIG_PPC64
 			   compat, sizeof(compat)-1);
 	if (len <= 0)
 		return PLATFORM_GENERIC;
-	if (strncmp(compat, RELOC("chrp"), 4))
+	if (strcmp(compat, RELOC("chrp")))
 		return PLATFORM_GENERIC;
 
 	/* Default to pSeries. We need to know if we are running LPAR */
