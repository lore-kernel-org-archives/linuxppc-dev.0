Return-Path: <SRS0=gJAX=2I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B59C43603
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 08:28:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD92920717
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 08:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD92920717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47d7S54XzTzDqCF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 19:28:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=sandipan@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47d6gb5nlrzDqKV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2019 18:52:59 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBI7qTK7002240
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2019 02:52:57 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wy705fwgw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2019 02:52:57 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Wed, 18 Dec 2019 07:52:54 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 18 Dec 2019 07:52:50 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBI7qmEr44892412
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2019 07:52:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACECDAE04D;
 Wed, 18 Dec 2019 07:52:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63319AE045;
 Wed, 18 Dec 2019 07:52:46 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 18 Dec 2019 07:52:46 +0000 (GMT)
From: Sandipan Das <sandipan@linux.ibm.com>
To: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Subject: [PATCH v15 19/23] selftests/vm/pkeys: Introduce a sub-page allocator
Date: Wed, 18 Dec 2019 13:21:52 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576645161.git.sandipan@linux.ibm.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1576645161.git.sandipan@linux.ibm.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19121807-0028-0000-0000-000003C9CAEB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121807-0029-0000-0000-0000248D1635
Message-Id: <299a88ab295be71c4394d42787e41a8bc74f5542.1576645161.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_01:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=2 mlxscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912180063
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
Cc: linux-arch@vger.kernel.org, fweimer@redhat.com, linux-mm@kvack.org,
 aneesh.kumar@linux.ibm.com, x86@kernel.org, linuxram@us.ibm.com,
 mhocko@kernel.org, dave.hansen@intel.com, mingo@redhat.com, msuchanek@suse.de,
 linuxppc-dev@lists.ozlabs.org, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Ram Pai <linuxram@us.ibm.com>

This introduces a new allocator that allocates 4K hardware
pages to back 64K linux pages. This allocator is available
only on powerpc.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    |  6 +++++
 tools/testing/selftests/vm/pkey-powerpc.h    | 25 ++++++++++++++++++++
 tools/testing/selftests/vm/pkey-x86.h        |  5 ++++
 tools/testing/selftests/vm/protection_keys.c |  1 +
 4 files changed, 37 insertions(+)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 43299435f24c..6a03faf1ef44 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -28,6 +28,9 @@
 extern int dprint_in_signal;
 extern char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
 
+extern int test_nr;
+extern int iteration_nr;
+
 #ifdef __GNUC__
 __attribute__((format(printf, 1, 2)))
 #endif
@@ -78,6 +81,9 @@ __attribute__((noinline)) int read_ptr(int *ptr);
 void expected_pkey_fault(int pkey);
 int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 int sys_pkey_free(unsigned long pkey);
+int mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
+		unsigned long pkey);
+void record_pkey_malloc(void *ptr, long size, int prot);
 
 #if defined(__i386__) || defined(__x86_64__) /* arch */
 #include "pkey-x86.h"
diff --git a/tools/testing/selftests/vm/pkey-powerpc.h b/tools/testing/selftests/vm/pkey-powerpc.h
index a43d7be85a27..f7a20bd07870 100644
--- a/tools/testing/selftests/vm/pkey-powerpc.h
+++ b/tools/testing/selftests/vm/pkey-powerpc.h
@@ -91,4 +91,29 @@ void expect_fault_on_read_execonly_key(void *p1, int pkey)
 /* 8-bytes of instruction * 16384bytes = 1 page */
 #define __page_o_noops() asm(".rept 16384 ; nop; .endr")
 
+void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
+{
+	void *ptr;
+	int ret;
+
+	dprintf1("doing %s(size=%ld, prot=0x%x, pkey=%d)\n", __func__,
+			size, prot, pkey);
+	pkey_assert(pkey < NR_PKEYS);
+	ptr = mmap(NULL, size, prot, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	pkey_assert(ptr != (void *)-1);
+
+	ret = syscall(__NR_subpage_prot, ptr, size, NULL);
+	if (ret) {
+		perror("subpage_perm");
+		return PTR_ERR_ENOTSUP;
+	}
+
+	ret = mprotect_pkey((void *)ptr, PAGE_SIZE, prot, pkey);
+	pkey_assert(!ret);
+	record_pkey_malloc(ptr, size, prot);
+
+	dprintf1("%s() for pkey %d @ %p\n", __func__, pkey, ptr);
+	return ptr;
+}
+
 #endif /* _PKEYS_POWERPC_H */
diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
index e5fdee39a7d8..87b85f60b43f 100644
--- a/tools/testing/selftests/vm/pkey-x86.h
+++ b/tools/testing/selftests/vm/pkey-x86.h
@@ -175,4 +175,9 @@ void expect_fault_on_read_execonly_key(void *p1, int pkey)
 	expected_pkey_fault(pkey);
 }
 
+void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
+{
+	return PTR_ERR_ENOTSUP;
+}
+
 #endif /* _PKEYS_X86_H */
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 176625ded549..5faf52ba7b8f 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -844,6 +844,7 @@ void *malloc_pkey_mmap_dax(long size, int prot, u16 pkey)
 void *(*pkey_malloc[])(long size, int prot, u16 pkey) = {
 
 	malloc_pkey_with_mprotect,
+	malloc_pkey_with_mprotect_subpage,
 	malloc_pkey_anon_huge,
 	malloc_pkey_hugetlb
 /* can not do direct with the pkey_mprotect() API:
-- 
2.17.1

