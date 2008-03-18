Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id D8CCDDDDFB
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 16:14:13 +1100 (EST)
Received: from pd2mr3so.prod.shaw.ca
	(pd2mr3so-qfe3.prod.shaw.ca [10.0.141.108]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JXW0080PUI0I570@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 17 Mar 2008 23:13:12 -0600 (MDT)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd2mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JXW00IWUUHZS930@pd2mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 17 Mar 2008 23:13:12 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JXW0024BUHY5L00@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 17 Mar 2008 23:13:11 -0600 (MDT)
Date: Mon, 17 Mar 2008 23:13:10 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH][POWERPC] bootwrapper: Add entries for tqm8540 and sbc85xx
To: bunk@kernel.org, paul.gortmaker@windriver.com, galak@kernel.crashing.org,
	paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Message-id: <20080318051112.17634.63025.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Gortmaker <paul.gortmaker@windriver.com>

The wrapper script didn't have entries for the TQM8540 board and the
SBC8548 or SBC8560 boards.  I've assumed that the TQM8540 console is
8250 based and not CPM based by looking at its defconfig.  There was
also a trailing * on the TQM8555 entry that I removed too.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

Paulus; this fixes the broken defconfig issues that Adrian raised.  Can you
please pick this up for merger into 2.6.25?

Thanks,
g.

 arch/powerpc/boot/Makefile |    4 ++--
 arch/powerpc/boot/wrapper  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 4974d9e..1aded8f 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -253,8 +253,8 @@ image-$(CONFIG_TQM8540)			+= cuImage.tqm8540
 image-$(CONFIG_TQM8541)			+= cuImage.tqm8541
 image-$(CONFIG_TQM8555)			+= cuImage.tqm8555
 image-$(CONFIG_TQM8560)			+= cuImage.tqm8560
-image-$(CONFIG_SBC8548)			+= cuImage.tqm8548
-image-$(CONFIG_SBC8560)			+= cuImage.tqm8560
+image-$(CONFIG_SBC8548)			+= cuImage.sbc8548
+image-$(CONFIG_SBC8560)			+= cuImage.sbc8560
 
 # Board ports in arch/powerpc/platform/embedded6xx/Kconfig
 image-$(CONFIG_STORCENTER)		+= cuImage.storcenter
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index d50e498..8f8b849 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -174,10 +174,10 @@ cuboot*)
     *-mpc83*)
         platformo=$object/cuboot-83xx.o
         ;;
-    *-tqm8541|*-mpc8560*|*-tqm8560|*-tqm8555*)
+    *-tqm8541|*-mpc8560*|*-tqm8560|*-tqm8555)
         platformo=$object/cuboot-85xx-cpm2.o
         ;;
-    *-mpc85*)
+    *-mpc85*|*-tqm8540|*-sbc85*)
         platformo=$object/cuboot-85xx.o
         ;;
     esac
