Return-Path: <mgreer@mvista.com>
Date: Wed, 18 Oct 2006 14:38:09 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: wrapper: don't require execute perms for
	zImage.initrd
Message-ID: <20061018213809.GA8175@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Don't require that the wrapper script be executable when building
zImage.initrds.  This has already been fixed for zImages.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
---

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 37ddfca..4b2be61 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -115,7 +115,7 @@ endif
 quiet_cmd_wrap	= WRAP    $@
       cmd_wrap	=$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) vmlinux
 quiet_cmd_wrap_initrd = WRAP    $@
-      cmd_wrap_initrd =$(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
+      cmd_wrap_initrd =$(CONFIG_SHELL) $(wrapper) -c -o $@ -p $2 $(CROSSWRAP) \
 				-i $(obj)/ramdisk.image.gz vmlinux
 
 $(obj)/zImage.chrp: vmlinux $(wrapperbits)
