Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbsx53pcDzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 20:12:25 +1000 (AEST)
Date: Mon, 29 May 2017 20:11:13 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V3 0/2] KVM: PPC: Book3S HV: Support POWER9's large
 decrementer mode
Message-ID: <20170529101113.GA13938@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

One of the new features of POWER9 is that the decrementer (the
facility that provides an interrupt after a programmable length of
time) has been increased in size from 32 bits to 56 bits, allowing
time intervals of up to about 814 days, compared to 4 seconds
previously.  This patch series adds support for the large decrementer
mode to HV KVM.  There is already code in the host kernel to enable
large decrementer mode for the host, which means that some of the KVM
entry/exit code is currently incorrect; the first patch fixes that.
The second patch allows userspace to enable large decrementer mode for
the guest, by setting the appropriate bit in the guest LPCR value.

Changes in v3: Don't use up a CPU feature bit, since there is actually
only one place that needs a feature section.  For that, we can test the
value of the LPCR_LD bit in the image of the host LPCR that is kept in
the kvm struct.  This means that this patch set now only touches KVM
code.

Paul.
---
 arch/powerpc/include/asm/kvm_host.h     |  2 +-
 arch/powerpc/kvm/book3s_hv.c            |  6 ++++
 arch/powerpc/kvm/book3s_hv_interrupts.S | 12 +++++++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 50 ++++++++++++++++++++++++++-------
 arch/powerpc/kvm/emulate.c              |  4 +--
 5 files changed, 60 insertions(+), 14 deletions(-)
