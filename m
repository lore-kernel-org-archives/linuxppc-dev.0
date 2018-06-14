Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415lMD5mPszF07t
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 10:47:20 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id g14-v6so2701170qkm.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 17:47:20 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de,
 aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v13 17/24] selftests/vm: powerpc implementation to check
 support for pkey
Date: Wed, 13 Jun 2018 17:45:08 -0700
Message-Id: <1528937115-10132-18-git-send-email-linuxram@us.ibm.com>
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

pkey subsystem is supported if the hardware and kernel has support.
We determine that by checking if allocation of a key succeeds or not.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    |    2 ++
 tools/testing/selftests/vm/pkey-powerpc.h    |   14 ++++++++++++--
 tools/testing/selftests/vm/pkey-x86.h        |    8 ++++----
 tools/testing/selftests/vm/protection_keys.c |    9 +++++----
 4 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 321bbbd..288ccff 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -76,6 +76,8 @@ static inline void sigsafe_printf(const char *format, ...)
 
 __attribute__((noinline)) int read_ptr(int *ptr);
 void expected_pkey_fault(int pkey);
+int sys_pkey_alloc(unsigned long flags, u64 init_val);
+int sys_pkey_free(unsigned long pkey);
 
 #if defined(__i386__) || defined(__x86_64__) /* arch */
 #include "pkey-x86.h"
diff --git a/tools/testing/selftests/vm/pkey-powerpc.h b/tools/testing/selftests/vm/pkey-powerpc.h
index ec6f5d7..957f6f6 100644
--- a/tools/testing/selftests/vm/pkey-powerpc.h
+++ b/tools/testing/selftests/vm/pkey-powerpc.h
@@ -62,9 +62,19 @@ static inline void __write_pkey_reg(pkey_reg_t pkey_reg)
 			pkey_reg);
 }
 
-static inline int cpu_has_pku(void)
+static inline bool is_pkey_supported(void)
 {
-	return 1;
+	/*
+	 * No simple way to determine this.
+	 * Lets try allocating a key and see if it succeeds.
+	 */
+	int ret = sys_pkey_alloc(0, 0);
+
+	if (ret > 0) {
+		sys_pkey_free(ret);
+		return true;
+	}
+	return false;
 }
 
 static inline int arch_reserved_keys(void)
diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
index 95ee952..6820c10 100644
--- a/tools/testing/selftests/vm/pkey-x86.h
+++ b/tools/testing/selftests/vm/pkey-x86.h
@@ -105,7 +105,7 @@ static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
 #define X86_FEATURE_PKU        (1<<3) /* Protection Keys for Userspace */
 #define X86_FEATURE_OSPKE      (1<<4) /* OS Protection Keys Enable */
 
-static inline int cpu_has_pku(void)
+static inline bool is_pkey_supported(void)
 {
 	unsigned int eax;
 	unsigned int ebx;
@@ -118,13 +118,13 @@ static inline int cpu_has_pku(void)
 
 	if (!(ecx & X86_FEATURE_PKU)) {
 		dprintf2("cpu does not have PKU\n");
-		return 0;
+		return false;
 	}
 	if (!(ecx & X86_FEATURE_OSPKE)) {
 		dprintf2("cpu does not have OSPKE\n");
-		return 0;
+		return false;
 	}
-	return 1;
+	return true;
 }
 
 #define XSTATE_PKEY_BIT	(9)
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index ba184ca..cb81a47 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1393,8 +1393,8 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 	int size = PAGE_SIZE;
 	int sret;
 
-	if (cpu_has_pku()) {
-		dprintf1("SKIP: %s: no CPU support\n", __func__);
+	if (is_pkey_supported()) {
+		dprintf1("SKIP: %s: no CPU/kernel support\n", __func__);
 		return;
 	}
 
@@ -1458,12 +1458,13 @@ void run_tests_once(void)
 int main(void)
 {
 	int nr_iterations = 22;
+	int pkey_supported = is_pkey_supported();
 
 	setup_handlers();
 
-	printf("has pkey: %d\n", cpu_has_pku());
+	printf("has pkey: %s\n", pkey_supported ? "Yes" : "No");
 
-	if (!cpu_has_pku()) {
+	if (!pkey_supported) {
 		int size = PAGE_SIZE;
 		int *ptr;
 
-- 
1.7.1
