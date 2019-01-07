Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7846C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:05:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38814206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38814206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YPx22b9CzDqNt
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 06:05:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.51.249; helo=6.mo177.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 6.mo177.mail-out.ovh.net (6.mo177.mail-out.ovh.net
 [46.105.51.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YPrT5zjyzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 06:01:45 +1100 (AEDT)
Received: from player737.ha.ovh.net (unknown [10.109.160.76])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 534A2D8D42
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2019 19:43:53 +0100 (CET)
Received: from kaod.org (lfbn-1-10605-110.w90-89.abo.wanadoo.fr
 [90.89.196.110]) (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 3489C18662F9;
 Mon,  7 Jan 2019 18:43:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 00/19] KVM: PPC: Book3S HV: add XIVE native exploitation mode
Date: Mon,  7 Jan 2019 19:43:12 +0100
Message-Id: <20190107184331.8429-1-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11378625935612546007
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrvdejgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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
interrupt sources using MMIO to trigger events, to EOI or to turn off
the sources. Priority management and interrupt acknowledgment is also
controlled by MMIO in the CPU presenter subengine.

PowerNV/baremetal Linux runs natively under XIVE but sPAPR guests need
special support from the hypervisor to do the same. This is called the
XIVE native exploitation mode and today, it can be activated under the
PowerPC Hypervisor, pHyp. However, Linux/KVM lacks XIVE native support
and still offers the old interrupt mode interface using a
XICS-over-XIVE glue which implements the XICS hcalls.

The following series is proposal to add the same support under KVM.

A new KVM device is introduced for the XIVE native exploitation
mode. It reuses most of the XICS-over-XIVE glue implementation
structures which are internal to KVM but has a completely different
interface. A set of Hypervisor calls configures the sources and the
event queues and from there, all control is done by the guest through
MMIOs.

These MMIO regions (ESB and TIMA) are exposed to guests in QEMU,
similarly to VFIO, and the associated VMAs are populated dynamically
with the appropriate pages using a fault handler. This is implemented
with a couple of KVM device ioctls.

On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
negotiation process determines whether the guest operates with a
interrupt controller using the XICS legacy model, as found on POWER8,
or in XIVE exploitation mode. Which means that the KVM interrupt
device should be created at runtime, after the machine as started.
This requires extra KVM support to create/destroy KVM devices. The
last patches are an attempt to solve that problem.

Migration has its own specific needs. The patchset provides the
necessary routines to quiesce XIVE, to capture and restore the state
of the different structures used by KVM, OPAL and HW. Extra OPAL
support is required for these.

GitHub trees available here :
 
QEMU sPAPR:

  https://github.com/legoater/qemu/commits/xive-next
  
Linux/KVM:

  https://github.com/legoater/linux/commits/xive-5.0

OPAL:

  https://github.com/legoater/skiboot/commits/xive

Best wishes for 2019 !

C.


Cédric Le Goater (19):
  powerpc/xive: export flags for the XIVE native exploitation mode
    hcalls
  powerpc/xive: add OPAL extensions for the XIVE native exploitation
    support
  KVM: PPC: Book3S HV: check the IRQ controller type
  KVM: PPC: Book3S HV: export services for the XIVE native exploitation
    device
  KVM: PPC: Book3S HV: add a new KVM device for the XIVE native
    exploitation mode
  KVM: PPC: Book3S HV: add a GET_ESB_FD control to the XIVE native
    device
  KVM: PPC: Book3S HV: add a GET_TIMA_FD control to XIVE native device
  KVM: PPC: Book3S HV: add a VC_BASE control to the XIVE native device
  KVM: PPC: Book3S HV: add a SET_SOURCE control to the XIVE native
    device
  KVM: PPC: Book3S HV: add a EISN attribute to kvmppc_xive_irq_state
  KVM: PPC: Book3S HV: add support for the XIVE native exploitation mode
    hcalls
  KVM: PPC: Book3S HV: record guest queue page address
  KVM: PPC: Book3S HV: add a SYNC control for the XIVE native migration
  KVM: PPC: Book3S HV: add a control to make the XIVE EQ pages dirty
  KVM: PPC: Book3S HV: add get/set accessors for the source
    configuration
  KVM: PPC: Book3S HV: add get/set accessors for the EQ configuration
  KVM: PPC: Book3S HV: add get/set accessors for the VP XIVE state
  KVM: PPC: Book3S HV: add passthrough support
  KVM: introduce a KVM_DELETE_DEVICE ioctl

 arch/powerpc/include/asm/kvm_host.h           |    2 +
 arch/powerpc/include/asm/kvm_ppc.h            |   69 +
 arch/powerpc/include/asm/opal-api.h           |   11 +-
 arch/powerpc/include/asm/opal.h               |    7 +
 arch/powerpc/include/asm/xive.h               |   40 +
 arch/powerpc/include/uapi/asm/kvm.h           |   47 +
 arch/powerpc/kvm/book3s_xive.h                |   82 +
 include/linux/kvm_host.h                      |    2 +
 include/uapi/linux/kvm.h                      |    5 +
 arch/powerpc/kvm/book3s.c                     |   31 +-
 arch/powerpc/kvm/book3s_hv.c                  |   29 +
 arch/powerpc/kvm/book3s_hv_builtin.c          |  196 +++
 arch/powerpc/kvm/book3s_hv_rm_xive_native.c   |   47 +
 arch/powerpc/kvm/book3s_xive.c                |  149 +-
 arch/powerpc/kvm/book3s_xive_native.c         | 1406 +++++++++++++++++
 .../powerpc/kvm/book3s_xive_native_template.c |  398 +++++
 arch/powerpc/kvm/powerpc.c                    |   30 +
 arch/powerpc/sysdev/xive/native.c             |  110 ++
 arch/powerpc/sysdev/xive/spapr.c              |   28 +-
 virt/kvm/kvm_main.c                           |   39 +
 arch/powerpc/kvm/Makefile                     |    4 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S       |   52 +
 .../powerpc/platforms/powernv/opal-wrappers.S |    3 +
 23 files changed, 2722 insertions(+), 65 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_hv_rm_xive_native.c
 create mode 100644 arch/powerpc/kvm/book3s_xive_native.c
 create mode 100644 arch/powerpc/kvm/book3s_xive_native_template.c

-- 
2.20.1

