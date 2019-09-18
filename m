Return-Path: <SRS0=xS+q=XN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982E1C4CEC9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Sep 2019 05:29:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2033B20856
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Sep 2019 05:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2033B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Y7nk6qf5zF3dJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Sep 2019 15:29:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=au1.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=au1.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Y7d04SvvzF4HC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2019 15:21:40 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8I5HSBj083065
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2019 01:21:38 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v3bdknaap-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2019 01:21:37 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 18 Sep 2019 06:21:35 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 18 Sep 2019 06:21:31 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8I5LUXl24838250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Sep 2019 05:21:30 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 921B1AE04D;
 Wed, 18 Sep 2019 05:21:30 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02725AE056;
 Wed, 18 Sep 2019 05:21:30 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 18 Sep 2019 05:21:29 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A96B3A01E6;
 Wed, 18 Sep 2019 15:21:28 +1000 (AEST)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: alastair@d-silva.org
Subject: [PATCH v3 2/5] powerpc: define helpers to get L1 icache sizes
Date: Wed, 18 Sep 2019 15:20:56 +1000
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918052106.14113-1-alastair@au1.ibm.com>
References: <20190918052106.14113-1-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091805-4275-0000-0000-00000367E284
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091805-4276-0000-0000-0000387A49E4
Message-Id: <20190918052106.14113-3-alastair@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-18_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=864 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909180056
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Qian Cai <cai@lca.pw>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Alastair D'Silva <alastair@d-silva.org>

This patch adds helpers to retrieve icache sizes, and renames the existing
helpers to make it clear that they are for dcache.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/include/asm/cache.h      | 29 +++++++++++++++++++++++----
 arch/powerpc/include/asm/cacheflush.h | 12 +++++------
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index b3388d95f451..f852d5cd746c 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -55,25 +55,46 @@ struct ppc64_caches {
 
 extern struct ppc64_caches ppc64_caches;
 
-static inline u32 l1_cache_shift(void)
+static inline u32 l1_dcache_shift(void)
 {
 	return ppc64_caches.l1d.log_block_size;
 }
 
-static inline u32 l1_cache_bytes(void)
+static inline u32 l1_dcache_bytes(void)
 {
 	return ppc64_caches.l1d.block_size;
 }
+
+static inline u32 l1_icache_shift(void)
+{
+	return ppc64_caches.l1i.log_block_size;
+}
+
+static inline u32 l1_icache_bytes(void)
+{
+	return ppc64_caches.l1i.block_size;
+}
 #else
-static inline u32 l1_cache_shift(void)
+static inline u32 l1_dcache_shift(void)
 {
 	return L1_CACHE_SHIFT;
 }
 
-static inline u32 l1_cache_bytes(void)
+static inline u32 l1_dcache_bytes(void)
 {
 	return L1_CACHE_BYTES;
 }
+
+static inline u32 l1_icache_shift(void)
+{
+	return L1_CACHE_SHIFT;
+}
+
+static inline u32 l1_icache_bytes(void)
+{
+	return L1_CACHE_BYTES;
+}
+
 #endif
 #endif /* ! __ASSEMBLY__ */
 
diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index eef388f2659f..ed57843ef452 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -63,8 +63,8 @@ static inline void __flush_dcache_icache_phys(unsigned long physaddr)
  */
 static inline void flush_dcache_range(unsigned long start, unsigned long stop)
 {
-	unsigned long shift = l1_cache_shift();
-	unsigned long bytes = l1_cache_bytes();
+	unsigned long shift = l1_dcache_shift();
+	unsigned long bytes = l1_dcache_bytes();
 	void *addr = (void *)(start & ~(bytes - 1));
 	unsigned long size = stop - (unsigned long)addr + (bytes - 1);
 	unsigned long i;
@@ -89,8 +89,8 @@ static inline void flush_dcache_range(unsigned long start, unsigned long stop)
  */
 static inline void clean_dcache_range(unsigned long start, unsigned long stop)
 {
-	unsigned long shift = l1_cache_shift();
-	unsigned long bytes = l1_cache_bytes();
+	unsigned long shift = l1_dcache_shift();
+	unsigned long bytes = l1_dcache_bytes();
 	void *addr = (void *)(start & ~(bytes - 1));
 	unsigned long size = stop - (unsigned long)addr + (bytes - 1);
 	unsigned long i;
@@ -108,8 +108,8 @@ static inline void clean_dcache_range(unsigned long start, unsigned long stop)
 static inline void invalidate_dcache_range(unsigned long start,
 					   unsigned long stop)
 {
-	unsigned long shift = l1_cache_shift();
-	unsigned long bytes = l1_cache_bytes();
+	unsigned long shift = l1_dcache_shift();
+	unsigned long bytes = l1_dcache_bytes();
 	void *addr = (void *)(start & ~(bytes - 1));
 	unsigned long size = stop - (unsigned long)addr + (bytes - 1);
 	unsigned long i;
-- 
2.21.0

