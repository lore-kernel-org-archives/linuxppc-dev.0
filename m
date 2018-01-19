Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zN3jF2ZWXzF0xb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 12:52:01 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id 33so464467qtv.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 17:52:01 -0800 (PST)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: [PATCH v10 07/27] powerpc: cleanup AMR,
 IAMR when a key is allocated or freed
Date: Thu, 18 Jan 2018 17:50:28 -0800
Message-Id: <1516326648-22775-8-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
References: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cleanup the bits corresponding to a key in the AMR, and IAMR
register, when the key is newly allocated/activated or is freed.
We dont want some residual bits cause the hardware enforce
unintended behavior when the key is activated or freed.

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 1e8cef2..9964b46 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -69,6 +69,8 @@ static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 		__mm_pkey_is_allocated(mm, pkey));
 }
 
+extern void __arch_activate_pkey(int pkey);
+extern void __arch_deactivate_pkey(int pkey);
 /*
  * Returns a positive, 5-bit key on success, or -1 on failure.
  * Relies on the mmap_sem to protect against concurrency in mm_pkey_alloc() and
@@ -96,6 +98,12 @@ static inline int mm_pkey_alloc(struct mm_struct *mm)
 
 	ret = ffz((u32)mm_pkey_allocation_map(mm));
 	__mm_pkey_allocated(mm, ret);
+
+	/*
+	 * Enable the key in the hardware
+	 */
+	if (ret > 0)
+		__arch_activate_pkey(ret);
 	return ret;
 }
 
@@ -107,6 +115,10 @@ static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
 	if (!mm_pkey_is_allocated(mm, pkey))
 		return -EINVAL;
 
+	/*
+	 * Disable the key in the hardware
+	 */
+	__arch_deactivate_pkey(pkey);
 	__mm_pkey_free(mm, pkey);
 
 	return 0;
-- 
1.7.1
