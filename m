Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GcVl0QwTzF1pH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 06:09:18 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id r131so435657wmb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 13:09:18 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/19] powerpc/chrp/setup: Remove idu_size variable and
 make some functions static
Date: Wed,  4 Apr 2018 22:09:11 +0200
Message-Id: <20180404200911.27506-1-malat@debian.org>
In-Reply-To: <20180328193553.1122-1-malat@debian.org>
References: <20180328193553.1122-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove variable declaration idu_size and associated code since not used.

These functions can all be static, make it so. Fix warnings treated as
errors with W=1:

  arch/powerpc/platforms/chrp/setup.c:97:6: error: no previous prototype for ‘chrp_show_cpuinfo’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/setup.c:302:13: error: no previous prototype for ‘chrp_setup_arch’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/setup.c:385:16: error: variable ‘idu_size’ set but not used [-Werror=unused-but-set-variable]
  arch/powerpc/platforms/chrp/setup.c:526:13: error: no previous prototype for ‘chrp_init_IRQ’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/setup.c:559:1: error: no previous prototype for ‘chrp_init2’ [-Werror=missing-prototypes]

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v3: update subject line after v2 change
v2: Remove totally variable idu_size
 arch/powerpc/platforms/chrp/setup.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 481ed133e04b..d6d8ffc0271e 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -94,7 +94,7 @@ static const char *chrp_names[] = {
 	"Total Impact Briq"
 };
 
-void chrp_show_cpuinfo(struct seq_file *m)
+static void chrp_show_cpuinfo(struct seq_file *m)
 {
 	int i, sdramen;
 	unsigned int t;
@@ -299,7 +299,7 @@ static __init void chrp_init(void)
 	of_node_put(node);
 }
 
-void __init chrp_setup_arch(void)
+static void __init chrp_setup_arch(void)
 {
 	struct device_node *root = of_find_node_by_path("/");
 	const char *machine = NULL;
@@ -382,7 +382,7 @@ static void __init chrp_find_openpic(void)
 {
 	struct device_node *np, *root;
 	int len, i, j;
-	int isu_size, idu_size;
+	int isu_size;
 	const unsigned int *iranges, *opprop = NULL;
 	int oplen = 0;
 	unsigned long opaddr;
@@ -427,11 +427,9 @@ static void __init chrp_find_openpic(void)
 	}
 
 	isu_size = 0;
-	idu_size = 0;
 	if (len > 0 && iranges[1] != 0) {
 		printk(KERN_INFO "OpenPIC irqs %d..%d in IDU\n",
 		       iranges[0], iranges[0] + iranges[1] - 1);
-		idu_size = iranges[1];
 	}
 	if (len > 1)
 		isu_size = iranges[3];
@@ -523,7 +521,7 @@ static void __init chrp_find_8259(void)
 	}
 }
 
-void __init chrp_init_IRQ(void)
+static void __init chrp_init_IRQ(void)
 {
 #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_XMON)
 	struct device_node *kbd;
@@ -555,7 +553,7 @@ void __init chrp_init_IRQ(void)
 #endif
 }
 
-void __init
+static void __init
 chrp_init2(void)
 {
 #ifdef CONFIG_NVRAM
-- 
2.11.0
