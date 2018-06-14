Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415lMV5xTtzDrvG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 10:47:32 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id 185-v6so2688079qkk.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 17:47:32 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de,
 aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v13 23/24] selftests/vm: sub-page allocator
Date: Wed, 13 Jun 2018 17:45:14 -0700
Message-Id: <1528937115-10132-24-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
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
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    |    6 ++++++
 tools/testing/selftests/vm/pkey-powerpc.h    |   25 +++++++++++++++++++++++++
 tools/testing/selftests/vm/pkey-x86.h        |    5 +++++
 tools/testing/selftests/vm/protection_keys.c |    1 +
 4 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 288ccff..a00eee6 100644
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
@@ -78,6 +81,9 @@ static inline void sigsafe_printf(const char *format, ...)
 void expected_pkey_fault(int pkey);
 int sys_pkey_alloc(unsigned long flags, u64 init_val);
 int sys_pkey_free(unsigned long pkey);
+int mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
+		unsigned long pkey);
+void record_pkey_malloc(void *ptr, long size, int prot);
 
 #if defined(__i386__) || defined(__x86_64__) /* arch */
 #include "pkey-x86.h"
diff --git a/tools/testing/selftests/vm/pkey-powerpc.h b/tools/testing/selftests/vm/pkey-powerpc.h
index 957f6f6..af44eed 100644
--- a/tools/testing/selftests/vm/pkey-powerpc.h
+++ b/tools/testing/selftests/vm/pkey-powerpc.h
@@ -98,4 +98,29 @@ void expect_fault_on_read_execonly_key(void *p1, u16 pkey)
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
index 6820c10..322da49 100644
--- a/tools/testing/selftests/vm/pkey-x86.h
+++ b/tools/testing/selftests/vm/pkey-x86.h
@@ -176,4 +176,9 @@ void expect_fault_on_read_execonly_key(void *p1, u16 pkey)
 	expected_pkey_fault(pkey);
 }
 
+void *malloc_pkey_with_mprotect_subpage(long size, int prot, u16 pkey)
+{
+	return PTR_ERR_ENOTSUP;
+}
+
 #endif /* _PKEYS_X86_H */
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index b5a9e6c..cbd87f8 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -887,6 +887,7 @@ void setup_hugetlbfs(void)
 void *(*pkey_malloc[])(long size, int prot, u16 pkey) = {
 
 	malloc_pkey_with_mprotect,
+	malloc_pkey_with_mprotect_subpage,
 	malloc_pkey_anon_huge,
 	malloc_pkey_hugetlb
 /* can not do direct with the pkey_mprotect() API:
-- 
1.7.1
