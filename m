Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lDNb030084@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:43 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 28/43] ppc64 boot: bootfiles depend on linker script
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

bootfiles must be relinked of linker script changes

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/boot/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/ppc64/boot/Makefile~ppc64-boot-bootfiles-depend-on-linker-script arch/ppc64/boot/Makefile
--- devel/arch/ppc64/boot/Makefile~ppc64-boot-bootfiles-depend-on-linker-script	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/Makefile	2005-10-28 17:45:21.000000000 -0700
@@ -127,11 +127,11 @@ $(call obj-sec, $(required) $(initrd)): 
 	$(call cmd,addsection)
 
 $(obj)/zImage.vmode: obj-boot += $(call obj-sec, $(required))
-$(obj)/zImage.vmode: $(call obj-sec, $(required)) $(obj-boot)
+$(obj)/zImage.vmode: $(call obj-sec, $(required)) $(obj-boot) $(srctree)/$(src)/zImage.lds
 	$(call cmd,bootld,$(obj-boot))
 
 $(obj)/zImage.initrd.vmode: obj-boot += $(call obj-sec, $(required) $(initrd))
-$(obj)/zImage.initrd.vmode: $(call obj-sec, $(required) $(initrd)) $(obj-boot)
+$(obj)/zImage.initrd.vmode: $(call obj-sec, $(required) $(initrd)) $(obj-boot) $(srctree)/$(src)/zImage.lds
 	$(call cmd,bootld,$(obj-boot))
 
 $(obj)/zImage: $(obj)/zImage.vmode $(obj)/addnote
_
