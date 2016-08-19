Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFxZK0bmlzDr68
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 18:53:12 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7J8nBJD007867
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 04:53:10 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24vrm5tgya-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 04:53:04 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 19 Aug 2016 04:53:04 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 5/5] powerpc/64/kexec: Remove BookE special
 default_machine_kexec_prepare()
Date: Fri, 19 Aug 2016 14:22:39 +0530
In-Reply-To: <1471596759-3396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1471596759-3396-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1471596759-3396-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

The only difference is now the TCE table check which doesn't need
to be ifdef'ed out, it will basically do nothing on BookE (it is
only useful for ancient IBM machines).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/machine_kexec_64.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 98058d13d115..ae4dafa2a9bd 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -32,21 +32,6 @@
 #include <asm/asm-prototypes.h>
 #include <asm/firmware.h>
 
-#ifdef CONFIG_PPC_BOOK3E
-int default_machine_kexec_prepare(struct kimage *image)
-{
-	int i;
-	/*
-	 * Since we use the kernel fault handlers and paging code to
-	 * handle the virtual mode, we must make sure no destination
-	 * overlaps kernel static data or bss.
-	 */
-	for (i = 0; i < image->nr_segments; i++)
-		if (image->segment[i].mem < __pa(_end))
-			return -ETXTBSY;
-	return 0;
-}
-#else
 int default_machine_kexec_prepare(struct kimage *image)
 {
 	int i;
@@ -86,7 +71,6 @@ int default_machine_kexec_prepare(struct kimage *image)
 
 	return 0;
 }
-#endif /* !CONFIG_PPC_BOOK3E */
 
 static void copy_segments(unsigned long ind)
 {
-- 
2.7.4
