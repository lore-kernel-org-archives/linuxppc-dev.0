Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv3G363P3zDqLs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 23:04:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v6 11/19] powerpc/mm/hash: Check for non-kernel address in
 get_kernel_vsid()
Date: Thu, 30 Mar 2017 23:03:59 +1100
Message-Id: <1490875447-4016-11-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
References: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

get_kernel_vsid() has a very stern comment saying that it's only valid
for kernel addresses, but there's nothing in the code to enforce that.

Rather than hoping our callers are well behaved, add a check and return
a VSID of 0 (invalid).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index a5ab6f5b8a7f..10a34282829e 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -682,6 +682,9 @@ static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
 {
 	unsigned long context;
 
+	if (!is_kernel_addr(ea))
+		return 0;
+
 	/*
 	 * For kernel space, we use context ids 1-4 to map the address space as
 	 * below:
-- 
2.7.4
