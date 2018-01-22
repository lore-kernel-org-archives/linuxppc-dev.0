Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQLDc3RrVzF0VX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 05:53:36 +1100 (AEDT)
Received: by mail-qt0-x244.google.com with SMTP id g14so14270623qti.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 10:53:36 -0800 (PST)
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
Subject: [PATCH v10 16/24] selftests/vm: fix an assertion in
 test_pkey_alloc_exhaust()
Date: Mon, 22 Jan 2018 10:52:09 -0800
Message-Id: <1516647137-11174-17-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1516647137-11174-1-git-send-email-linuxram@us.ibm.com>
References: <1516647137-11174-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The maximum number of keys that can be allocated has to
take into consideration, that some keys are reserved by
the architecture for   specific   purpose. Hence cannot
be allocated.

Fix the assertion in test_pkey_alloc_exhaust()

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    |   14 ++++++++++++++
 tools/testing/selftests/vm/protection_keys.c |    9 ++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 3559527..9d06b4a 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -401,4 +401,18 @@ static inline int get_start_key(void)
 #endif /* arch */
 }
 
+static inline int arch_reserved_keys(void)
+{
+#if defined(__i386__) || defined(__x86_64__) /* arch */
+	return NR_RESERVED_PKEYS;
+#elif __powerpc64__ /* arch */
+	if (sysconf(_SC_PAGESIZE) == 4096)
+		return NR_RESERVED_PKEYS_4K;
+	else
+		return NR_RESERVED_PKEYS_64K;
+#else /* arch */
+	NOT SUPPORTED
+#endif /* arch */
+}
+
 #endif /* _PKEYS_HELPER_H */
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 65e6dd6..33d5839 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1167,12 +1167,11 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	pkey_assert(i < NR_PKEYS*2);
 
 	/*
-	 * There are 16 pkeys supported in hardware.  One is taken
-	 * up for the default (0) and another can be taken up by
-	 * an execute-only mapping.  Ensure that we can allocate
-	 * at least 14 (16-2).
+	 * There are NR_PKEYS pkeys supported in hardware. arch_reserved_keys()
+	 * are reserved. One   can   be   taken   up by an execute-only mapping.
+	 * Ensure that we can allocate at least the remaining.
 	 */
-	pkey_assert(i >= NR_PKEYS-2);
+	pkey_assert(i >= (NR_PKEYS-arch_reserved_keys()-1));
 
 	for (i = 0; i < nr_allocated_pkeys; i++) {
 		err = sys_pkey_free(allocated_pkeys[i]);
-- 
1.7.1
