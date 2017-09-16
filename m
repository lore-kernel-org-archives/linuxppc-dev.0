Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvDy14rYnzDrcM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 11:21:45 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id i14so2432927qke.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 18:21:45 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org
Cc: arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 5/6] Documentation/x86: Move protecton key documentation to
 arch neutral directory
Date: Fri, 15 Sep 2017 18:21:09 -0700
Message-Id: <1505524870-4783-6-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1505524870-4783-1-git-send-email-linuxram@us.ibm.com>
References: <1505524870-4783-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since PowerPC and Intel both support memory protection keys, moving
the documenation to arch-neutral directory.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 Documentation/vm/protection-keys.txt  |   85 +++++++++++++++++++++++++++++++++
 Documentation/x86/protection-keys.txt |   85 ---------------------------------
 2 files changed, 85 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/vm/protection-keys.txt
 delete mode 100644 Documentation/x86/protection-keys.txt

diff --git a/Documentation/vm/protection-keys.txt b/Documentation/vm/protection-keys.txt
new file mode 100644
index 0000000..b643045
--- /dev/null
+++ b/Documentation/vm/protection-keys.txt
@@ -0,0 +1,85 @@
+Memory Protection Keys for Userspace (PKU aka PKEYs) is a CPU feature
+which will be found on future Intel CPUs.
+
+Memory Protection Keys provides a mechanism for enforcing page-based
+protections, but without requiring modification of the page tables
+when an application changes protection domains.  It works by
+dedicating 4 previously ignored bits in each page table entry to a
+"protection key", giving 16 possible keys.
+
+There is also a new user-accessible register (PKRU) with two separate
+bits (Access Disable and Write Disable) for each key.  Being a CPU
+register, PKRU is inherently thread-local, potentially giving each
+thread a different set of protections from every other thread.
+
+There are two new instructions (RDPKRU/WRPKRU) for reading and writing
+to the new register.  The feature is only available in 64-bit mode,
+even though there is theoretically space in the PAE PTEs.  These
+permissions are enforced on data access only and have no effect on
+instruction fetches.
+
+=========================== Syscalls ===========================
+
+There are 3 system calls which directly interact with pkeys:
+
+	int pkey_alloc(unsigned long flags, unsigned long init_access_rights)
+	int pkey_free(int pkey);
+	int pkey_mprotect(unsigned long start, size_t len,
+			  unsigned long prot, int pkey);
+
+Before a pkey can be used, it must first be allocated with
+pkey_alloc().  An application calls the WRPKRU instruction
+directly in order to change access permissions to memory covered
+with a key.  In this example WRPKRU is wrapped by a C function
+called pkey_set().
+
+	int real_prot = PROT_READ|PROT_WRITE;
+	pkey = pkey_alloc(0, PKEY_DENY_WRITE);
+	ptr = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	ret = pkey_mprotect(ptr, PAGE_SIZE, real_prot, pkey);
+	... application runs here
+
+Now, if the application needs to update the data at 'ptr', it can
+gain access, do the update, then remove its write access:
+
+	pkey_set(pkey, 0); // clear PKEY_DENY_WRITE
+	*ptr = foo; // assign something
+	pkey_set(pkey, PKEY_DENY_WRITE); // set PKEY_DENY_WRITE again
+
+Now when it frees the memory, it will also free the pkey since it
+is no longer in use:
+
+	munmap(ptr, PAGE_SIZE);
+	pkey_free(pkey);
+
+(Note: pkey_set() is a wrapper for the RDPKRU and WRPKRU instructions.
+ An example implementation can be found in
+ tools/testing/selftests/x86/protection_keys.c)
+
+=========================== Behavior ===========================
+
+The kernel attempts to make protection keys consistent with the
+behavior of a plain mprotect().  For instance if you do this:
+
+	mprotect(ptr, size, PROT_NONE);
+	something(ptr);
+
+you can expect the same effects with protection keys when doing this:
+
+	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE | PKEY_DISABLE_READ);
+	pkey_mprotect(ptr, size, PROT_READ|PROT_WRITE, pkey);
+	something(ptr);
+
+That should be true whether something() is a direct access to 'ptr'
+like:
+
+	*ptr = foo;
+
+or when the kernel does the access on the application's behalf like
+with a read():
+
+	read(fd, ptr, 1);
+
+The kernel will send a SIGSEGV in both cases, but si_code will be set
+to SEGV_PKERR when violating protection keys versus SEGV_ACCERR when
+the plain mprotect() permissions are violated.
diff --git a/Documentation/x86/protection-keys.txt b/Documentation/x86/protection-keys.txt
deleted file mode 100644
index b643045..0000000
--- a/Documentation/x86/protection-keys.txt
+++ /dev/null
@@ -1,85 +0,0 @@
-Memory Protection Keys for Userspace (PKU aka PKEYs) is a CPU feature
-which will be found on future Intel CPUs.
-
-Memory Protection Keys provides a mechanism for enforcing page-based
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
-instruction fetches.
-
-=========================== Syscalls ===========================
-
-There are 3 system calls which directly interact with pkeys:
-
-	int pkey_alloc(unsigned long flags, unsigned long init_access_rights)
-	int pkey_free(int pkey);
-	int pkey_mprotect(unsigned long start, size_t len,
-			  unsigned long prot, int pkey);
-
-Before a pkey can be used, it must first be allocated with
-pkey_alloc().  An application calls the WRPKRU instruction
-directly in order to change access permissions to memory covered
-with a key.  In this example WRPKRU is wrapped by a C function
-called pkey_set().
-
-	int real_prot = PROT_READ|PROT_WRITE;
-	pkey = pkey_alloc(0, PKEY_DENY_WRITE);
-	ptr = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-	ret = pkey_mprotect(ptr, PAGE_SIZE, real_prot, pkey);
-	... application runs here
-
-Now, if the application needs to update the data at 'ptr', it can
-gain access, do the update, then remove its write access:
-
-	pkey_set(pkey, 0); // clear PKEY_DENY_WRITE
-	*ptr = foo; // assign something
-	pkey_set(pkey, PKEY_DENY_WRITE); // set PKEY_DENY_WRITE again
-
-Now when it frees the memory, it will also free the pkey since it
-is no longer in use:
-
-	munmap(ptr, PAGE_SIZE);
-	pkey_free(pkey);
-
-(Note: pkey_set() is a wrapper for the RDPKRU and WRPKRU instructions.
- An example implementation can be found in
- tools/testing/selftests/x86/protection_keys.c)
-
-=========================== Behavior ===========================
-
-The kernel attempts to make protection keys consistent with the
-behavior of a plain mprotect().  For instance if you do this:
-
-	mprotect(ptr, size, PROT_NONE);
-	something(ptr);
-
-you can expect the same effects with protection keys when doing this:
-
-	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE | PKEY_DISABLE_READ);
-	pkey_mprotect(ptr, size, PROT_READ|PROT_WRITE, pkey);
-	something(ptr);
-
-That should be true whether something() is a direct access to 'ptr'
-like:
-
-	*ptr = foo;
-
-or when the kernel does the access on the application's behalf like
-with a read():
-
-	read(fd, ptr, 1);
-
-The kernel will send a SIGSEGV in both cases, but si_code will be set
-to SEGV_PKERR when violating protection keys versus SEGV_ACCERR when
-the plain mprotect() permissions are violated.
-- 
1.7.1
