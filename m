Return-Path: <jwboyer@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by ozlabs.org (Postfix) with ESMTP id 35440DEDE9
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 01:42:05 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so4199wag.13
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 08:42:03 -0700 (PDT)
Message-Id: <faaaa9f9e286063b3f2363e9fc43cd59002861d3.1219160188.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Tue, 19 Aug 2008 11:27:01 -0400
Subject: [PATCH 8/9] powerpc/44x: Add explicit support for AMCC Glacier
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add explicit support for the AMCC Glacier eval board to Kconfig and the
ppc44x_simple file.  Also removes the cayonlands compatible entry from the
DTS file.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/dts/glacier.dts          |    2 +-
 arch/powerpc/platforms/44x/Kconfig         |   11 +++++++++++
 arch/powerpc/platforms/44x/ppc44x_simple.c |    1 +
 3 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/glacier.dts b/arch/powerpc/boot/dts/glacier.dts
index 24cf0db..f3787a2 100644
--- a/arch/powerpc/boot/dts/glacier.dts
+++ b/arch/powerpc/boot/dts/glacier.dts
@@ -14,7 +14,7 @@
 	#address-cells = <2>;
 	#size-cells = <1>;
 	model = "amcc,glacier";
-	compatible = "amcc,glacier", "amcc,canyonlands";
+	compatible = "amcc,glacier";
 	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index e0bea83..f8ef279 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -92,6 +92,17 @@ config CANYONLANDS
 	help
 	  This option enables support for the AMCC PPC460EX evaluation board.
 
+config GLACIER
+	bool "Glacier"
+	depends on 44x
+	default n
+	select PPC44x_SIMPLE
+	select 460EX # Odd since it uses 460GT but the effects are the same
+	select PCI
+	select PPC4xx_PCI_EXPRESS
+	help
+	  This option enables support for the AMCC PPC460GT evaluation board.
+
 config YOSEMITE
 	bool "Yosemite"
 	depends on 44x
diff --git a/arch/powerpc/platforms/44x/ppc44x_simple.c b/arch/powerpc/platforms/44x/ppc44x_simple.c
index 067cddb..4e78e04 100644
--- a/arch/powerpc/platforms/44x/ppc44x_simple.c
+++ b/arch/powerpc/platforms/44x/ppc44x_simple.c
@@ -43,6 +43,7 @@ machine_device_initcall(ppc44x_simple, ppc44x_device_probe);
 static char *board[] __initdata = {
 	"amcc,bamboo",
 	"amcc,cayonlands",
+	"amcc,glacier",
 	"ibm,ebony",
 	"amcc,katmai",
 	"amcc,rainier",
-- 
1.5.5.1
