Return-Path: <kda@linux-powerpc.org>
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com
 [209.85.217.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59F541A0728
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 05:03:08 +1100 (AEDT)
Received: by mail-lb0-f174.google.com with SMTP id z11so23551436lbi.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Feb 2015 10:03:04 -0800 (PST)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 0/6] bpf: Enable BPF JIT on ppc32
Date: Sun, 15 Feb 2015 21:06:39 +0300
Message-Id: <1424023605-2416-1-git-send-email-kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series enables BPF JIT on ppc32. There are relatevily
few chnages in the code to make it work.

All test_bpf tests passed both on 7447a and P2041-based machines.

 arch/powerpc/Kconfig                  |   2 +-
 arch/powerpc/include/asm/asm-compat.h |   4 +
 arch/powerpc/include/asm/ppc-opcode.h |   2 +
 arch/powerpc/net/Makefile             |   2 +-
 arch/powerpc/net/bpf_jit.h            |  47 ++++++-
 arch/powerpc/net/bpf_jit_64.S         | 229 ----------------------------------
 arch/powerpc/net/bpf_jit_asm.S        | 229 ++++++++++++++++++++++++++++++++++
 arch/powerpc/net/bpf_jit_comp.c       |  32 ++---
 8 files changed, 300 insertions(+), 247 deletions(-)
