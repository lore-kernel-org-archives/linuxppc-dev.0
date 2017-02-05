Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGgN241tzzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 06:17:22 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vGgN16gMYz9s7F
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Feb 2017 06:17:21 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v15JDZ2Q085484
 for <linuxppc-dev@ozlabs.org>; Sun, 5 Feb 2017 14:17:19 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28e3cg2n54-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 05 Feb 2017 14:17:19 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 6 Feb 2017 00:47:16 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 69572E005A
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Feb 2017 00:48:37 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v15JHDoE14024808
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Feb 2017 00:47:13 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v15JHBGm019639
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Feb 2017 00:47:12 +0530
Subject: [PATCH v6 0/2] KVM: PPC: Add FWNMI support for KVM guests on POWER
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, pbonzini@redhat.com
Cc: Michael Ellerman <mpe@ellerman.id.au>, bsingharora@gmail.com,
 kvm@vger.kernel.org, david@gibson.dropbear.id.au
Date: Mon, 06 Feb 2017 00:47:10 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148632203211.7314.13690405241893581965.stgit@jupiter.in.ibm.com>
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


 Documentation/virtual/kvm/api.txt       |   11 +++++++
 arch/powerpc/include/asm/kvm_host.h     |    3 ++
 arch/powerpc/include/asm/machdep.h      |    7 ++++
 arch/powerpc/include/asm/opal.h         |    4 ++
 arch/powerpc/include/uapi/asm/kvm.h     |    6 ++++
 arch/powerpc/kernel/asm-offsets.c       |    1 +
 arch/powerpc/kvm/book3s_hv.c            |   24 ++++++++++----
 arch/powerpc/kvm/book3s_hv_ras.c        |   18 ++++++++++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   52 ++++++++++++++++++-------------
 arch/powerpc/kvm/powerpc.c              |    7 ++++
 arch/powerpc/platforms/powernv/opal.c   |   26 ++++++++++++++++
 arch/powerpc/platforms/powernv/setup.c  |    3 ++
 include/uapi/linux/kvm.h                |    1 +
 13 files changed, 133 insertions(+), 30 deletions(-)

--
