Return-Path: <srs0=+vpc=3o=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzVYD3KBWzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 03:48:00 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzVYC34Jcz8syC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 03:47:59 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vzVYB1L58z9s8N
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2017 03:47:58 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v36HhiCm025198
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2017 13:47:53 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29nq7x12f3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Apr 2017 13:47:52 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 03:47:49 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v36HldT840960126
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 03:47:47 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v36HlATH007646
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 03:47:11 +1000
Subject: [PATCH v8 0/3] KVM: PPC: Add FWNMI support for KVM guests on POWER
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: gleb@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, agraf@suse.de,
 KVM-PPC <kvm-ppc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, pbonzini@redhat.com
Cc: KVM <kvm@vger.kernel.org>, david@gibson.dropbear.id.au
Date: Thu, 06 Apr 2017 23:16:54 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149150078227.9475.13869552319691573937.stgit@jupiter.in.ibm.com>
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
