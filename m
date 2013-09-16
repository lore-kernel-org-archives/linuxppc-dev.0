Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A6F72C00F8
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:41:03 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 16 Sep 2013 22:29:03 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 06F2D2CE8051
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:40:59 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8GCOTaI4915604
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:24:30 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8GCevZI001547
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Sep 2013 22:40:57 +1000
Subject: [RFC PATCH v4 00/12] Machine check handling in linux host.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 16 Sep 2013 18:10:55 +0530
Message-ID: <20130916123908.16111.4657.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
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

The patch 2 introduces separate emergency stack in paca structure exclusively
for machine check exception handling.  Patch 3 implements the logic to save the
raw MCE info onto the emergency stack and prepares to take another exception.
Patch 5 and 6 adds CPU-side hooks for early machine check handler and TLB
flush.  The patch 7 and 8 is responsible to detect SLB/TLB errors and flush
them off in the real mode. The patch 9 implements the logic to decode and save
high level MCE information to per cpu buffer without clobbering. Patch 10
implements mechanism to queue up MCE event in cases where early handler
can not deliver the event to host kernel right away. The patch 12
adds the basic error handling to the high level C code with MMU on.

I have tested SLB multihit, MC coming from opal context on powernv.

Please review and let me know your comments.

Changes in v4:
- Split the prolog common macro in 3 parts in patch 1.
- Save the regs from EXMC save area to stack before turning on ME bit.
- Set/Clear MSR_RI bit at right places.
- Handle a situation where machine check comes in when thread was in power
  saving mode.
- Queue up the MCE event and return from the interrupt if MC is hit during
  context which we are not sure of. Go to kernel in V mode only if we
  are coming from hypervisor userspace (HV=1, PR=1).

Changes in v3:
- Rebased to v3.11-rc7
- Handle MCE coming from opal context, secondary thread nap and return
  from interrupt. Queue up the MCE event in this scenario and log it
  later during syscall exit path.

Changes in v2:
- Moved early machine check handling code under CPU_FTR_HVMODE section.
  This makes sure that the early machine check handler will get executed
  only in hypervisor kernel.
- Add dedicated emergency stack for machine check so that we don't end up
  disturbing others who use same emergency stack.
- Fixed the machine check early handle where it used to assume that r1 always
  contains the valid stack pointer.
- Fixed an issue where per-cpu mce_nest_count variable underflows when kvm
  fails to handle MC error and exit the guest.
- Fixed the code to restore r13 while before exiting early handler.

Thanks,
-Mahesh.

---

Mahesh Salgaonkar (12):
      powerpc/book3s: Split the common exception prolog logic into two section.
      powerpc/book3s: Introduce exclusive emergency stack for machine check exception.
      powerpc/book3s: handle machine check in Linux host.
      powerpc/book3s: Return from interrupt if coming from evil context.
      powerpc/book3s: Introduce a early machine check hook in cpu_spec.
      powerpc/book3s: Add flush_tlb operation in cpu_spec.
      powerpc/book3s: Flush SLB/TLBs if we get SLB/TLB machine check errors on power7.
      powerpc/book3s: Flush SLB/TLBs if we get SLB/TLB machine check errors on power8.
      powerpc/book3s: Decode and save machine check event.
      powerpc/book3s: Queue up and process delayed MCE events.
      powerpc/powernv: Remove machine check handling in OPAL.
      powerpc/powernv: Machine check exception handling.


 arch/powerpc/include/asm/bitops.h        |    5 
 arch/powerpc/include/asm/cputable.h      |   12 +
 arch/powerpc/include/asm/exception-64s.h |   21 +-
 arch/powerpc/include/asm/mce.h           |  198 +++++++++++++++++
 arch/powerpc/include/asm/paca.h          |    9 +
 arch/powerpc/kernel/Makefile             |    1 
 arch/powerpc/kernel/asm-offsets.c        |    4 
 arch/powerpc/kernel/cpu_setup_power.S    |   38 ++-
 arch/powerpc/kernel/cputable.c           |   16 +
 arch/powerpc/kernel/entry_64.S           |    5 
 arch/powerpc/kernel/exceptions-64s.S     |  196 +++++++++++++++++
 arch/powerpc/kernel/idle_power7.S        |    1 
 arch/powerpc/kernel/mce.c                |  345 ++++++++++++++++++++++++++++++
 arch/powerpc/kernel/mce_power.c          |  284 +++++++++++++++++++++++++
 arch/powerpc/kernel/setup_64.c           |   10 +
 arch/powerpc/kernel/traps.c              |   15 +
 arch/powerpc/kvm/book3s_hv_ras.c         |   50 ++--
 arch/powerpc/platforms/powernv/opal.c    |  161 ++++----------
 arch/powerpc/xmon/xmon.c                 |    4 
 19 files changed, 1220 insertions(+), 155 deletions(-)
 create mode 100644 arch/powerpc/include/asm/mce.h
 create mode 100644 arch/powerpc/kernel/mce.c
 create mode 100644 arch/powerpc/kernel/mce_power.c

-- 
-Mahesh
