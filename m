Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQLCg1rcGzDqlG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 05:52:47 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id x27so23446114qtm.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 10:52:47 -0800 (PST)
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
Subject: [PATCH v10 00/24] selftests, powerpc, x86 : Memory Protection Keys
Date: Mon, 22 Jan 2018 10:51:53 -0800
Message-Id: <1516647137-11174-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory protection keys enable applications to protect its address space from
inadvertent access from itself.

This feature is now enabled on powerpc architecture.  The patches move the
selftests to arch neutral directory and enhances them. Verified for correctness
on powerpc and on x86 architectures(using EC2 ubuntu VM instances).

Ram Pai (21):
  selftests/x86: Move protecton key selftest to arch neutral directory
  selftests/vm: rename all references to pkru to a generic name
  selftests/vm: move generic definitions to header file
  selftests/vm: typecast the pkey register
  selftests/vm: generic function to handle shadow key register
  selftests/vm: fix the wrong assert in pkey_disable_set()
  selftests/vm: fixed bugs in pkey_disable_clear()
  selftests/vm: clear the bits in shadow reg when a pkey is freed.
  selftests/vm: fix alloc_random_pkey() to make it really random
  selftests/vm: introduce two arch independent abstraction
  selftests/vm: pkey register should match shadow pkey
  selftests/vm: generic cleanup
  selftests/vm: powerpc implementation for generic abstraction
  selftests/vm: clear the bits in shadow reg when a pkey is freed.
  selftests/vm: powerpc implementation to check support for pkey
  selftests/vm: fix an assertion in test_pkey_alloc_exhaust()
  selftests/vm: associate key on a mapped page and detect access
    violation
  selftests/vm: associate key on a mapped page and detect write
    violation
  selftests/vm: detect write violation on a mapped access-denied-key
    page
  selftests/vm: testcases must restore pkey-permissions
  selftests/vm: sub-page allocator

Thiago Jung Bauermann (3):
  selftests/vm: Fix deadlock in protection_keys.c
  selftests/powerpc: Add ptrace tests for Protection Key register
  selftests/powerpc: Add core file test for Protection Key register

 tools/testing/selftests/powerpc/include/reg.h      |    1 +
 tools/testing/selftests/powerpc/ptrace/Makefile    |    5 +-
 tools/testing/selftests/powerpc/ptrace/core-pkey.c |  438 ++++++
 .../testing/selftests/powerpc/ptrace/ptrace-pkey.c |  443 ++++++
 tools/testing/selftests/vm/Makefile                |    1 +
 tools/testing/selftests/vm/pkey-helpers.h          |  419 ++++++
 tools/testing/selftests/vm/protection_keys.c       | 1471 ++++++++++++++++++++
 tools/testing/selftests/x86/Makefile               |    2 +-
 tools/testing/selftests/x86/pkey-helpers.h         |  223 ---
 tools/testing/selftests/x86/protection_keys.c      | 1407 -------------------
 10 files changed, 2778 insertions(+), 1632 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/core-pkey.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
 create mode 100644 tools/testing/selftests/vm/pkey-helpers.h
 create mode 100644 tools/testing/selftests/vm/protection_keys.c
 delete mode 100644 tools/testing/selftests/x86/pkey-helpers.h
 delete mode 100644 tools/testing/selftests/x86/protection_keys.c
