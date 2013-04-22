Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E215A2C01CD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:02:04 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 22 Apr 2013 19:52:39 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 239EC2CE804C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:01:57 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3MA1oxo37683332
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:01:50 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3MA1utK010372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2013 20:01:56 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, David Gibson <dwg@au1.ibm.com>
Subject: [PATCH -V6 04/27] powerpc: Don't truncate pgd_index wrongly
Date: Mon, 22 Apr 2013 15:30:38 +0530
Message-Id: <1366624861-24948-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/pgtable-ppc64.h |    3 +--
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
1.7.10
