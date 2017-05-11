Return-Path: <srs0=ltoi=4r=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNjXY2G5XzDqLg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 16:15:57 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wNjXY1dXbz8t1b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 16:15:57 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wNjXX57K9z9sCZ
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 16:15:55 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4B694xN131598
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 02:15:53 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ac7me1cd2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 02:15:53 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 11 May 2017 16:15:50 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4B6FfLs32637038
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 16:15:49 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4B6FA7Z029587
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 16:15:10 +1000
Subject: [PATCH v9 0/3] KVM: PPC: Add FWNMI support for KVM guests on POWER
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, pbonzini@redhat.com
Cc: Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
 david@gibson.dropbear.id.au
Date: Thu, 11 May 2017 11:44:52 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149448323691.12206.11861424815113458031.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

This series of patches add FWNMI support for KVM guests
on POWER.

Memory errors such as bit flips that cannot be corrected
by hardware is passed on to the kernel for handling
by raising machine check exception (an NMI). Upon such
machine check exceptions, if the address in error belongs
to the guest, the error is passed on to the guest
kernel for handling. However, for guest kernels that
have issued "ibm,nmi-register" call, QEMU should build
an error log and pass on the error log to the guest-
kernel registered machine check handler routine.

This patch series adds the functionality to pass on the
machine check exception to the guest kernel by
giving control to QEMU. QEMU builds the error log
and invokes the guest-kernel registered handler.

QEMU part can be found at:
http://lists.nongnu.org/archive/html/qemu-ppc/2015-12/msg00199.html

Change Log v9:
  - Rebase to latest upstream.

Change Log v8:
  - export symbol machine_check_print_event_info() and directly call it
    from kvmppc_handle_exit_hv().

Change Log v7:
  - Move the FWNMI capability inside #ifdef CONFIG_PPC_BOOK3S_64 block.
  - Split 2nd patch into two, one that adds mce hook and other that touches
    kvm code.

Change Log v6:
  - Deliver all MCE errors (handled/unhandled) for FWNMI capable guest.
  - Use kvm_run->flags to pass NMI disposition status.

Change Log v5:
  - Added capability documentation. No functionality/code change.

Change Log v4:
  - Allow host-side handling of the machine check exception before
    passing on the exception to the guest.

Change Log v3:
  - Split the patch into 2. First patch introduces the
    new capability while the second one enhances KVM to
    redirect MCE.
  - Fix access width bug

Change Log v2:
  - Added KVM capability
---

Aravinda Prasad (2):
      KVM: PPC: Add new capability to control MCE behaviour
      KVM: PPC: Exit guest upon MCE when FWNMI capability is enabled

Mahesh Salgaonkar (1):
      powerpc/book3s: EXPORT_SYMBOL machine_check_print_event_info


 Documentation/virtual/kvm/api.txt       |   11 +++++++
 arch/powerpc/include/asm/kvm_host.h     |    3 ++
 arch/powerpc/include/uapi/asm/kvm.h     |    6 ++++
 arch/powerpc/kernel/asm-offsets.c       |    1 +
 arch/powerpc/kernel/mce.c               |    1 +
 arch/powerpc/kvm/book3s_hv.c            |   23 ++++++++------
 arch/powerpc/kvm/book3s_hv_ras.c        |   18 ++++++++++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   52 ++++++++++++++++++-------------
 arch/powerpc/kvm/powerpc.c              |    9 +++++
 include/uapi/linux/kvm.h                |    1 +
 10 files changed, 93 insertions(+), 32 deletions(-)

--
Signature
