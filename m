Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VM9z2WfmzF3Hw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 23:50:47 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id y5-v6so876956qti.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 06:50:47 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de,
 aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v14 20/22] selftests/vm: testcases must restore
 pkey-permissions
Date: Tue, 17 Jul 2018 06:49:23 -0700
Message-Id: <1531835365-32387-21-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
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
original state.  Test cases may not remember to restoring the key
register state. During cleanup generically restore the key permissions.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 8a6afdd..ea3cf04 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1476,8 +1476,13 @@ void run_tests_once(void)
 		pkey_tests[test_nr](ptr, pkey);
 		dprintf1("freeing test memory: %p\n", ptr);
 		free_pkey_malloc(ptr);
+
+		/* restore the permission on the key after use */
+		pkey_access_allow(pkey);
+		pkey_write_allow(pkey);
 		sys_pkey_free(pkey);
 
+
 		dprintf1("pkey_faults: %d\n", pkey_faults);
 		dprintf1("orig_pkey_faults: %d\n", orig_pkey_faults);
 
-- 
1.7.1
