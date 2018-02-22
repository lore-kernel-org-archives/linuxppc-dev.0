Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmyCv4BDBzF132
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 12:57:31 +1100 (AEDT)
Received: by mail-qt0-x244.google.com with SMTP id g14so4515152qti.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 17:57:31 -0800 (PST)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com,
 arnd@arndb.de
Subject: [PATCH v12 21/22] selftests/vm: sub-page allocator
Date: Wed, 21 Feb 2018 17:55:40 -0800
Message-Id: <1519264541-7621-22-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

introduce a new allocator that allocates 4k hardware-pages to back
64k linux-page. This allocator is only applicable on powerpc.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |   30 ++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 42c068a..1b06e59 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -766,6 +766,35 @@ void free_pkey_malloc(void *ptr)
 	return ptr;
 }
 
+void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
+{
+#ifdef __powerpc64__
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
+	record_pkey_malloc(ptr, size);
+
+	dprintf1("%s() for pkey %d @ %p\n", __func__, pkey, ptr);
+	return ptr;
+#else /*  __powerpc64__ */
+	return PTR_ERR_ENOTSUP;
+#endif /*  __powerpc64__ */
+}
+
 void *malloc_pkey_anon_huge(long size, int prot, u16 pkey)
 {
 	int ret;
@@ -888,6 +917,7 @@ void setup_hugetlbfs(void)
 void *(*pkey_malloc[])(long size, int prot, u16 pkey) = {
 
 	malloc_pkey_with_mprotect,
+	malloc_pkey_with_mprotect_subpage,
 	malloc_pkey_anon_huge,
 	malloc_pkey_hugetlb
 /* can not do direct with the pkey_mprotect() API:
-- 
1.7.1
