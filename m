Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4735967BBD
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 11:11:45 +1100 (EST)
Message-ID: <4574B93A.6030307@am.sony.com>
Date: Mon, 04 Dec 2006 16:11:38 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [POWERPC] ps3: add a default zImage target
References: <456BAB86.4070104@am.sony.com>
In-Reply-To: <456BAB86.4070104@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a powerpc make target that can be loaded by the ps3 bootloader (kboot) and
set this as the default image to build for that platform.

Until the compressed zImage wrapper is made, this arranges for a stripped
vmlinux image to be built.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

Paul,

I noticed this didn't go into the latest set in powerpc.git.
 
I think having the default image for ps3 set as zImage.pseries will cause
confusion for some users since that image is not loadable by the ps3 bootloader.

I rebased this to the latest powerpc.git.  Please apply.

-Geoff 


 arch/powerpc/boot/Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

--- cell--common--7.orig/arch/powerpc/boot/Makefile
+++ cell--common--7/arch/powerpc/boot/Makefile
@@ -149,13 +149,16 @@ $(obj)/zImage.miboot: vmlinux $(wrapperb
 $(obj)/zImage.initrd.miboot: vmlinux $(wrapperbits)
 	$(call cmd,wrap_initrd,miboot)
 
+$(obj)/zImage.ps3: vmlinux
+	$(STRIP) -s -R .comment $< -o $@
+
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call cmd,wrap,uboot)
 
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
 image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
-image-$(CONFIG_PPC_PS3)			+= zImage.pseries
+image-$(CONFIG_PPC_PS3)			+= zImage.ps3
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_EFIKA)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
