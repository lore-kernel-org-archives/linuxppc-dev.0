Return-Path: <zhlcindy@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03D571A0367
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 14:56:44 +1100 (AEDT)
Received: by mail-oi0-x244.google.com with SMTP id c203so248030oia.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Mar 2016 19:56:43 -0800 (PST)
From: Li Zhang <zhlcindy@gmail.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, mgorman@techsingularity.net,
 mpe@ellerman.id.au, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Li Zhang <zhlcindy@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc/mm: Enable page parallel initialisation
Date: Tue,  8 Mar 2016 11:55:54 +0800
Message-Id: <1457409354-10867-3-git-send-email-zhlcindy@gmail.com>
In-Reply-To: <1457409354-10867-1-git-send-email-zhlcindy@gmail.com>
References: <1457409354-10867-1-git-send-email-zhlcindy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Li Zhang <zhlcindy@linux.vnet.ibm.com>

Parallel initialisation has been enabled for X86, boot time is
improved greatly. On Power8, it is improved greatly for small
memory. Here is the result from my test on Power8 platform:

For 4GB memory: 57% is improved, boot time as the following:
with patch: 10s, without patch: 24.5s

For 50GB memory: 22% is improved, boot time as the following:
with patch: 43.8s, without patch: 56.8s

Acked-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Li Zhang <zhlcindy@linux.vnet.ibm.com>
---
 * Add boot time details in change log.
 * Please apply this patch after [PATCH 1/2] mm: meminit: initialise
    more memory for inode/dentry hash tables in early boot, because
   [PATCH 1/2] is to fix a bug which can be reproduced on Power.

 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9faa18c..97d41ad 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -158,6 +158,7 @@ config PPC
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select HAVE_ARCH_SECCOMP_FILTER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
-- 
2.1.0
