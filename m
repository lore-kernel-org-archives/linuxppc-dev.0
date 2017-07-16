Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9CPg5CWLzDqmQ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jul 2017 14:00:23 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id v31so14710678qtb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2017 21:00:23 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org,
 corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
Subject: [RFC v6 56/62] selftest/vm: detect no key violation on a freed key
Date: Sat, 15 Jul 2017 20:56:58 -0700
Message-Id: <1500177424-13695-57-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

a access-denied key should not trigger any key violation
after the key has been freed.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index bf27bcd..47c23cc 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1026,6 +1026,30 @@ void test_read_of_access_disabled_region_with_page_already_mapped(int *ptr,
 	expected_pkey_fault(pkey);
 }
 
+void test_read_of_access_disabled_but_freed_key_region(int *ptr, u16 pkey)
+{
+	int ptr_contents;
+
+	dprintf1("disabling access to PKEY[%02d], doing read @ %p\n",
+			 pkey, ptr);
+
+	/* read the content */
+	ptr_contents = read_ptr(ptr);
+	do_not_expect_pkey_fault();
+
+	/* deny key access */
+	pkey_access_deny(pkey);
+	ptr_contents = read_ptr(ptr);
+	dprintf1("*ptr: %d\n", ptr_contents);
+	expected_pkey_fault(pkey);
+
+	/* free the key without restoring access */
+	pkey_access_deny(pkey);
+	sys_pkey_free(pkey);
+	ptr_contents = read_ptr(ptr);
+	do_not_expect_pkey_fault();
+}
+
 void test_write_of_write_disabled_region(int *ptr, u16 pkey)
 {
 	dprintf1("disabling write access to PKEY[%02d], doing write\n", pkey);
@@ -1333,6 +1357,7 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 	test_pkey_syscalls_on_non_allocated_pkey,
 	test_pkey_syscalls_bad_args,
 	test_pkey_alloc_exhaust,
+	test_read_of_access_disabled_but_freed_key_region,
 };
 
 void run_tests_once(void)
-- 
1.7.1
