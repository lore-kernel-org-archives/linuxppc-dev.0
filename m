Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sXlp1XWBzF1RG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 14:07:49 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id bi12-v6so2317349plb.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 21:07:49 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v6 0/4] powerpc/64: memcmp() optimization
Date: Fri, 25 May 2018 12:07:32 +0800
Message-Id: <1527221256-17029-1-git-send-email-wei.guo.simon@gmail.com>
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

From: Simon Guo <wei.guo.simon@gmail.com>

There is some room to optimize memcmp() in powerpc 64 bits version for
following 2 cases:
(1) Even src/dst addresses are not aligned with 8 bytes at the beginning,
memcmp() can align them and go with .Llong comparision mode without
fallback to .Lshort comparision mode do compare buffer byte by byte.
(2) VMX instructions can be used to speed up for large size comparision,
currently the threshold is set for 4K bytes. Notes the VMX instructions
will lead to VMX regs save/load penalty. This patch set includes a
patch to add a 32 bytes pre-checking to minimize the penalty.

It did the similar with glibc commit dec4a7105e (powerpc: Improve memcmp 
performance for POWER8). Thanks Cyril Bur's information.
This patch set also updates memcmp selftest case to make it compiled and
incorporate large size comparison case.

v5 -> v6:
- correct some comments/commit messsage.
- rename VMX_OPS_THRES to VMX_THRESH

v4 -> v5:
- Expand 32 bytes prechk to src/dst different offset case, and remove
KSM specific label/comment.

v3 -> v4:
- Add 32 bytes pre-checking before using VMX instructions.

v2 -> v3:
- add optimization for src/dst with different offset against 8 bytes
boundary.
- renamed some label names.
- reworked some comments from Cyril Bur, such as fill the pipeline, 
and use VMX when size == 4K.
- fix a bug of enter/exit_vmx_ops pairness issue. And revised test 
case to test whether enter/exit_vmx_ops are paired.

v1 -> v2:
- update 8bytes unaligned bytes comparison method.
- fix a VMX comparision bug.
- enhanced the original memcmp() selftest.
- add powerpc/64 to subject/commit message.

Simon Guo (4):
  powerpc/64: Align bytes before fall back to .Lshort in powerpc64
    memcmp()
  powerpc/64: enhance memcmp() with VMX instruction for long bytes
    comparision
  powerpc/64: add 32 bytes prechecking before using VMX optimization on
    memcmp()
  powerpc:selftest update memcmp_64 selftest for VMX implementation

 arch/powerpc/include/asm/asm-prototypes.h          |   4 +-
 arch/powerpc/lib/copypage_power7.S                 |   4 +-
 arch/powerpc/lib/memcmp_64.S                       | 408 ++++++++++++++++++++-
 arch/powerpc/lib/memcpy_power7.S                   |   6 +-
 arch/powerpc/lib/vmx-helper.c                      |   4 +-
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      |   4 +-
 .../selftests/powerpc/stringloops/asm/ppc_asm.h    |  22 ++
 .../testing/selftests/powerpc/stringloops/memcmp.c |  98 +++--
 8 files changed, 510 insertions(+), 40 deletions(-)

-- 
1.8.3.1
