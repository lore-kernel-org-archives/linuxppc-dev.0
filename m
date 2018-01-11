Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHfzg23gfzF0Td
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 09:04:15 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0BM37Pg085789
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 17:04:10 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fefnn9yfn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 17:04:10 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 11 Jan 2018 22:04:07 -0000
Subject: Re: [PATCH 00/26] KVM: PPC: Book3S PR: Transaction memory support
 on PR KVM
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Gustavo Romero <gromero@linux.vnet.ibm.com>, wei.guo.simon@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Date: Fri, 12 Jan 2018 09:04:03 +1100
In-Reply-To: <5A576D2B.6060900@linux.vnet.ibm.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <5A576D2B.6060900@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1515708243.31850.47.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-01-11 at 11:56 -0200, Gustavo Romero wrote:
> Hi Simon,
> 
> On 01/11/2018 08:11 AM, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > In current days, many OS distributions have utilized transaction
> > memory functionality. In PowerPC, HV KVM supports TM. But PR KVM
> > does not.
> > 
> > The drive for the transaction memory support of PR KVM is the
> > openstack Continuous Integration testing - They runs a HV(hypervisor)
> > KVM(as level 1) and then run PR KVM(as level 2) on top of that.
> > 
> > This patch set add transaction memory support on PR KVM.
> 
> Is this correct to assume that this emulation mode will just kick in on P9
> with kernel TM workarounds and HV KVM will continue to be used on POWER8
> since HV KVM is supported on POWER8 hosts?

HV KVM is supported on POWER9. In fact it's PR KVM that isn't (at least
not yet and never will be in Radix mode at least).

Cheers,
Ben.

> 
> 
> Regards,
> Gustavo
> 
> > Test cases performed:
> > linux/tools/testing/selftests/powerpc/tm/tm-syscall
> > linux/tools/testing/selftests/powerpc/tm/tm-fork
> > linux/tools/testing/selftests/powerpc/tm/tm-vmx-unavail
> > linux/tools/testing/selftests/powerpc/tm/tm-tmspr
> > linux/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv
> > linux/tools/testing/selftests/powerpc/math/vsx_preempt
> > linux/tools/testing/selftests/powerpc/math/fpu_signal
> > linux/tools/testing/selftests/powerpc/math/vmx_preempt
> > linux/tools/testing/selftests/powerpc/math/fpu_syscall
> > linux/tools/testing/selftests/powerpc/math/vmx_syscall
> > linux/tools/testing/selftests/powerpc/math/fpu_preempt
> > linux/tools/testing/selftests/powerpc/math/vmx_signal
> > linux/tools/testing/selftests/powerpc/ptrace/ptrace-tm-gpr
> > linux/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-gpr
> > linux/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spd-vsx
> > linux/tools/testing/selftests/powerpc/ptrace/ptrace-tm-spr
> > linux/tools/testing/selftests/powerpc/ptrace/ptrace-tm-vsx
> > https://github.com/justdoitqd/publicFiles/blob/master/test_tbegin_pr.c
> > https://github.com/justdoitqd/publicFiles/blob/master/test_tabort.c
> > https://github.com/justdoitqd/publicFiles/blob/master/test_kvm_htm_cap.c
> > 
> > Simon Guo (25):
> >   KVM: PPC: Book3S PR: Move kvmppc_save_tm/kvmppc_restore_tm to separate
> >     file
> >   KVM: PPC: Book3S PR: add new parameter (guest MSR) for
> >     kvmppc_save_tm()/kvmppc_restore_tm()
> >   KVM: PPC: Book3S PR: turn on FP/VSX/VMX MSR bits in kvmppc_save_tm()
> >   KVM: PPC: Book3S PR: add C function wrapper for
> >     _kvmppc_save/restore_tm()
> >   KVM: PPC: Book3S PR: In PR KVM suspends Transactional state when
> >     inject an interrupt.
> >   KVM: PPC: Book3S PR: PR KVM pass through MSR TM/TS bits to shadow_msr.
> >   KVM: PPC: Book3S PR: add TEXASR related macros
> >   KVM: PPC: Book3S PR: Sync TM bits to shadow msr for problem state
> >     guest
> >   KVM: PPC: Book3S PR: implement RFID TM behavior to suppress change
> >     from S0 to N0
> >   KVM: PPC: Book3S PR: set MSR HV bit accordingly for PPC970 and others.
> >   KVM: PPC: Book3S PR: prevent TS bits change in kvmppc_interrupt_pr()
> >   powerpc: export symbol msr_check_and_set().
> >   KVM: PPC: Book3S PR: adds new
> >     kvmppc_copyto_vcpu_tm/kvmppc_copyfrom_vcpu_tm API for PR KVM.
> >   KVM: PPC: Book3S PR: export tm_enable()/tm_disable/tm_abort() APIs
> >   KVM: PPC: Book3S PR: add kvmppc_save/restore_tm_sprs() APIs
> >   KVM: PPC: Book3S PR: add transaction memory save/restore skeleton for
> >     PR KVM
> >   KVM: PPC: Book3S PR: add math support for PR KVM HTM
> >   KVM: PPC: Book3S PR: make mtspr/mfspr emulation behavior based on
> >     active TM SPRs
> >   KVM: PPC: Book3S PR: always fail transaction in guest privilege state
> >   KVM: PPC: Book3S PR: enable NV reg restore for reading TM SPR at guest
> >     privilege state
> >   KVM: PPC: Book3S PR: adds emulation for treclaim.
> >   KVM: PPC: Book3S PR: add emulation for trechkpt in PR KVM.
> >   KVM: PPC: Book3S PR: add emulation for tabort. for privilege guest
> >   KVM: PPC: Book3S PR: add guard code to prevent returning to guest with
> >     PR=0 and Transactional state
> >   KVM: PPC: Book3S PR: enable HTM for PR KVM for KVM_CHECK_EXTENSION
> >     ioctl
> > 
> >  arch/powerpc/include/asm/asm-prototypes.h   |  10 +
> >  arch/powerpc/include/asm/kvm_book3s.h       |   8 +
> >  arch/powerpc/include/asm/kvm_host.h         |   3 +
> >  arch/powerpc/include/asm/reg.h              |  25 +-
> >  arch/powerpc/include/asm/tm.h               |   2 -
> >  arch/powerpc/include/uapi/asm/tm.h          |   2 +-
> >  arch/powerpc/kernel/process.c               |   1 +
> >  arch/powerpc/kernel/tm.S                    |  12 +
> >  arch/powerpc/kvm/Makefile                   |   3 +
> >  arch/powerpc/kvm/book3s.h                   |   1 +
> >  arch/powerpc/kvm/book3s_64_mmu.c            |  11 +-
> >  arch/powerpc/kvm/book3s_emulate.c           | 279 +++++++++++++++++++-
> >  arch/powerpc/kvm/book3s_hv_rmhandlers.S     | 259 ++-----------------
> >  arch/powerpc/kvm/book3s_pr.c                | 256 +++++++++++++++++--
> >  arch/powerpc/kvm/book3s_segment.S           |  13 +
> >  arch/powerpc/kvm/powerpc.c                  |   3 +-
> >  arch/powerpc/kvm/tm.S                       | 379 ++++++++++++++++++++++++++++
> >  arch/powerpc/mm/hash_utils_64.c             |   1 +
> >  arch/powerpc/platforms/powernv/copy-paste.h |   3 +-
> >  19 files changed, 982 insertions(+), 289 deletions(-)
> >  create mode 100644 arch/powerpc/kvm/tm.S
> > 
