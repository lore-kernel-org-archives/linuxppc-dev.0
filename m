Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCvsp5nFZzDrD7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 15:30:54 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 17so8150188pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 21:30:54 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>,
 Christophe LEROY <christophe.leroy@c-s.fr>, Cyril Bur <cyrilbur@gmail.com>,
 Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v3 0/3] powerpc/64: memcmp() optimization
Date: Fri, 13 Oct 2017 12:29:57 +0800
Message-Id: <1507869000-24336-1-git-send-email-wei.guo.simon@gmail.com>
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
currently the threshold is set for 4K bytes.

glibc commit dec4a7105e (powerpc: Improve memcmp performance for POWER8)
did the similar. Thanks Cyril Bur's information.
This patch set also updates memcmp selftest case to make it compiled and
incorporate large size comparison case.

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


Simon Guo (3):
  powerpc/64: Align bytes before fall back to .Lshort in powerpc64
    memcmp().
  powerpc/64: enhance memcmp() with VMX instruction for long bytes
    comparision
  powerpc:selftest update memcmp_64 selftest for VMX implementation

 arch/powerpc/include/asm/asm-prototypes.h          |   4 +-
 arch/powerpc/lib/copypage_power7.S                 |   4 +-
 arch/powerpc/lib/memcmp_64.S                       | 374 ++++++++++++++++++++-
 arch/powerpc/lib/memcpy_power7.S                   |   6 +-
 arch/powerpc/lib/vmx-helper.c                      |   4 +-
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      |   4 +-
 .../selftests/powerpc/stringloops/asm/ppc_asm.h    |  22 ++
 .../testing/selftests/powerpc/stringloops/memcmp.c |  98 ++++--
 8 files changed, 476 insertions(+), 40 deletions(-)

-- 
1.8.3.1
