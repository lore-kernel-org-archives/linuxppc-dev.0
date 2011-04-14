Return-Path: <nacc@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 295F1B70FE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 15:46:05 +1000 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3E5Ox6j026438
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2011 01:24:59 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id AAEFB38C803C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 01:45:52 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3E5k2E0304972
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2011 01:46:02 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p3E5k2KO003447
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2011 01:46:02 -0400
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH v4] powerpc: use a kmem cache for DTL buffers
Date: Wed, 13 Apr 2011 22:45:59 -0700
Message-Id: <1302759959-31467-1-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1302758026-29313-1-git-send-email-nacc@us.ibm.com>
References: <1302758026-29313-1-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PAPR specifies that DTL buffers can not cross AMS environments (aka CMO
in the PAPR) and can not cross a memory entitlement granule boundary
(4k). This is found in section 14.11.3.2 H_REGISTER_VPA of the PAPR.
kmalloc does not guarantee an alignment of the allocation, though,
beyond 8 bytes (at least in my understanding). Create a special kmem
cache for DTL buffers with the alignment requirement.

---
Change from v1: removed extraneous #include.
Change from v2: instead of overallocating and aligning, use a kmem cache
Change from v3: handle cache creation failure

Note, I initially put this in a firmware check if-block, but we have
also seen some issues with alignment with non-AMS partitions. The wasted
memory is unfortunate, though.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ben Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org

 arch/powerpc/platforms/pseries/setup.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 0007241..9e20b83 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -287,14 +287,22 @@ static int alloc_dispatch_logs(void)
 	int cpu, ret;
 	struct paca_struct *pp;
 	struct dtl_entry *dtl;
+	struct kmem_cache *dtl_cache;
 
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return 0;
 
+	dtl_cache = kmem_cache_create("dtl", DISPATCH_LOG_BYTES,
+						DISPATCH_LOG_BYTES, 0, NULL); 
+	if (!dtl_cache) {
+		pr_warn("Failed to create dispatch trace log buffer cache\n");
+		pr_warn("Stolen time statistics will be unreliable\n");
+		return 0;
+	}
+
 	for_each_possible_cpu(cpu) {
 		pp = &paca[cpu];
-		dtl = kmalloc_node(DISPATCH_LOG_BYTES, GFP_KERNEL,
-				   cpu_to_node(cpu));
+		dtl = kmem_cache_alloc(dtl_cache, GFP_KERNEL);
 		if (!dtl) {
 			pr_warn("Failed to allocate dispatch trace log for cpu %d\n",
 				cpu);
-- 
1.7.4.1
