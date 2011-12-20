Return-Path: <vhtnguyen@apm.com>
Received: from exprod5og102.obsmtp.com (exprod5og102.obsmtp.com [64.18.0.143])
 by ozlabs.org (Postfix) with SMTP id F4156B7020
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2011 23:50:26 +1100 (EST)
Received: by mail-iy0-f179.google.com with SMTP id e16so9260095iaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2011 04:50:25 -0800 (PST)
From: Vinh Nguyen Huu Tuong <vhtnguyen@apm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Josh Boyer <jwboyer@gmail.com>,
 Matt Porter <mporter@kernel.crashing.org>,
 Kumar Gala <galak@kernel.crashing.org>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Anton Blanchard <anton@samba.org>,
 Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
 Grant Likely <grant.likely@secretlab.ca>,
 Tony Breeds <tony@bakeyournoodle.com>,
 Rob Herring <rob.herring@calxeda.com>, Jiri Kosina <jkosina@suse.cz>,
 Lucas De Marchi <lucas.demarchi@profusion.mobi>,
 Ayman El-Khashab <ayman@elkhashab.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] powerpc/44x: The bug fixed support for APM821xx SoC and
 Bluestone board
Date: Tue, 20 Dec 2011 19:43:34 +0700
Message-Id: <1324385014-30725-1-git-send-email-vhtnguyen@apm.com>
Cc: Vinh Nguyen Huu Tuong <vhtnguyen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch consists of:
- Fix the pvr mask for checking pvr in cputable.c
- Fix the cpu name as consistent with cpu name is describled in dts file

Signed-off-by: Vinh Nguyen Huu Tuong <vhtnguyen@apm.com>
---
 arch/powerpc/kernel/cputable.c             |    2 +-
 arch/powerpc/platforms/44x/ppc44x_simple.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index edae5bb..6a5a9a8 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1803,7 +1803,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.platform		= "ppc440",
 	},
 	{ /* 464 in APM821xx */
-		.pvr_mask		= 0xffffff00,
+		.pvr_mask		= 0xfffffff0,
 		.pvr_value		= 0x12C41C80,
 		.cpu_name		= "APM821XX",
 		.cpu_features		= CPU_FTRS_44X,
diff --git a/arch/powerpc/platforms/44x/ppc44x_simple.c b/arch/powerpc/platforms/44x/ppc44x_simple.c
index 8d22027..3ffb915 100644
--- a/arch/powerpc/platforms/44x/ppc44x_simple.c
+++ b/arch/powerpc/platforms/44x/ppc44x_simple.c
@@ -52,7 +52,7 @@ machine_device_initcall(ppc44x_simple, ppc44x_device_probe);
 static char *board[] __initdata = {
 	"amcc,arches",
 	"amcc,bamboo",
-	"amcc,bluestone",
+	"apm,bluestone",
 	"amcc,glacier",
 	"ibm,ebony",
 	"amcc,eiger",
-- 
1.7.2.5
