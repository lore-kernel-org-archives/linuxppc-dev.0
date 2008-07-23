Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D6981DDE9F
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 18:37:19 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id m6N8al4P279040
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 08:36:47 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m6N8altC4329518
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:36:47 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m6N8al0n021853
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 10:36:47 +0200
From: ehrhardt@linux.vnet.ibm.com
To: kvm-ppc@vger.kernel.org, embedded-hypervisor@power.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 0/6][RFC] kvmppc: paravirtualization interface
Date: Wed, 23 Jul 2008 10:36:41 +0200
Message-Id: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
Cc: hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

This patch series implements a paravirtualization interface using:
- the device tree mechanism to pass hypervisor informations to the guest
- hypercalls for guest->host calls
- an example exploiter of that interface (magic page)
This is work in progress, but working so far. I just start to really exploit
the fuctionality behind the magic page mechanism therefor I can't provide any
performance improvements so far, but it is evolved enough for RFC and to start
the standardization discussion.

The used hypercall ABI was already discussed on the embedded-hypervisor mailing
list and is available at http://kvm.qumranet.com/kvmwiki/PowerPC_Hypercall_ABI

The device tree format used here (=base for the discussions on
embedded-hypervisor) is the following.
- A node "hypervisor" to show the general availability of some hypervisor data
- flags for features like the example "feature,pv-magicpage"
  setting 1 = available, everything else = unavailable
- Some features might need to pass more data and can use an entry in the
  device tree like the example of "data,pv-magicpage-size"

Parties on cc:
linuxppc-dev@ozlabs.org
  The patches affect code in the generic powerpc boot&setup so I would be
  happy about comments if the hooks are ok that way.
embedded-hypervisor@power.org
  This power.org TSC discusses about standardization of the virtualization
  interfaces. This patch series is perfectly suited due to it's simple changes
  to start the discussion about the device tree there.
kvm-ppc@vger.kernel.org
  The code is made for kvm on powerpc which lives on this list.

[patches in series]
Subject: [PATCH 1/6] kvmppc: read device tree hypervisor node infrastructure
  Providing the guest functionality to read hypervisor features from the
  device tree and adding the basic hook to the powerpc boot6setup code
Subject: [PATCH 2/6] kvmppc: add hypercall infrastructure - host part
Subject: [PATCH 3/6] kvmppc: add hypercall infrastructure - guest part
  patch 2&3 add the hypercall infrastruture as mentioned above
Subject: [PATCH 4/6] kvmppc: magic page hypercall - host part
Subject: [PATCH 5/6] kvmppc: magic page paravirtualization - guest part
  patch 4&5 add the magic page mechanism which will later on be used for
  binary rewriting the guest.
Subject: [PATCH 6/6] kvmppc: kvm-userspace: device tree modification for magicpage
  This connects host and guest reading host capabilities and modifying the
  device tree passed to the guest accordingly 

---
[diffstat]
 arch/powerpc/kernel/kvm.c            |   48 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/emulate.c           |    5 +++
 b/arch/powerpc/kernel/Makefile       |    2 +
 b/arch/powerpc/kernel/kvm.c          |   30 +++++++++++++++++++++
 b/arch/powerpc/kernel/setup_32.c     |    3 ++
 b/arch/powerpc/kvm/emulate.c         |   27 +++++++++++++++++++
 b/arch/powerpc/kvm/powerpc.c         |   18 ++++++++++++-
 b/arch/powerpc/platforms/44x/Kconfig |    7 +++++
 b/include/asm-powerpc/kvm_para.h     |   37 ++++++++++++++++++++++++--
 b/include/linux/kvm.h                |    6 ++++
 b/libkvm/libkvm-powerpc.c            |    6 ++++
 b/libkvm/libkvm.h                    |    6 ++++
 b/qemu/hw/device_tree.c              |   10 +++++++
 b/qemu/hw/device_tree.h              |    1
 b/qemu/hw/ppc440_bamboo.c            |   15 ++++++++++
 b/qemu/qemu-kvm-powerpc.c            |    5 +++
 b/qemu/qemu-kvm.h                    |    1
 include/asm-powerpc/kvm_para.h       |   47 +++++++++++++++++++++++++++++++++-
 18 files changed, 269 insertions(+), 5 deletions(-)
