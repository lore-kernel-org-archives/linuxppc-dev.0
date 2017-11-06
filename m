Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVmjV40tCzDr5T
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 20:00:14 +1100 (AEDT)
Received: by mail-qk0-x244.google.com with SMTP id y23so9992288qkb.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 01:00:14 -0800 (PST)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: [PATCH v9 41/51] selftest/vm: introduce two arch independent
 abstraction
Date: Mon,  6 Nov 2017 00:57:33 -0800
Message-Id: <1509958663-18737-42-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

open_hugepage_file() <- opens the huge page file
get_start_key() <--  provides the first non-reserved key.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    |   11 +++++++++++
 tools/testing/selftests/vm/protection_keys.c |    6 +++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index d521f53..30755be 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -301,3 +301,14 @@ static inline void __page_o_noops(void)
 	}					\
 } while (0)
 #define raw_assert(cond) assert(cond)
+
+static inline int open_hugepage_file(int flag)
+{
+	return open("/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages",
+		 O_RDONLY);
+}
+
+static inline int get_start_key(void)
+{
+	return 1;
+}
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 1a14027..19ae991 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -809,7 +809,7 @@ void setup_hugetlbfs(void)
 	 * Now go make sure that we got the pages and that they
 	 * are 2M pages.  Someone might have made 1G the default.
 	 */
-	fd = open("/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages", O_RDONLY);
+	fd = open_hugepage_file(O_RDONLY);
 	if (fd < 0) {
 		perror("opening sysfs 2M hugetlb config");
 		return;
@@ -1087,10 +1087,10 @@ void test_kernel_gup_write_to_write_disabled_region(int *ptr, u16 pkey)
 void test_pkey_syscalls_on_non_allocated_pkey(int *ptr, u16 pkey)
 {
 	int err;
-	int i;
+	int i = get_start_key();
 
 	/* Note: 0 is the default pkey, so don't mess with it */
-	for (i = 1; i < NR_PKEYS; i++) {
+	for (; i < NR_PKEYS; i++) {
 		if (pkey == i)
 			continue;
 
-- 
1.7.1
