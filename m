Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415lMG2gSpzF07t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 10:47:22 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id c198-v6so2685801qkg.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 17:47:22 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de,
 aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v13 18/24] selftests/vm: fix an assertion in
 test_pkey_alloc_exhaust()
Date: Wed, 13 Jun 2018 17:45:09 -0700
Message-Id: <1528937115-10132-19-git-send-email-linuxram@us.ibm.com>
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

The maximum number of keys that can be allocated has to
take into consideration, that some keys are reserved by
the architecture for   specific   purpose. Hence cannot
be allocated.

Fix the assertion in test_pkey_alloc_exhaust()

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index cb81a47..e8ad970 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1175,15 +1175,12 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	pkey_assert(i < NR_PKEYS*2);
 
 	/*
-	 * There are 16 pkeys supported in hardware.  Three are
-	 * allocated by the time we get here:
-	 *   1. The default key (0)
-	 *   2. One possibly consumed by an execute-only mapping.
-	 *   3. One allocated by the test code and passed in via
-	 *      'pkey' to this function.
-	 * Ensure that we can allocate at least another 13 (16-3).
+	 * There are NR_PKEYS pkeys supported in hardware. arch_reserved_keys()
+	 * are reserved. One of which is the default key(0). One can be taken
+	 * up by an execute-only mapping.
+	 * Ensure that we can allocate at least the remaining.
 	 */
-	pkey_assert(i >= NR_PKEYS-3);
+	pkey_assert(i >= (NR_PKEYS-arch_reserved_keys()-1));
 
 	for (i = 0; i < nr_allocated_pkeys; i++) {
 		err = sys_pkey_free(allocated_pkeys[i]);
-- 
1.7.1
