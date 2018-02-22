Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmyCq2Mz8zF13W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 12:57:27 +1100 (AEDT)
Received: by mail-qk0-x243.google.com with SMTP id l206so4652659qke.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 17:57:27 -0800 (PST)
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
Subject: [PATCH v12 20/22] selftests/vm: testcases must restore
 pkey-permissions
Date: Wed, 21 Feb 2018 17:55:39 -0800
Message-Id: <1519264541-7621-21-git-send-email-linuxram@us.ibm.com>
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

Generally the signal handler restores the state of the pkey register
before returning. However there are times when the read/write operation
can legitamely fail without invoking the signal handler.  Eg: A
sys_read() operaton to a write-protected page should be disallowed.  In
such a case the state of the pkey register is not restored to its
original state.  The test case is responsible for restoring the key
register state to its original value.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 437ee74..42c068a 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1003,6 +1003,7 @@ void test_read_of_write_disabled_region(int *ptr, u16 pkey)
 	ptr_contents = read_ptr(ptr);
 	dprintf1("*ptr: %d\n", ptr_contents);
 	dprintf1("\n");
+	pkey_write_allow(pkey);
 }
 void test_read_of_access_disabled_region(int *ptr, u16 pkey)
 {
@@ -1082,6 +1083,7 @@ void test_kernel_write_of_access_disabled_region(int *ptr, u16 pkey)
 	ret = read(test_fd, ptr, 1);
 	dprintf1("read ret: %d\n", ret);
 	pkey_assert(ret);
+	pkey_access_allow(pkey);
 }
 void test_kernel_write_of_write_disabled_region(int *ptr, u16 pkey)
 {
@@ -1094,6 +1096,7 @@ void test_kernel_write_of_write_disabled_region(int *ptr, u16 pkey)
 	if (ret < 0 && (DEBUG_LEVEL > 0))
 		perror("verbose read result (OK for this to be bad)");
 	pkey_assert(ret);
+	pkey_write_allow(pkey);
 }
 
 void test_kernel_gup_of_access_disabled_region(int *ptr, u16 pkey)
@@ -1113,6 +1116,7 @@ void test_kernel_gup_of_access_disabled_region(int *ptr, u16 pkey)
 	vmsplice_ret = vmsplice(pipe_fds[1], &iov, 1, SPLICE_F_GIFT);
 	dprintf1("vmsplice() ret: %d\n", vmsplice_ret);
 	pkey_assert(vmsplice_ret == -1);
+	pkey_access_allow(pkey);
 
 	close(pipe_fds[0]);
 	close(pipe_fds[1]);
@@ -1133,6 +1137,7 @@ void test_kernel_gup_write_to_write_disabled_region(int *ptr, u16 pkey)
 	if (DEBUG_LEVEL > 0)
 		perror("futex");
 	dprintf1("futex() ret: %d\n", futex_ret);
+	pkey_write_allow(pkey);
 }
 
 /* Assumes that all pkeys other than 'pkey' are unallocated */
-- 
1.7.1
