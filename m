Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406dN11HvpzF20H
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 07:20:49 +1100 (AEDT)
Received: by mail-wr0-x241.google.com with SMTP id z73so10008880wrb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 13:20:49 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 05/19] powerpc/chrp/setup: Add attribute unused and make some
 functions static
Date: Thu, 22 Mar 2018 21:19:51 +0100
Message-Id: <20180322202007.23088-6-malat@debian.org>
In-Reply-To: <20180322202007.23088-1-malat@debian.org>
References: <20180322202007.23088-1-malat@debian.org>
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

Add gcc attribute unused to silence a warning.

These functions can all be static, make it so. Fix warnings treated as
errors with W=1:

  arch/powerpc/platforms/chrp/setup.c:97:6: error: no previous prototype for ‘chrp_show_cpuinfo’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/setup.c:302:13: error: no previous prototype for ‘chrp_setup_arch’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/setup.c:385:16: error: variable ‘idu_size’ set but not used [-Werror=unused-but-set-variable]
  arch/powerpc/platforms/chrp/setup.c:526:13: error: no previous prototype for ‘chrp_init_IRQ’ [-Werror=missing-prototypes]
  arch/powerpc/platforms/chrp/setup.c:559:1: error: no previous prototype for ‘chrp_init2’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/platforms/chrp/setup.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index 481ed133e04b..85df479fd631 100644
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
+	int isu_size, idu_size __maybe_unused;
 	const unsigned int *iranges, *opprop = NULL;
 	int oplen = 0;
 	unsigned long opaddr;
@@ -523,7 +523,7 @@ static void __init chrp_find_8259(void)
 	}
 }
 
-void __init chrp_init_IRQ(void)
+static void __init chrp_init_IRQ(void)
 {
 #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(CONFIG_XMON)
 	struct device_node *kbd;
@@ -555,7 +555,7 @@ void __init chrp_init_IRQ(void)
 #endif
 }
 
-void __init
+static void __init
 chrp_init2(void)
 {
 #ifdef CONFIG_NVRAM
-- 
2.11.0
