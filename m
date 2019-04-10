Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9F8C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:44:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6952082E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6952082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fWkH4CbNzDqJL
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:44:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.56.76; helo=6.mo179.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 1203 seconds by postgrey-1.36 at bilbo;
 Thu, 11 Apr 2019 03:42:41 AEST
Received: from 6.mo179.mail-out.ovh.net (6.mo179.mail-out.ovh.net
 [46.105.56.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fWhK5CnMzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 03:42:38 +1000 (AEST)
Received: from player157.ha.ovh.net (unknown [10.109.160.253])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id D43161226DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 19:05:00 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
 [86.201.133.22]) (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 6C931492A23D;
 Wed, 10 Apr 2019 17:04:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v5 00/16] KVM: PPC: Book3S HV: add XIVE native exploitation
 mode
Date: Wed, 10 Apr 2019 19:04:32 +0200
Message-Id: <20190410170448.3923-1-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2466846699187768279
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudejgdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

On the POWER9 processor, the XIVE interrupt controller can control
interrupt sources using MMIOs to trigger events, to EOI or to turn off
the sources. Priority management and interrupt acknowledgment is also
controlled by MMIO in the CPU presenter sub-engine.

PowerNV/baremetal Linux runs natively under XIVE but sPAPR guests need
special support from the hypervisor to do the same. This is called the
XIVE native exploitation mode and today, it can be activated under the
PowerPC Hypervisor, pHyp. However, Linux/KVM lacks XIVE native support
and still offers the old interrupt mode interface using a KVM device
implementing the XICS hcalls over XIVE.

The following series is proposal to add the same support under KVM.

A new KVM device is introduced for the XIVE native exploitation
mode. It reuses most of the XICS-over-XIVE glue implementation
structures which are internal to KVM but has a completely different
interface. A set of KVM device ioctls provide support for the
hypervisor calls, all handled in QEMU, to configure the sources and
the event queues. From there, all interrupt control is transferred to
the guest which can use MMIOs.

These MMIO regions (ESB and TIMA) are exposed to guests in QEMU,
similarly to VFIO, and the associated VMAs are populated dynamically
with the appropriate pages using a fault handler. These are now
implemented using mmap()s of the KVM device fd.

Migration has its own specific needs regarding memory. The patchset
provides a specific control to quiesce XIVE before capturing the
memory. The save and restore of the internal state is based on the
same ioctls used for the hcalls.

On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
negotiation process determines whether the guest operates with a
interrupt controller using the XICS legacy model, as found on POWER8,
or in XIVE exploitation mode. Which means that the KVM interrupt
device should be created at run-time, after the machine has started.
This requires extra support from KVM to destroy KVM devices. It is
introduced at the end of the patchset and requires some attention.

This is based on Linux 5.1-rc4 and is a candidate for 5.2. The OPAL
patches have been merged now.


GitHub trees available here :
 
QEMU sPAPR:

  https://github.com/legoater/qemu/commits/xive-next
  
Linux/KVM:

  https://github.com/legoater/linux/commits/xive-5.1

Thanks,

C.

Caveats :

 - We should introduce a set of definitions common to XIVE and XICS
 - The XICS-over-XIVE device file book3s_xive.c could be renamed to
   book3s_xics_on_xive.c or book3s_xics_p9.c
 - The XICS-over-XIVE device still has locking issues in the setup.
 - xc->valid is not useful
 - xc->xive is not very useful either

Changes since v4:

 - add check on EQ page alignment
 - add requirement on KVM_XIVE_EQ_ALWAYS_NOTIFY
 - add documentation in Documentation/virtual/kvm/api.txt
 - remove 'destroy' method
 - introduce a 'release' device operation called when device fd is
   closed.
 - introduce a 'xive_devices' array under the VM to store kvmppc_xive
   objects until VM is destroyed.
 
Changes since v3:

 - removed a couple of useless includes
 - fix the test ont the initial setting of the EQ toggle bit : 0 -> 1
 - renamed qsize to qshift
 - renamed qpage to qaddr
 - checked host page size
 - limited flags to KVM_XIVE_EQ_ALWAYS_NOTIFY to fit sPAPR specs
 - Fixed xive_timaval description in documentation

Changes since v2:

 - removed extra OPAL call definitions
 - removed ->q_order setting. Only useful in the XICS-on-XIVE KVM
   device which allocates the EQs on behalf of the guest.
 - returned -ENXIO when VP base is invalid
 - made use of the xive_vp() macro to compute VP identifiers
 - reworked locking in kvmppc_xive_native_connect_vcpu() to fix races 
 - stop advertising KVM_CAP_PPC_IRQ_XIVE as support is not fully
   available yet
 - fixed comment on XIVE IRQ number space
 - removed usage of the __x_* macros
 - fixed locking on source block
 - fixed comments on the KVM device attribute definitions
 - handled MASKED EAS configuration
 - fixed check on supported EQ size to restrict to 64K pages
 - checked kvm_eq.flags that need to be zero
 - removed the OPAL call when EQ qtoggle bit and index are zero. 
 - reduced the size of kvmppc_one_reg timaval attribute to two u64s
 - stopped returning of the OS CAM line value
 
Changes since v1:

 - Better documentation (was missing)
 - Nested support. XIVE not advertised on non PowerNV platforms. This
   is a good way to test the fallback on QEMU emulated devices.
 - ESB and TIMA special mapping done using the KVM device fd
 - All hcalls moved to QEMU. Dropped the patch moving the hcall flags.
 - Reworked of the KVM device ioctl controls to support hcalls and
   migration needs to capture/save states
 - Merged the control syncing XIVE and marking the EQ page dirty
 - Fixed passthrough support using the KVM device file address_space
   to clear the ESB pages from the mapping
 - Misc enhancements and fixes 

Cédric Le Goater (16):
  powerpc/xive: add OPAL extensions for the XIVE native exploitation
    support
  KVM: PPC: Book3S HV: add a new KVM device for the XIVE native
    exploitation mode
  KVM: PPC: Book3S HV: XIVE: introduce a new capability
    KVM_CAP_PPC_IRQ_XIVE
  KVM: PPC: Book3S HV: XIVE: add a control to initialize a source
  KVM: PPC: Book3S HV: XIVE: add a control to configure a source
  KVM: PPC: Book3S HV: XIVE: add controls for the EQ configuration
  KVM: PPC: Book3S HV: XIVE: add a global reset control
  KVM: PPC: Book3S HV: XIVE: add a control to sync the sources
  KVM: PPC: Book3S HV: XIVE: add a control to dirty the XIVE EQ pages
  KVM: PPC: Book3S HV: XIVE: add get/set accessors for the VP XIVE state
  KVM: introduce a 'mmap' method for KVM devices
  KVM: PPC: Book3S HV: XIVE: add a TIMA mapping
  KVM: PPC: Book3S HV: XIVE: add a mapping for the source ESB pages
  KVM: PPC: Book3S HV: XIVE: add passthrough support
  KVM: PPC: Book3S HV: XIVE: activate XIVE exploitation mode
  KVM: PPC: Book3S HV: XIVE: introduce a 'release' device operation

 arch/powerpc/include/asm/kvm_host.h        |    3 +
 arch/powerpc/include/asm/kvm_ppc.h         |   32 +
 arch/powerpc/include/asm/opal-api.h        |    7 +-
 arch/powerpc/include/asm/opal.h            |    7 +
 arch/powerpc/include/asm/xive.h            |   17 +
 arch/powerpc/include/uapi/asm/kvm.h        |   46 +
 arch/powerpc/kvm/book3s_xive.h             |   37 +
 include/linux/kvm_host.h                   |    2 +
 include/uapi/linux/kvm.h                   |    3 +
 arch/powerpc/kvm/book3s.c                  |   31 +-
 arch/powerpc/kvm/book3s_xive.c             |  230 +++-
 arch/powerpc/kvm/book3s_xive_native.c      | 1243 ++++++++++++++++++++
 arch/powerpc/kvm/powerpc.c                 |   37 +
 arch/powerpc/platforms/powernv/opal-call.c |    3 +
 arch/powerpc/sysdev/xive/native.c          |  110 ++
 virt/kvm/kvm_main.c                        |   24 +
 Documentation/virtual/kvm/api.txt          |   10 +
 Documentation/virtual/kvm/devices/xive.txt |  197 ++++
 arch/powerpc/kvm/Makefile                  |    2 +-
 19 files changed, 1980 insertions(+), 61 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_xive_native.c
 create mode 100644 Documentation/virtual/kvm/devices/xive.txt

-- 
2.20.1

