Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmyCx1NRbzF13M
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 12:57:33 +1100 (AEDT)
Received: by mail-qk0-x241.google.com with SMTP id f25so4649035qkm.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 17:57:33 -0800 (PST)
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
Subject: [PATCH v12 22/22] selftests/vm: Fix deadlock in protection_keys.c
Date: Wed, 21 Feb 2018 17:55:41 -0800
Message-Id: <1519264541-7621-23-git-send-email-linuxram@us.ibm.com>
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

From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

The sig_chld() handler calls dprintf2() taking care of setting
dprint_in_signal so that sigsafe_printf() won't call printf().
Unfortunately, this precaution is is negated by dprintf_level(), which
has a call to fflush().

This function acquires a lock, which means that if the signal interrupts an
ongoing fflush() the process will deadlock. At least on powerpc this is
easy to trigger, resulting in the following backtrace when attaching to the
frozen process:

  (gdb) bt
  #0  0x00007fff9f96c7d8 in __lll_lock_wait_private () from /lib64/power8/libc.so.6
  #1  0x00007fff9f8cba4c in _IO_flush_all_lockp () from /lib64/power8/libc.so.6
  #2  0x00007fff9f8cbd1c in __GI__IO_flush_all () from /lib64/power8/libc.so.6
  #3  0x00007fff9f8b7424 in fflush () from /lib64/power8/libc.so.6
  #4  0x00000000100504f8 in sig_chld (x=17) at protection_keys.c:283
  #5  <signal handler called>
  #6  0x00007fff9f8cb8ac in _IO_flush_all_lockp () from /lib64/power8/libc.so.6
  #7  0x00007fff9f8cbd1c in __GI__IO_flush_all () from /lib64/power8/libc.so.6
  #8  0x00007fff9f8b7424 in fflush () from /lib64/power8/libc.so.6
  #9  0x0000000010050b50 in pkey_get (pkey=7, flags=0) at protection_keys.c:379
  #10 0x0000000010050dc0 in pkey_disable_set (pkey=7, flags=2) at protection_keys.c:423
  #11 0x0000000010051414 in pkey_write_deny (pkey=7) at protection_keys.c:486
  #12 0x00000000100556bc in test_ptrace_of_child (ptr=0x7fff9f7f0000, pkey=7) at protection_keys.c:1288
  #13 0x0000000010055f60 in run_tests_once () at protection_keys.c:1414
  #14 0x00000000100561a4 in main () at protection_keys.c:1459

The fix is to refrain from calling fflush() when inside a signal handler.
The output may not be as pretty but at least the testcase will be able to
move on.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

 tools/testing/selftests/vm/pkey-helpers.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
 tools/testing/selftests/vm/pkey-helpers.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 67f9b0f..7240598 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -128,7 +128,8 @@ static inline void sigsafe_printf(const char *format, ...)
 #define dprintf_level(level, args...) do {	\
 	if (level <= DEBUG_LEVEL)		\
 		sigsafe_printf(args);		\
-	fflush(NULL);				\
+	if (!dprint_in_signal)			\
+		fflush(NULL);			\
 } while (0)
 #define dprintf0(args...) dprintf_level(0, args)
 #define dprintf1(args...) dprintf_level(1, args)
-- 
1.7.1
