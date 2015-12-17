Return-Path: <warrier@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 146EB1A170C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 07:59:49 +1100 (AEDT)
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A1D42140BA4
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2015 07:59:47 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <warrier@linux.vnet.ibm.com>;
 Thu, 17 Dec 2015 13:59:45 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id BB089C40001
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:47:34 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBHKxNgt28573774
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:23 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBHKxNTc014462
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2015 13:59:23 -0700
From: Suresh Warrier <warrier@linux.vnet.ibm.com>
To: kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de,
 mpe@ellerman.id.au
Subject: [PATCH v3 0/9] KVM: PPC: Book3S HV: Optimize wakeup VCPU from H_IPI
Date: Thu, 17 Dec 2015 14:59:02 -0600
Message-Id: <1450385951-25128-1-git-send-email-warrier@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the VCPU target of an H_IPI hypercall is not running
in the guest, we need to do a kick VCPU (wake the VCPU thread)
to make it runnable. The real-mode version of the H_IPI hypercall
cannot do this because it involves waking a sleeping thread.
Thus the hcall returns H_TOO_HARD which forces a switch back
to host so that the H_IPI call can be completed in virtual mode.
This has been found to cause a slowdown for many workloads like
YCSB MongoDB, small message networking, etc. 

One solution is to hand off this job of waking the VCPU to a CPU
that is running in the host by sending it a message through the 
IPI mechanism from the hypercall.

This patch set optimizes the wakeup of the target VCPU by posting
a free core already running in the host to do the wakeup, thus
avoiding the switch to host and back. It requires maintaining a
bitmask of all the available cores in the system to indicate if
they are in the host or running in some guest. It also requires
the H_IPI hypercall to search for a free host core and send it a
new IPI message PPC_MSG_RM_HOST_ACTION after stashing away some
parameters like the pointer to VCPU for the IPI handler. Locks
are avoided by using atomic operations to save core state, to
find and reserve a core in the host, etc.

Note that it is possible for a guest to be destroyed and its
VCPUs freed before the IPI handler gets to run. This case is
handled by ensuring that any pending PPC_MSG_RM_HOST_ACTION
IPIs are completed before proceeding with freeing the VCPUs.

Currently, powerpc only support 4 IPI messages and all 4 are 
already taken for other purposes. This patch also set increases
the number of supported IPI messages to 8. It also provides the
code to send an IPI from hypercall running in real-mode since
the existing cause_ipi functions cannot be executed in real-mode.

A tunable h_ipi_redirect is also included in the patch set to
disable the feature. 

v3:
* Updated/clarified commit logs.
* Fix build break when building without KVM.

v2:
* Complete patch set sent to both kvm and linuxppc mailing lists
  to avoid build-breaks.
* Broke up real mode IPI messaging function into two pieces - one
  to set the message and one to cause the IPI. New function
  icp_native_cause_ipi_rm added to arch/powerpc/sysdev/xics/icp-native.c


Suresh Warrier (9):
  powerpc/smp: Support more IPI messages
  powerpc/smp: Add smp_muxed_ipi_set_message
  powerpc/xics: Add icp_native_cause_ipi_rm
  KVM: PPC: Book3S HV: Host-side RM data structures
  KVM: PPC: Book3S HV: Manage core host state
  KVM: PPC: Book3S HV: kvmppc_host_rm_ops - handle offlining CPUs
  KVM: PPC: Book3S HV: Host side kick VCPU when poked by real-mode KVM
  KVM: PPC: Book3S HV: Send IPI to host core to wake VCPU
  KVM: PPC: Book3S HV: Add tunable to control H_IPI redirection

 arch/powerpc/include/asm/kvm_ppc.h    |  33 +++++++
 arch/powerpc/include/asm/smp.h        |   4 +
 arch/powerpc/include/asm/xics.h       |   1 +
 arch/powerpc/kernel/smp.c             |  28 +++++-
 arch/powerpc/kvm/book3s_hv.c          | 166 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_builtin.c  |   3 +
 arch/powerpc/kvm/book3s_hv_rm_xics.c  | 120 +++++++++++++++++++++++-
 arch/powerpc/kvm/powerpc.c            |  10 ++
 arch/powerpc/sysdev/xics/icp-native.c |  21 +++++
 9 files changed, 378 insertions(+), 8 deletions(-)

-- 
1.8.3.4
