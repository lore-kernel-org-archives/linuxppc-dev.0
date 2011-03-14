Return-Path: <nacc@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 969C4B6FCF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Mar 2011 07:36:19 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2EKGshj022512
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2011 16:16:54 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 604CE38C8038
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Mar 2011 16:36:12 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2EKaFPb346540
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2011 16:36:15 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2EKaEbm006779
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Mar 2011 16:36:15 -0400
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] cxgb4: use pgprot_writecombine() on powerpc
Date: Mon, 14 Mar 2011 13:36:11 -0700
Message-Id: <1300134971-16752-1-git-send-email-nacc@us.ibm.com>
Cc: Steve Wise <swise@opengridcomputing.com>, linuxppc-dev@lists.ozlabs.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit fe3cc0d99de6a9bf99b6c279a8afb5833888c1f7 ("powerpc: Add
pgprot_writecombine") in benh's tree exposes the pgprot_writecombine()
API to drivers on powerpc. cxgb4 has an open-coded version of the same,
so use the common API now that it's available.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Steve Wise <swise@opengridcomputing.com>
Cc: Anton Blanchard <anton@samba.org>

---

Given that this depends on a patch in Ben's tree, should this go in via
the powerpc tree? Presuming Steve acks it, of course.

 drivers/infiniband/hw/cxgb4/t4.h |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/t4.h b/drivers/infiniband/hw/cxgb4/t4.h
index 7000442..2fce083 100644
--- a/drivers/infiniband/hw/cxgb4/t4.h
+++ b/drivers/infiniband/hw/cxgb4/t4.h
@@ -269,11 +269,8 @@ struct t4_swsqe {
 
 static inline pgprot_t t4_pgprot_wc(pgprot_t prot)
 {
-#if defined(__i386__) || defined(__x86_64__)
+#if defined(__i386__) || defined(__x86_64__) || defined(CONFIG_PPC64)
 	return pgprot_writecombine(prot);
-#elif defined(CONFIG_PPC64)
-	return __pgprot((pgprot_val(prot) | _PAGE_NO_CACHE) &
-			~(pgprot_t)_PAGE_GUARDED);
 #else
 	return pgprot_noncached(prot);
 #endif
-- 
1.7.1
