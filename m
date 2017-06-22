Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtPR43xjJzDqlZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 11:40:16 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id r62so356704qkf.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 18:40:16 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org,
 corbet@lwn.net, mingo@redhat.com
Subject: [RFC v3 10/23] mm: provide the ability to disable execute on a key at
 creation
Date: Wed, 21 Jun 2017 18:39:26 -0700
Message-Id: <1498095579-6790-11-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1498095579-6790-1-git-send-email-linuxram@us.ibm.com>
References: <1498095579-6790-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently sys_pkey_create() provides the ability to disable read
and write permission on the key, at  creation. powerpc  has  the
hardware support to disable execute on a pkey as well.This patch
enhances the interface to let disable execute  at  key  creation
time. x86 does  not  allow  this.  Hence the next patch will add
ability  in  x86  to  return  error  is  PKEY_DISABLE_EXECUTE is
specified.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 include/uapi/asm-generic/mman-common.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 8c27db0..bf4fa07 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -74,7 +74,9 @@
 
 #define PKEY_DISABLE_ACCESS	0x1
 #define PKEY_DISABLE_WRITE	0x2
+#define PKEY_DISABLE_EXECUTE	0x4
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
-				 PKEY_DISABLE_WRITE)
+				 PKEY_DISABLE_WRITE  |\
+				 PKEY_DISABLE_EXECUTE)
 
 #endif /* __ASM_GENERIC_MMAN_COMMON_H */
-- 
1.8.3.1
