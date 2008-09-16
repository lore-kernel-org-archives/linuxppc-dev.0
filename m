Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.17.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 955ADDDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 16:28:13 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.1/8.13.1) with ESMTP id m8G6S16P002795
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 06:28:05 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id m8G6RwCD1409064
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 08:27:58 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m8G6RsZV025219
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 08:27:55 +0200
From: ehrhardt@linux.vnet.ibm.com
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 0/3][RFC] kvmppc: paravirtualization interface - guest part v3
Date: Tue, 16 Sep 2008 08:27:27 +0200
Message-Id: <1221546450-15761-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
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

Version 3 updates:
- guest hypercall infrastructure is now generic (in epapr_hcalls.h)
  while the kvm specific functions stay in kvm_para.h
- the hypercalls now use beat style ABI
- dropped the guest coop patch changing wrteei to wrtee (now mfmsr is
  rewritten avoiding side effects and a lot of corner cases. Additionally this
  does not need any guest cooperation to be effective)

This patch series implements a paravirtualization interface using:
- the device tree mechanism to pass hypervisor informations to the guest
- hypercalls for guest->host calls
- an example exploiter of that interface (magic page)

The device tree format used here (=base for the discussions on
embedded-hypervisor) is the following.
- A node "hypervisor" to show the general availability of some hypervisor data
- flags for features like the example "feature,pv-magicpage"
  setting 1 = available, everything else = unavailable
- Some features might need to pass more data and can use an entry in the
  device tree like the example of "data,pv-magicpage-size"

The host side of these patches can be found on kvm-ppc@vger.kernel.org

I hope that eventually this guest patch series (that is modifying the ppc boot
process and adding e.g. new ppc fixmaps could go upstream (when discussed
and agreed somewhen) via linuxppc-dev, while the kvm host part will go via
kvm (Avi Kivity).

[patches in series]
[PATCH 1/3] kvmppc: read device tree hypervisor node infrastructure
[PATCH 2/3] kvmppc: add hypercall infrastructure - guest part
[PATCH 3/3] kvmppc: magic page paravirtualization - guest part

---
[diffstat]
 arch/powerpc/kernel/kvm.c            |   53 +++++++++++++++++++++++++++++++
 b/arch/powerpc/kernel/Makefile       |    2 +
 b/arch/powerpc/kernel/kvm.c          |   30 +++++++++++++++++
 b/arch/powerpc/kernel/setup_32.c     |    3 +
 b/arch/powerpc/platforms/44x/Kconfig |    7 ++++
 b/include/asm-powerpc/epapr_hcalls.h |   59 +++++++++++++++++++++++++++++++++++
 b/include/asm-powerpc/fixmap.h       |   10 +++++
 b/include/asm-powerpc/kvm_para.h     |   43 +++++++++++++++++++++++--
 include/asm-powerpc/kvm_para.h       |   26 +++++++++++++++
 9 files changed, 229 insertions(+), 4 deletions(-)
