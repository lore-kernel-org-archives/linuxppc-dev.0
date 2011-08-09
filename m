Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 226F5B6F90
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 02:31:55 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 00/10] PAPR virtualization on PR KVM
Date: Tue,  9 Aug 2011 18:31:38 +0200
Message-Id: <1312907508-14599-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In KVM for Book3S PPC we currently have 2 implementations. There
is the PR based implementation which works on any POWER system
you pass in and the super fast HV implementation which requires
libre firmware (so almost nobody can use it).

Currently, the two target two different machine types, with PR KVM
being used for bare metal system virtualization, while the HV KVM
is used to virtualize PAPR.

In an effort to make things more cozy and transparent to the user,
this patch set implements PAPR capabilities to the PR KVM side, so
a user doesn't have to worry what the respective kernel module
supports. Any machine he's virtualizing "just works".


Alex

Alexander Graf (10):
  KVM: PPC: move compute_tlbie_rb to book3s common header
  KVM: PPC: Add papr_enabled flag
  KVM: PPC: Check privilege level on SPRs
  KVM: PPC: Interpret SDR1 as HVA in PAPR mode
  KVM: PPC: Read out syscall instruction on trap
  KVM: PPC: Add support for explicit HIOR setting
  KVM: PPC: Add PAPR hypercall code for PR mode
  KVM: PPC: Stub emulate CFAR and PURR SPRs
  KVM: PPC: Support SC1 hypercalls for PAPR in PR mode
  KVM: PPC: Enable the PAPR CAP for Book3S

 arch/powerpc/include/asm/kvm.h        |    8 ++
 arch/powerpc/include/asm/kvm_book3s.h |   36 ++++++++
 arch/powerpc/include/asm/kvm_host.h   |    1 +
 arch/powerpc/kvm/Makefile             |    1 +
 arch/powerpc/kvm/book3s_64_mmu.c      |    8 ++-
 arch/powerpc/kvm/book3s_emulate.c     |   29 ++++++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c   |   33 -------
 arch/powerpc/kvm/book3s_pr.c          |   36 +++++++-
 arch/powerpc/kvm/book3s_pr_papr.c     |  158 +++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_segment.S     |    5 +
 arch/powerpc/kvm/powerpc.c            |    6 ++
 include/linux/kvm.h                   |    2 +
 12 files changed, 286 insertions(+), 37 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_pr_papr.c
