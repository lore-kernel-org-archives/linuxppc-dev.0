Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sw8H86FhYzDt0X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:53:40 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id s8so6038125pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 17:53:40 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: pbonzini@redhat.com, rkrcmar@redhat.com, agraf@suse.com, corbet@lwn.net
Cc: paulus@samba.org, mpe@ellerman.id.au, sam.bobroff@au1.ibm.com,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 linux-doc@vger.kernel.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 0/6] kvm: powerpc halt polling updates
Date: Fri, 14 Oct 2016 11:53:18 +1100
Message-Id: <1476406404-32752-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series makes some updates and bug fixes to the powerpc kvm-hv
halt polling code.

The first two patches are concerned with exporting the generic kvm module
parameter variables and accessing these from the powerpc specific code.

The third patch fixes a bug where changing the global max halt polling
interval module parameter can sometimes have no effect.

The fourth patch decreases the default global max halt polling interval
to something more sensible.

The fifth patch contains generic fixups with no functional effect.

The last patch adds halt polling documentation.

Suraj Jitindar Singh (6):
  kvm: export kvm module parameter variables
  powerpc/kvm: Use generic kvm module parameters in kvm-hv
  powerpc/kvm: Add check for module parameter halt_poll_ns
  powerpc/kvm: Decrease the powerpc default halt poll max value
  powerpc/kvm: Comment style and print format fixups
  doc/kvm: Add halt polling documentation

 Documentation/virtual/kvm/00-INDEX         |   2 +
 Documentation/virtual/kvm/halt-polling.txt | 127 +++++++++++++++++++++++++++++
 arch/powerpc/include/asm/kvm_host.h        |   2 +-
 arch/powerpc/kvm/book3s_hv.c               |  33 ++------
 arch/powerpc/kvm/trace_hv.h                |   2 +-
 include/linux/kvm_host.h                   |   4 +
 virt/kvm/kvm_main.c                        |   9 +-
 7 files changed, 149 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/virtual/kvm/halt-polling.txt

-- 
2.5.5
