Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxJPf3bcqzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 20:04:22 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id u18so1674070pgo.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 03:04:22 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v1 0/3] powerpc: memcmp() optimization
Date: Tue, 19 Sep 2017 18:03:56 +0800
Message-Id: <1505815439-18720-1-git-send-email-wei.guo.simon@gmail.com>
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

There is some room to optimize memcmp() in powerpc for following 2 cases:
(1) Even src/dst addresses are not aligned with 8 bytes at the beginning,
memcmp() can align them and go with .Llong comparision mode without
fallback to .Lshort comparision mode do compare buffer byte by byte.
(2) VMX instructions can be used to speed up for large size comparision.

This patch set also updates selftest case to make it compiled.


Simon Guo (3):
  powerpc: Align bytes before fall back to .Lshort in powerpc memcmp
  powerpc: enhance memcmp() with VMX instruction for long bytes
    comparision
  powerpc:selftest update memcmp selftest according to kernel change

 arch/powerpc/include/asm/asm-prototypes.h          |   2 +-
 arch/powerpc/lib/copypage_power7.S                 |   2 +-
 arch/powerpc/lib/memcmp_64.S                       | 165 ++++++++++++++++++++-
 arch/powerpc/lib/memcpy_power7.S                   |   2 +-
 arch/powerpc/lib/vmx-helper.c                      |   2 +-
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      |   2 +-
 .../selftests/powerpc/stringloops/asm/ppc_asm.h    |  31 ++++
 7 files changed, 197 insertions(+), 9 deletions(-)

-- 
1.8.3.1
