Return-Path: <zhlcindy@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F3B21A0B57
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 18:02:20 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id q129so828953pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Mar 2016 23:02:20 -0800 (PST)
From: Li Zhang <zhlcindy@gmail.com>
To: mpe@ellerman.id.au, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, mgorman@techsingularity.net
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Li Zhang <zhlcindy@linux.vnet.ibm.com>
Subject: [PATCH RFC 2/2] powerpc/mm: Enable page parallel initialisation
Date: Thu,  3 Mar 2016 15:01:41 +0800
Message-Id: <1456988501-29046-3-git-send-email-zhlcindy@gmail.com>
In-Reply-To: <1456988501-29046-1-git-send-email-zhlcindy@gmail.com>
References: <1456988501-29046-1-git-send-email-zhlcindy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Li Zhang <zhlcindy@linux.vnet.ibm.com>

Parallel initialisation has been enabled for X86,
boot time is improved greatly.
On Power8, for small memory, it is improved greatly.
Here is the result from my test on Power8 platform:

For 4GB memory: 57% is improved
For 50GB memory: 22% is improve

Signed-off-by: Li Zhang <zhlcindy@linux.vnet.ibm.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e4824fd..83073c2 100644
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
