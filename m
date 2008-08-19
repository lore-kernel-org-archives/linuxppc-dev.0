Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.17.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18268DE55B
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 20:37:26 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.1/8.13.1) with ESMTP id m7JAajrL025086
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 10:36:45 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7JAairU4100220
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 12:36:44 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7JAaivA010549
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 12:36:44 +0200
From: ehrhardt@linux.vnet.ibm.com
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 0/4][RFC] kvmppc: paravirtualization interface - guest part v2
Date: Tue, 19 Aug 2008 12:36:40 +0200
Message-Id: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
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

Version 2 includes changes to the feedback of my last submission and is now
tested against the implemented and working host part. The host part discussion
can be found on kvm-ppc@vger.kernel.org.

The used hypercall ABI was already discussed on the embedded-hypervisor mailing
list and is available at http://kvm.qumranet.com/kvmwiki/PowerPC_Hypercall_ABI

The device tree format used here (=base for the discussions on
embedded-hypervisor) is the following.
- A node "hypervisor" to show the general availability of some hypervisor data
- flags for features like the example "feature,pv-magicpage"
  setting 1 = available, everything else = unavailable
- Some features might need to pass more data and can use an entry in the
  device tree like the example of "data,pv-magicpage-size"

I hope that eventually this guest patch series (that is modifying the boot
process and adding e.g. new ppc fixmaps could go upstream (when discussed
and agreed somewhen) via linuxppc-dev, while the kvm host part will go via
kvm (Avi Kivity).

[patches in series]
[PATCH 1/4] kvmppc: read device tree hypervisor node infrastructure
[PATCH 2/4] kvmppc: add hypercall infrastructure - guest part
[PATCH 3/4] kvmppc: magic page paravirtualization - guest part
[PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest optimization

---
[diffstat]
 arch/powerpc/kernel/kvm.c            |   51 ++++++++++++++++++++++++++++++
 b/arch/powerpc/kernel/Makefile       |    2 +
 b/arch/powerpc/kernel/kvm.c          |   30 +++++++++++++++++
 b/arch/powerpc/kernel/setup_32.c     |    3 +
 b/arch/powerpc/platforms/44x/Kconfig |    7 ++++
 b/include/asm-powerpc/fixmap.h       |   10 +++++
 b/include/asm-powerpc/hw_irq.h       |   12 +++++++
 b/include/asm-powerpc/kvm_para.h     |   43 +++++++++++++++++++++++--
 b/mm/page_alloc.c                    |    1
 include/asm-powerpc/kvm_para.h       |   59 +++++++++++++++++++++++++++++++++++
 10 files changed, 214 insertions(+), 4 deletions(-)
