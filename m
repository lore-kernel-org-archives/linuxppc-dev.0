Return-Path: <kda@linux-powerpc.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 018031A025C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 18:00:49 +1100 (AEDT)
Received: by labpn19 with SMTP id pn19so33986699lab.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 23:00:46 -0800 (PST)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: netdev@vger.kernel.org
Subject: bpf: Enable BPF JIT on ppc32
Date: Tue, 17 Feb 2015 10:04:37 +0300
Message-Id: <1424156683-2682-1-git-send-email-kda@linux-powerpc.org>
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

Changelog:
v1 - > v2: Reordered Kconfig patch in the series

Denis Kirjanov (6):
      ppc: bpf: add required compatibility macros for jit
      ppc: bpf: add reqired opcodes for ppc32
      ppc: bpf: update jit to use compatibility macros
      ppc: bpf: rename bpf_jit_64.S to bpf_jit_asm.S
      ppc: bpf: Add SKF_AD_CPU for ppc32
      ppc: Kconfig: Enable BPF JIT on ppc32

 arch/powerpc/include/asm/asm-compat.h |   4 +
 arch/powerpc/include/asm/ppc-opcode.h |   2 +
 arch/powerpc/net/Makefile             |   2 +-
 arch/powerpc/net/bpf_jit.h            |  64 +++++++++-
 arch/powerpc/net/bpf_jit_64.S         | 229 ----------------------------------
 arch/powerpc/net/bpf_jit_asm.S        | 229 ++++++++++++++++++++++++++++++++++
 arch/powerpc/net/bpf_jit_comp.c       |  46 +++----
 7 files changed, 317 insertions(+), 259 deletions(-)
