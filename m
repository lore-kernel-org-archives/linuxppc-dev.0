Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VMBn0rFkzF3Hy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 23:51:29 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id y5-v6so879459qti.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2018 06:51:29 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, linuxram@us.ibm.com,
 Ulrich.Weigand@de.ibm.com, fweimer@redhat.com, msuchanek@suse.de
Subject: [PATCH v3 0/9] powerpc/pkeys: fixes to pkeys
Date: Tue, 17 Jul 2018 06:51:01 -0700
Message-Id: <1531835470-32691-1-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Assortment of fixes to pkey to match its behavior to that on x86.

Patch 1  makes pkey consumable in multithreaded applications.

Patch 2  Deny, by default, permissions on all unallocated keys.

Patch 3  pkey allocation/free must not change pkey registers.

Patch 4  fixes fork to inherit the key attributes.

Patch 5  A off-by-one bug made one key unusable. Fixes it.

Patch 6  Makes pkey-0 less special.

Patch 7 fix to core-pkeys selftest to capture the modified behavior

Patch 8 fix to ptrace-pkeys selftest to capture the modified behavior

The above patch series is successfully verified using pkey selftests,
on both powerpc and x86.

Ram Pai (9):
  powerpc/pkeys: Give all threads control of their key permissions
  powerpc/pkeys: Deny read/write/execute by default
  powerpc/pkeys: key allocation/deallocation must not change pkey
    registers
  powerpc/pkeys: Save the pkey registers before fork
  powerpc/pkeys: fix calculation of total pkeys.
  powerpc/pkeys: Preallocate execute-only key
  powerpc/pkeys: make protection key 0 less special
  powerpc/core-pkeys: execute-permission on keys are disabled by
    default
  powerpc/ptrace-pkeys: execute-permission on keys are disabled by
    default

 arch/powerpc/include/asm/pkeys.h                   |   40 +++---
 arch/powerpc/kernel/process.c                      |    1 +
 arch/powerpc/mm/pkeys.c                            |  141 +++++++-------------
 tools/testing/selftests/powerpc/ptrace/core-pkey.c |    4 +
 .../testing/selftests/powerpc/ptrace/ptrace-pkey.c |    5 +
 5 files changed, 79 insertions(+), 112 deletions(-)
