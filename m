Return-Path: <srs0=buqp=cg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWqqV6vsGzDr62
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 13:24:06 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yWqqV2Wj3z8t9V
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 13:24:06 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yWqqT4g55z9s4s
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2017 13:24:05 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA82NtcZ133598
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Nov 2017 21:24:03 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e3p8gf6p9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 07 Nov 2017 21:24:03 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 7 Nov 2017 19:24:02 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/18] powerpc/vas: Add support for FTW 
Date: Tue,  7 Nov 2017 18:23:40 -0800
Message-Id: <1510107838-15181-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The first 10 patches in this set sanitize cpu/chip id to VAS id mapping,
improve vas_win_close() performance, add a check for return of credits
and cleans up some code.

Patch 11 adds debugfs support for the VAS window contexts.

Patches 12-18 add support for user space aka Fast thread-wakeup windows
in VAS. These include a patch from Michael Neuling to support emulating
the paste instruction.

Changelog[v3]:
	- [Michael Ellerman] We don't need to disable/enable pagefaults
	  when emulating paste;
	- [Michael Ellerman, Aneesh Kumar] Fix retval from emulate_paste()
	  and paste().
	- [Nick Piggin] Drop CP_ABORT since set_thread_uses_vas() does
	  that now (in earlier patch) and add a check for return value.
	- [Michael Ellerman] Fix couple of unininitialized variables
	- Minor tweak to a debug message

Michael Neuling (1):
  powerpc: Emulate paste instruction

Sukadev Bhattiprolu (17):
  powerpc/vas: init missing fields from [rt]xattr
  powerpc/vas: Validate window credits
  powerpc/vas: Cleanup some debug code
  powerpc/vas: Drop poll_window_cast_out().
  powerpc/vas: Use helper to unpin/close window
  powerpc/vas: Reduce polling interval for busy state
  powerpc/vas: Save configured window credits
  powerpc/vas: poll for return of window credits
  powerpc/vas: Create cpu to vas id mapping
  powerpc/vas, nx-842: Define and use chip_to_vas_id()
  powerpc/vas: Export HVWC to debugfs
  powerpc: have copy depend on CONFIG_BOOK3S_64
  powerpc: Add support for setting SPRN_TIDR
  powerpc: Define set_thread_uses_vas()
  powerpc/vas: Define vas_win_paste_addr()
  powerpc/vas: Define vas_win_id()
  powerpc/vas: Add support for user receive window

 arch/powerpc/include/asm/emulated_ops.h     |   1 +
 arch/powerpc/include/asm/ppc-opcode.h       |   1 +
 arch/powerpc/include/asm/processor.h        |   3 +
 arch/powerpc/include/asm/reg.h              |   2 +
 arch/powerpc/include/asm/switch_to.h        |   5 +
 arch/powerpc/include/asm/vas.h              |  21 +++
 arch/powerpc/kernel/process.c               | 169 +++++++++++++++++--
 arch/powerpc/kernel/traps.c                 |  67 ++++++++
 arch/powerpc/platforms/powernv/Makefile     |   3 +-
 arch/powerpc/platforms/powernv/vas-debug.c  | 209 ++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/vas-window.c | 242 +++++++++++++++++++++++-----
 arch/powerpc/platforms/powernv/vas.c        |  31 +++-
 arch/powerpc/platforms/powernv/vas.h        |  93 ++++++-----
 drivers/crypto/nx/nx-842-powernv.c          |  18 +--
 14 files changed, 751 insertions(+), 114 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/vas-debug.c

-- 
2.7.4
