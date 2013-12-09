Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 53C152C00A3
 for <linuxppc-dev@ozlabs.org>; Mon,  9 Dec 2013 21:04:29 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 9 Dec 2013 20:04:04 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 000F03578023
 for <linuxppc-dev@ozlabs.org>; Mon,  9 Dec 2013 21:04:01 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rB99jpP964946402
 for <linuxppc-dev@ozlabs.org>; Mon, 9 Dec 2013 20:45:52 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB9A41Oa002901
 for <linuxppc-dev@ozlabs.org>; Mon, 9 Dec 2013 21:04:01 +1100
Subject: [PATCH] powerpc: Fix up the kdump base cap to 128M
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 09 Dec 2013 15:33:39 +0530
Message-ID: <20131209100329.5034.85208.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

The current logic sets the kdump base to min of 2G or ppc64_rma_size/2.
On PowerNV kernel the first memory block 'memory@0' can be very large,
equal to the DIMM size with ppc64_rma_size value capped to 1G. Hence on
PowerNV, kdump base is set to 512M resulting kdump to fail while allocating
paca array. This is because, paca need its memory from RMA region capped
at 256M (see allocate_pacas()).

This patch lowers the kdump base cap to 128M so that kdump kernel can
successfully get memory below 256M for paca allocation.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/machine_kexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 88a7fb4..75d4f73 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -148,7 +148,7 @@ void __init reserve_crashkernel(void)
 		 * a small SLB (128MB) since the crash kernel needs to place
 		 * itself and some stacks to be in the first segment.
 		 */
-		crashk_res.start = min(0x80000000ULL, (ppc64_rma_size / 2));
+		crashk_res.start = min(0x8000000ULL, (ppc64_rma_size / 2));
 #else
 		crashk_res.start = KDUMP_KERNELBASE;
 #endif
