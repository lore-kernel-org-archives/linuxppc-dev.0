Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F2332C039E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:06:10 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 26 Feb 2013 17:58:48 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E4CF62CE8023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:06:07 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1Q7refd65273898
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 18:53:41 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1Q866xE008797
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:06:07 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V1 22/24] powerpc/THP: hypervisor require few WIMG bit set
Date: Tue, 26 Feb 2013 13:35:12 +0530
Message-Id: <1361865914-13911-23-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
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

Without this insert will return H_PARAMETER error. Also use
the signed variant when printing error.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugepage-hash64.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index c9c2640..48d366b 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -131,6 +131,8 @@ repeat:
 		/* Add in WIMG bits. FIXME!! enabled by default */
 		rflags |= (new_pmd & (_PAGE_WRITETHRU | _PAGE_NO_CACHE |
 				      _PAGE_COHERENT | _PAGE_GUARDED));
+#else
+		rflags |= _PAGE_COHERENT;
 #endif
 		/* Insert into the hash table, primary slot */
 		slot = ppc_md.hpte_insert(hpte_group, vpn, pa, rflags, 0,
-- 
1.7.10
