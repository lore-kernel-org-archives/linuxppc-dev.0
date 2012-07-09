Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 534F32C0322
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 23:14:06 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 9 Jul 2012 14:00:41 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q69DE3X951052686
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 23:14:03 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q69DE2Hn030073
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 23:14:02 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V3 05/11] arch/powerpc: remove masking top 16 bit of va in
 tlb invalidate
Date: Mon,  9 Jul 2012 18:43:35 +0530
Message-Id: <1341839621-28332-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

ISA doc doesn't talk about this. As per ISA doc for a 4K page

     tlbie RB RS

" The Abbreviated Virtual Address (AVA) field in register RB must
  contain bits 14:65 of the virtual address translated by the TLB
  entry to be invalidated."

That indicate we should not mask the top 16 bits. So remove the same.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index b019f2d..9bf8187 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -54,9 +54,6 @@ static inline void __tlbie(unsigned long vpn, int psize, int ssize)
 	BUG_ON((77 - 65) > VPN_SHIFT);
 	va = vpn << VPN_SHIFT;
 
-	/* clear top 16 bits, non SLS segment */
-	va &= ~(0xffffULL << 48);
-
 	switch (psize) {
 	case MMU_PAGE_4K:
 		va |= ssize << 8;
@@ -86,9 +83,6 @@ static inline void __tlbiel(unsigned long vpn, int psize, int ssize)
 	BUG_ON((77 - 65) > VPN_SHIFT);
 	va = vpn << VPN_SHIFT;
 
-	/* clear top 16 bits, non SLS segment */
-	va &= ~(0xffffULL << 48);
-
 	switch (psize) {
 	case MMU_PAGE_4K:
 		va |= ssize << 8;
-- 
1.7.10
