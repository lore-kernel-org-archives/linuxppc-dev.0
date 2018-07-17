Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VM972bYFzF3Hl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 23:50:02 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id y19-v6so885153qto.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 06:50:02 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: shuahkh@osg.samsung.com,
	linux-kselftest@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 dave.hansen@intel.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 linuxram@us.ibm.com, fweimer@redhat.com, msuchanek@suse.de,
 aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v14 00/22] selftests, powerpc, x86 : Memory Protection Keys
Date: Tue, 17 Jul 2018 06:49:03 -0700
Message-Id: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory protection keys enables an application to protect its address space from
inadvertent access by its own code.

This feature is now enabled on powerpc architecture and integrated in
4.16-rc1.  The patches move the selftests to arch neutral directory
and enhance their test coverage.

Test
----
Verified for correctness on powerpc and on x86.

History:
-------
version 14:
	(1) incorporated another round of comments from Dave Hansen.

version 13:
        (1) Incorporated comments for Dave Hansen.
	(2)   Added one more test for correct pkey-0 behavior.

version 12:
	(1) fixed the offset of pkey field in the siginfo structure for
		x86_64 and powerpc. And tries to use the actual field
		if the headers have it defined.

version 11:
	(1) fixed a deadlock in the ptrace testcase.

version 10 and prior:
	(1) moved the testcase to arch neutral directory
	(2) split the changes into incremental patches.

Ram Pai (20):
  selftests/x86: Move protecton key selftest to arch neutral directory
  selftests/vm: rename all references to pkru to a generic name
  selftests/vm: move generic definitions to header file
  selftests/vm: typecast the pkey register
  selftests/vm: generic function to handle shadow key register
  selftests/vm: fix the wrong assert in pkey_disable_set()
  selftests/vm: fixed bugs in pkey_disable_clear()
  selftests/vm: fix alloc_random_pkey() to make it really random
  selftests/vm: introduce two arch independent abstraction
  selftests/vm: pkey register should match shadow pkey
  selftests/vm: generic cleanup
  selftests/vm: Introduce generic abstractions
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
  selftests/vm: test correct behavior of pkey-0

Thiago Jung Bauermann (2):
  selftests/vm: move arch-specific definitions to arch-specific header
  selftests/vm: Make gcc check arguments of sigsafe_printf()

 tools/testing/selftests/vm/.gitignore         |    1 +
 tools/testing/selftests/vm/Makefile           |    1 +
 tools/testing/selftests/vm/pkey-helpers.h     |  214 ++++
 tools/testing/selftests/vm/pkey-powerpc.h     |  128 ++
 tools/testing/selftests/vm/pkey-x86.h         |  184 +++
 tools/testing/selftests/vm/protection_keys.c  | 1593 +++++++++++++++++++++++++
 tools/testing/selftests/x86/.gitignore        |    1 -
 tools/testing/selftests/x86/pkey-helpers.h    |  219 ----
 tools/testing/selftests/x86/protection_keys.c | 1485 -----------------------
 9 files changed, 2121 insertions(+), 1705 deletions(-)
 create mode 100644 tools/testing/selftests/vm/pkey-helpers.h
 create mode 100644 tools/testing/selftests/vm/pkey-powerpc.h
 create mode 100644 tools/testing/selftests/vm/pkey-x86.h
 create mode 100644 tools/testing/selftests/vm/protection_keys.c
 delete mode 100644 tools/testing/selftests/x86/pkey-helpers.h
 delete mode 100644 tools/testing/selftests/x86/protection_keys.c
