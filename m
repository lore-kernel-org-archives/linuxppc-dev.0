Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFsBv1lHgzDrBG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 15:36:07 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 00/13] Real-mode acceleration of device interrupts in HV KVM
Date: Fri, 19 Aug 2016 15:35:44 +1000
Message-Id: <1471584957-21484-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set reduces the latency for presenting interrupts from PCI
pass-through devices to a Book3S HV guest.  Currently, if an interrupt
arrives from a PCI pass-through device while a guest is running, it
causes an exit of all threads on the core to the host, where the
interrupt is handled by making an interrupt pending in the virtual
XICS interrupt controller for the guest that owns the device.
Furthermore, there is currently no attempt to direct PCI pass-through
device interrupts to the physical core where the VCPU that they are
directed to is running, so they often land on a different core and
require an IPI to interrupt the VCPU.

With this patch set, if the interrupt arrives on a core where the
correct guest is running, it can be handled in hypervisor real mode
without needing an exit to host context.  If the destination VCPU is
on the same core, then we can interrupt it using at most a msgsnd
(message send) instruction, which is considerably faster than an IPI.

Further, if an interrupt arrives on a different core, we then change
the destination for the interrupt in the physical interrupt controller
to point to the core where the VCPU is running.  For now, we always
direct the interrupt to thread 0 of the core because the other threads
are offline from the point of view of the host, and the offline loop
(which is where those other threads run when thread 0 is in host
context) doesn't handle device interrupts.

This patch set is based on a patch set from Suresh Warrier, with
considerable revision by me.  The data structure for mapping host
interrupt numbers to guest interrupt numbers is just a flat array that
is searched linearly, which works and is simple but could perform
poorly with large numbers of interrupt sources.  It would be simple to
replace this mapping array with a more sophisticated data structure in
future.

To test the performance of this patch set, I used a network one-byte
ping-pong test between a guest with a Mellanox CX-3 passed through to
it, connected over 10Gb ethernet to another POWER8 system running
bare-metal with a Chelsio 10Gb ethernet adapter.  (The guest was
running Ubuntu 16.04.1 under QEMU v2.7-rc2 on a POWER8.)  Without this
patchset, the round-trip latency was 43us, and with it the latency was
41us, a saving of 2us per round-trip.

Paul.
-----
 arch/powerpc/include/asm/io.h                  |  29 ++++
 arch/powerpc/include/asm/kvm_asm.h             |  10 ++
 arch/powerpc/include/asm/kvm_book3s.h          |   1 +
 arch/powerpc/include/asm/kvm_host.h            |  20 +++
 arch/powerpc/include/asm/kvm_ppc.h             |  28 ++++
 arch/powerpc/include/asm/opal.h                |   1 +
 arch/powerpc/include/asm/pnv-pci.h             |   3 +
 arch/powerpc/kvm/Kconfig                       |   2 +
 arch/powerpc/kvm/book3s.c                      |   3 +
 arch/powerpc/kvm/book3s_hv.c                   | 199 ++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_hv_builtin.c           | 141 ++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rm_xics.c           | 120 +++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S        | 183 +++++++++++++----------
 arch/powerpc/kvm/book3s_xics.c                 |  55 ++++++-
 arch/powerpc/kvm/book3s_xics.h                 |   2 +
 arch/powerpc/kvm/powerpc.c                     |  38 +++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/pci-ioda.c      |  24 ++-
 18 files changed, 773 insertions(+), 87 deletions(-)
