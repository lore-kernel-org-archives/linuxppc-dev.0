Return-Path: <jacmet@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.191])
	by ozlabs.org (Postfix) with ESMTP id 09D99DDE09
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 01:43:08 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so5365346mue
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 08:43:07 -0700 (PDT)
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] fsl_spi devices should use mode "cpu" or "qe"
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 03 Oct 2007 17:43:00 +0200
Message-ID: <87przwxkzf.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

According to booting-without-of.txt, fsl_spi mode should be either
"cpu" or "qe", not "cpu-qe".

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/powerpc/boot/dts/mpc832x_rdb.dts |    2 +-
 arch/powerpc/sysdev/fsl_soc.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 388c8a7..a5158d5 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -175,7 +175,7 @@
 			reg = <4c0 40>;
 			interrupts = <2>;
 			interrupt-parent = <&qeic>;
-			mode = "cpu-qe";
+			mode = "qe";
 		};
 
 		spi@500 {
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index c765d7a..a57fe56 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1253,7 +1253,7 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 		pdata.bus_num = *(u32 *)prop;
 
 		prop = of_get_property(np, "mode", NULL);
-		if (prop && !strcmp(prop, "cpu-qe"))
+		if (prop && !strcmp(prop, "qe"))
 			pdata.qe_mode = 1;
 
 		for (j = 0; j < num_board_infos; j++) {
-- 
1.5.3.2


-- 
Bye, Peter Korsgaard
