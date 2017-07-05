Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2v4z173mzDr3s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 07:24:03 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id w12so192975qta.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 14:24:03 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org,
 corbet@lwn.net, mingo@redhat.com
Subject: [RFC v5 38/38] Documentation: PowerPC specific updates to memory
 protection keys
Date: Wed,  5 Jul 2017 14:22:15 -0700
Message-Id: <1499289735-14220-39-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add documentation updates that capture PowerPC specific changes.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 Documentation/vm/protection-keys.txt |   85 ++++++++++++++++++++++++++--------
 1 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/Documentation/vm/protection-keys.txt b/Documentation/vm/protection-keys.txt
index b643045..d50b6ab 100644
--- a/Documentation/vm/protection-keys.txt
+++ b/Documentation/vm/protection-keys.txt
@@ -1,21 +1,46 @@
-Memory Protection Keys for Userspace (PKU aka PKEYs) is a CPU feature
-which will be found on future Intel CPUs.
+Memory Protection Keys for Userspace (PKU aka PKEYs) is a CPU feature found in
+new generation of intel CPUs and on PowerPC 7 and higher CPUs.
 
 Memory Protection Keys provides a mechanism for enforcing page-based
-protections, but without requiring modification of the page tables
-when an application changes protection domains.  It works by
-dedicating 4 previously ignored bits in each page table entry to a
-"protection key", giving 16 possible keys.
-
-There is also a new user-accessible register (PKRU) with two separate
-bits (Access Disable and Write Disable) for each key.  Being a CPU
-register, PKRU is inherently thread-local, potentially giving each
-thread a different set of protections from every other thread.
-
-There are two new instructions (RDPKRU/WRPKRU) for reading and writing
-to the new register.  The feature is only available in 64-bit mode,
-even though there is theoretically space in the PAE PTEs.  These
-permissions are enforced on data access only and have no effect on
+protections, but without requiring modification of the page tables when an
+application changes protection domains.
+
+
+On Intel:
+
+	It works by dedicating 4 previously ignored bits in each page table
+	entry to a "protection key", giving 16 possible keys.
+
+	There is also a new user-accessible register (PKRU) with two separate
+	bits (Access Disable and Write Disable) for each key.  Being a CPU
+	register, PKRU is inherently thread-local, potentially giving each
+	thread a different set of protections from every other thread.
+
+	There are two new instructions (RDPKRU/WRPKRU) for reading and writing
+	to the new register.  The feature is only available in 64-bit mode,
+	even though there is theoretically space in the PAE PTEs.  These
+	permissions are enforced on data access only and have no effect on
+	instruction fetches.
+
+
+On PowerPC:
+
+	It works by dedicating 5 page table entry bits to a "protection key",
+	giving 32 possible keys.
+
+	There  is  a  user-accessible  register (AMR)  with  two separate bits;
+	Access Disable and  Write  Disable, for  each key.  Being  a  CPU
+	register,  AMR  is inherently  thread-local,  potentially  giving  each
+	thread a different set of protections from every other thread.  NOTE:
+	Disabling read permission does not disable write and vice-versa.
+
+	The feature is available on 64-bit HPTE mode only.
+	'mtspr 0xd, mem' reads the AMR register
+	'mfspr mem, 0xd' writes into the AMR register.
+
+
+
+Permissions are enforced on data access only and have no effect on
 instruction fetches.
 
 =========================== Syscalls ===========================
@@ -28,9 +53,9 @@ There are 3 system calls which directly interact with pkeys:
 			  unsigned long prot, int pkey);
 
 Before a pkey can be used, it must first be allocated with
-pkey_alloc().  An application calls the WRPKRU instruction
+pkey_alloc().  An application calls the WRPKRU/AMR instruction
 directly in order to change access permissions to memory covered
-with a key.  In this example WRPKRU is wrapped by a C function
+with a key.  In this example WRPKRU/AMR is wrapped by a C function
 called pkey_set().
 
 	int real_prot = PROT_READ|PROT_WRITE;
@@ -52,11 +77,11 @@ is no longer in use:
 	munmap(ptr, PAGE_SIZE);
 	pkey_free(pkey);
 
-(Note: pkey_set() is a wrapper for the RDPKRU and WRPKRU instructions.
+(Note: pkey_set() is a wrapper for the RDPKRU,WRPKRU or AMR instructions.
  An example implementation can be found in
  tools/testing/selftests/x86/protection_keys.c)
 
-=========================== Behavior ===========================
+=========================== Behavior =================================
 
 The kernel attempts to make protection keys consistent with the
 behavior of a plain mprotect().  For instance if you do this:
@@ -83,3 +108,23 @@ with a read():
 The kernel will send a SIGSEGV in both cases, but si_code will be set
 to SEGV_PKERR when violating protection keys versus SEGV_ACCERR when
 the plain mprotect() permissions are violated.
+
+
+====================================================================
+		Semantic differences
+
+The following semantic differences exist between x86 and power.
+
+a) powerpc allows creation of a key with execute-disabled.  The following
+	is allowed on powerpc.
+	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE | PKEY_DISABLE_ACCESS |
+			PKEY_DISABLE_EXECUTE);
+   x86 disallows PKEY_DISABLE_EXECUTE during key creation.
+
+b) changing the permission bits of a key from a signal handler does not
+   persist on x86. The PKRU specific fpregs entry needs to be modified
+   for it to persist.  On powerpc the permission bits of the key can be
+   modified by programming the AMR register from the signal handler.
+   The changes persists across signal boundaries.
+
+=====================================================================
-- 
1.7.1
