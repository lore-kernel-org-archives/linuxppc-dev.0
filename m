Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpYQZ2MJ4zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 15:26:14 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 0/5] KVM: PPC: Improve MMIO emulation
Date: Thu, 23 Mar 2017 15:25:58 +1100
Message-Id: <1490243163-19566-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guests accessing emulated MMIO can do so using a wide variety of load
and store instructions on PPC machines.  However, KVM currently only
knows about a subset of the load and store instructions available.
This patchset expands the set of load and store instructions that KVM
can emulate to include all of the integer loads and stores (except
those that trap when used on cache-inhibited mappings), all of the
floating-point loads and stores and all of the VSX loads and stores
defined in the Power ISA v2.07B (which is the architecture for
POWER8).

This does not implement Altivec/VMX loads and stores or the new loads
and stores defined in Power ISA v3.00.

This patch set is against v4.11-rc3.

---

 arch/powerpc/include/asm/disassemble.h |   5 +
 arch/powerpc/include/asm/kvm_host.h    |  23 ++
 arch/powerpc/include/asm/kvm_ppc.h     |  10 +
 arch/powerpc/include/asm/ppc-opcode.h  |  58 ++++
 arch/powerpc/kvm/Makefile              |   2 +-
 arch/powerpc/kvm/book3s.c              |  18 ++
 arch/powerpc/kvm/booke.c               |   5 +
 arch/powerpc/kvm/emulate_loadstore.c   | 472 ++++++++++++++++++++++++++++++---
 arch/powerpc/kvm/powerpc.c             | 317 +++++++++++++++++++++-
 9 files changed, 862 insertions(+), 48 deletions(-)
