Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zxQMd3N0XzF1X4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2018 07:33:33 +1100 (AEDT)
Received: by mail-wr0-x242.google.com with SMTP id l43so3511087wrc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Mar 2018 12:33:32 -0800 (PST)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>,
 linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND
 64-BIT)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 15/21] powerpc: Make function MMU_setup static
Date: Wed,  7 Mar 2018 21:32:55 +0100
Message-Id: <20180307203257.23542-1-malat@debian.org>
In-Reply-To: <20180225172236.29650-16-malat@debian.org>
References: <20180225172236.29650-16-malat@debian.org>
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

Since function `MMU_setup` is not meant to be exported, change the
signature to `static`. Fix warning (treated as error with W=1):

  CC      kernel/sys.o
arch/powerpc/mm/init_32.c:102:13: error: no previous prototype for ‘MMU_setup’ [-Werror=missing-prototypes]
 void __init MMU_setup(void)
             ^~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/mm/init_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 6419b33ca309..a2bf6965d04f 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -99,7 +99,7 @@ unsigned long __max_low_memory = MAX_LOW_MEM;
 /*
  * Check for command-line options that affect what MMU_init will do.
  */
-void __init MMU_setup(void)
+static void __init MMU_setup(void)
 {
 	/* Check for nobats option (used in mapin_ram). */
 	if (strstr(boot_command_line, "nobats")) {
-- 
2.11.0
