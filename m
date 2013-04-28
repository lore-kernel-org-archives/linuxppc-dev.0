Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 48FF22C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 05:37:52 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 29 Apr 2013 01:02:46 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3C686E0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 01:09:55 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3SJbfEL52035678
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 01:07:41 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3SJbihH003098
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2013 05:37:45 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, dwg@au1.ibm.com,
 linux-mm@kvack.org
Subject: [PATCH -V7 07/18] powerpc: Don't truncate pgd_index wrongly
Date: Mon, 29 Apr 2013 01:07:28 +0530
Message-Id: <1367177859-7893-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1367177859-7893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1367177859-7893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

With PGD_INDEX_SIZE set to 12 the existing macro doesn't work. Fix it to
use PTRS_PER_PGD

The idea originally was to have one more bit in the result of
pgd_index() than PGD_INDEX_SIZE, so that if one had an address
corresponding to the last PGD entry, and then incremented that address
by PGD_SIZE, and took pgd_index() of that, you wouldn't end up with
zero.  The commit that introduced that dates back to 2002, and the
code that was sensitive to that edge case has long since been
refactored (several times), so there is no need for it these days.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 0182c20..e3d55f6f 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -167,8 +167,7 @@
  * Find an entry in a page-table-directory.  We combine the address region
  * (the high order N bits) and the pgd portion of the address.
  */
-/* to avoid overflow in free_pgtables we don't use PTRS_PER_PGD here */
-#define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & 0x1ff)
+#define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & (PTRS_PER_PGD - 1))
 
 #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
 
-- 
1.8.1.2
