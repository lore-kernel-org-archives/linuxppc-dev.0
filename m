Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsWWD09dkzDqlw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 16:11:03 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id v5so7213515pgn.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 23:11:03 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au,
	npiggin@gmail.com,
	mahesh@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v2 0/4] Revisit MCE handling for UE Errors
Date: Wed, 13 Sep 2017 16:10:44 +1000
Message-Id: <20170913061049.13256-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series is designed to hook up memory_failure on
UE errors, this is specially helpful for user_mode UE errors.

The first two patches cleanup bits, remove dead code.
I could not find any users of get_mce_fault_addr().
The second one improves printing of physical address

The third patch walks kernel/user mode page tables in
real mode to extract the effective address of the instruction
that caused the UE error and the effective address it was
trying to access (for load/store). The fourth patch hooks
up the pfn for instruction UE errors (ierror).

The fifth patch hooks up memory_failure to the MCE patch.

TODO:
Log the address in NVRAM, so that we can recover from
bad pages at boot and keep the blacklist persistent.

Changelog v2:
	- Remove pr_warn from real mode to a more delayed
	context, where its OK to warn.
	- Add a trivial patch to align prints of physical
	and effective address
Changelog v1:
	- address review comments from Nick and Mahesh
	(initialization of pfn and more comments on failure
	when addr_to_pfn() or anaylse_instr() fail)
	- Hookup ierrors to the framework as well
	(comments from Mahesh)

Balbir Singh (4):
  powerpc/mce.c: Remove unused function get_mce_fault_addr()
  powerpc/mce: Hookup derror (load/store) UE errors
  powerpc/mce: Hookup ierror (instruction) UE errors
  powerpc/mce: hookup memory_failure for UE errors

 arch/powerpc/include/asm/mce.h  |   4 +-
 arch/powerpc/kernel/mce.c       | 112 +++++++++++++++++++++++++---------------
 arch/powerpc/kernel/mce_power.c | 103 +++++++++++++++++++++++++++++++++---
 3 files changed, 165 insertions(+), 54 deletions(-)

-- 
2.9.5
