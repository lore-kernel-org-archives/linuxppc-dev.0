Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDsvq3vDTzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 22:05:27 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
	msuchanek@suse.de
Subject: [PATCH] powerpc/mm/hash: Fix off-by-one in comment about kernel
 contexts ids
Date: Fri, 28 Apr 2017 22:05:23 +1000
Message-Id: <1493381123-26701-1-git-send-email-mpe@ellerman.id.au>
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

Michal Suchánek noticed a comment in book3s/64/mmu-hash.h about the context ids
we use for the kernel was inconsistent with the code and other comments in the
same file.

It should read 1-4 not 1-5.

While we're touching it, update "address" to "addresses" which makes more sense
as it's referring to more than one address below.

Reported-by: Michal Suchánek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 6d56974adf28..6981a52b3887 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -494,7 +494,7 @@ extern void slb_set_size(u16 size);
  *
  * For user processes max context id is limited to MAX_USER_CONTEXT.
 
- * For kernel space, we use context ids 1-5 to map address as below:
+ * For kernel space, we use context ids 1-4 to map addresses as below:
  * NOTE: each context only support 64TB now.
  * 0x00001 -  [ 0xc000000000000000 - 0xc0003fffffffffff ]
  * 0x00002 -  [ 0xd000000000000000 - 0xd0003fffffffffff ]
-- 
2.7.4
