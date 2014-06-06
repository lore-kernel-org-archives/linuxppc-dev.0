Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AB321A00D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 18:44:23 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 6 Jun 2014 18:44:18 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 238253578055
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 18:44:14 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s568hwh09306416
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 18:43:58 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s568iDTx001024
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 18:44:13 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/6] powerpc/powernv: Make set_bypass() callback a type
Date: Fri,  6 Jun 2014 18:44:05 +1000
Message-Id: <1402044246-13650-6-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1402044246-13650-1-git-send-email-aik@ozlabs.ru>
References: <1402044246-13650-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are going to be other callbacks which are going to be used as
function parameters so change the existing set_bypass() callback to be
a type.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/iommu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index f503a5c..2bc8f8c 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -65,6 +65,7 @@ struct iommu_owner {
 	unsigned char __unused[0];
 };
 
+typedef void (*iommu_set_bypass_fn)(struct iommu_table *tbl, bool enable);
 struct iommu_table {
 	unsigned long  it_busno;     /* Bus number this table belongs to */
 	unsigned long  it_size;      /* Size of iommu table in entries */
@@ -82,7 +83,7 @@ struct iommu_table {
 #ifdef CONFIG_IOMMU_API
 	struct iommu_group *it_group;
 #endif
-	void (*set_bypass)(struct iommu_table *tbl, bool enable);
+	iommu_set_bypass_fn set_bypass;
 	struct iommu_owner *it_owner;
 };
 
-- 
2.0.0
