Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0Kvl13B3zDqVJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 22:21:39 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3v0Kvk455sz9vKb
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2017 22:21:38 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0DBEWmt136241
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2017 06:21:36 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27xukj56rs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2017 06:21:35 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 13 Jan 2017 04:21:34 -0700
Subject: [PATCH v5 0/2] KVM: PPC: Add FWNMI support for KVM guests on POWER
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org, paulus@ozlabs.org,
 linuxppc-dev@ozlabs.org, pbonzini@redhat.com
Cc: mahesh@linux.vnet.ibm.com, mpe@ellerman.id.au, bsingharora@gmail.com,
 kvm@vger.kernel.org, david@gibson.dropbear.id.au
Date: Fri, 13 Jan 2017 16:51:18 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148430634902.22799.7589829837646104546.stgit@aravinda>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
 arch/powerpc/include/asm/kvm_host.h     |    1 +
 arch/powerpc/kernel/asm-offsets.c       |    1 +
 arch/powerpc/kvm/book3s_hv.c            |   27 +++++++++++++-----
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   47 ++++++++++++++++---------------
 arch/powerpc/kvm/powerpc.c              |    7 +++++
 arch/powerpc/platforms/powernv/opal.c   |   10 +++++++
 include/uapi/linux/kvm.h                |    1 +
 8 files changed, 75 insertions(+), 30 deletions(-)

--
Aravinda Prasad
