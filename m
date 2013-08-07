Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C28E52C0118
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Aug 2013 19:40:25 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 7 Aug 2013 19:29:35 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F2EA92BB004F
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Aug 2013 19:38:02 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r779MCIb7078220
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Aug 2013 19:22:13 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r779c15H016114
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Aug 2013 19:38:01 +1000
Subject: [RFC PATCH 0/9] Machine check handling in linux host.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 07 Aug 2013 15:07:58 +0530
Message-ID: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Please find the patch set that performs the machine check handling inside linux
host. The design is to be able to handle re-entrancy so that we do not clobber
the machine check information during nested machine check interrupt.

The patch 2 implements the logic to save the raw MCE info onto the emergency
stack and prepares to take another exception. Patch 3 and 4 adds CPU-side hooks
for early machine check handler and TLB flush.  The patch 5 and 6 is
responsible to detect SLB/TLB errors and flush them off in the real mode. The
patch 7 implements the logic to decode and save high level MCE information to
per cpu buffer without clobbering. The patch 9 adds the basic error handling to
the high level C code with MMU on.

I have tested SLB multihit scenario on powernv. For TLB multihit and nested
machine check testing, I am still working on getting cronus setup to be able
to inject errors.

Please review and let me know your comments.

Thanks,
-Mahesh.

---

Mahesh Salgaonkar (9):
      powerpc: Split the common exception prolog logic into two section.
      powerpc: handle machine check in Linux host.
      powerpc: Introduce a early machine check hook in cpu_spec.
      powerpc: Add flush_tlb operation in cpu_spec.
      powerpc: Flush SLB/TLBs if we get SLB/TLB machine check errors on power7.
      powerpc: Flush SLB/TLBs if we get SLB/TLB machine check errors on power8.
      powerpc: Decode and save machine check event.
      powerpc/powernv: Remove machine check handling in OPAL.
      powerpc/powernv: Machine check exception handling.


 arch/powerpc/include/asm/bitops.h        |    5 +
 arch/powerpc/include/asm/cputable.h      |   12 +
 arch/powerpc/include/asm/exception-64s.h |  110 ++++++++---
 arch/powerpc/include/asm/mce.h           |  190 ++++++++++++++++++++
 arch/powerpc/kernel/Makefile             |    3 
 arch/powerpc/kernel/cpu_setup_power.S    |   39 +++-
 arch/powerpc/kernel/cputable.c           |   16 ++
 arch/powerpc/kernel/exceptions-64s.S     |   50 +++++
 arch/powerpc/kernel/mce.c                |  179 +++++++++++++++++++
 arch/powerpc/kernel/mce_power.c          |  287 ++++++++++++++++++++++++++++++
 arch/powerpc/kernel/traps.c              |   15 ++
 arch/powerpc/kvm/book3s_hv_ras.c         |   42 +---
 arch/powerpc/platforms/powernv/opal.c    |   84 ++++++---
 13 files changed, 935 insertions(+), 97 deletions(-)
 create mode 100644 arch/powerpc/include/asm/mce.h
 create mode 100644 arch/powerpc/kernel/mce.c
 create mode 100644 arch/powerpc/kernel/mce_power.c

-- 
-Mahesh
