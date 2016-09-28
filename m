Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skTlB599czDrXS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 17:25:58 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id 6so1781649pfl.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 00:25:58 -0700 (PDT)
Subject: [PATCH v2] Fix buglet in tlbiel where we set L=1 for ISA 206/7
To: linuxppc-dev@lists.ozlabs.org
References: <1473748807-9604-1-git-send-email-bsingharora@gmail.com>
Cc: Paul Mackerras <paulus@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <michael@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <7c9ac97f-00ef-5597-cbb4-032581856de6@gmail.com>
Date: Wed, 28 Sep 2016 17:25:52 +1000
MIME-Version: 1.0
In-Reply-To: <1473748807-9604-1-git-send-email-bsingharora@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This patch fixes a bug where we set bit 10 in tlbie via our
custom .long opcode for tlbiel. These bits are reserved for
2.06/2.07. In ISA 3.0 bit 10 is a part of the register field
RS and we could end up corrupting the meaning of the register
field completely with L=1

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 Changelog v2->v1:
	Use the compiler to generate tlbiel as suggsted by mpe
	Drop the rest of the changes to macros

 arch/powerpc/mm/hash_native_64.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 0e4e965..0f77edf 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -123,8 +123,9 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 		va |= ssize << 8;
 		sllp = get_sllp_encoding(apsize);
 		va |= sllp << 5;
-		asm volatile(".long 0x7c000224 | (%0 << 11) | (0 << 21)"
-			     : : "r"(va) : "memory");
+		asm volatile(ASM_FTR_IFCLR("tlbiel %0,0", "tlbiel %0", %1)
+			     : : "r" (va), "i" (CPU_FTR_ARCH_206)
+			     : "memory");
 		break;
 	default:
 		/* We need 14 to 14 + i bits of va */
@@ -141,8 +142,9 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 		 */
 		va |= (vpn & 0xfe);
 		va |= 1; /* L */
-		asm volatile(".long 0x7c000224 | (%0 << 11) | (1 << 21)"
-			     : : "r"(va) : "memory");
+		asm volatile(ASM_FTR_IFCLR("tlbiel %0,1", "tlbiel %0", %1)
+			     : : "r" (va), "i" (CPU_FTR_ARCH_206)
+			     : "memory");
 		break;
 	}
 
-- 
2.5.5
