Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews08.kpnxchange.com (cpsmtpb-ews08.kpnxchange.com
 [213.75.39.13]) by ozlabs.org (Postfix) with ESMTP id B129D2C033A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 17:55:52 +1000 (EST)
Message-ID: <1369814147.23034.9.camel@x61.thuisdomein>
Subject: [PATCH] [TRIVIAL] Fix error typo "CONFIG_START_KERNEL"
From: Paul Bolle <pebolle@tiscali.nl>
To: Jiri Kosina <trivial@kernel.org>
Date: Wed, 29 May 2013 09:55:47 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested. Please note that a quick scan of this code suggests that the
preceding test should read
    #if (CONFIG_LOWMEM_SIZE > (0xF0000000 - CONFIG_KERNEL_START))

But this fix is correct anyhow.

 arch/powerpc/mm/init_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 01e2db9..d47d3da 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -52,7 +52,7 @@
 #if defined(CONFIG_KERNEL_START_BOOL) || defined(CONFIG_LOWMEM_SIZE_BOOL)
 /* The amount of lowmem must be within 0xF0000000 - KERNELBASE. */
 #if (CONFIG_LOWMEM_SIZE > (0xF0000000 - PAGE_OFFSET))
-#error "You must adjust CONFIG_LOWMEM_SIZE or CONFIG_START_KERNEL"
+#error "You must adjust CONFIG_LOWMEM_SIZE or CONFIG_KERNEL_START"
 #endif
 #endif
 #define MAX_LOW_MEM	CONFIG_LOWMEM_SIZE
-- 
1.7.11.7
