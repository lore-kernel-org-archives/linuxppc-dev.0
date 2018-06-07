Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411TG92y3nzDrpC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 11:58:09 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 15-v6so3916200pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jun 2018 18:58:09 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Cyril Bur <cyrilbur@gmail.com>, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v8 0/5] powerpc/64: memcmp() optimization
Date: Thu,  7 Jun 2018 09:57:50 +0800
Message-Id: <1528336675-10879-1-git-send-email-wei.guo.simon@gmail.com>
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

v7 -> v8:
- define memcmp with _GLOBAL_TOC() instead of _GLOBAL() to fix TOC issue.
add _GLOBAL_TOC() definition into selftest so that it can be compiled.
- use mfocrf/mtocrf instead of mcrf to save/restore CR0

v6 -> v7:
- add vcmpequd/vcmpequdb .long macro
- add CPU_FTR pair so that Power7 won't invoke Altivec instrs.
- rework some instructions for higher performance or more readable.

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


Simon Guo (5):
  powerpc/64: Align bytes before fall back to .Lshort in powerpc64
    memcmp()
  powerpc: add vcmpequd/vcmpequb ppc instruction macro
  powerpc/64: enhance memcmp() with VMX instruction for long bytes
    comparision
  powerpc/64: add 32 bytes prechecking before using VMX optimization on
    memcmp()
  powerpc:selftest update memcmp_64 selftest for VMX implementation

 arch/powerpc/include/asm/asm-prototypes.h          |   4 +-
 arch/powerpc/include/asm/ppc-opcode.h              |  11 +
 arch/powerpc/lib/copypage_power7.S                 |   4 +-
 arch/powerpc/lib/memcmp_64.S                       | 414 ++++++++++++++++++++-
 arch/powerpc/lib/memcpy_power7.S                   |   6 +-
 arch/powerpc/lib/vmx-helper.c                      |   4 +-
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      |   4 +-
 .../selftests/powerpc/stringloops/asm/ppc-opcode.h |  39 ++
 .../selftests/powerpc/stringloops/asm/ppc_asm.h    |  25 ++
 .../testing/selftests/powerpc/stringloops/memcmp.c |  98 +++--
 10 files changed, 568 insertions(+), 41 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/stringloops/asm/ppc-opcode.h

-- 
1.8.3.1
