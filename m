Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415lMQ2vjkzF09h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 10:47:30 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id j80-v6so2690414qke.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 17:47:30 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de,
 aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v13 22/24] selftests/vm: testcases must restore
 pkey-permissions
Date: Wed, 13 Jun 2018 17:45:13 -0700
Message-Id: <1528937115-10132-23-git-send-email-linuxram@us.ibm.com>
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
index caf634e..b5a9e6c 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1011,6 +1011,7 @@ void test_read_of_write_disabled_region(int *ptr, u16 pkey)
 	ptr_contents = read_ptr(ptr);
 	dprintf1("*ptr: %d\n", ptr_contents);
 	dprintf1("\n");
+	pkey_write_allow(pkey);
 }
 void test_read_of_access_disabled_region(int *ptr, u16 pkey)
 {
@@ -1090,6 +1091,7 @@ void test_kernel_write_of_access_disabled_region(int *ptr, u16 pkey)
 	ret = read(test_fd, ptr, 1);
 	dprintf1("read ret: %d\n", ret);
 	pkey_assert(ret);
+	pkey_access_allow(pkey);
 }
 void test_kernel_write_of_write_disabled_region(int *ptr, u16 pkey)
 {
@@ -1102,6 +1104,7 @@ void test_kernel_write_of_write_disabled_region(int *ptr, u16 pkey)
 	if (ret < 0 && (DEBUG_LEVEL > 0))
 		perror("verbose read result (OK for this to be bad)");
 	pkey_assert(ret);
+	pkey_write_allow(pkey);
 }
 
 void test_kernel_gup_of_access_disabled_region(int *ptr, u16 pkey)
@@ -1121,6 +1124,7 @@ void test_kernel_gup_of_access_disabled_region(int *ptr, u16 pkey)
 	vmsplice_ret = vmsplice(pipe_fds[1], &iov, 1, SPLICE_F_GIFT);
 	dprintf1("vmsplice() ret: %d\n", vmsplice_ret);
 	pkey_assert(vmsplice_ret == -1);
+	pkey_access_allow(pkey);
 
 	close(pipe_fds[0]);
 	close(pipe_fds[1]);
@@ -1141,6 +1145,7 @@ void test_kernel_gup_write_to_write_disabled_region(int *ptr, u16 pkey)
 	if (DEBUG_LEVEL > 0)
 		perror("futex");
 	dprintf1("futex() ret: %d\n", futex_ret);
+	pkey_write_allow(pkey);
 }
 
 /* Assumes that all pkeys other than 'pkey' are unallocated */
-- 
1.7.1
