Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B4BEE2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Dec 2013 12:24:54 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/4] powerpc: Enable ILE on pSeries without H_MODE_SET
Date: Mon, 23 Dec 2013 02:24:41 +0100
Message-Id: <1387761885-39599-1-git-send-email-agraf@suse.de>
Cc: Dinar Valeev <dvaleev@suse.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Howdy,

There are a few machines out there that would be pretty ppc64le capable
if only it wasn't for the hypervisor that's running on them.

The problem is that we need to run in ILE (interrupts delivered in little
endian) mode to run our normal interrupt vectors. The hypercall to enable
this mode is not available on PowerVM.

However, we can try to be smart here. Instead of configuring the hypervisor
to run interrupts in little endian mode, we can just bring ourselves back
to little endian on every interrupt.

We do this by patching every interrupt handler with a "branch" instruction
at the beginning which jumps into a tiny helper that turns on MSR.LE and
resumes the interrupt handler.

This is not the most smart thing to do performance wise, but it does have
a really nice side effect: We do not impact hypervisors that do support
H_SET_MODE. This is important, as we want to be as fast as possible on machines
that are supposed to run Little Endian guests.

As a tiny side effect we also clobber CFAR in every interrupt, rendering
the whole thing pretty useless. So we don't get nice and shiny perf and
debugging helps. Oh well.

Given that the alternatives to all of this would either be

  a) Not run at all or
  b) Incur performance penalties for "good" systems or
  c) Add significant maintenance burden on us

I'm quite convinced this is the way we want to go.


Enjoy,

Alex

Alexander Graf (4):
  powerpc: Add global exports for all interrupt vectors
  powerpc: Add relocation code for fixups
  powerpc: Add hack to make ppc64le work on hosts without ILE
  powerpc: Don't return to BE mode when we are already there

 arch/powerpc/include/asm/cputable.h    |   2 +
 arch/powerpc/kernel/Makefile           |   3 +
 arch/powerpc/kernel/exceptions-64s.S   |   5 ++
 arch/powerpc/kernel/fake_ile.S         | 101 +++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/vmlinux.lds.S      |  14 +++++
 arch/powerpc/lib/feature-fixups.c      |  22 +++++++
 arch/powerpc/platforms/pseries/setup.c |  61 +++++++++++++++++++-
 7 files changed, 207 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/kernel/fake_ile.S

-- 
1.8.1.4
